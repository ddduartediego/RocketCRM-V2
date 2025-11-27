#!/usr/bin/env python3
"""
Script para gerar SQL de importação da planilha de eventos.
Gera um arquivo SQL que pode ser executado no Supabase SQL Editor.

Uso: python3 scripts/gerar_sql_importacao.py
Saída: supabase/migrations/20251127100000_import_planilha_eventos.sql
"""

import csv
import re
from datetime import datetime

# Configurações
CSV_PATH = '/Users/iduarte/Downloads/Planilha.csv'
SQL_OUTPUT = 'supabase/migrations/20251127100000_import_planilha_eventos.sql'

# Recreadores que devem ser ignorados (são custos adicionais, não pessoas)
IGNORAR_NOMES = {
    'ALIMENTAÇÃO', 'DESL', 'DESLO', 'JANTAR', 'OMAS HAUS REPASSE',
    'DISK ALEGRIA', 'DISK ALE', 'CI',  # CI parece ser abreviação incompleta
    'DESL FELICIA', 'DESL BACON', 'DESL  FELICIA'  # São deslocamentos, não recreadores
}

# Sufixos que indicam deslocamento (serão tratados separadamente)
SUFIXOS_DESL = ['DESL', ' DESL']

# Mapeamento de nomes com typos para o nome correto
CORRECOES_NOMES = {
    'SORRIOS': 'SORRISO',
    'PEDRIITA': 'PEDRITA',
    'NÉIA': 'NEIA',
}

def limpar_valor(valor_str):
    """Converte string de valor monetário para float."""
    if not valor_str or valor_str.strip() in ['', '-', '#VALUE!']:
        return None
    # Remove R$, espaços, aspas e substitui vírgula por ponto
    valor = re.sub(r'[R$\s"\']', '', valor_str)
    valor = valor.replace('.', '').replace(',', '.')
    try:
        return float(valor)
    except ValueError:
        return None

def converter_data(data_str):
    """Converte data DD/MM/YYYY ou M/D/YYYY para YYYY-MM-DD."""
    if not data_str or data_str.strip() == '':
        return None
    
    data_str = data_str.strip()
    
    # Tentar formato DD/MM/YYYY
    try:
        dt = datetime.strptime(data_str, '%d/%m/%Y')
        return dt.strftime('%Y-%m-%d')
    except ValueError:
        pass
    
    # Tentar formato M/D/YYYY (americano)
    try:
        dt = datetime.strptime(data_str, '%m/%d/%Y')
        return dt.strftime('%Y-%m-%d')
    except ValueError:
        pass
    
    return None

def limpar_nome_recreador(nome):
    """Limpa e normaliza nome do recreador."""
    if not nome:
        return None
    
    nome = re.sub(r'^[\s"\']+|[\s"\']+$', '', nome).strip().upper()
    
    # Remover sufixo DESL do nome
    nome_base = nome
    for sufixo in SUFIXOS_DESL:
        if nome.endswith(sufixo):
            nome_base = nome[:-len(sufixo)].strip()
            break
    
    # Ignorar nomes na lista
    if nome in IGNORAR_NOMES or nome_base in IGNORAR_NOMES:
        return None
    
    # Ignorar se começa com número ou R$
    if nome.startswith('R$') or (nome and nome[0].isdigit()):
        return None
    
    # Ignorar nomes muito curtos
    if len(nome_base) < 2:
        return None
    
    # Aplicar correções de nomes (typos)
    if nome_base in CORRECOES_NOMES:
        nome_base = CORRECOES_NOMES[nome_base]
    
    return nome_base

def escapar_sql(texto):
    """Escapa aspas simples para SQL."""
    if texto is None:
        return 'NULL'
    return "'" + str(texto).replace("'", "''") + "'"

def gerar_sql():
    """Gera o script SQL completo."""
    
    # Coletar dados da planilha
    eventos = []
    recreadores = set()
    
    with open(CSV_PATH, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        next(reader)  # pular cabeçalho
        
        for row in reader:
            if len(row) < 7 or not row[0].strip():
                continue
            
            data_evento = converter_data(row[0])
            if not data_evento:
                continue
            
            descricao = row[1].strip() if len(row) > 1 else ''
            tipo = row[2].strip() if len(row) > 2 else 'Recreação'
            valor_total = limpar_valor(row[3]) if len(row) > 3 else None
            valor_sinal = limpar_valor(row[4]) if len(row) > 4 else None
            data_pagamento = converter_data(row[5]) if len(row) > 5 else None
            status = row[6].strip() if len(row) > 6 else 'A pagar'
            
            # Coletar recreadores do evento
            recs_evento = []
            for i in range(7, min(len(row), 28), 2):
                nome_rec = limpar_nome_recreador(row[i]) if i < len(row) else None
                valor_rec = limpar_valor(row[i+1]) if i+1 < len(row) else None
                
                if nome_rec and valor_rec and valor_rec > 0:
                    recreadores.add(nome_rec)
                    recs_evento.append((nome_rec, valor_rec))
            
            eventos.append({
                'data_evento': data_evento,
                'descricao': descricao,
                'tipo': tipo,
                'valor_total': valor_total,
                'valor_sinal': valor_sinal,
                'data_pagamento': data_pagamento,
                'status': status,
                'recreadores': recs_evento
            })
    
    # Gerar SQL
    sql_lines = []
    
    # Cabeçalho
    sql_lines.append("""-- =============================================
-- Migration: Importação da Planilha de Eventos
-- =============================================
-- Este script importa eventos históricos da planilha Excel.
-- Executar manualmente no SQL Editor do Supabase.
-- 
-- Data: 27/11/2025
-- Total de eventos: {}
-- Total de recreadores: {}
-- =============================================

BEGIN;

""".format(len(eventos), len(recreadores)))

    # ==========================================
    # PARTE 1: Criar Tipos de Evento
    # ==========================================
    sql_lines.append("""-- =============================================
-- PARTE 1: Criar Novos Tipos de Evento
-- =============================================

INSERT INTO tipos_evento (nome, icone, cor, ordem, ativo)
SELECT * FROM (VALUES
  ('Recreação', '🎭', '#22c55e', 10, true),
  ('Brinks+Recre', '🎪', '#8b5cf6', 11, true),
  ('Infláveis', '🎈', '#f97316', 12, true)
) AS v(nome, icone, cor, ordem, ativo)
WHERE NOT EXISTS (
  SELECT 1 FROM tipos_evento WHERE nome = v.nome
);

""")

    # ==========================================
    # PARTE 2: Criar Recreadores
    # ==========================================
    sql_lines.append("""-- =============================================
-- PARTE 2: Criar Membros da Equipe (Recreadores)
-- =============================================

""")
    
    for nome in sorted(recreadores):
        sql_lines.append(f"""INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT {escapar_sql(nome)}, 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = {escapar_sql(nome)});
""")
    
    sql_lines.append("\n")

    # ==========================================
    # PARTE 3, 4, 5: Criar Eventos, Transações e Alocações
    # ==========================================
    sql_lines.append("""-- =============================================
-- PARTE 3, 4, 5: Eventos, Transações e Alocações
-- =============================================
-- Usando CTEs para criar eventos e transações de forma atômica

DO $$
DECLARE
  v_evento_id UUID;
  v_tipo_id UUID;
  v_membro_id UUID;
  v_transacao_id UUID;
  v_categoria_receita_id UUID;
  v_categoria_monitores_id UUID;
  v_data_hoje DATE := CURRENT_DATE;
BEGIN
  -- Buscar categorias financeiras
  SELECT id INTO v_categoria_receita_id FROM categorias_financeiras WHERE nome = 'Pagamento de Evento' AND tipo = 'receita' LIMIT 1;
  SELECT id INTO v_categoria_monitores_id FROM categorias_financeiras WHERE nome = 'Monitores' AND tipo = 'despesa' LIMIT 1;

""")

    # Gerar INSERT para cada evento
    for idx, evento in enumerate(eventos):
        data_evento = evento['data_evento']
        descricao = evento['descricao']
        tipo = evento['tipo']
        valor_total = evento['valor_total']
        valor_sinal = evento['valor_sinal']
        data_pagamento = evento['data_pagamento']
        status = evento['status']
        recreadores_evento = evento['recreadores']
        
        # Determinar status do evento
        if data_evento:
            status_evento = 'realizado' if data_evento < '2025-11-27' else 'confirmado'
        else:
            status_evento = 'confirmado'
        
        # Determinar status de pagamento
        status_pag = 'pago' if status.lower() == 'pago' else 'pendente'
        
        sql_lines.append(f"""
  -- Evento {idx + 1}: {descricao} ({data_evento})
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = {escapar_sql(tipo)} LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = {escapar_sql(data_evento)}::DATE 
    AND UPPER(nome) = {escapar_sql(descricao.upper() if descricao else 'SEM NOME')}
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      {escapar_sql(descricao or 'Evento ' + data_evento)},
      v_tipo_id,
      {escapar_sql(data_evento)}::DATE,
      {valor_total if valor_total else 'NULL'},
      {valor_sinal if valor_sinal else 'NULL'},
      '{status_evento}',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;
""")

        # Criar transação de receita se houver valor
        if valor_total and valor_total > 0:
            sql_lines.append(f"""
    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || {escapar_sql(descricao or 'Evento')},
      'receita',
      {valor_total},
      {escapar_sql(data_pagamento or data_evento)}::DATE,
      {escapar_sql(data_pagamento) + '::DATE' if data_pagamento and status_pag == 'pago' else 'NULL'},
      '{status_pag}',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
""")

        # Criar alocações de equipe
        for nome_rec, valor_rec in recreadores_evento:
            sql_lines.append(f"""
    -- Alocação: {nome_rec} (R$ {valor_rec})
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = {escapar_sql(nome_rec)} LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - {nome_rec} - ' || {escapar_sql(descricao or 'Evento')},
        'despesa',
        {valor_rec},
        {escapar_sql(data_pagamento or data_evento)}::DATE,
        {escapar_sql(data_pagamento) + '::DATE' if data_pagamento and status_pag == 'pago' else 'NULL'},
        '{status_pag}',
        v_categoria_monitores_id,
        v_evento_id,
        'Importado da planilha'
      )
      RETURNING id INTO v_transacao_id;
      
      -- Criar alocação
      INSERT INTO alocacao_equipe (membro_id, evento_id, data, valor_pago, transacao_id, observacoes)
      VALUES (
        v_membro_id,
        v_evento_id,
        {escapar_sql(data_evento)}::DATE,
        {valor_rec},
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
""")

        sql_lines.append("""  END IF;
""")

    # Finalizar
    sql_lines.append("""
END $$;

COMMIT;

-- =============================================
-- FIM DA IMPORTAÇÃO
-- =============================================
""")

    # Escrever arquivo
    with open(SQL_OUTPUT, 'w', encoding='utf-8') as f:
        f.write(''.join(sql_lines))
    
    print(f"SQL gerado com sucesso!")
    print(f"Arquivo: {SQL_OUTPUT}")
    print(f"Total de eventos: {len(eventos)}")
    print(f"Total de recreadores: {len(recreadores)}")
    print(f"\nRecreadores encontrados:")
    for r in sorted(recreadores):
        print(f"  - {r}")

if __name__ == '__main__':
    gerar_sql()

