-- =============================================
-- Migration: Importação da Planilha de Eventos
-- =============================================
-- Este script importa eventos históricos da planilha Excel.
-- Executar manualmente no SQL Editor do Supabase.
-- 
-- Data: 27/11/2025
-- Total de eventos: 269
-- Total de recreadores: 44
-- =============================================

BEGIN;

-- =============================================
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

-- =============================================
-- PARTE 2: Criar Membros da Equipe (Recreadores)
-- =============================================

INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Alice', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Alice'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Ana', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Ana'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Ana Samurai', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Ana Samurai'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Babalu', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Babalu'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Bacon', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Bacon'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Batata', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Batata'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Caca', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Caca'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Cinthia', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Cinthia'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Cintia', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Cintia'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Crystal', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Crystal'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Detona Ralph', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Detona Ralph'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Dinho', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Dinho'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Docinho', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Docinho'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Dora', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Dora'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Estrela', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Estrela'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Felicia', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Felicia'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Gabe', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Gabe'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Gisa', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Gisa'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Joaninha', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Joaninha'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Jojo', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Jojo'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Juci', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Juci'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Jujuba', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Jujuba'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Kinho', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Kinho'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Lady', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Lady'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Leka', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Leka'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Mari', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Mari'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Moranguinho', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Moranguinho'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Mu', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Mu'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Nanda', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Nanda'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Neia', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Neia'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Pantera', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Pantera'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Paola', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Paola'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Paçoca', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Paçoca'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Pedrita', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Pedrita'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Pepe', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Pepe'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Plutos', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Plutos'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Poc', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Poc'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Polly', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Polly'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Pucca', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Pucca'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Ravena', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Ravena'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Samurai', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Samurai'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Sorriso', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Sorriso'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Vertinho', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Vertinho'));
INSERT INTO equipe (nome, funcao, tipo_contrato, ativo)
SELECT 'Vick', 'recreador', 'freelancer', true
WHERE NOT EXISTS (SELECT 1 FROM equipe WHERE UPPER(nome) = UPPER('Vick'));

-- =============================================
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


  -- Evento 1: Ana (2025-01-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-04'::DATE 
    AND UPPER(nome) = 'ANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'Ana',
      v_tipo_id,
      '2025-01-04'::DATE,
      1050.0,
      315.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'Ana',
      'receita',
      1050.0,
      '2025-01-19'::DATE,
      '2025-01-19'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'Ana',
        'despesa',
        180.0,
        '2025-01-19'::DATE,
        '2025-01-19'::DATE,
        'pago',
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
        '2025-01-04'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Joaninha (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Joaninha') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Joaninha - ' || 'Ana',
        'despesa',
        180.0,
        '2025-01-19'::DATE,
        '2025-01-19'::DATE,
        'pago',
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
        '2025-01-04'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 2: NATHI (2025-01-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-08'::DATE 
    AND UPPER(nome) = 'NATHI'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'NATHI',
      v_tipo_id,
      '2025-01-08'::DATE,
      1050.0,
      315.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'NATHI',
      'receita',
      1050.0,
      '2025-01-23'::DATE,
      '2025-01-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'NATHI',
        'despesa',
        200.0,
        '2025-01-23'::DATE,
        '2025-01-23'::DATE,
        'pago',
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
        '2025-01-08'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'NATHI',
        'despesa',
        180.0,
        '2025-01-23'::DATE,
        '2025-01-23'::DATE,
        'pago',
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
        '2025-01-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 3: PISCINA BVCC (2025-01-11)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-11'::DATE 
    AND UPPER(nome) = 'PISCINA BVCC'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PISCINA BVCC',
      v_tipo_id,
      '2025-01-11'::DATE,
      2200.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PISCINA BVCC',
      'receita',
      2200.0,
      '2025-01-26'::DATE,
      '2025-01-26'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'PISCINA BVCC',
        'despesa',
        180.0,
        '2025-01-26'::DATE,
        '2025-01-26'::DATE,
        'pago',
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
        '2025-01-11'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'PISCINA BVCC',
        'despesa',
        180.0,
        '2025-01-26'::DATE,
        '2025-01-26'::DATE,
        'pago',
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
        '2025-01-11'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 4: TATI (2025-01-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-12'::DATE 
    AND UPPER(nome) = 'TATI'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TATI',
      v_tipo_id,
      '2025-01-12'::DATE,
      610.0,
      183.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TATI',
      'receita',
      610.0,
      '2025-01-27'::DATE,
      '2025-01-27'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 170.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'TATI',
        'despesa',
        170.0,
        '2025-01-27'::DATE,
        '2025-01-27'::DATE,
        'pago',
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
        '2025-01-12'::DATE,
        170.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 5: VIVIANE (2025-01-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-12'::DATE 
    AND UPPER(nome) = 'VIVIANE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'VIVIANE',
      v_tipo_id,
      '2025-01-12'::DATE,
      1050.0,
      315.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'VIVIANE',
      'receita',
      1050.0,
      '2025-01-27'::DATE,
      '2025-01-27'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'VIVIANE',
        'despesa',
        200.0,
        '2025-01-27'::DATE,
        '2025-01-27'::DATE,
        'pago',
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
        '2025-01-12'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Vick (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Vick') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Vick - ' || 'VIVIANE',
        'despesa',
        180.0,
        '2025-01-27'::DATE,
        '2025-01-27'::DATE,
        'pago',
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
        '2025-01-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 6: SUZANA (2025-01-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-15'::DATE 
    AND UPPER(nome) = 'SUZANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SUZANA',
      v_tipo_id,
      '2025-01-15'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SUZANA',
      'receita',
      730.0,
      '2025-01-30'::DATE,
      '2025-01-30'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'SUZANA',
        'despesa',
        200.0,
        '2025-01-30'::DATE,
        '2025-01-30'::DATE,
        'pago',
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
        '2025-01-15'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 7: ANA PAULA (2025-01-18)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-18'::DATE 
    AND UPPER(nome) = 'ANA PAULA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA PAULA',
      v_tipo_id,
      '2025-01-18'::DATE,
      730.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA PAULA',
      'receita',
      730.0,
      '2025-02-02'::DATE,
      '2025-02-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'ANA PAULA',
        'despesa',
        180.0,
        '2025-02-02'::DATE,
        '2025-02-02'::DATE,
        'pago',
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
        '2025-01-18'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 8: LARISSA (2025-01-18)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-18'::DATE 
    AND UPPER(nome) = 'LARISSA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LARISSA',
      v_tipo_id,
      '2025-01-18'::DATE,
      1050.0,
      315.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LARISSA',
      'receita',
      1050.0,
      '2025-02-02'::DATE,
      '2025-02-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Pepe (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'LARISSA',
        'despesa',
        200.0,
        '2025-02-02'::DATE,
        '2025-02-02'::DATE,
        'pago',
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
        '2025-01-18'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Ravena (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Ravena') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Ravena - ' || 'LARISSA',
        'despesa',
        180.0,
        '2025-02-02'::DATE,
        '2025-02-02'::DATE,
        'pago',
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
        '2025-01-18'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 9: MAYARA (2025-01-18)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-18'::DATE 
    AND UPPER(nome) = 'MAYARA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MAYARA',
      v_tipo_id,
      '2025-01-18'::DATE,
      1750.0,
      600.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MAYARA',
      'receita',
      1750.0,
      '2025-02-02'::DATE,
      '2025-02-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'MAYARA',
        'despesa',
        180.0,
        '2025-02-02'::DATE,
        '2025-02-02'::DATE,
        'pago',
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
        '2025-01-18'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'MAYARA',
        'despesa',
        180.0,
        '2025-02-02'::DATE,
        '2025-02-02'::DATE,
        'pago',
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
        '2025-01-18'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 10: CINTIA (2025-01-19)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-19'::DATE 
    AND UPPER(nome) = 'CINTIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CINTIA',
      v_tipo_id,
      '2025-01-19'::DATE,
      599.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CINTIA',
      'receita',
      599.0,
      '2025-03-02'::DATE,
      '2025-03-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'CINTIA',
        'despesa',
        150.0,
        '2025-03-02'::DATE,
        '2025-03-02'::DATE,
        'pago',
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
        '2025-01-19'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 11: JOICE (2025-01-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-22'::DATE 
    AND UPPER(nome) = 'JOICE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JOICE',
      v_tipo_id,
      '2025-01-22'::DATE,
      1300.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JOICE',
      'receita',
      1300.0,
      '2025-06-02'::DATE,
      '2025-06-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'JOICE',
        'despesa',
        200.0,
        '2025-06-02'::DATE,
        '2025-06-02'::DATE,
        'pago',
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
        '2025-01-22'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'JOICE',
        'despesa',
        180.0,
        '2025-06-02'::DATE,
        '2025-06-02'::DATE,
        'pago',
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
        '2025-01-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 12: MDB (2025-01-23)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-23'::DATE 
    AND UPPER(nome) = 'MDB'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MDB',
      v_tipo_id,
      '2025-01-23'::DATE,
      780.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MDB',
      'receita',
      780.0,
      '2025-07-02'::DATE,
      '2025-07-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MDB',
        'despesa',
        200.0,
        '2025-07-02'::DATE,
        '2025-07-02'::DATE,
        'pago',
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
        '2025-01-23'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'MDB',
        'despesa',
        180.0,
        '2025-07-02'::DATE,
        '2025-07-02'::DATE,
        'pago',
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
        '2025-01-23'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 13: GINCANDEIAS (2025-01-24)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-24'::DATE 
    AND UPPER(nome) = 'GINCANDEIAS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GINCANDEIAS',
      v_tipo_id,
      '2025-01-24'::DATE,
      3900.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GINCANDEIAS',
      'receita',
      3900.0,
      '2025-08-02'::DATE,
      '2025-08-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Kinho (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Kinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Kinho - ' || 'GINCANDEIAS',
        'despesa',
        200.0,
        '2025-08-02'::DATE,
        '2025-08-02'::DATE,
        'pago',
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
        '2025-01-24'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Leka (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Leka') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Leka - ' || 'GINCANDEIAS',
        'despesa',
        200.0,
        '2025-08-02'::DATE,
        '2025-08-02'::DATE,
        'pago',
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
        '2025-01-24'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pantera (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pantera') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pantera - ' || 'GINCANDEIAS',
        'despesa',
        200.0,
        '2025-08-02'::DATE,
        '2025-08-02'::DATE,
        'pago',
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
        '2025-01-24'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 14: PISCINA BVCC (2025-01-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-25'::DATE 
    AND UPPER(nome) = 'PISCINA BVCC'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PISCINA BVCC',
      v_tipo_id,
      '2025-01-25'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'PISCINA BVCC',
        'despesa',
        180.0,
        '2025-09-02'::DATE,
        '2025-09-02'::DATE,
        'pago',
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
        '2025-01-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'PISCINA BVCC',
        'despesa',
        180.0,
        '2025-09-02'::DATE,
        '2025-09-02'::DATE,
        'pago',
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
        '2025-01-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 15: JULIO (2025-01-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-25'::DATE 
    AND UPPER(nome) = 'JULIO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JULIO',
      v_tipo_id,
      '2025-01-25'::DATE,
      600.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JULIO',
      'receita',
      600.0,
      '2025-09-02'::DATE,
      '2025-09-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'JULIO',
        'despesa',
        180.0,
        '2025-09-02'::DATE,
        '2025-09-02'::DATE,
        'pago',
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
        '2025-01-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 16: LUISE (2025-01-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-25'::DATE 
    AND UPPER(nome) = 'LUISE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LUISE',
      v_tipo_id,
      '2025-01-25'::DATE,
      1050.0,
      315.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LUISE',
      'receita',
      1050.0,
      '2025-09-02'::DATE,
      '2025-09-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'LUISE',
        'despesa',
        200.0,
        '2025-09-02'::DATE,
        '2025-09-02'::DATE,
        'pago',
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
        '2025-01-25'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'LUISE',
        'despesa',
        180.0,
        '2025-09-02'::DATE,
        '2025-09-02'::DATE,
        'pago',
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
        '2025-01-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 17: BRUNA (2025-01-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-25'::DATE 
    AND UPPER(nome) = 'BRUNA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BRUNA',
      v_tipo_id,
      '2025-01-25'::DATE,
      690.0,
      207.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BRUNA',
      'receita',
      690.0,
      '2025-09-02'::DATE,
      '2025-09-02'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'BRUNA',
        'despesa',
        200.0,
        '2025-09-02'::DATE,
        '2025-09-02'::DATE,
        'pago',
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
        '2025-01-25'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 18: ESPAÇO KIDS (2025-01-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-01-08'::DATE 
    AND UPPER(nome) = 'ESPAÇO KIDS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ESPAÇO KIDS',
      v_tipo_id,
      '2025-01-08'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Jojo (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'ESPAÇO KIDS',
        'despesa',
        180.0,
        '2025-01-23'::DATE,
        '2025-01-23'::DATE,
        'pago',
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
        '2025-01-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 600.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'ESPAÇO KIDS',
        'despesa',
        600.0,
        '2025-01-23'::DATE,
        '2025-01-23'::DATE,
        'pago',
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
        '2025-01-08'::DATE,
        600.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 19: ALEXANDRA (2025-02-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-01'::DATE 
    AND UPPER(nome) = 'ALEXANDRA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ALEXANDRA',
      v_tipo_id,
      '2025-02-01'::DATE,
      980.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ALEXANDRA',
      'receita',
      980.0,
      '2025-02-16'::DATE,
      '2025-02-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ALEXANDRA',
        'despesa',
        200.0,
        '2025-02-16'::DATE,
        '2025-02-16'::DATE,
        'pago',
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
        '2025-02-01'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 20: DANIELA (2025-02-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-01'::DATE 
    AND UPPER(nome) = 'DANIELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'DANIELA',
      v_tipo_id,
      '2025-02-01'::DATE,
      990.0,
      297.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'DANIELA',
      'receita',
      990.0,
      '2025-02-16'::DATE,
      '2025-02-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'DANIELA',
        'despesa',
        180.0,
        '2025-02-16'::DATE,
        '2025-02-16'::DATE,
        'pago',
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
        '2025-02-01'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'DANIELA',
        'despesa',
        180.0,
        '2025-02-16'::DATE,
        '2025-02-16'::DATE,
        'pago',
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
        '2025-02-01'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 21: PISCINA BVCC (2025-02-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-01'::DATE 
    AND UPPER(nome) = 'PISCINA BVCC'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PISCINA BVCC',
      v_tipo_id,
      '2025-02-01'::DATE,
      1400.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PISCINA BVCC',
      'receita',
      1400.0,
      '2025-02-16'::DATE,
      '2025-02-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'PISCINA BVCC',
        'despesa',
        180.0,
        '2025-02-16'::DATE,
        '2025-02-16'::DATE,
        'pago',
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
        '2025-02-01'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pedrita (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pedrita') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pedrita - ' || 'PISCINA BVCC',
        'despesa',
        180.0,
        '2025-02-16'::DATE,
        '2025-02-16'::DATE,
        'pago',
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
        '2025-02-01'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 22: MAIARA (2025-02-02)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-02'::DATE 
    AND UPPER(nome) = 'MAIARA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MAIARA',
      v_tipo_id,
      '2025-02-02'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MAIARA',
      'receita',
      730.0,
      '2025-02-17'::DATE,
      '2025-02-17'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MAIARA',
        'despesa',
        200.0,
        '2025-02-17'::DATE,
        '2025-02-17'::DATE,
        'pago',
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
        '2025-02-02'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 23: JACKIE (2025-02-02)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-02'::DATE 
    AND UPPER(nome) = 'JACKIE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JACKIE',
      v_tipo_id,
      '2025-02-02'::DATE,
      600.0,
      180.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JACKIE',
      'receita',
      600.0,
      '2025-02-17'::DATE,
      '2025-02-17'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'JACKIE',
        'despesa',
        150.0,
        '2025-02-17'::DATE,
        '2025-02-17'::DATE,
        'pago',
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
        '2025-02-02'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 24: FERNANDA (2025-02-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-08'::DATE 
    AND UPPER(nome) = 'FERNANDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FERNANDA',
      v_tipo_id,
      '2025-02-08'::DATE,
      1030.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FERNANDA',
      'receita',
      1030.0,
      '2025-02-23'::DATE,
      '2025-02-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'FERNANDA',
        'despesa',
        200.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 25: PISCINA BVCC (2025-02-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-08'::DATE 
    AND UPPER(nome) = 'PISCINA BVCC'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PISCINA BVCC',
      v_tipo_id,
      '2025-02-08'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'PISCINA BVCC',
        'despesa',
        180.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'PISCINA BVCC',
        'despesa',
        180.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 26: ALINE (2025-02-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-08'::DATE 
    AND UPPER(nome) = 'ALINE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ALINE',
      v_tipo_id,
      '2025-02-08'::DATE,
      990.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ALINE',
      'receita',
      990.0,
      '2025-02-23'::DATE,
      '2025-02-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ALINE',
        'despesa',
        200.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'ALINE',
        'despesa',
        180.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 27: LUANA (2025-02-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-08'::DATE 
    AND UPPER(nome) = 'LUANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LUANA',
      v_tipo_id,
      '2025-02-08'::DATE,
      1500.0,
      546.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LUANA',
      'receita',
      1500.0,
      '2025-02-23'::DATE,
      '2025-02-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'LUANA',
        'despesa',
        180.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'LUANA',
        'despesa',
        180.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 28: DEBORA (2025-02-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-08'::DATE 
    AND UPPER(nome) = 'DEBORA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'DEBORA',
      v_tipo_id,
      '2025-02-08'::DATE,
      1200.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'DEBORA',
      'receita',
      1200.0,
      '2025-02-23'::DATE,
      '2025-02-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Plutos (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'DEBORA',
        'despesa',
        180.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'DEBORA',
        'despesa',
        30.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 29: ALINE HAKA (2025-02-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-08'::DATE 
    AND UPPER(nome) = 'ALINE HAKA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ALINE HAKA',
      v_tipo_id,
      '2025-02-08'::DATE,
      850.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ALINE HAKA',
      'receita',
      850.0,
      '2025-02-23'::DATE,
      '2025-02-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'ALINE HAKA',
        'despesa',
        180.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Juci (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Juci') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Juci - ' || 'ALINE HAKA',
        'despesa',
        180.0,
        '2025-02-23'::DATE,
        '2025-02-23'::DATE,
        'pago',
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
        '2025-02-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 30: ELIANY (2025-02-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-09'::DATE 
    AND UPPER(nome) = 'ELIANY'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ELIANY',
      v_tipo_id,
      '2025-02-09'::DATE,
      730.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ELIANY',
      'receita',
      730.0,
      '2025-02-24'::DATE,
      '2025-02-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'ELIANY',
        'despesa',
        180.0,
        '2025-02-24'::DATE,
        '2025-02-24'::DATE,
        'pago',
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
        '2025-02-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 31: JUSSARA (2025-02-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-09'::DATE 
    AND UPPER(nome) = 'JUSSARA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JUSSARA',
      v_tipo_id,
      '2025-02-09'::DATE,
      1470.0,
      300.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JUSSARA',
      'receita',
      1470.0,
      '2025-02-24'::DATE,
      '2025-02-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'JUSSARA',
        'despesa',
        200.0,
        '2025-02-24'::DATE,
        '2025-02-24'::DATE,
        'pago',
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
        '2025-02-09'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Vick (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Vick') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Vick - ' || 'JUSSARA',
        'despesa',
        180.0,
        '2025-02-24'::DATE,
        '2025-02-24'::DATE,
        'pago',
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
        '2025-02-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 32: AMANDA (2025-02-14)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-14'::DATE 
    AND UPPER(nome) = 'AMANDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'AMANDA',
      v_tipo_id,
      '2025-02-14'::DATE,
      1400.0,
      420.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'AMANDA',
      'receita',
      1400.0,
      '2025-01-03'::DATE,
      '2025-01-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'AMANDA',
        'despesa',
        200.0,
        '2025-01-03'::DATE,
        '2025-01-03'::DATE,
        'pago',
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
        '2025-02-14'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'AMANDA',
        'despesa',
        180.0,
        '2025-01-03'::DATE,
        '2025-01-03'::DATE,
        'pago',
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
        '2025-02-14'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 33: GRAZIELA (2025-02-14)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-14'::DATE 
    AND UPPER(nome) = 'GRAZIELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GRAZIELA',
      v_tipo_id,
      '2025-02-14'::DATE,
      650.0,
      195.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GRAZIELA',
      'receita',
      650.0,
      '2025-01-03'::DATE,
      '2025-01-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'GRAZIELA',
        'despesa',
        150.0,
        '2025-01-03'::DATE,
        '2025-01-03'::DATE,
        'pago',
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
        '2025-02-14'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 34: FERNANDO (2025-02-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-15'::DATE 
    AND UPPER(nome) = 'FERNANDO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FERNANDO',
      v_tipo_id,
      '2025-02-15'::DATE,
      320.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FERNANDO',
      'receita',
      320.0,
      '2025-02-03'::DATE,
      '2025-02-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'FERNANDO',
        'despesa',
        180.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 35: BELA FOLIA (2025-02-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-15'::DATE 
    AND UPPER(nome) = 'BELA FOLIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BELA FOLIA',
      v_tipo_id,
      '2025-02-15'::DATE,
      4200.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BELA FOLIA',
      'receita',
      4200.0,
      '2025-02-03'::DATE,
      '2025-02-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'BELA FOLIA',
        'despesa',
        210.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'BELA FOLIA',
        'despesa',
        210.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'BELA FOLIA',
        'despesa',
        210.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Juci (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Juci') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Juci - ' || 'BELA FOLIA',
        'despesa',
        210.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 36: ROBERTA RDK (2025-02-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-15'::DATE 
    AND UPPER(nome) = 'ROBERTA RDK'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ROBERTA RDK',
      v_tipo_id,
      '2025-02-15'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ROBERTA RDK',
      'receita',
      1090.0,
      '2025-02-03'::DATE,
      '2025-02-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'ROBERTA RDK',
        'despesa',
        180.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'ROBERTA RDK',
        'despesa',
        180.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 37: BRUNA (2025-02-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-15'::DATE 
    AND UPPER(nome) = 'BRUNA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BRUNA',
      v_tipo_id,
      '2025-02-15'::DATE,
      1480.0,
      315.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BRUNA',
      'receita',
      1480.0,
      '2025-02-03'::DATE,
      '2025-02-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'BRUNA',
        'despesa',
        200.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 38: ANA LUISA (2025-02-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-15'::DATE 
    AND UPPER(nome) = 'ANA LUISA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA LUISA',
      v_tipo_id,
      '2025-02-15'::DATE,
      1440.0,
      432.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA LUISA',
      'receita',
      1440.0,
      '2025-02-03'::DATE,
      '2025-02-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ANA LUISA',
        'despesa',
        200.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'ANA LUISA',
        'despesa',
        180.0,
        '2025-02-03'::DATE,
        '2025-02-03'::DATE,
        'pago',
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
        '2025-02-15'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 39: TATA (2025-02-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-16'::DATE 
    AND UPPER(nome) = 'TATA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TATA',
      v_tipo_id,
      '2025-02-16'::DATE,
      2430.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TATA',
      'receita',
      2430.0,
      '2025-03-03'::DATE,
      '2025-03-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 290.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'TATA',
        'despesa',
        290.0,
        '2025-03-03'::DATE,
        '2025-03-03'::DATE,
        'pago',
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
        '2025-02-16'::DATE,
        290.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 270.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'TATA',
        'despesa',
        270.0,
        '2025-03-03'::DATE,
        '2025-03-03'::DATE,
        'pago',
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
        '2025-02-16'::DATE,
        270.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 40: MANIA DE BRINCAR (2025-02-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-22'::DATE 
    AND UPPER(nome) = 'MANIA DE BRINCAR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MANIA DE BRINCAR',
      v_tipo_id,
      '2025-02-22'::DATE,
      780.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MANIA DE BRINCAR',
      'receita',
      780.0,
      '2025-09-03'::DATE,
      '2025-09-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'MANIA DE BRINCAR',
        'despesa',
        180.0,
        '2025-09-03'::DATE,
        '2025-09-03'::DATE,
        'pago',
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
        '2025-02-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'MANIA DE BRINCAR',
        'despesa',
        180.0,
        '2025-09-03'::DATE,
        '2025-09-03'::DATE,
        'pago',
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
        '2025-02-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 41: CAMILA (2025-02-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-22'::DATE 
    AND UPPER(nome) = 'CAMILA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAMILA',
      v_tipo_id,
      '2025-02-22'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAMILA',
      'receita',
      1090.0,
      '2025-09-03'::DATE,
      '2025-09-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Plutos (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'CAMILA',
        'despesa',
        180.0,
        '2025-09-03'::DATE,
        '2025-09-03'::DATE,
        'pago',
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
        '2025-02-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'CAMILA',
        'despesa',
        30.0,
        '2025-09-03'::DATE,
        '2025-09-03'::DATE,
        'pago',
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
        '2025-02-22'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'CAMILA',
        'despesa',
        180.0,
        '2025-09-03'::DATE,
        '2025-09-03'::DATE,
        'pago',
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
        '2025-02-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 42: BRUNA (2025-02-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-22'::DATE 
    AND UPPER(nome) = 'BRUNA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BRUNA',
      v_tipo_id,
      '2025-02-22'::DATE,
      1400.0,
      420.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BRUNA',
      'receita',
      1400.0,
      '2025-09-03'::DATE,
      '2025-09-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'BRUNA',
        'despesa',
        180.0,
        '2025-09-03'::DATE,
        '2025-09-03'::DATE,
        'pago',
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
        '2025-02-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'BRUNA',
        'despesa',
        180.0,
        '2025-09-03'::DATE,
        '2025-09-03'::DATE,
        'pago',
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
        '2025-02-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 43: BRUNA (2025-02-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-22'::DATE 
    AND UPPER(nome) = 'BRUNA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BRUNA',
      v_tipo_id,
      '2025-02-22'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BRUNA',
      'receita',
      730.0,
      '2025-09-03'::DATE,
      '2025-09-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'BRUNA',
        'despesa',
        200.0,
        '2025-09-03'::DATE,
        '2025-09-03'::DATE,
        'pago',
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
        '2025-02-22'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 44: ANGÉLICA (2025-02-23)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-23'::DATE 
    AND UPPER(nome) = 'ANGÉLICA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANGÉLICA',
      v_tipo_id,
      '2025-02-23'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANGÉLICA',
      'receita',
      1090.0,
      '2025-10-03'::DATE,
      '2025-10-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ANGÉLICA',
        'despesa',
        200.0,
        '2025-10-03'::DATE,
        '2025-10-03'::DATE,
        'pago',
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
        '2025-02-23'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'ANGÉLICA',
        'despesa',
        180.0,
        '2025-10-03'::DATE,
        '2025-10-03'::DATE,
        'pago',
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
        '2025-02-23'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 45: GISELIA (2025-02-23)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-23'::DATE 
    AND UPPER(nome) = 'GISELIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GISELIA',
      v_tipo_id,
      '2025-02-23'::DATE,
      780.0,
      234.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GISELIA',
      'receita',
      780.0,
      '2025-10-03'::DATE,
      '2025-10-03'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Pucca (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pucca') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pucca - ' || 'GISELIA',
        'despesa',
        200.0,
        '2025-10-03'::DATE,
        '2025-10-03'::DATE,
        'pago',
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
        '2025-02-23'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 46: EXCELSIOR (2025-02-10)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-10'::DATE 
    AND UPPER(nome) = 'EXCELSIOR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'EXCELSIOR',
      v_tipo_id,
      '2025-02-10'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Poc (R$ 260.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'EXCELSIOR',
        'despesa',
        260.0,
        '2025-02-25'::DATE,
        '2025-02-25'::DATE,
        'pago',
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
        '2025-02-10'::DATE,
        260.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'EXCELSIOR',
        'despesa',
        240.0,
        '2025-02-25'::DATE,
        '2025-02-25'::DATE,
        'pago',
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
        '2025-02-10'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'EXCELSIOR',
        'despesa',
        30.0,
        '2025-02-25'::DATE,
        '2025-02-25'::DATE,
        'pago',
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
        '2025-02-10'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'EXCELSIOR',
        'despesa',
        150.0,
        '2025-02-25'::DATE,
        '2025-02-25'::DATE,
        'pago',
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
        '2025-02-10'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 47: MASCOTE BONJA (2025-02-10)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-10'::DATE 
    AND UPPER(nome) = 'MASCOTE BONJA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MASCOTE BONJA',
      v_tipo_id,
      '2025-02-10'::DATE,
      1400.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MASCOTE BONJA',
      'receita',
      1400.0,
      '2025-02-25'::DATE,
      '2025-02-25'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'MASCOTE BONJA',
        'despesa',
        150.0,
        '2025-02-25'::DATE,
        '2025-02-25'::DATE,
        'pago',
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
        '2025-02-10'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 48: JACY BENÍCIO (2025-02-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-02-12'::DATE 
    AND UPPER(nome) = 'JACY BENÍCIO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JACY BENÍCIO',
      v_tipo_id,
      '2025-02-12'::DATE,
      1220.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JACY BENÍCIO',
      'receita',
      1220.0,
      '2025-02-27'::DATE,
      '2025-02-27'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'JACY BENÍCIO',
        'despesa',
        180.0,
        '2025-02-27'::DATE,
        '2025-02-27'::DATE,
        'pago',
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
        '2025-02-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'JACY BENÍCIO',
        'despesa',
        180.0,
        '2025-02-27'::DATE,
        '2025-02-27'::DATE,
        'pago',
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
        '2025-02-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'JACY BENÍCIO',
        'despesa',
        30.0,
        '2025-02-27'::DATE,
        '2025-02-27'::DATE,
        'pago',
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
        '2025-02-12'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 49: FAZENDA EVARISTO (2025-03-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-01'::DATE 
    AND UPPER(nome) = 'FAZENDA EVARISTO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FAZENDA EVARISTO',
      v_tipo_id,
      '2025-03-01'::DATE,
      2000.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FAZENDA EVARISTO',
      'receita',
      2000.0,
      '2025-03-16'::DATE,
      '2025-03-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 600.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'FAZENDA EVARISTO',
        'despesa',
        600.0,
        '2025-03-16'::DATE,
        '2025-03-16'::DATE,
        'pago',
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
        '2025-03-01'::DATE,
        600.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 600.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'FAZENDA EVARISTO',
        'despesa',
        600.0,
        '2025-03-16'::DATE,
        '2025-03-16'::DATE,
        'pago',
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
        '2025-03-01'::DATE,
        600.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 50: MARAMBAIA CARNAVAL (2025-03-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-01'::DATE 
    AND UPPER(nome) = 'MARAMBAIA CARNAVAL'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARAMBAIA CARNAVAL',
      v_tipo_id,
      '2025-03-01'::DATE,
      2300.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARAMBAIA CARNAVAL',
      'receita',
      2300.0,
      '2025-03-16'::DATE,
      '2025-03-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Leka (R$ 510.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Leka') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Leka - ' || 'MARAMBAIA CARNAVAL',
        'despesa',
        510.0,
        '2025-03-16'::DATE,
        '2025-03-16'::DATE,
        'pago',
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
        '2025-03-01'::DATE,
        510.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Leka (R$ 340.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Leka') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Leka - ' || 'MARAMBAIA CARNAVAL',
        'despesa',
        340.0,
        '2025-03-16'::DATE,
        '2025-03-16'::DATE,
        'pago',
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
        '2025-03-01'::DATE,
        340.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Ravena (R$ 510.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Ravena') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Ravena - ' || 'MARAMBAIA CARNAVAL',
        'despesa',
        510.0,
        '2025-03-16'::DATE,
        '2025-03-16'::DATE,
        'pago',
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
        '2025-03-01'::DATE,
        510.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 51: JENNI (2025-03-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-01'::DATE 
    AND UPPER(nome) = 'JENNI'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JENNI',
      v_tipo_id,
      '2025-03-01'::DATE,
      1640.0,
      315.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JENNI',
      'receita',
      1640.0,
      '2025-03-16'::DATE,
      '2025-03-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'JENNI',
        'despesa',
        180.0,
        '2025-03-16'::DATE,
        '2025-03-16'::DATE,
        'pago',
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
        '2025-03-01'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'JENNI',
        'despesa',
        180.0,
        '2025-03-16'::DATE,
        '2025-03-16'::DATE,
        'pago',
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
        '2025-03-01'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 52: OSTERFEST (2025-03-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-01'::DATE 
    AND UPPER(nome) = 'OSTERFEST'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'OSTERFEST',
      v_tipo_id,
      '2025-03-01'::DATE,
      39000.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'OSTERFEST',
      'receita',
      39000.0,
      '2025-03-16'::DATE,
      '2025-03-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'OSTERFEST',
        'despesa',
        180.0,
        '2025-03-16'::DATE,
        '2025-03-16'::DATE,
        'pago',
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
        '2025-03-01'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 53: ANA CAROLINE (2025-03-07)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-07'::DATE 
    AND UPPER(nome) = 'ANA CAROLINE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA CAROLINE',
      v_tipo_id,
      '2025-03-07'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA CAROLINE',
      'receita',
      730.0,
      '2025-03-22'::DATE,
      '2025-03-22'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 185.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ANA CAROLINE',
        'despesa',
        185.0,
        '2025-03-22'::DATE,
        '2025-03-22'::DATE,
        'pago',
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
        '2025-03-07'::DATE,
        185.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 165.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'ANA CAROLINE',
        'despesa',
        165.0,
        '2025-03-22'::DATE,
        '2025-03-22'::DATE,
        'pago',
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
        '2025-03-07'::DATE,
        165.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 54: PATRICIA (2025-03-07)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-07'::DATE 
    AND UPPER(nome) = 'PATRICIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PATRICIA',
      v_tipo_id,
      '2025-03-07'::DATE,
      870.0,
      435.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PATRICIA',
      'receita',
      870.0,
      '2025-03-22'::DATE,
      '2025-03-22'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'PATRICIA',
        'despesa',
        180.0,
        '2025-03-22'::DATE,
        '2025-03-22'::DATE,
        'pago',
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
        '2025-03-07'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'PATRICIA',
        'despesa',
        180.0,
        '2025-03-22'::DATE,
        '2025-03-22'::DATE,
        'pago',
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
        '2025-03-07'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 55: LARISSA (2025-03-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-08'::DATE 
    AND UPPER(nome) = 'LARISSA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LARISSA',
      v_tipo_id,
      '2025-03-08'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LARISSA',
      'receita',
      1090.0,
      '2025-03-23'::DATE,
      '2025-03-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'LARISSA',
        'despesa',
        180.0,
        '2025-03-23'::DATE,
        '2025-03-23'::DATE,
        'pago',
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
        '2025-03-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'LARISSA',
        'despesa',
        180.0,
        '2025-03-23'::DATE,
        '2025-03-23'::DATE,
        'pago',
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
        '2025-03-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'LARISSA',
        'despesa',
        180.0,
        '2025-03-23'::DATE,
        '2025-03-23'::DATE,
        'pago',
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
        '2025-03-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 56: ANA (2025-03-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-08'::DATE 
    AND UPPER(nome) = 'ANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA',
      v_tipo_id,
      '2025-03-08'::DATE,
      1450.0,
      435.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA',
      'receita',
      1450.0,
      '2025-03-23'::DATE,
      '2025-03-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jojo (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'ANA',
        'despesa',
        210.0,
        '2025-03-23'::DATE,
        '2025-03-23'::DATE,
        'pago',
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
        '2025-03-08'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'ANA',
        'despesa',
        210.0,
        '2025-03-23'::DATE,
        '2025-03-23'::DATE,
        'pago',
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
        '2025-03-08'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 57: SUELEN (2025-03-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-08'::DATE 
    AND UPPER(nome) = 'SUELEN'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SUELEN',
      v_tipo_id,
      '2025-03-08'::DATE,
      2550.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SUELEN',
      'receita',
      2550.0,
      '2025-03-23'::DATE,
      '2025-03-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 230.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'SUELEN',
        'despesa',
        230.0,
        '2025-03-23'::DATE,
        '2025-03-23'::DATE,
        'pago',
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
        '2025-03-08'::DATE,
        230.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'SUELEN',
        'despesa',
        210.0,
        '2025-03-23'::DATE,
        '2025-03-23'::DATE,
        'pago',
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
        '2025-03-08'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'SUELEN',
        'despesa',
        210.0,
        '2025-03-23'::DATE,
        '2025-03-23'::DATE,
        'pago',
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
        '2025-03-08'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 58: GREICE (2025-03-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-09'::DATE 
    AND UPPER(nome) = 'GREICE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GREICE',
      v_tipo_id,
      '2025-03-09'::DATE,
      2500.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GREICE',
      'receita',
      2500.0,
      '2025-03-24'::DATE,
      '2025-03-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'GREICE',
        'despesa',
        180.0,
        '2025-03-24'::DATE,
        '2025-03-24'::DATE,
        'pago',
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
        '2025-03-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 59: KARINE (2025-03-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-09'::DATE 
    AND UPPER(nome) = 'KARINE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'KARINE',
      v_tipo_id,
      '2025-03-09'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'KARINE',
      'receita',
      730.0,
      '2025-03-24'::DATE,
      '2025-03-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'KARINE',
        'despesa',
        180.0,
        '2025-03-24'::DATE,
        '2025-03-24'::DATE,
        'pago',
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
        '2025-03-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 60: CARLA (2025-03-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-09'::DATE 
    AND UPPER(nome) = 'CARLA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CARLA',
      v_tipo_id,
      '2025-03-09'::DATE,
      1540.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CARLA',
      'receita',
      1540.0,
      '2025-03-24'::DATE,
      '2025-03-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'CARLA',
        'despesa',
        180.0,
        '2025-03-24'::DATE,
        '2025-03-24'::DATE,
        'pago',
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
        '2025-03-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'CARLA',
        'despesa',
        200.0,
        '2025-03-24'::DATE,
        '2025-03-24'::DATE,
        'pago',
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
        '2025-03-09'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'CARLA',
        'despesa',
        180.0,
        '2025-03-24'::DATE,
        '2025-03-24'::DATE,
        'pago',
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
        '2025-03-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'CARLA',
        'despesa',
        180.0,
        '2025-03-24'::DATE,
        '2025-03-24'::DATE,
        'pago',
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
        '2025-03-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 61: FESTIVAL DA CERVEJA (2025-03-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-12'::DATE 
    AND UPPER(nome) = 'FESTIVAL DA CERVEJA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FESTIVAL DA CERVEJA',
      v_tipo_id,
      '2025-03-12'::DATE,
      30.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FESTIVAL DA CERVEJA',
      'receita',
      30.0,
      '2025-03-27'::DATE,
      '2025-03-27'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 320.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'FESTIVAL DA CERVEJA',
        'despesa',
        320.0,
        '2025-03-27'::DATE,
        '2025-03-27'::DATE,
        'pago',
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
        '2025-03-12'::DATE,
        320.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 300.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'FESTIVAL DA CERVEJA',
        'despesa',
        300.0,
        '2025-03-27'::DATE,
        '2025-03-27'::DATE,
        'pago',
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
        '2025-03-12'::DATE,
        300.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 300.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'FESTIVAL DA CERVEJA',
        'despesa',
        300.0,
        '2025-03-27'::DATE,
        '2025-03-27'::DATE,
        'pago',
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
        '2025-03-12'::DATE,
        300.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 300.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'FESTIVAL DA CERVEJA',
        'despesa',
        300.0,
        '2025-03-27'::DATE,
        '2025-03-27'::DATE,
        'pago',
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
        '2025-03-12'::DATE,
        300.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 62: FESTIVAL DA CERVEJA (2025-03-14)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-14'::DATE 
    AND UPPER(nome) = 'FESTIVAL DA CERVEJA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FESTIVAL DA CERVEJA',
      v_tipo_id,
      '2025-03-14'::DATE,
      640.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FESTIVAL DA CERVEJA',
      'receita',
      640.0,
      '2025-03-29'::DATE,
      '2025-03-29'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'FESTIVAL DA CERVEJA',
        'despesa',
        240.0,
        '2025-03-29'::DATE,
        '2025-03-29'::DATE,
        'pago',
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
        '2025-03-14'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'FESTIVAL DA CERVEJA',
        'despesa',
        240.0,
        '2025-03-29'::DATE,
        '2025-03-29'::DATE,
        'pago',
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
        '2025-03-14'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'FESTIVAL DA CERVEJA',
        'despesa',
        240.0,
        '2025-03-29'::DATE,
        '2025-03-29'::DATE,
        'pago',
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
        '2025-03-14'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 63: FESTIVAL DA CERVEJA (2025-03-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-15'::DATE 
    AND UPPER(nome) = 'FESTIVAL DA CERVEJA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FESTIVAL DA CERVEJA',
      v_tipo_id,
      '2025-03-15'::DATE,
      1850.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FESTIVAL DA CERVEJA',
      'receita',
      1850.0,
      '2025-03-30'::DATE,
      '2025-03-30'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'FESTIVAL DA CERVEJA',
        'despesa',
        150.0,
        '2025-03-30'::DATE,
        '2025-03-30'::DATE,
        'pago',
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
        '2025-03-15'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Samurai (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Samurai') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Samurai - ' || 'FESTIVAL DA CERVEJA',
        'despesa',
        150.0,
        '2025-03-30'::DATE,
        '2025-03-30'::DATE,
        'pago',
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
        '2025-03-15'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 64: EVENTO AD HERING (2025-03-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-15'::DATE 
    AND UPPER(nome) = 'EVENTO AD HERING'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'EVENTO AD HERING',
      v_tipo_id,
      '2025-03-15'::DATE,
      1880.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'EVENTO AD HERING',
      'receita',
      1880.0,
      '2025-03-30'::DATE,
      '2025-03-30'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'EVENTO AD HERING',
        'despesa',
        200.0,
        '2025-03-30'::DATE,
        '2025-03-30'::DATE,
        'pago',
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
        '2025-03-15'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 65: GAUCHO (2025-03-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-15'::DATE 
    AND UPPER(nome) = 'GAUCHO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GAUCHO',
      v_tipo_id,
      '2025-03-15'::DATE,
      1190.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GAUCHO',
      'receita',
      1190.0,
      '2025-03-30'::DATE,
      '2025-03-30'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'GAUCHO',
        'despesa',
        180.0,
        '2025-03-30'::DATE,
        '2025-03-30'::DATE,
        'pago',
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
        '2025-03-15'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'GAUCHO',
        'despesa',
        180.0,
        '2025-03-30'::DATE,
        '2025-03-30'::DATE,
        'pago',
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
        '2025-03-15'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 66: NATALIA (2025-03-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-16'::DATE 
    AND UPPER(nome) = 'NATALIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'NATALIA',
      v_tipo_id,
      '2025-03-16'::DATE,
      1540.0,
      462.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'NATALIA',
      'receita',
      1540.0,
      '2025-03-31'::DATE,
      '2025-03-31'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Plutos (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'NATALIA',
        'despesa',
        180.0,
        '2025-03-31'::DATE,
        '2025-03-31'::DATE,
        'pago',
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
        '2025-03-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'NATALIA',
        'despesa',
        30.0,
        '2025-03-31'::DATE,
        '2025-03-31'::DATE,
        'pago',
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
        '2025-03-16'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'NATALIA',
        'despesa',
        180.0,
        '2025-03-31'::DATE,
        '2025-03-31'::DATE,
        'pago',
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
        '2025-03-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 67: RAFAELA (2025-03-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-16'::DATE 
    AND UPPER(nome) = 'RAFAELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'RAFAELA',
      v_tipo_id,
      '2025-03-16'::DATE,
      990.0,
      297.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'RAFAELA',
      'receita',
      990.0,
      '2025-03-31'::DATE,
      '2025-03-31'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'RAFAELA',
        'despesa',
        180.0,
        '2025-03-31'::DATE,
        '2025-03-31'::DATE,
        'pago',
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
        '2025-03-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Samurai (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Samurai') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Samurai - ' || 'RAFAELA',
        'despesa',
        180.0,
        '2025-03-31'::DATE,
        '2025-03-31'::DATE,
        'pago',
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
        '2025-03-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 68: BRUNA (2025-03-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-16'::DATE 
    AND UPPER(nome) = 'BRUNA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BRUNA',
      v_tipo_id,
      '2025-03-16'::DATE,
      2150.0,
      645.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BRUNA',
      'receita',
      2150.0,
      '2025-03-31'::DATE,
      '2025-03-31'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'BRUNA',
        'despesa',
        180.0,
        '2025-03-31'::DATE,
        '2025-03-31'::DATE,
        'pago',
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
        '2025-03-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Juci (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Juci') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Juci - ' || 'BRUNA',
        'despesa',
        180.0,
        '2025-03-31'::DATE,
        '2025-03-31'::DATE,
        'pago',
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
        '2025-03-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 69: SABRINA (2025-03-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-16'::DATE 
    AND UPPER(nome) = 'SABRINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SABRINA',
      v_tipo_id,
      '2025-03-16'::DATE,
      1800.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SABRINA',
      'receita',
      1800.0,
      '2025-03-31'::DATE,
      '2025-03-31'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'SABRINA',
        'despesa',
        200.0,
        '2025-03-31'::DATE,
        '2025-03-31'::DATE,
        'pago',
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
        '2025-03-16'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'SABRINA',
        'despesa',
        180.0,
        '2025-03-31'::DATE,
        '2025-03-31'::DATE,
        'pago',
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
        '2025-03-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 70: ELISABETH (2025-03-20)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-20'::DATE 
    AND UPPER(nome) = 'ELISABETH'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ELISABETH',
      v_tipo_id,
      '2025-03-20'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ELISABETH',
      'receita',
      1090.0,
      '2025-04-04'::DATE,
      '2025-04-04'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'ELISABETH',
        'despesa',
        180.0,
        '2025-04-04'::DATE,
        '2025-04-04'::DATE,
        'pago',
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
        '2025-03-20'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'ELISABETH',
        'despesa',
        180.0,
        '2025-04-04'::DATE,
        '2025-04-04'::DATE,
        'pago',
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
        '2025-03-20'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 71: IVANA (2025-03-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-22'::DATE 
    AND UPPER(nome) = 'IVANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'IVANA',
      v_tipo_id,
      '2025-03-22'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'IVANA',
      'receita',
      1090.0,
      '2025-06-04'::DATE,
      '2025-06-04'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'IVANA',
        'despesa',
        180.0,
        '2025-06-04'::DATE,
        '2025-06-04'::DATE,
        'pago',
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
        '2025-03-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'IVANA',
        'despesa',
        180.0,
        '2025-06-04'::DATE,
        '2025-06-04'::DATE,
        'pago',
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
        '2025-03-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 72: MANIA DE BRINCAR (2025-03-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-22'::DATE 
    AND UPPER(nome) = 'MANIA DE BRINCAR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MANIA DE BRINCAR',
      v_tipo_id,
      '2025-03-22'::DATE,
      780.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MANIA DE BRINCAR',
      'receita',
      780.0,
      '2025-06-04'::DATE,
      '2025-06-04'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'MANIA DE BRINCAR',
        'despesa',
        180.0,
        '2025-06-04'::DATE,
        '2025-06-04'::DATE,
        'pago',
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
        '2025-03-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Estrela (R$ 80.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'MANIA DE BRINCAR',
        'despesa',
        80.0,
        '2025-06-04'::DATE,
        '2025-06-04'::DATE,
        'pago',
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
        '2025-03-22'::DATE,
        80.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'MANIA DE BRINCAR',
        'despesa',
        180.0,
        '2025-06-04'::DATE,
        '2025-06-04'::DATE,
        'pago',
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
        '2025-03-22'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 73: ALINE (2025-03-23)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-23'::DATE 
    AND UPPER(nome) = 'ALINE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ALINE',
      v_tipo_id,
      '2025-03-23'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ALINE',
      'receita',
      1090.0,
      '2025-07-04'::DATE,
      '2025-07-04'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Plutos (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'ALINE',
        'despesa',
        180.0,
        '2025-07-04'::DATE,
        '2025-07-04'::DATE,
        'pago',
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
        '2025-03-23'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'ALINE',
        'despesa',
        30.0,
        '2025-07-04'::DATE,
        '2025-07-04'::DATE,
        'pago',
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
        '2025-03-23'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'ALINE',
        'despesa',
        180.0,
        '2025-07-04'::DATE,
        '2025-07-04'::DATE,
        'pago',
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
        '2025-03-23'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 74: ANGÉLICA (2025-03-29)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-29'::DATE 
    AND UPPER(nome) = 'ANGÉLICA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANGÉLICA',
      v_tipo_id,
      '2025-03-29'::DATE,
      1230.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANGÉLICA',
      'receita',
      1230.0,
      '2025-04-13'::DATE,
      '2025-04-13'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 75: GISELE (2025-03-29)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-29'::DATE 
    AND UPPER(nome) = 'GISELE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GISELE',
      v_tipo_id,
      '2025-03-29'::DATE,
      480.0,
      480.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GISELE',
      'receita',
      480.0,
      '2025-04-13'::DATE,
      '2025-04-13'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'GISELE',
        'despesa',
        180.0,
        '2025-04-13'::DATE,
        '2025-04-13'::DATE,
        'pago',
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
        '2025-03-29'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Moranguinho (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Moranguinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Moranguinho - ' || 'GISELE',
        'despesa',
        180.0,
        '2025-04-13'::DATE,
        '2025-04-13'::DATE,
        'pago',
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
        '2025-03-29'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 76: JAQUELINE (2025-03-29)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-29'::DATE 
    AND UPPER(nome) = 'JAQUELINE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JAQUELINE',
      v_tipo_id,
      '2025-03-29'::DATE,
      1780.0,
      534.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JAQUELINE',
      'receita',
      1780.0,
      '2025-04-13'::DATE,
      '2025-04-13'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'JAQUELINE',
        'despesa',
        200.0,
        '2025-04-13'::DATE,
        '2025-04-13'::DATE,
        'pago',
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
        '2025-03-29'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 77: CAMILA (2025-03-29)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-29'::DATE 
    AND UPPER(nome) = 'CAMILA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAMILA',
      v_tipo_id,
      '2025-03-29'::DATE,
      730.0,
      300.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAMILA',
      'receita',
      730.0,
      '2025-04-13'::DATE,
      '2025-04-13'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'CAMILA',
        'despesa',
        210.0,
        '2025-04-13'::DATE,
        '2025-04-13'::DATE,
        'pago',
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
        '2025-03-29'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Moranguinho (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Moranguinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Moranguinho - ' || 'CAMILA',
        'despesa',
        210.0,
        '2025-04-13'::DATE,
        '2025-04-13'::DATE,
        'pago',
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
        '2025-03-29'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 78: JOSY (2025-03-30)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-30'::DATE 
    AND UPPER(nome) = 'JOSY'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JOSY',
      v_tipo_id,
      '2025-03-30'::DATE,
      1720.0,
      516.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JOSY',
      'receita',
      1720.0,
      '2025-04-14'::DATE,
      '2025-04-14'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'JOSY',
        'despesa',
        180.0,
        '2025-04-14'::DATE,
        '2025-04-14'::DATE,
        'pago',
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
        '2025-03-30'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'JOSY',
        'despesa',
        180.0,
        '2025-04-14'::DATE,
        '2025-04-14'::DATE,
        'pago',
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
        '2025-03-30'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 79: PAULA (2025-03-30)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-30'::DATE 
    AND UPPER(nome) = 'PAULA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PAULA',
      v_tipo_id,
      '2025-03-30'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PAULA',
      'receita',
      1090.0,
      '2025-04-14'::DATE,
      '2025-04-14'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Plutos (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'PAULA',
        'despesa',
        150.0,
        '2025-04-14'::DATE,
        '2025-04-14'::DATE,
        'pago',
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
        '2025-03-30'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'PAULA',
        'despesa',
        30.0,
        '2025-04-14'::DATE,
        '2025-04-14'::DATE,
        'pago',
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
        '2025-03-30'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 80: ESPAÇO KIDS (2025-03-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-03-26'::DATE 
    AND UPPER(nome) = 'ESPAÇO KIDS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ESPAÇO KIDS',
      v_tipo_id,
      '2025-03-26'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Jojo (R$ 900.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'ESPAÇO KIDS',
        'despesa',
        900.0,
        '2025-05-05'::DATE,
        '2025-05-05'::DATE,
        'pago',
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
        '2025-03-26'::DATE,
        900.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'ESPAÇO KIDS',
        'despesa',
        400.0,
        '2025-05-05'::DATE,
        '2025-05-05'::DATE,
        'pago',
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
        '2025-03-26'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 81: ESPAÇO KIDS (2025-04-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-01'::DATE 
    AND UPPER(nome) = 'ESPAÇO KIDS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ESPAÇO KIDS',
      v_tipo_id,
      '2025-04-01'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;
  END IF;

  -- Evento 82: AD HERING (2025-04-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-04'::DATE 
    AND UPPER(nome) = 'AD HERING'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'AD HERING',
      v_tipo_id,
      '2025-04-04'::DATE,
      250.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'AD HERING',
      'receita',
      250.0,
      '2025-04-19'::DATE,
      '2025-04-19'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 83: CORINGAS (2025-04-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-05'::DATE 
    AND UPPER(nome) = 'CORINGAS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CORINGAS',
      v_tipo_id,
      '2025-04-05'::DATE,
      610.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CORINGAS',
      'receita',
      610.0,
      '2025-04-20'::DATE,
      '2025-04-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Plutos (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'CORINGAS',
        'despesa',
        240.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'CORINGAS',
        'despesa',
        30.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Lady (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Lady') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Lady - ' || 'CORINGAS',
        'despesa',
        240.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 84: BUCHMANN (2025-04-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-05'::DATE 
    AND UPPER(nome) = 'BUCHMANN'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BUCHMANN',
      v_tipo_id,
      '2025-04-05'::DATE,
      1000.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BUCHMANN',
      'receita',
      1000.0,
      '2025-04-20'::DATE,
      '2025-04-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'BUCHMANN',
        'despesa',
        240.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'BUCHMANN',
        'despesa',
        240.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 85: TÂNIA (2025-04-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-05'::DATE 
    AND UPPER(nome) = 'TÂNIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TÂNIA',
      v_tipo_id,
      '2025-04-05'::DATE,
      1300.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TÂNIA',
      'receita',
      1300.0,
      '2025-04-20'::DATE,
      '2025-04-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Moranguinho (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Moranguinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Moranguinho - ' || 'TÂNIA',
        'despesa',
        180.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 86: MARLON (2025-04-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-05'::DATE 
    AND UPPER(nome) = 'MARLON'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARLON',
      v_tipo_id,
      '2025-04-05'::DATE,
      1120.0,
      333.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARLON',
      'receita',
      1120.0,
      '2025-04-20'::DATE,
      '2025-04-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 290.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MARLON',
        'despesa',
        290.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        290.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'MARLON',
        'despesa',
        30.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'MARLON',
        'despesa',
        240.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 270.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'MARLON',
        'despesa',
        270.0,
        '2025-04-20'::DATE,
        '2025-04-20'::DATE,
        'pago',
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
        '2025-04-05'::DATE,
        270.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 87: EVENTO BREITKOPF (2025-04-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-06'::DATE 
    AND UPPER(nome) = 'EVENTO BREITKOPF'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'EVENTO BREITKOPF',
      v_tipo_id,
      '2025-04-06'::DATE,
      2000.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'EVENTO BREITKOPF',
      'receita',
      2000.0,
      '2025-04-21'::DATE,
      '2025-04-21'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'EVENTO BREITKOPF',
        'despesa',
        180.0,
        '2025-04-21'::DATE,
        '2025-04-21'::DATE,
        'pago',
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
        '2025-04-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'EVENTO BREITKOPF',
        'despesa',
        180.0,
        '2025-04-21'::DATE,
        '2025-04-21'::DATE,
        'pago',
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
        '2025-04-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 88: CRISTIANE (2025-04-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-06'::DATE 
    AND UPPER(nome) = 'CRISTIANE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CRISTIANE',
      v_tipo_id,
      '2025-04-06'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CRISTIANE',
      'receita',
      1090.0,
      '2025-04-21'::DATE,
      '2025-04-21'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'CRISTIANE',
        'despesa',
        180.0,
        '2025-04-21'::DATE,
        '2025-04-21'::DATE,
        'pago',
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
        '2025-04-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Moranguinho (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Moranguinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Moranguinho - ' || 'CRISTIANE',
        'despesa',
        180.0,
        '2025-04-21'::DATE,
        '2025-04-21'::DATE,
        'pago',
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
        '2025-04-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Estrela (R$ 80.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'CRISTIANE',
        'despesa',
        80.0,
        '2025-04-21'::DATE,
        '2025-04-21'::DATE,
        'pago',
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
        '2025-04-06'::DATE,
        80.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 89: MARCELA (2025-04-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-06'::DATE 
    AND UPPER(nome) = 'MARCELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARCELA',
      v_tipo_id,
      '2025-04-06'::DATE,
      1150.0,
      1000.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARCELA',
      'receita',
      1150.0,
      '2025-04-21'::DATE,
      '2025-04-21'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'MARCELA',
        'despesa',
        180.0,
        '2025-04-21'::DATE,
        '2025-04-21'::DATE,
        'pago',
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
        '2025-04-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Crystal (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Crystal') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Crystal - ' || 'MARCELA',
        'despesa',
        180.0,
        '2025-04-21'::DATE,
        '2025-04-21'::DATE,
        'pago',
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
        '2025-04-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 90: PAULA (2025-04-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-09'::DATE 
    AND UPPER(nome) = 'PAULA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PAULA',
      v_tipo_id,
      '2025-04-09'::DATE,
      850.0,
      255.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PAULA',
      'receita',
      850.0,
      '2025-04-24'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 350.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'PAULA',
        'despesa',
        350.0,
        '2025-04-24'::DATE,
        NULL,
        'pendente',
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
        '2025-04-09'::DATE,
        350.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Estrela (R$ 350.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'PAULA',
        'despesa',
        350.0,
        '2025-04-24'::DATE,
        NULL,
        'pendente',
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
        '2025-04-09'::DATE,
        350.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 350.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'PAULA',
        'despesa',
        350.0,
        '2025-04-24'::DATE,
        NULL,
        'pendente',
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
        '2025-04-09'::DATE,
        350.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 350.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'PAULA',
        'despesa',
        350.0,
        '2025-04-24'::DATE,
        NULL,
        'pendente',
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
        '2025-04-09'::DATE,
        350.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 350.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'PAULA',
        'despesa',
        350.0,
        '2025-04-24'::DATE,
        NULL,
        'pendente',
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
        '2025-04-09'::DATE,
        350.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 91: UNICAMP (2025-04-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-25'::DATE 
    AND UPPER(nome) = 'UNICAMP'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'UNICAMP',
      v_tipo_id,
      '2025-04-25'::DATE,
      4780.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'UNICAMP',
      'receita',
      4780.0,
      '2025-10-05'::DATE,
      '2025-10-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'UNICAMP',
        'despesa',
        200.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'UNICAMP',
        'despesa',
        180.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Samurai (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Samurai') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Samurai - ' || 'UNICAMP',
        'despesa',
        180.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Ana (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Ana') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Ana - ' || 'UNICAMP',
        'despesa',
        180.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Nanda (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Nanda') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Nanda - ' || 'UNICAMP',
        'despesa',
        180.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'UNICAMP',
        'despesa',
        180.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'UNICAMP',
        'despesa',
        180.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Crystal (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Crystal') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Crystal - ' || 'UNICAMP',
        'despesa',
        180.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Paola (R$ 100.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Paola') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Paola - ' || 'UNICAMP',
        'despesa',
        100.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        100.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'UNICAMP',
        'despesa',
        180.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Neia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Neia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Neia - ' || 'UNICAMP',
        'despesa',
        180.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 92: SAGRADA (2025-04-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-12'::DATE 
    AND UPPER(nome) = 'SAGRADA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SAGRADA',
      v_tipo_id,
      '2025-04-12'::DATE,
      9400.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SAGRADA',
      'receita',
      9400.0,
      '2025-04-27'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 440.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'SAGRADA',
        'despesa',
        440.0,
        '2025-04-27'::DATE,
        NULL,
        'pendente',
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
        '2025-04-12'::DATE,
        440.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 440.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'SAGRADA',
        'despesa',
        440.0,
        '2025-04-27'::DATE,
        NULL,
        'pendente',
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
        '2025-04-12'::DATE,
        440.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Paola (R$ 230.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Paola') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Paola - ' || 'SAGRADA',
        'despesa',
        230.0,
        '2025-04-27'::DATE,
        NULL,
        'pendente',
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
        '2025-04-12'::DATE,
        230.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Cintia (R$ 300.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Cintia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Cintia - ' || 'SAGRADA',
        'despesa',
        300.0,
        '2025-04-27'::DATE,
        NULL,
        'pendente',
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
        '2025-04-12'::DATE,
        300.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Samurai (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Samurai') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Samurai - ' || 'SAGRADA',
        'despesa',
        240.0,
        '2025-04-27'::DATE,
        NULL,
        'pendente',
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
        '2025-04-12'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Ana Samurai (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Ana Samurai') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Ana Samurai - ' || 'SAGRADA',
        'despesa',
        240.0,
        '2025-04-27'::DATE,
        NULL,
        'pendente',
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
        '2025-04-12'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'SAGRADA',
        'despesa',
        240.0,
        '2025-04-27'::DATE,
        NULL,
        'pendente',
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
        '2025-04-12'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'SAGRADA',
        'despesa',
        240.0,
        '2025-04-27'::DATE,
        NULL,
        'pendente',
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
        '2025-04-12'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Nanda (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Nanda') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Nanda - ' || 'SAGRADA',
        'despesa',
        240.0,
        '2025-04-27'::DATE,
        NULL,
        'pendente',
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
        '2025-04-12'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 93: OMAS HAUS (2025-05-10)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-10'::DATE 
    AND UPPER(nome) = 'OMAS HAUS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'OMAS HAUS',
      v_tipo_id,
      '2025-05-10'::DATE,
      6606.03,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'OMAS HAUS',
      'receita',
      6606.03,
      '2025-05-25'::DATE,
      '2025-05-25'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Plutos (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'OMAS HAUS',
        'despesa',
        150.0,
        '2025-05-25'::DATE,
        '2025-05-25'::DATE,
        'pago',
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
        '2025-05-10'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'OMAS HAUS',
        'despesa',
        30.0,
        '2025-05-25'::DATE,
        '2025-05-25'::DATE,
        'pago',
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
        '2025-05-10'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'OMAS HAUS',
        'despesa',
        150.0,
        '2025-05-25'::DATE,
        '2025-05-25'::DATE,
        'pago',
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
        '2025-05-10'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 94: LU (2025-04-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-12'::DATE 
    AND UPPER(nome) = 'LU'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LU',
      v_tipo_id,
      '2025-04-12'::DATE,
      860.0,
      258.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LU',
      'receita',
      860.0,
      '2025-04-27'::DATE,
      '2025-04-27'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'LU',
        'despesa',
        200.0,
        '2025-04-27'::DATE,
        '2025-04-27'::DATE,
        'pago',
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
        '2025-04-12'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 95: AMANDA (2025-04-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-12'::DATE 
    AND UPPER(nome) = 'AMANDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'AMANDA',
      v_tipo_id,
      '2025-04-12'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'AMANDA',
      'receita',
      730.0,
      '2025-04-27'::DATE,
      '2025-04-27'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'AMANDA',
        'despesa',
        180.0,
        '2025-04-27'::DATE,
        '2025-04-27'::DATE,
        'pago',
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
        '2025-04-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'AMANDA',
        'despesa',
        200.0,
        '2025-04-27'::DATE,
        '2025-04-27'::DATE,
        'pago',
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
        '2025-04-12'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 96: GILSON (2025-04-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-12'::DATE 
    AND UPPER(nome) = 'GILSON'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GILSON',
      v_tipo_id,
      '2025-04-12'::DATE,
      950.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GILSON',
      'receita',
      950.0,
      '2025-04-27'::DATE,
      '2025-04-27'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'GILSON',
        'despesa',
        200.0,
        '2025-04-27'::DATE,
        '2025-04-27'::DATE,
        'pago',
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
        '2025-04-12'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'GILSON',
        'despesa',
        200.0,
        '2025-04-27'::DATE,
        '2025-04-27'::DATE,
        'pago',
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
        '2025-04-12'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Samurai (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Samurai') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Samurai - ' || 'GILSON',
        'despesa',
        180.0,
        '2025-04-27'::DATE,
        '2025-04-27'::DATE,
        'pago',
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
        '2025-04-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Ana (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Ana') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Ana - ' || 'GILSON',
        'despesa',
        180.0,
        '2025-04-27'::DATE,
        '2025-04-27'::DATE,
        'pago',
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
        '2025-04-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'GILSON',
        'despesa',
        180.0,
        '2025-04-27'::DATE,
        '2025-04-27'::DATE,
        'pago',
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
        '2025-04-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'GILSON',
        'despesa',
        180.0,
        '2025-04-27'::DATE,
        '2025-04-27'::DATE,
        'pago',
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
        '2025-04-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 97: PÁSCOA BVCC (2025-04-13)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-13'::DATE 
    AND UPPER(nome) = 'PÁSCOA BVCC'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PÁSCOA BVCC',
      v_tipo_id,
      '2025-04-13'::DATE,
      3800.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PÁSCOA BVCC',
      'receita',
      3800.0,
      '2025-04-28'::DATE,
      '2025-04-28'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'PÁSCOA BVCC',
        'despesa',
        180.0,
        '2025-04-28'::DATE,
        '2025-04-28'::DATE,
        'pago',
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
        '2025-04-13'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Estrela (R$ 80.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'PÁSCOA BVCC',
        'despesa',
        80.0,
        '2025-04-28'::DATE,
        '2025-04-28'::DATE,
        'pago',
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
        '2025-04-13'::DATE,
        80.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'PÁSCOA BVCC',
        'despesa',
        180.0,
        '2025-04-28'::DATE,
        '2025-04-28'::DATE,
        'pago',
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
        '2025-04-13'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'PÁSCOA BVCC',
        'despesa',
        30.0,
        '2025-04-28'::DATE,
        '2025-04-28'::DATE,
        'pago',
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
        '2025-04-13'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Paola (R$ 100.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Paola') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Paola - ' || 'PÁSCOA BVCC',
        'despesa',
        100.0,
        '2025-04-28'::DATE,
        '2025-04-28'::DATE,
        'pago',
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
        '2025-04-13'::DATE,
        100.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'PÁSCOA BVCC',
        'despesa',
        180.0,
        '2025-04-28'::DATE,
        '2025-04-28'::DATE,
        'pago',
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
        '2025-04-13'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 98: PÁSCOA BAND (2025-04-13)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-13'::DATE 
    AND UPPER(nome) = 'PÁSCOA BAND'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PÁSCOA BAND',
      v_tipo_id,
      '2025-04-13'::DATE,
      2500.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PÁSCOA BAND',
      'receita',
      2500.0,
      '2025-04-28'::DATE,
      '2025-04-28'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'PÁSCOA BAND',
        'despesa',
        200.0,
        '2025-04-28'::DATE,
        '2025-04-28'::DATE,
        'pago',
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
        '2025-04-13'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 99: SUSANA (2025-04-13)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-13'::DATE 
    AND UPPER(nome) = 'SUSANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SUSANA',
      v_tipo_id,
      '2025-04-13'::DATE,
      590.0,
      177.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SUSANA',
      'receita',
      590.0,
      '2025-04-28'::DATE,
      '2025-04-28'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'SUSANA',
        'despesa',
        200.0,
        '2025-04-28'::DATE,
        '2025-04-28'::DATE,
        'pago',
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
        '2025-04-13'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'SUSANA',
        'despesa',
        200.0,
        '2025-04-28'::DATE,
        '2025-04-28'::DATE,
        'pago',
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
        '2025-04-13'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 100: MAÇONARIA JULIO (2025-04-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-16'::DATE 
    AND UPPER(nome) = 'MAÇONARIA JULIO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MAÇONARIA JULIO',
      v_tipo_id,
      '2025-04-16'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MAÇONARIA JULIO',
      'receita',
      1090.0,
      '2025-01-05'::DATE,
      '2025-01-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 230.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MAÇONARIA JULIO',
        'despesa',
        230.0,
        '2025-01-05'::DATE,
        '2025-01-05'::DATE,
        'pago',
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
        '2025-04-16'::DATE,
        230.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 230.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'MAÇONARIA JULIO',
        'despesa',
        230.0,
        '2025-01-05'::DATE,
        '2025-01-05'::DATE,
        'pago',
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
        '2025-04-16'::DATE,
        230.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'MAÇONARIA JULIO',
        'despesa',
        210.0,
        '2025-01-05'::DATE,
        '2025-01-05'::DATE,
        'pago',
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
        '2025-04-16'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'MAÇONARIA JULIO',
        'despesa',
        210.0,
        '2025-01-05'::DATE,
        '2025-01-05'::DATE,
        'pago',
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
        '2025-04-16'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Plutos (R$ 30.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Plutos') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Plutos - ' || 'MAÇONARIA JULIO',
        'despesa',
        30.0,
        '2025-01-05'::DATE,
        '2025-01-05'::DATE,
        'pago',
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
        '2025-04-16'::DATE,
        30.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 101: NOITE DO SONINHO UNI (2025-04-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-16'::DATE 
    AND UPPER(nome) = 'NOITE DO SONINHO UNI'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'NOITE DO SONINHO UNI',
      v_tipo_id,
      '2025-04-16'::DATE,
      3000.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'NOITE DO SONINHO UNI',
      'receita',
      3000.0,
      '2025-01-05'::DATE,
      '2025-01-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'NOITE DO SONINHO UNI',
        'despesa',
        180.0,
        '2025-01-05'::DATE,
        '2025-01-05'::DATE,
        'pago',
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
        '2025-04-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'NOITE DO SONINHO UNI',
        'despesa',
        180.0,
        '2025-01-05'::DATE,
        '2025-01-05'::DATE,
        'pago',
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
        '2025-04-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 102: JEANI (2025-04-17)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-17'::DATE 
    AND UPPER(nome) = 'JEANI'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JEANI',
      v_tipo_id,
      '2025-04-17'::DATE,
      850.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JEANI',
      'receita',
      850.0,
      '2025-02-05'::DATE,
      '2025-02-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Pepe (R$ 510.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'JEANI',
        'despesa',
        510.0,
        '2025-02-05'::DATE,
        '2025-02-05'::DATE,
        'pago',
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
        '2025-04-17'::DATE,
        510.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 510.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'JEANI',
        'despesa',
        510.0,
        '2025-02-05'::DATE,
        '2025-02-05'::DATE,
        'pago',
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
        '2025-04-17'::DATE,
        510.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 103: MARAMBAIA PÁSCOA (2025-04-18)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-18'::DATE 
    AND UPPER(nome) = 'MARAMBAIA PÁSCOA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARAMBAIA PÁSCOA',
      v_tipo_id,
      '2025-04-18'::DATE,
      2620.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARAMBAIA PÁSCOA',
      'receita',
      2620.0,
      '2025-03-05'::DATE,
      '2025-03-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MARAMBAIA PÁSCOA',
        'despesa',
        200.0,
        '2025-03-05'::DATE,
        '2025-03-05'::DATE,
        'pago',
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
        '2025-04-18'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 104: REBECCA (2025-04-18)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-18'::DATE 
    AND UPPER(nome) = 'REBECCA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'REBECCA',
      v_tipo_id,
      '2025-04-18'::DATE,
      730.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'REBECCA',
      'receita',
      730.0,
      '2025-03-05'::DATE,
      '2025-03-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'REBECCA',
        'despesa',
        400.0,
        '2025-03-05'::DATE,
        '2025-03-05'::DATE,
        'pago',
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
        '2025-04-18'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'REBECCA',
        'despesa',
        400.0,
        '2025-03-05'::DATE,
        '2025-03-05'::DATE,
        'pago',
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
        '2025-04-18'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 105: FAZENDA EVARISTO (2025-04-19)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-19'::DATE 
    AND UPPER(nome) = 'FAZENDA EVARISTO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FAZENDA EVARISTO',
      v_tipo_id,
      '2025-04-19'::DATE,
      2000.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FAZENDA EVARISTO',
      'receita',
      2000.0,
      '2025-04-05'::DATE,
      '2025-04-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'FAZENDA EVARISTO',
        'despesa',
        180.0,
        '2025-04-05'::DATE,
        '2025-04-05'::DATE,
        'pago',
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
        '2025-04-19'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Docinho (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Docinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Docinho - ' || 'FAZENDA EVARISTO',
        'despesa',
        180.0,
        '2025-04-05'::DATE,
        '2025-04-05'::DATE,
        'pago',
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
        '2025-04-19'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Docinho (R$ 36.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Docinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Docinho - ' || 'FAZENDA EVARISTO',
        'despesa',
        36.0,
        '2025-04-05'::DATE,
        '2025-04-05'::DATE,
        'pago',
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
        '2025-04-19'::DATE,
        36.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 106: ADRIANA (2025-04-19)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-19'::DATE 
    AND UPPER(nome) = 'ADRIANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ADRIANA',
      v_tipo_id,
      '2025-04-19'::DATE,
      1870.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ADRIANA',
      'receita',
      1870.0,
      '2025-04-05'::DATE,
      '2025-04-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 270.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'ADRIANA',
        'despesa',
        270.0,
        '2025-04-05'::DATE,
        '2025-04-05'::DATE,
        'pago',
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
        '2025-04-19'::DATE,
        270.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Juci (R$ 270.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Juci') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Juci - ' || 'ADRIANA',
        'despesa',
        270.0,
        '2025-04-05'::DATE,
        '2025-04-05'::DATE,
        'pago',
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
        '2025-04-19'::DATE,
        270.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 107: TABAJARA PÁSCOA (2025-04-20)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-20'::DATE 
    AND UPPER(nome) = 'TABAJARA PÁSCOA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TABAJARA PÁSCOA',
      v_tipo_id,
      '2025-04-20'::DATE,
      2500.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TABAJARA PÁSCOA',
      'receita',
      2500.0,
      '2025-05-05'::DATE,
      '2025-05-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'TABAJARA PÁSCOA',
        'despesa',
        200.0,
        '2025-05-05'::DATE,
        '2025-05-05'::DATE,
        'pago',
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
        '2025-04-20'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'TABAJARA PÁSCOA',
        'despesa',
        200.0,
        '2025-05-05'::DATE,
        '2025-05-05'::DATE,
        'pago',
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
        '2025-04-20'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 108: CAROLINA (2025-04-24)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-24'::DATE 
    AND UPPER(nome) = 'CAROLINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAROLINA',
      v_tipo_id,
      '2025-04-24'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAROLINA',
      'receita',
      1090.0,
      '2025-09-05'::DATE,
      '2025-09-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'CAROLINA',
        'despesa',
        200.0,
        '2025-09-05'::DATE,
        '2025-09-05'::DATE,
        'pago',
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
        '2025-04-24'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 109: PAOLA (2025-04-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-25'::DATE 
    AND UPPER(nome) = 'PAOLA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PAOLA',
      v_tipo_id,
      '2025-04-25'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PAOLA',
      'receita',
      730.0,
      '2025-10-05'::DATE,
      '2025-10-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'PAOLA',
        'despesa',
        150.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'PAOLA',
        'despesa',
        150.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 110: CAMILA (2025-04-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-25'::DATE 
    AND UPPER(nome) = 'CAMILA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAMILA',
      v_tipo_id,
      '2025-04-25'::DATE,
      850.0,
      255.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAMILA',
      'receita',
      850.0,
      '2025-10-05'::DATE,
      '2025-10-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Pepe (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'CAMILA',
        'despesa',
        200.0,
        '2025-10-05'::DATE,
        '2025-10-05'::DATE,
        'pago',
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
        '2025-04-25'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 111: RAFAEL (2025-04-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-26'::DATE 
    AND UPPER(nome) = 'RAFAEL'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'RAFAEL',
      v_tipo_id,
      '2025-04-26'::DATE,
      590.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'RAFAEL',
      'receita',
      590.0,
      '2025-11-05'::DATE,
      '2025-11-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'RAFAEL',
        'despesa',
        200.0,
        '2025-11-05'::DATE,
        '2025-11-05'::DATE,
        'pago',
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
        '2025-04-26'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'RAFAEL',
        'despesa',
        180.0,
        '2025-11-05'::DATE,
        '2025-11-05'::DATE,
        'pago',
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
        '2025-04-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'RAFAEL',
        'despesa',
        180.0,
        '2025-11-05'::DATE,
        '2025-11-05'::DATE,
        'pago',
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
        '2025-04-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 112: DANIELA (2025-04-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-26'::DATE 
    AND UPPER(nome) = 'DANIELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'DANIELA',
      v_tipo_id,
      '2025-04-26'::DATE,
      1499.0,
      500.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'DANIELA',
      'receita',
      1499.0,
      '2025-11-05'::DATE,
      '2025-11-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'DANIELA',
        'despesa',
        180.0,
        '2025-11-05'::DATE,
        '2025-11-05'::DATE,
        'pago',
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
        '2025-04-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 113: TATIANA (2025-04-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-26'::DATE 
    AND UPPER(nome) = 'TATIANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TATIANA',
      v_tipo_id,
      '2025-04-26'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TATIANA',
      'receita',
      730.0,
      '2025-11-05'::DATE,
      '2025-11-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'TATIANA',
        'despesa',
        200.0,
        '2025-11-05'::DATE,
        '2025-11-05'::DATE,
        'pago',
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
        '2025-04-26'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'TATIANA',
        'despesa',
        180.0,
        '2025-11-05'::DATE,
        '2025-11-05'::DATE,
        'pago',
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
        '2025-04-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 114: KRISLEY (2025-04-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-26'::DATE 
    AND UPPER(nome) = 'KRISLEY'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'KRISLEY',
      v_tipo_id,
      '2025-04-26'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'KRISLEY',
      'receita',
      1090.0,
      '2025-11-05'::DATE,
      '2025-11-05'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'KRISLEY',
        'despesa',
        200.0,
        '2025-11-05'::DATE,
        '2025-11-05'::DATE,
        'pago',
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
        '2025-04-26'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 115: ANDRESSA (2025-04-30)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-04-30'::DATE 
    AND UPPER(nome) = 'ANDRESSA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANDRESSA',
      v_tipo_id,
      '2025-04-30'::DATE,
      600.0,
      180.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANDRESSA',
      'receita',
      600.0,
      '2025-05-15'::DATE,
      '2025-05-15'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 116: GISLENE (2025-05-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-01'::DATE 
    AND UPPER(nome) = 'GISLENE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GISLENE',
      v_tipo_id,
      '2025-05-01'::DATE,
      380.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GISLENE',
      'receita',
      380.0,
      '2025-05-16'::DATE,
      '2025-05-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'GISLENE',
        'despesa',
        200.0,
        '2025-05-16'::DATE,
        '2025-05-16'::DATE,
        'pago',
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
        '2025-05-01'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 117: GAUCHO (2025-05-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-01'::DATE 
    AND UPPER(nome) = 'GAUCHO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GAUCHO',
      v_tipo_id,
      '2025-05-01'::DATE,
      600.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GAUCHO',
      'receita',
      600.0,
      '2025-05-16'::DATE,
      '2025-05-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'GAUCHO',
        'despesa',
        200.0,
        '2025-05-16'::DATE,
        '2025-05-16'::DATE,
        'pago',
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
        '2025-05-01'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'GAUCHO',
        'despesa',
        180.0,
        '2025-05-16'::DATE,
        '2025-05-16'::DATE,
        'pago',
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
        '2025-05-01'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 118: TATIANA (2025-05-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-01'::DATE 
    AND UPPER(nome) = 'TATIANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TATIANA',
      v_tipo_id,
      '2025-05-01'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TATIANA',
      'receita',
      1090.0,
      '2025-05-16'::DATE,
      '2025-05-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'TATIANA',
        'despesa',
        400.0,
        '2025-05-16'::DATE,
        '2025-05-16'::DATE,
        'pago',
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
        '2025-05-01'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'TATIANA',
        'despesa',
        400.0,
        '2025-05-16'::DATE,
        '2025-05-16'::DATE,
        'pago',
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
        '2025-05-01'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 119: FAZENDA EVARISTO (2025-05-02)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-02'::DATE 
    AND UPPER(nome) = 'FAZENDA EVARISTO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FAZENDA EVARISTO',
      v_tipo_id,
      '2025-05-02'::DATE,
      2000.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FAZENDA EVARISTO',
      'receita',
      2000.0,
      '2025-05-17'::DATE,
      '2025-05-17'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'FAZENDA EVARISTO',
        'despesa',
        180.0,
        '2025-05-17'::DATE,
        '2025-05-17'::DATE,
        'pago',
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
        '2025-05-02'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Detona Ralph (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Detona Ralph') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Detona Ralph - ' || 'FAZENDA EVARISTO',
        'despesa',
        180.0,
        '2025-05-17'::DATE,
        '2025-05-17'::DATE,
        'pago',
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
        '2025-05-02'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 120: SIMONE (2025-05-03)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-03'::DATE 
    AND UPPER(nome) = 'SIMONE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SIMONE',
      v_tipo_id,
      '2025-05-03'::DATE,
      1010.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SIMONE',
      'receita',
      1010.0,
      '2025-05-18'::DATE,
      '2025-05-18'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'SIMONE',
        'despesa',
        180.0,
        '2025-05-18'::DATE,
        '2025-05-18'::DATE,
        'pago',
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
        '2025-05-03'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'SIMONE',
        'despesa',
        180.0,
        '2025-05-18'::DATE,
        '2025-05-18'::DATE,
        'pago',
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
        '2025-05-03'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 121: BIANKA (2025-05-03)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-03'::DATE 
    AND UPPER(nome) = 'BIANKA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BIANKA',
      v_tipo_id,
      '2025-05-03'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BIANKA',
      'receita',
      1090.0,
      '2025-05-18'::DATE,
      '2025-05-18'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'BIANKA',
        'despesa',
        200.0,
        '2025-05-18'::DATE,
        '2025-05-18'::DATE,
        'pago',
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
        '2025-05-03'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 122: DAVID (2025-05-03)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-03'::DATE 
    AND UPPER(nome) = 'DAVID'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'DAVID',
      v_tipo_id,
      '2025-05-03'::DATE,
      630.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'DAVID',
      'receita',
      630.0,
      '2025-05-18'::DATE,
      '2025-05-18'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 270.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'DAVID',
        'despesa',
        270.0,
        '2025-05-18'::DATE,
        '2025-05-18'::DATE,
        'pago',
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
        '2025-05-03'::DATE,
        270.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 123: CASAMENTO BRUNA (2025-05-03)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-03'::DATE 
    AND UPPER(nome) = 'CASAMENTO BRUNA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CASAMENTO BRUNA',
      v_tipo_id,
      '2025-05-03'::DATE,
      1250.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CASAMENTO BRUNA',
      'receita',
      1250.0,
      '2025-05-18'::DATE,
      '2025-05-18'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'CASAMENTO BRUNA',
        'despesa',
        200.0,
        '2025-05-18'::DATE,
        '2025-05-18'::DATE,
        'pago',
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
        '2025-05-03'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'CASAMENTO BRUNA',
        'despesa',
        180.0,
        '2025-05-18'::DATE,
        '2025-05-18'::DATE,
        'pago',
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
        '2025-05-03'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 124: MANIA DE BRINCAR (2025-05-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-04'::DATE 
    AND UPPER(nome) = 'MANIA DE BRINCAR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MANIA DE BRINCAR',
      v_tipo_id,
      '2025-05-04'::DATE,
      720.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MANIA DE BRINCAR',
      'receita',
      720.0,
      '2025-05-19'::DATE,
      '2025-05-19'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 170.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'MANIA DE BRINCAR',
        'despesa',
        170.0,
        '2025-05-19'::DATE,
        '2025-05-19'::DATE,
        'pago',
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
        '2025-05-04'::DATE,
        170.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 125: RESTAURANTE HEIMAT (2025-05-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-04'::DATE 
    AND UPPER(nome) = 'RESTAURANTE HEIMAT'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'RESTAURANTE HEIMAT',
      v_tipo_id,
      '2025-05-04'::DATE,
      420.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'RESTAURANTE HEIMAT',
      'receita',
      420.0,
      '2025-05-19'::DATE,
      '2025-05-19'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'RESTAURANTE HEIMAT',
        'despesa',
        200.0,
        '2025-05-19'::DATE,
        '2025-05-19'::DATE,
        'pago',
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
        '2025-05-04'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'RESTAURANTE HEIMAT',
        'despesa',
        180.0,
        '2025-05-19'::DATE,
        '2025-05-19'::DATE,
        'pago',
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
        '2025-05-04'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 126: FLAVIA (2025-05-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-05'::DATE 
    AND UPPER(nome) = 'FLAVIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FLAVIA',
      v_tipo_id,
      '2025-05-05'::DATE,
      1090.0,
      550.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FLAVIA',
      'receita',
      1090.0,
      '2025-05-20'::DATE,
      '2025-05-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 127: LUANA (2025-05-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-04'::DATE 
    AND UPPER(nome) = 'LUANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LUANA',
      v_tipo_id,
      '2025-05-04'::DATE,
      900.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LUANA',
      'receita',
      900.0,
      '2025-05-19'::DATE,
      '2025-05-19'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'LUANA',
        'despesa',
        180.0,
        '2025-05-19'::DATE,
        '2025-05-19'::DATE,
        'pago',
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
        '2025-05-04'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'LUANA',
        'despesa',
        180.0,
        '2025-05-19'::DATE,
        '2025-05-19'::DATE,
        'pago',
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
        '2025-05-04'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 128: FERNANDA (2025-05-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-08'::DATE 
    AND UPPER(nome) = 'FERNANDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FERNANDA',
      v_tipo_id,
      '2025-05-08'::DATE,
      1090.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FERNANDA',
      'receita',
      1090.0,
      '2025-05-23'::DATE,
      '2025-05-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'FERNANDA',
        'despesa',
        200.0,
        '2025-05-23'::DATE,
        '2025-05-23'::DATE,
        'pago',
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
        '2025-05-08'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'FERNANDA',
        'despesa',
        180.0,
        '2025-05-23'::DATE,
        '2025-05-23'::DATE,
        'pago',
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
        '2025-05-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 129: RAFAELA (2025-05-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-09'::DATE 
    AND UPPER(nome) = 'RAFAELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'RAFAELA',
      v_tipo_id,
      '2025-05-09'::DATE,
      990.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'RAFAELA',
      'receita',
      990.0,
      '2025-05-24'::DATE,
      '2025-05-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'RAFAELA',
        'despesa',
        180.0,
        '2025-05-24'::DATE,
        '2025-05-24'::DATE,
        'pago',
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
        '2025-05-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 130: BRUNA (2025-05-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-09'::DATE 
    AND UPPER(nome) = 'BRUNA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BRUNA',
      v_tipo_id,
      '2025-05-09'::DATE,
      730.0,
      300.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BRUNA',
      'receita',
      730.0,
      '2025-05-24'::DATE,
      '2025-05-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'BRUNA',
        'despesa',
        180.0,
        '2025-05-24'::DATE,
        '2025-05-24'::DATE,
        'pago',
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
        '2025-05-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 131: ROBERTA RDK (2025-05-10)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-10'::DATE 
    AND UPPER(nome) = 'ROBERTA RDK'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ROBERTA RDK',
      v_tipo_id,
      '2025-05-10'::DATE,
      990.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ROBERTA RDK',
      'receita',
      990.0,
      '2025-05-25'::DATE,
      '2025-05-25'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'ROBERTA RDK',
        'despesa',
        180.0,
        '2025-05-25'::DATE,
        '2025-05-25'::DATE,
        'pago',
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
        '2025-05-10'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'ROBERTA RDK',
        'despesa',
        180.0,
        '2025-05-25'::DATE,
        '2025-05-25'::DATE,
        'pago',
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
        '2025-05-10'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 132: PATRICIA (2025-05-10)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-10'::DATE 
    AND UPPER(nome) = 'PATRICIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PATRICIA',
      v_tipo_id,
      '2025-05-10'::DATE,
      1090.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PATRICIA',
      'receita',
      1090.0,
      '2025-05-25'::DATE,
      '2025-05-25'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 133: UNI PIPOCA (2025-05-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-09'::DATE 
    AND UPPER(nome) = 'UNI PIPOCA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'UNI PIPOCA',
      v_tipo_id,
      '2025-05-09'::DATE,
      990.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'UNI PIPOCA',
      'receita',
      990.0,
      '2025-05-24'::DATE,
      '2025-05-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Gisa (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Gisa') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Gisa - ' || 'UNI PIPOCA',
        'despesa',
        180.0,
        '2025-05-24'::DATE,
        '2025-05-24'::DATE,
        'pago',
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
        '2025-05-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 134: RESTAURANTE HEIMAT (2025-05-11)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-11'::DATE 
    AND UPPER(nome) = 'RESTAURANTE HEIMAT'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'RESTAURANTE HEIMAT',
      v_tipo_id,
      '2025-05-11'::DATE,
      420.0,
      250.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'RESTAURANTE HEIMAT',
      'receita',
      420.0,
      '2025-05-26'::DATE,
      '2025-05-26'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'RESTAURANTE HEIMAT',
        'despesa',
        180.0,
        '2025-05-26'::DATE,
        '2025-05-26'::DATE,
        'pago',
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
        '2025-05-11'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 135: REBECCA (2025-05-11)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-11'::DATE 
    AND UPPER(nome) = 'REBECCA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'REBECCA',
      v_tipo_id,
      '2025-05-11'::DATE,
      630.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'REBECCA',
      'receita',
      630.0,
      '2025-05-26'::DATE,
      '2025-05-26'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'REBECCA',
        'despesa',
        180.0,
        '2025-05-26'::DATE,
        '2025-05-26'::DATE,
        'pago',
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
        '2025-05-11'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'REBECCA',
        'despesa',
        180.0,
        '2025-05-26'::DATE,
        '2025-05-26'::DATE,
        'pago',
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
        '2025-05-11'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 136: ALINE (2025-05-11)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-11'::DATE 
    AND UPPER(nome) = 'ALINE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ALINE',
      v_tipo_id,
      '2025-05-11'::DATE,
      1000.0,
      500.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ALINE',
      'receita',
      1000.0,
      '2025-05-26'::DATE,
      '2025-05-26'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ALINE',
        'despesa',
        200.0,
        '2025-05-26'::DATE,
        '2025-05-26'::DATE,
        'pago',
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
        '2025-05-11'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'ALINE',
        'despesa',
        180.0,
        '2025-05-26'::DATE,
        '2025-05-26'::DATE,
        'pago',
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
        '2025-05-11'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 137: JENNIFER (2025-05-14)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-14'::DATE 
    AND UPPER(nome) = 'JENNIFER'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JENNIFER',
      v_tipo_id,
      '2025-05-14'::DATE,
      2330.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JENNIFER',
      'receita',
      2330.0,
      '2025-05-29'::DATE,
      '2025-05-29'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 230.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'JENNIFER',
        'despesa',
        230.0,
        '2025-05-29'::DATE,
        '2025-05-29'::DATE,
        'pago',
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
        '2025-05-14'::DATE,
        230.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'JENNIFER',
        'despesa',
        210.0,
        '2025-05-29'::DATE,
        '2025-05-29'::DATE,
        'pago',
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
        '2025-05-14'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 138: BARBARA (2025-05-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-16'::DATE 
    AND UPPER(nome) = 'BARBARA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BARBARA',
      v_tipo_id,
      '2025-05-16'::DATE,
      1290.0,
      387.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BARBARA',
      'receita',
      1290.0,
      '2025-05-31'::DATE,
      '2025-05-31'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'BARBARA',
        'despesa',
        180.0,
        '2025-05-31'::DATE,
        '2025-05-31'::DATE,
        'pago',
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
        '2025-05-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 139: KAUE (2025-05-17)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-17'::DATE 
    AND UPPER(nome) = 'KAUE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'KAUE',
      v_tipo_id,
      '2025-05-17'::DATE,
      590.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'KAUE',
      'receita',
      590.0,
      '2025-01-06'::DATE,
      '2025-01-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'KAUE',
        'despesa',
        180.0,
        '2025-01-06'::DATE,
        '2025-01-06'::DATE,
        'pago',
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
        '2025-05-17'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 140: CARLA (2025-05-17)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-17'::DATE 
    AND UPPER(nome) = 'CARLA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CARLA',
      v_tipo_id,
      '2025-05-17'::DATE,
      1340.0,
      402.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CARLA',
      'receita',
      1340.0,
      '2025-01-06'::DATE,
      '2025-01-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'CARLA',
        'despesa',
        200.0,
        '2025-01-06'::DATE,
        '2025-01-06'::DATE,
        'pago',
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
        '2025-05-17'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 141: ANA CAROLINA (2025-05-17)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-17'::DATE 
    AND UPPER(nome) = 'ANA CAROLINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA CAROLINA',
      v_tipo_id,
      '2025-05-17'::DATE,
      600.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA CAROLINA',
      'receita',
      600.0,
      '2025-01-06'::DATE,
      '2025-01-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ANA CAROLINA',
        'despesa',
        200.0,
        '2025-01-06'::DATE,
        '2025-01-06'::DATE,
        'pago',
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
        '2025-05-17'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 142: MEIRIELLY (2025-05-18)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-18'::DATE 
    AND UPPER(nome) = 'MEIRIELLY'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MEIRIELLY',
      v_tipo_id,
      '2025-05-18'::DATE,
      640.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MEIRIELLY',
      'receita',
      640.0,
      '2025-02-06'::DATE,
      '2025-02-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'MEIRIELLY',
        'despesa',
        180.0,
        '2025-02-06'::DATE,
        '2025-02-06'::DATE,
        'pago',
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
        '2025-05-18'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'MEIRIELLY',
        'despesa',
        180.0,
        '2025-02-06'::DATE,
        '2025-02-06'::DATE,
        'pago',
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
        '2025-05-18'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 143: TAUHANA (2025-05-18)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-18'::DATE 
    AND UPPER(nome) = 'TAUHANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TAUHANA',
      v_tipo_id,
      '2025-05-18'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TAUHANA',
      'receita',
      1090.0,
      '2025-02-06'::DATE,
      '2025-02-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'TAUHANA',
        'despesa',
        180.0,
        '2025-02-06'::DATE,
        '2025-02-06'::DATE,
        'pago',
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
        '2025-05-18'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'TAUHANA',
        'despesa',
        180.0,
        '2025-02-06'::DATE,
        '2025-02-06'::DATE,
        'pago',
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
        '2025-05-18'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 144: MARCELA (2025-05-18)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-18'::DATE 
    AND UPPER(nome) = 'MARCELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARCELA',
      v_tipo_id,
      '2025-05-18'::DATE,
      990.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARCELA',
      'receita',
      990.0,
      '2025-02-06'::DATE,
      '2025-02-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MARCELA',
        'despesa',
        200.0,
        '2025-02-06'::DATE,
        '2025-02-06'::DATE,
        'pago',
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
        '2025-05-18'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 145: ISA (2025-05-21)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-21'::DATE 
    AND UPPER(nome) = 'ISA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ISA',
      v_tipo_id,
      '2025-05-21'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ISA',
      'receita',
      730.0,
      '2025-05-06'::DATE,
      '2025-05-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 250.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ISA',
        'despesa',
        250.0,
        '2025-05-06'::DATE,
        '2025-05-06'::DATE,
        'pago',
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
        '2025-05-21'::DATE,
        250.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 250.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'ISA',
        'despesa',
        250.0,
        '2025-05-06'::DATE,
        '2025-05-06'::DATE,
        'pago',
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
        '2025-05-21'::DATE,
        250.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 146: EMPREENDER GO (2025-05-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-22'::DATE 
    AND UPPER(nome) = 'EMPREENDER GO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'EMPREENDER GO',
      v_tipo_id,
      '2025-05-22'::DATE,
      2000.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'EMPREENDER GO',
      'receita',
      2000.0,
      '2025-06-06'::DATE,
      '2025-06-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'EMPREENDER GO',
        'despesa',
        240.0,
        '2025-06-06'::DATE,
        '2025-06-06'::DATE,
        'pago',
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
        '2025-05-22'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'EMPREENDER GO',
        'despesa',
        240.0,
        '2025-06-06'::DATE,
        '2025-06-06'::DATE,
        'pago',
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
        '2025-05-22'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'EMPREENDER GO',
        'despesa',
        240.0,
        '2025-06-06'::DATE,
        '2025-06-06'::DATE,
        'pago',
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
        '2025-05-22'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 147: TANIA (2025-05-24)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-24'::DATE 
    AND UPPER(nome) = 'TANIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TANIA',
      v_tipo_id,
      '2025-05-24'::DATE,
      1750.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TANIA',
      'receita',
      1750.0,
      '2025-08-06'::DATE,
      '2025-08-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'TANIA',
        'despesa',
        180.0,
        '2025-08-06'::DATE,
        '2025-08-06'::DATE,
        'pago',
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
        '2025-05-24'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 148: RESTAURANTE HEIMAT (2025-05-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-25'::DATE 
    AND UPPER(nome) = 'RESTAURANTE HEIMAT'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'RESTAURANTE HEIMAT',
      v_tipo_id,
      '2025-05-25'::DATE,
      420.0,
      210.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'RESTAURANTE HEIMAT',
      'receita',
      420.0,
      '2025-09-06'::DATE,
      '2025-09-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'RESTAURANTE HEIMAT',
        'despesa',
        180.0,
        '2025-09-06'::DATE,
        '2025-09-06'::DATE,
        'pago',
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
        '2025-05-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 149: REBECCA (2025-05-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-25'::DATE 
    AND UPPER(nome) = 'REBECCA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'REBECCA',
      v_tipo_id,
      '2025-05-25'::DATE,
      630.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'REBECCA',
      'receita',
      630.0,
      '2025-09-06'::DATE,
      '2025-09-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'REBECCA',
        'despesa',
        200.0,
        '2025-09-06'::DATE,
        '2025-09-06'::DATE,
        'pago',
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
        '2025-05-25'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'REBECCA',
        'despesa',
        180.0,
        '2025-09-06'::DATE,
        '2025-09-06'::DATE,
        'pago',
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
        '2025-05-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 150: MONIQUE (2025-05-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-25'::DATE 
    AND UPPER(nome) = 'MONIQUE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MONIQUE',
      v_tipo_id,
      '2025-05-25'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MONIQUE',
      'receita',
      1090.0,
      '2025-09-06'::DATE,
      '2025-09-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'MONIQUE',
        'despesa',
        180.0,
        '2025-09-06'::DATE,
        '2025-09-06'::DATE,
        'pago',
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
        '2025-05-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'MONIQUE',
        'despesa',
        180.0,
        '2025-09-06'::DATE,
        '2025-09-06'::DATE,
        'pago',
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
        '2025-05-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 151: JOSEANE (2025-05-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-25'::DATE 
    AND UPPER(nome) = 'JOSEANE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JOSEANE',
      v_tipo_id,
      '2025-05-25'::DATE,
      990.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JOSEANE',
      'receita',
      990.0,
      '2025-09-06'::DATE,
      '2025-09-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'JOSEANE',
        'despesa',
        200.0,
        '2025-09-06'::DATE,
        '2025-09-06'::DATE,
        'pago',
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
        '2025-05-25'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'JOSEANE',
        'despesa',
        180.0,
        '2025-09-06'::DATE,
        '2025-09-06'::DATE,
        'pago',
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
        '2025-05-25'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 152: ANA PAULA (2025-05-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-26'::DATE 
    AND UPPER(nome) = 'ANA PAULA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA PAULA',
      v_tipo_id,
      '2025-05-26'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA PAULA',
      'receita',
      1090.0,
      '2025-10-06'::DATE,
      '2025-10-06'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ANA PAULA',
        'despesa',
        200.0,
        '2025-10-06'::DATE,
        '2025-10-06'::DATE,
        'pago',
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
        '2025-05-26'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Bacon (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'ANA PAULA',
        'despesa',
        180.0,
        '2025-10-06'::DATE,
        '2025-10-06'::DATE,
        'pago',
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
        '2025-05-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 153: ADRIANA (2025-05-30)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-30'::DATE 
    AND UPPER(nome) = 'ADRIANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ADRIANA',
      v_tipo_id,
      '2025-05-30'::DATE,
      1650.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ADRIANA',
      'receita',
      1650.0,
      '2025-06-14'::DATE,
      '2025-06-14'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 154: ANA PAULA (2025-05-31)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-31'::DATE 
    AND UPPER(nome) = 'ANA PAULA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA PAULA',
      v_tipo_id,
      '2025-05-31'::DATE,
      220.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA PAULA',
      'receita',
      220.0,
      '2025-06-15'::DATE,
      '2025-06-15'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ANA PAULA',
        'despesa',
        200.0,
        '2025-06-15'::DATE,
        '2025-06-15'::DATE,
        'pago',
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
        '2025-05-31'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 155: CAMILA (2025-05-31)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-31'::DATE 
    AND UPPER(nome) = 'CAMILA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAMILA',
      v_tipo_id,
      '2025-05-31'::DATE,
      980.0,
      490.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAMILA',
      'receita',
      980.0,
      '2025-06-15'::DATE,
      '2025-06-15'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Bacon (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Bacon') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Bacon - ' || 'CAMILA',
        'despesa',
        150.0,
        '2025-06-15'::DATE,
        '2025-06-15'::DATE,
        'pago',
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
        '2025-05-31'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'CAMILA',
        'despesa',
        150.0,
        '2025-06-15'::DATE,
        '2025-06-15'::DATE,
        'pago',
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
        '2025-05-31'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 156: CRISTIANE (2025-05-31)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-31'::DATE 
    AND UPPER(nome) = 'CRISTIANE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CRISTIANE',
      v_tipo_id,
      '2025-05-31'::DATE,
      830.0,
      249.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CRISTIANE',
      'receita',
      830.0,
      '2025-06-15'::DATE,
      '2025-06-15'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'CRISTIANE',
        'despesa',
        180.0,
        '2025-06-15'::DATE,
        '2025-06-15'::DATE,
        'pago',
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
        '2025-05-31'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Babalu (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'CRISTIANE',
        'despesa',
        200.0,
        '2025-06-15'::DATE,
        '2025-06-15'::DATE,
        'pago',
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
        '2025-05-31'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 157: JERUSA (2025-05-31)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-31'::DATE 
    AND UPPER(nome) = 'JERUSA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JERUSA',
      v_tipo_id,
      '2025-05-31'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JERUSA',
      'receita',
      1090.0,
      '2025-06-15'::DATE,
      '2025-06-15'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'JERUSA',
        'despesa',
        180.0,
        '2025-06-15'::DATE,
        '2025-06-15'::DATE,
        'pago',
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
        '2025-05-31'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Docinho (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Docinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Docinho - ' || 'JERUSA',
        'despesa',
        180.0,
        '2025-06-15'::DATE,
        '2025-06-15'::DATE,
        'pago',
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
        '2025-05-31'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 158: ANA (2025-05-31)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-31'::DATE 
    AND UPPER(nome) = 'ANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA',
      v_tipo_id,
      '2025-05-31'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA',
      'receita',
      1090.0,
      '2025-06-15'::DATE,
      '2025-06-15'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'ANA',
        'despesa',
        180.0,
        '2025-06-15'::DATE,
        '2025-06-15'::DATE,
        'pago',
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
        '2025-05-31'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'ANA',
        'despesa',
        180.0,
        '2025-06-15'::DATE,
        '2025-06-15'::DATE,
        'pago',
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
        '2025-05-31'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 159: JULIANE (2025-06-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-01'::DATE 
    AND UPPER(nome) = 'JULIANE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JULIANE',
      v_tipo_id,
      '2025-06-01'::DATE,
      1150.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JULIANE',
      'receita',
      1150.0,
      '2025-06-16'::DATE,
      '2025-06-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Gisa (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Gisa') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Gisa - ' || 'JULIANE',
        'despesa',
        180.0,
        '2025-06-16'::DATE,
        '2025-06-16'::DATE,
        'pago',
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
        '2025-06-01'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 160: RESTAURANTE HEIMAT (2025-06-01)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-01'::DATE 
    AND UPPER(nome) = 'RESTAURANTE HEIMAT'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'RESTAURANTE HEIMAT',
      v_tipo_id,
      '2025-06-01'::DATE,
      420.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'RESTAURANTE HEIMAT',
      'receita',
      420.0,
      '2025-06-16'::DATE,
      '2025-06-16'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'RESTAURANTE HEIMAT',
        'despesa',
        150.0,
        '2025-06-16'::DATE,
        '2025-06-16'::DATE,
        'pago',
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
        '2025-06-01'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 161: ESPAÇO KIDS (2025-05-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-08'::DATE 
    AND UPPER(nome) = 'ESPAÇO KIDS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ESPAÇO KIDS',
      v_tipo_id,
      '2025-05-08'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Jujuba (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'ESPAÇO KIDS',
        'despesa',
        150.0,
        '2025-05-23'::DATE,
        '2025-05-23'::DATE,
        'pago',
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
        '2025-05-08'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 162: ESPAÇO KIDS (2025-05-21)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-05-21'::DATE 
    AND UPPER(nome) = 'ESPAÇO KIDS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ESPAÇO KIDS',
      v_tipo_id,
      '2025-05-21'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ESPAÇO KIDS',
        'despesa',
        200.0,
        '2025-05-06'::DATE,
        '2025-05-06'::DATE,
        'pago',
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
        '2025-05-21'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 163: WILLIAM (2025-06-03)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-03'::DATE 
    AND UPPER(nome) = 'WILLIAM'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'WILLIAM',
      v_tipo_id,
      '2025-06-03'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'WILLIAM',
      'receita',
      730.0,
      '2025-06-18'::DATE,
      '2025-06-18'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'WILLIAM',
        'despesa',
        150.0,
        '2025-06-18'::DATE,
        '2025-06-18'::DATE,
        'pago',
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
        '2025-06-03'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 164: TALITA (2025-06-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-06'::DATE 
    AND UPPER(nome) = 'TALITA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TALITA',
      v_tipo_id,
      '2025-06-06'::DATE,
      630.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TALITA',
      'receita',
      630.0,
      '2025-06-21'::DATE,
      '2025-06-21'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 170.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'TALITA',
        'despesa',
        170.0,
        '2025-06-21'::DATE,
        '2025-06-21'::DATE,
        'pago',
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
        '2025-06-06'::DATE,
        170.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'TALITA',
        'despesa',
        150.0,
        '2025-06-21'::DATE,
        '2025-06-21'::DATE,
        'pago',
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
        '2025-06-06'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 165: ANA CAROLINE (2025-06-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-06'::DATE 
    AND UPPER(nome) = 'ANA CAROLINE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA CAROLINE',
      v_tipo_id,
      '2025-06-06'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA CAROLINE',
      'receita',
      1090.0,
      '2025-06-21'::DATE,
      '2025-06-21'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'ANA CAROLINE',
        'despesa',
        180.0,
        '2025-06-21'::DATE,
        '2025-06-21'::DATE,
        'pago',
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
        '2025-06-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 166: JAISON (2025-06-07)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-07'::DATE 
    AND UPPER(nome) = 'JAISON'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JAISON',
      v_tipo_id,
      '2025-06-07'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JAISON',
      'receita',
      730.0,
      '2025-06-22'::DATE,
      '2025-06-22'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Polly (R$ 260.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Polly') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Polly - ' || 'JAISON',
        'despesa',
        260.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        260.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Cinthia (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Cinthia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Cinthia - ' || 'JAISON',
        'despesa',
        240.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'JAISON',
        'despesa',
        240.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Nanda (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Nanda') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Nanda - ' || 'JAISON',
        'despesa',
        240.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 167: JUNINA AD HERING (2025-06-07)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-07'::DATE 
    AND UPPER(nome) = 'JUNINA AD HERING'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JUNINA AD HERING',
      v_tipo_id,
      '2025-06-07'::DATE,
      5000.0,
      2500.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JUNINA AD HERING',
      'receita',
      5000.0,
      '2025-06-22'::DATE,
      '2025-06-22'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'JUNINA AD HERING',
        'despesa',
        180.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Caca (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Caca') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Caca - ' || 'JUNINA AD HERING',
        'despesa',
        180.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 168: BRUNA (2025-06-07)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-07'::DATE 
    AND UPPER(nome) = 'BRUNA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BRUNA',
      v_tipo_id,
      '2025-06-07'::DATE,
      1090.0,
      500.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BRUNA',
      'receita',
      1090.0,
      '2025-06-22'::DATE,
      '2025-06-22'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'BRUNA',
        'despesa',
        200.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'BRUNA',
        'despesa',
        180.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 169: NATALIA (2025-06-07)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-07'::DATE 
    AND UPPER(nome) = 'NATALIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'NATALIA',
      v_tipo_id,
      '2025-06-07'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'NATALIA',
      'receita',
      1090.0,
      '2025-06-22'::DATE,
      '2025-06-22'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Gisa (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Gisa') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Gisa - ' || 'NATALIA',
        'despesa',
        200.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 170: TALITA (2025-06-07)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-07'::DATE 
    AND UPPER(nome) = 'TALITA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TALITA',
      v_tipo_id,
      '2025-06-07'::DATE,
      2080.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TALITA',
      'receita',
      2080.0,
      '2025-06-22'::DATE,
      '2025-06-22'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'TALITA',
        'despesa',
        180.0,
        '2025-06-22'::DATE,
        '2025-06-22'::DATE,
        'pago',
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
        '2025-06-07'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 171: MARCELA (2025-06-07)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-07'::DATE 
    AND UPPER(nome) = 'MARCELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARCELA',
      v_tipo_id,
      '2025-06-07'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARCELA',
      'receita',
      730.0,
      '2025-06-22'::DATE,
      '2025-06-22'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 172: LILIAN (2025-06-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-08'::DATE 
    AND UPPER(nome) = 'LILIAN'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LILIAN',
      v_tipo_id,
      '2025-06-08'::DATE,
      290.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LILIAN',
      'receita',
      290.0,
      '2025-06-23'::DATE,
      '2025-06-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'LILIAN',
        'despesa',
        180.0,
        '2025-06-23'::DATE,
        '2025-06-23'::DATE,
        'pago',
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
        '2025-06-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dinho (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dinho - ' || 'LILIAN',
        'despesa',
        180.0,
        '2025-06-23'::DATE,
        '2025-06-23'::DATE,
        'pago',
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
        '2025-06-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 173: ZECA (2025-06-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-08'::DATE 
    AND UPPER(nome) = 'ZECA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ZECA',
      v_tipo_id,
      '2025-06-08'::DATE,
      1700.0,
      610.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ZECA',
      'receita',
      1700.0,
      '2025-06-23'::DATE,
      '2025-06-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'ZECA',
        'despesa',
        180.0,
        '2025-06-23'::DATE,
        '2025-06-23'::DATE,
        'pago',
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
        '2025-06-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'ZECA',
        'despesa',
        180.0,
        '2025-06-23'::DATE,
        '2025-06-23'::DATE,
        'pago',
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
        '2025-06-08'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 174: FERNANDA (2025-06-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-08'::DATE 
    AND UPPER(nome) = 'FERNANDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FERNANDA',
      v_tipo_id,
      '2025-06-08'::DATE,
      890.0,
      267.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FERNANDA',
      'receita',
      890.0,
      '2025-06-23'::DATE,
      '2025-06-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'FERNANDA',
        'despesa',
        200.0,
        '2025-06-23'::DATE,
        '2025-06-23'::DATE,
        'pago',
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
        '2025-06-08'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Poc (R$ 60.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'FERNANDA',
        'despesa',
        60.0,
        '2025-06-23'::DATE,
        '2025-06-23'::DATE,
        'pago',
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
        '2025-06-08'::DATE,
        60.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 175: ANA (2025-06-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-08'::DATE 
    AND UPPER(nome) = 'ANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA',
      v_tipo_id,
      '2025-06-08'::DATE,
      790.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA',
      'receita',
      790.0,
      '2025-06-23'::DATE,
      '2025-06-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 176: LUCAS (2025-06-11)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-11'::DATE 
    AND UPPER(nome) = 'LUCAS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LUCAS',
      v_tipo_id,
      '2025-06-11'::DATE,
      220.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LUCAS',
      'receita',
      220.0,
      '2025-06-26'::DATE,
      '2025-06-26'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'LUCAS',
        'despesa',
        200.0,
        '2025-06-26'::DATE,
        '2025-06-26'::DATE,
        'pago',
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
        '2025-06-11'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 177: CAMILA (2025-06-11)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-11'::DATE 
    AND UPPER(nome) = 'CAMILA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAMILA',
      v_tipo_id,
      '2025-06-11'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAMILA',
      'receita',
      1090.0,
      '2025-06-26'::DATE,
      '2025-06-26'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 178: UNI JUNINO (2025-06-13)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-13'::DATE 
    AND UPPER(nome) = 'UNI JUNINO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'UNI JUNINO',
      v_tipo_id,
      '2025-06-13'::DATE,
      2900.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'UNI JUNINO',
      'receita',
      2900.0,
      '2025-06-28'::DATE,
      '2025-06-28'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 179: SABRINA (2025-06-14)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-14'::DATE 
    AND UPPER(nome) = 'SABRINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SABRINA',
      v_tipo_id,
      '2025-06-14'::DATE,
      420.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SABRINA',
      'receita',
      420.0,
      '2025-06-29'::DATE,
      '2025-06-29'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 360.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'SABRINA',
        'despesa',
        360.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        360.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'SABRINA',
        'despesa',
        210.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 180: BAND (2025-06-14)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-14'::DATE 
    AND UPPER(nome) = 'BAND'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BAND',
      v_tipo_id,
      '2025-06-14'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Poc (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'BAND',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'BAND',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Nanda (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Nanda') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Nanda - ' || 'BAND',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Neia (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Neia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Neia - ' || 'BAND',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'BAND',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'BAND',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Babalu (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'BAND',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Estrela (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'BAND',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Caca (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Caca') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Caca - ' || 'BAND',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 181: BVCC JUNINA (2025-06-14)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-14'::DATE 
    AND UPPER(nome) = 'BVCC JUNINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BVCC JUNINA',
      v_tipo_id,
      '2025-06-14'::DATE,
      11300.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BVCC JUNINA',
      'receita',
      11300.0,
      '2025-06-29'::DATE,
      '2025-06-29'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Vertinho (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Vertinho') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Vertinho - ' || 'BVCC JUNINA',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'BVCC JUNINA',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Gisa (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Gisa') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Gisa - ' || 'BVCC JUNINA',
        'despesa',
        400.0,
        '2025-06-29'::DATE,
        '2025-06-29'::DATE,
        'pago',
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
        '2025-06-14'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 182: BVCC JUNINA (2025-06-14)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-14'::DATE 
    AND UPPER(nome) = 'BVCC JUNINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BVCC JUNINA',
      v_tipo_id,
      '2025-06-14'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;
  END IF;

  -- Evento 183: JULIA CLARA (2025-06-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-15'::DATE 
    AND UPPER(nome) = 'JULIA CLARA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JULIA CLARA',
      v_tipo_id,
      '2025-06-15'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JULIA CLARA',
      'receita',
      730.0,
      '2025-06-30'::DATE,
      '2025-06-30'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'JULIA CLARA',
        'despesa',
        180.0,
        '2025-06-30'::DATE,
        '2025-06-30'::DATE,
        'pago',
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
        '2025-06-15'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'JULIA CLARA',
        'despesa',
        180.0,
        '2025-06-30'::DATE,
        '2025-06-30'::DATE,
        'pago',
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
        '2025-06-15'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 184: FILIPE (2025-06-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-15'::DATE 
    AND UPPER(nome) = 'FILIPE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FILIPE',
      v_tipo_id,
      '2025-06-15'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FILIPE',
      'receita',
      1090.0,
      '2025-06-30'::DATE,
      '2025-06-30'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Gisa (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Gisa') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Gisa - ' || 'FILIPE',
        'despesa',
        180.0,
        '2025-06-30'::DATE,
        '2025-06-30'::DATE,
        'pago',
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
        '2025-06-15'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 185: RESTAURANTE HEIMAT (2025-06-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-15'::DATE 
    AND UPPER(nome) = 'RESTAURANTE HEIMAT'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'RESTAURANTE HEIMAT',
      v_tipo_id,
      '2025-06-15'::DATE,
      420.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'RESTAURANTE HEIMAT',
      'receita',
      420.0,
      '2025-06-30'::DATE,
      '2025-06-30'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'RESTAURANTE HEIMAT',
        'despesa',
        400.0,
        '2025-06-30'::DATE,
        '2025-06-30'::DATE,
        'pago',
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
        '2025-06-15'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 186: FAZENDA EVARISTO (2025-06-20)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-20'::DATE 
    AND UPPER(nome) = 'FAZENDA EVARISTO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FAZENDA EVARISTO',
      v_tipo_id,
      '2025-06-20'::DATE,
      2000.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FAZENDA EVARISTO',
      'receita',
      2000.0,
      '2025-05-07'::DATE,
      '2025-05-07'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 187: LÊ (2025-06-21)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-21'::DATE 
    AND UPPER(nome) = 'LÊ'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LÊ',
      v_tipo_id,
      '2025-06-21'::DATE,
      630.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LÊ',
      'receita',
      630.0,
      '2025-06-07'::DATE,
      '2025-06-07'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 188: BILLY (2025-06-21)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-21'::DATE 
    AND UPPER(nome) = 'BILLY'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BILLY',
      v_tipo_id,
      '2025-06-21'::DATE,
      550.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BILLY',
      'receita',
      550.0,
      '2025-06-07'::DATE,
      '2025-06-07'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'BILLY',
        'despesa',
        180.0,
        '2025-06-07'::DATE,
        '2025-06-07'::DATE,
        'pago',
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
        '2025-06-21'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'BILLY',
        'despesa',
        180.0,
        '2025-06-07'::DATE,
        '2025-06-07'::DATE,
        'pago',
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
        '2025-06-21'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 189: JACY (2025-06-21)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-21'::DATE 
    AND UPPER(nome) = 'JACY'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JACY',
      v_tipo_id,
      '2025-06-21'::DATE,
      1380.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JACY',
      'receita',
      1380.0,
      '2025-06-07'::DATE,
      '2025-06-07'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'JACY',
        'despesa',
        180.0,
        '2025-06-07'::DATE,
        '2025-06-07'::DATE,
        'pago',
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
        '2025-06-21'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 190: CAROLINA (2025-06-21)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-21'::DATE 
    AND UPPER(nome) = 'CAROLINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAROLINA',
      v_tipo_id,
      '2025-06-21'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAROLINA',
      'receita',
      730.0,
      '2025-06-07'::DATE,
      '2025-06-07'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'CAROLINA',
        'despesa',
        180.0,
        '2025-06-07'::DATE,
        '2025-06-07'::DATE,
        'pago',
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
        '2025-06-21'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'CAROLINA',
        'despesa',
        180.0,
        '2025-06-07'::DATE,
        '2025-06-07'::DATE,
        'pago',
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
        '2025-06-21'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 191: MARIA JULIA (2025-06-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-22'::DATE 
    AND UPPER(nome) = 'MARIA JULIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARIA JULIA',
      v_tipo_id,
      '2025-06-22'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARIA JULIA',
      'receita',
      1090.0,
      '2025-07-07'::DATE,
      '2025-07-07'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MARIA JULIA',
        'despesa',
        200.0,
        '2025-07-07'::DATE,
        '2025-07-07'::DATE,
        'pago',
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
        '2025-06-22'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 192: JOSELENE (2025-06-28)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-28'::DATE 
    AND UPPER(nome) = 'JOSELENE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JOSELENE',
      v_tipo_id,
      '2025-06-28'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JOSELENE',
      'receita',
      730.0,
      '2025-07-13'::DATE,
      '2025-07-13'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 193: FABI (2025-06-28)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-06-28'::DATE 
    AND UPPER(nome) = 'FABI'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FABI',
      v_tipo_id,
      '2025-06-28'::DATE,
      630.0,
      189.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FABI',
      'receita',
      630.0,
      '2025-07-13'::DATE,
      '2025-07-13'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'FABI',
        'despesa',
        180.0,
        '2025-07-13'::DATE,
        '2025-07-13'::DATE,
        'pago',
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
        '2025-06-28'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 194: MONICA (2025-07-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-04'::DATE 
    AND UPPER(nome) = 'MONICA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MONICA',
      v_tipo_id,
      '2025-07-04'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MONICA',
      'receita',
      1090.0,
      '2025-07-19'::DATE,
      '2025-07-19'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 195: INFLAVEIS BELA VISTA (2025-07-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-05'::DATE 
    AND UPPER(nome) = 'INFLAVEIS BELA VISTA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'INFLAVEIS BELA VISTA',
      v_tipo_id,
      '2025-07-05'::DATE,
      950.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'INFLAVEIS BELA VISTA',
      'receita',
      950.0,
      '2025-07-20'::DATE,
      '2025-07-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 196: MAPLE BEAR (2025-07-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-05'::DATE 
    AND UPPER(nome) = 'MAPLE BEAR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MAPLE BEAR',
      v_tipo_id,
      '2025-07-05'::DATE,
      1630.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MAPLE BEAR',
      'receita',
      1630.0,
      '2025-07-20'::DATE,
      '2025-07-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'MAPLE BEAR',
        'despesa',
        180.0,
        '2025-07-20'::DATE,
        '2025-07-20'::DATE,
        'pago',
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
        '2025-07-05'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 197: RENATA (2025-07-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-05'::DATE 
    AND UPPER(nome) = 'RENATA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'RENATA',
      v_tipo_id,
      '2025-07-05'::DATE,
      790.0,
      237.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'RENATA',
      'receita',
      790.0,
      '2025-07-20'::DATE,
      '2025-07-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'RENATA',
        'despesa',
        200.0,
        '2025-07-20'::DATE,
        '2025-07-20'::DATE,
        'pago',
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
        '2025-07-05'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 198: CAROL (2025-07-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-05'::DATE 
    AND UPPER(nome) = 'CAROL'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAROL',
      v_tipo_id,
      '2025-07-05'::DATE,
      1390.0,
      417.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAROL',
      'receita',
      1390.0,
      '2025-07-20'::DATE,
      '2025-07-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'CAROL',
        'despesa',
        180.0,
        '2025-07-20'::DATE,
        '2025-07-20'::DATE,
        'pago',
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
        '2025-07-05'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 199: SILMARA (2025-07-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-06'::DATE 
    AND UPPER(nome) = 'SILMARA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SILMARA',
      v_tipo_id,
      '2025-07-06'::DATE,
      730.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SILMARA',
      'receita',
      730.0,
      '2025-07-21'::DATE,
      '2025-07-21'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'SILMARA',
        'despesa',
        200.0,
        '2025-07-21'::DATE,
        '2025-07-21'::DATE,
        'pago',
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
        '2025-07-06'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 200: SUZY (2025-07-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-06'::DATE 
    AND UPPER(nome) = 'SUZY'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SUZY',
      v_tipo_id,
      '2025-07-06'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SUZY',
      'receita',
      1090.0,
      '2025-07-21'::DATE,
      '2025-07-21'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'SUZY',
        'despesa',
        180.0,
        '2025-07-21'::DATE,
        '2025-07-21'::DATE,
        'pago',
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
        '2025-07-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 201: LUCIANA (2025-07-11)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-11'::DATE 
    AND UPPER(nome) = 'LUCIANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LUCIANA',
      v_tipo_id,
      '2025-07-11'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LUCIANA',
      'receita',
      1090.0,
      '2025-07-26'::DATE,
      '2025-07-26'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'LUCIANA',
        'despesa',
        180.0,
        '2025-07-26'::DATE,
        '2025-07-26'::DATE,
        'pago',
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
        '2025-07-11'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Ravena (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Ravena') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Ravena - ' || 'LUCIANA',
        'despesa',
        200.0,
        '2025-07-26'::DATE,
        '2025-07-26'::DATE,
        'pago',
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
        '2025-07-11'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 202: ISADORA (2025-07-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-12'::DATE 
    AND UPPER(nome) = 'ISADORA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ISADORA',
      v_tipo_id,
      '2025-07-12'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ISADORA',
      'receita',
      1090.0,
      '2025-07-27'::DATE,
      '2025-07-27'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'ISADORA',
        'despesa',
        180.0,
        '2025-07-27'::DATE,
        '2025-07-27'::DATE,
        'pago',
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
        '2025-07-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 203: SUELEM (2025-07-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-12'::DATE 
    AND UPPER(nome) = 'SUELEM'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SUELEM',
      v_tipo_id,
      '2025-07-12'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SUELEM',
      'receita',
      1090.0,
      '2025-07-27'::DATE,
      '2025-07-27'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 204: ALEXANDRE (2025-07-13)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-13'::DATE 
    AND UPPER(nome) = 'ALEXANDRE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ALEXANDRE',
      v_tipo_id,
      '2025-07-13'::DATE,
      390.0,
      117.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ALEXANDRE',
      'receita',
      390.0,
      '2025-07-28'::DATE,
      '2025-07-28'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 205: INFLAVEIS MAPLE BEAR (2025-07-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-16'::DATE 
    AND UPPER(nome) = 'INFLAVEIS MAPLE BEAR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'INFLAVEIS MAPLE BEAR',
      v_tipo_id,
      '2025-07-16'::DATE,
      1120.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'INFLAVEIS MAPLE BEAR',
      'receita',
      1120.0,
      '2025-07-31'::DATE,
      '2025-07-31'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'INFLAVEIS MAPLE BEAR',
        'despesa',
        200.0,
        '2025-07-31'::DATE,
        '2025-07-31'::DATE,
        'pago',
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
        '2025-07-16'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 206: GIOVANA (2025-07-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-16'::DATE 
    AND UPPER(nome) = 'GIOVANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GIOVANA',
      v_tipo_id,
      '2025-07-16'::DATE,
      730.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GIOVANA',
      'receita',
      730.0,
      '2025-07-31'::DATE,
      '2025-07-31'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'GIOVANA',
        'despesa',
        150.0,
        '2025-07-31'::DATE,
        '2025-07-31'::DATE,
        'pago',
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
        '2025-07-16'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 207: EVENTO TAISE (2025-07-18)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-18'::DATE 
    AND UPPER(nome) = 'EVENTO TAISE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'EVENTO TAISE',
      v_tipo_id,
      '2025-07-18'::DATE,
      1810.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'EVENTO TAISE',
      'receita',
      1810.0,
      '2025-02-08'::DATE,
      '2025-02-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Pepe (R$ 260.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'EVENTO TAISE',
        'despesa',
        260.0,
        '2025-02-08'::DATE,
        '2025-02-08'::DATE,
        'pago',
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
        '2025-07-18'::DATE,
        260.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Estrela (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'EVENTO TAISE',
        'despesa',
        240.0,
        '2025-02-08'::DATE,
        '2025-02-08'::DATE,
        'pago',
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
        '2025-07-18'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Sorriso (R$ 240.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'EVENTO TAISE',
        'despesa',
        240.0,
        '2025-02-08'::DATE,
        '2025-02-08'::DATE,
        'pago',
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
        '2025-07-18'::DATE,
        240.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Babalu (R$ 260.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'EVENTO TAISE',
        'despesa',
        260.0,
        '2025-02-08'::DATE,
        '2025-02-08'::DATE,
        'pago',
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
        '2025-07-18'::DATE,
        260.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 208: FEIJOADA TO INDO (2025-07-19)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-19'::DATE 
    AND UPPER(nome) = 'FEIJOADA TO INDO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FEIJOADA TO INDO',
      v_tipo_id,
      '2025-07-19'::DATE,
      3400.0,
      1005.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FEIJOADA TO INDO',
      'receita',
      3400.0,
      '2025-03-08'::DATE,
      '2025-03-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'FEIJOADA TO INDO',
        'despesa',
        210.0,
        '2025-03-08'::DATE,
        '2025-03-08'::DATE,
        'pago',
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
        '2025-07-19'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 209: TÂNIA (2025-07-19)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-19'::DATE 
    AND UPPER(nome) = 'TÂNIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TÂNIA',
      v_tipo_id,
      '2025-07-19'::DATE,
      830.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TÂNIA',
      'receita',
      830.0,
      '2025-03-08'::DATE,
      '2025-03-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 350.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'TÂNIA',
        'despesa',
        350.0,
        '2025-03-08'::DATE,
        '2025-03-08'::DATE,
        'pago',
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
        '2025-07-19'::DATE,
        350.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pedrita (R$ 350.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pedrita') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pedrita - ' || 'TÂNIA',
        'despesa',
        350.0,
        '2025-03-08'::DATE,
        '2025-03-08'::DATE,
        'pago',
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
        '2025-07-19'::DATE,
        350.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mu (R$ 350.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mu - ' || 'TÂNIA',
        'despesa',
        350.0,
        '2025-03-08'::DATE,
        '2025-03-08'::DATE,
        'pago',
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
        '2025-07-19'::DATE,
        350.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 350.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'TÂNIA',
        'despesa',
        350.0,
        '2025-03-08'::DATE,
        '2025-03-08'::DATE,
        'pago',
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
        '2025-07-19'::DATE,
        350.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 210: FEIJOADA OMAS HAUS (2025-07-19)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-19'::DATE 
    AND UPPER(nome) = 'FEIJOADA OMAS HAUS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FEIJOADA OMAS HAUS',
      v_tipo_id,
      '2025-07-19'::DATE,
      800.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FEIJOADA OMAS HAUS',
      'receita',
      800.0,
      '2025-03-08'::DATE,
      '2025-03-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jojo (R$ 100.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'FEIJOADA OMAS HAUS',
        'despesa',
        100.0,
        '2025-03-08'::DATE,
        '2025-03-08'::DATE,
        'pago',
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
        '2025-07-19'::DATE,
        100.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 211: ESPAÇO KIDS (2025-07-15)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-15'::DATE 
    AND UPPER(nome) = 'ESPAÇO KIDS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ESPAÇO KIDS',
      v_tipo_id,
      '2025-07-15'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Jojo (R$ 100.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'ESPAÇO KIDS',
        'despesa',
        100.0,
        '2025-07-30'::DATE,
        '2025-07-30'::DATE,
        'pago',
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
        '2025-07-15'::DATE,
        100.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 212: ESPAÇO KIDS (2025-07-22)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-22'::DATE 
    AND UPPER(nome) = 'ESPAÇO KIDS'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ESPAÇO KIDS',
      v_tipo_id,
      '2025-07-22'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;
  END IF;

  -- Evento 213: JOSI (2025-07-25)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-25'::DATE 
    AND UPPER(nome) = 'JOSI'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JOSI',
      v_tipo_id,
      '2025-07-25'::DATE,
      220.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JOSI',
      'receita',
      220.0,
      '2025-09-08'::DATE,
      '2025-09-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 214: ANDERSON (2025-07-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-26'::DATE 
    AND UPPER(nome) = 'ANDERSON'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANDERSON',
      v_tipo_id,
      '2025-07-26'::DATE,
      220.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANDERSON',
      'receita',
      220.0,
      '2025-10-08'::DATE,
      '2025-10-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Alice (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Alice') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Alice - ' || 'ANDERSON',
        'despesa',
        180.0,
        '2025-10-08'::DATE,
        '2025-10-08'::DATE,
        'pago',
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
        '2025-07-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'ANDERSON',
        'despesa',
        180.0,
        '2025-10-08'::DATE,
        '2025-10-08'::DATE,
        'pago',
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
        '2025-07-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Babalu (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'ANDERSON',
        'despesa',
        180.0,
        '2025-10-08'::DATE,
        '2025-10-08'::DATE,
        'pago',
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
        '2025-07-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 215: EVENTO  D10 (2025-07-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-26'::DATE 
    AND UPPER(nome) = 'EVENTO  D10'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'EVENTO  D10',
      v_tipo_id,
      '2025-07-26'::DATE,
      1900.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'EVENTO  D10',
      'receita',
      1900.0,
      '2025-10-08'::DATE,
      '2025-10-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Sorriso (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Sorriso') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Sorriso - ' || 'EVENTO  D10',
        'despesa',
        180.0,
        '2025-10-08'::DATE,
        '2025-10-08'::DATE,
        'pago',
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
        '2025-07-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 216: BETINA (2025-07-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-26'::DATE 
    AND UPPER(nome) = 'BETINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BETINA',
      v_tipo_id,
      '2025-07-26'::DATE,
      1470.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BETINA',
      'receita',
      1470.0,
      '2025-10-08'::DATE,
      '2025-10-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'BETINA',
        'despesa',
        150.0,
        '2025-10-08'::DATE,
        '2025-10-08'::DATE,
        'pago',
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
        '2025-07-26'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 217: IVY (2025-07-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-26'::DATE 
    AND UPPER(nome) = 'IVY'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'IVY',
      v_tipo_id,
      '2025-07-26'::DATE,
      600.0,
      180.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'IVY',
      'receita',
      600.0,
      '2025-10-08'::DATE,
      '2025-10-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'IVY',
        'despesa',
        180.0,
        '2025-10-08'::DATE,
        '2025-10-08'::DATE,
        'pago',
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
        '2025-07-26'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 218: CAROLINA (2025-07-27)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-27'::DATE 
    AND UPPER(nome) = 'CAROLINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAROLINA',
      v_tipo_id,
      '2025-07-27'::DATE,
      1900.0,
      570.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAROLINA',
      'receita',
      1900.0,
      '2025-11-08'::DATE,
      '2025-11-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'CAROLINA',
        'despesa',
        180.0,
        '2025-11-08'::DATE,
        '2025-11-08'::DATE,
        'pago',
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
        '2025-07-27'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 219: MARIANE (2025-07-27)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-27'::DATE 
    AND UPPER(nome) = 'MARIANE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARIANE',
      v_tipo_id,
      '2025-07-27'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARIANE',
      'receita',
      730.0,
      '2025-11-08'::DATE,
      '2025-11-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'MARIANE',
        'despesa',
        180.0,
        '2025-11-08'::DATE,
        '2025-11-08'::DATE,
        'pago',
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
        '2025-07-27'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 220: TETE (2025-07-30)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-30'::DATE 
    AND UPPER(nome) = 'TETE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TETE',
      v_tipo_id,
      '2025-07-30'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TETE',
      'receita',
      1090.0,
      '2025-08-14'::DATE,
      '2025-08-14'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'TETE',
        'despesa',
        400.0,
        '2025-08-14'::DATE,
        '2025-08-14'::DATE,
        'pago',
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
        '2025-07-30'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pedrita (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pedrita') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pedrita - ' || 'TETE',
        'despesa',
        400.0,
        '2025-08-14'::DATE,
        '2025-08-14'::DATE,
        'pago',
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
        '2025-07-30'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 221: FAZENDA EVARISTO (2025-07-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-26'::DATE 
    AND UPPER(nome) = 'FAZENDA EVARISTO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FAZENDA EVARISTO',
      v_tipo_id,
      '2025-07-26'::DATE,
      2100.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FAZENDA EVARISTO',
      'receita',
      2100.0,
      '2025-10-08'::DATE,
      '2025-10-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 222: JOSI (2025-07-27)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Infláveis' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-27'::DATE 
    AND UPPER(nome) = 'JOSI'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JOSI',
      v_tipo_id,
      '2025-07-27'::DATE,
      1000.0,
      300.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JOSI',
      'receita',
      1000.0,
      '2025-11-08'::DATE,
      '2025-11-08'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'JOSI',
        'despesa',
        180.0,
        '2025-11-08'::DATE,
        '2025-11-08'::DATE,
        'pago',
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
        '2025-07-27'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 223: TETE (2025-07-30)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-07-30'::DATE 
    AND UPPER(nome) = 'TETE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TETE',
      v_tipo_id,
      '2025-07-30'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TETE',
      'receita',
      1090.0,
      '2025-08-14'::DATE,
      '2025-08-14'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 170.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'TETE',
        'despesa',
        170.0,
        '2025-08-14'::DATE,
        '2025-08-14'::DATE,
        'pago',
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
        '2025-07-30'::DATE,
        170.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 224: MARI (2025-08-02)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-02'::DATE 
    AND UPPER(nome) = 'MARI'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARI',
      v_tipo_id,
      '2025-08-02'::DATE,
      840.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARI',
      'receita',
      840.0,
      '2025-08-17'::DATE,
      '2025-08-17'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 170.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MARI',
        'despesa',
        170.0,
        '2025-08-17'::DATE,
        '2025-08-17'::DATE,
        'pago',
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
        '2025-08-02'::DATE,
        170.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 225: MANIA DE BRINCAR (2025-08-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-05'::DATE 
    AND UPPER(nome) = 'MANIA DE BRINCAR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MANIA DE BRINCAR',
      v_tipo_id,
      '2025-08-05'::DATE,
      690.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MANIA DE BRINCAR',
      'receita',
      690.0,
      '2025-08-20'::DATE,
      '2025-08-20'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MANIA DE BRINCAR',
        'despesa',
        200.0,
        '2025-08-20'::DATE,
        '2025-08-20'::DATE,
        'pago',
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
        '2025-08-05'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Gabe (R$ 120.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Gabe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Gabe - ' || 'MANIA DE BRINCAR',
        'despesa',
        120.0,
        '2025-08-20'::DATE,
        '2025-08-20'::DATE,
        'pago',
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
        '2025-08-05'::DATE,
        120.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'MANIA DE BRINCAR',
        'despesa',
        180.0,
        '2025-08-20'::DATE,
        '2025-08-20'::DATE,
        'pago',
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
        '2025-08-05'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Polly (R$ 120.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Polly') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Polly - ' || 'MANIA DE BRINCAR',
        'despesa',
        120.0,
        '2025-08-20'::DATE,
        '2025-08-20'::DATE,
        'pago',
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
        '2025-08-05'::DATE,
        120.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 120.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'MANIA DE BRINCAR',
        'despesa',
        120.0,
        '2025-08-20'::DATE,
        '2025-08-20'::DATE,
        'pago',
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
        '2025-08-05'::DATE,
        120.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Gisa (R$ 120.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Gisa') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Gisa - ' || 'MANIA DE BRINCAR',
        'despesa',
        120.0,
        '2025-08-20'::DATE,
        '2025-08-20'::DATE,
        'pago',
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
        '2025-08-05'::DATE,
        120.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 226: GINCANA MADRE (2025-08-08)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-08'::DATE 
    AND UPPER(nome) = 'GINCANA MADRE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GINCANA MADRE',
      v_tipo_id,
      '2025-08-08'::DATE,
      2200.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GINCANA MADRE',
      'receita',
      2200.0,
      '2025-08-23'::DATE,
      '2025-08-23'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 170.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'GINCANA MADRE',
        'despesa',
        170.0,
        '2025-08-23'::DATE,
        '2025-08-23'::DATE,
        'pago',
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
        '2025-08-08'::DATE,
        170.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 227: ELISANGELA (2025-08-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-09'::DATE 
    AND UPPER(nome) = 'ELISANGELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ELISANGELA',
      v_tipo_id,
      '2025-08-09'::DATE,
      590.0,
      177.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ELISANGELA',
      'receita',
      590.0,
      '2025-08-24'::DATE,
      '2025-08-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'ELISANGELA',
        'despesa',
        180.0,
        '2025-08-24'::DATE,
        '2025-08-24'::DATE,
        'pago',
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
        '2025-08-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'ELISANGELA',
        'despesa',
        180.0,
        '2025-08-24'::DATE,
        '2025-08-24'::DATE,
        'pago',
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
        '2025-08-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 228: LUIZA (2025-08-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-09'::DATE 
    AND UPPER(nome) = 'LUIZA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LUIZA',
      v_tipo_id,
      '2025-08-09'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LUIZA',
      'receita',
      1090.0,
      '2025-08-24'::DATE,
      '2025-08-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'LUIZA',
        'despesa',
        200.0,
        '2025-08-24'::DATE,
        '2025-08-24'::DATE,
        'pago',
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
        '2025-08-09'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'LUIZA',
        'despesa',
        180.0,
        '2025-08-24'::DATE,
        '2025-08-24'::DATE,
        'pago',
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
        '2025-08-09'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 229: FERNANDA (2025-08-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-09'::DATE 
    AND UPPER(nome) = 'FERNANDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FERNANDA',
      v_tipo_id,
      '2025-08-09'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FERNANDA',
      'receita',
      1090.0,
      '2025-08-24'::DATE,
      '2025-08-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 230: MARIA EDUARDA (2025-08-09)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-09'::DATE 
    AND UPPER(nome) = 'MARIA EDUARDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARIA EDUARDA',
      v_tipo_id,
      '2025-08-09'::DATE,
      630.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARIA EDUARDA',
      'receita',
      630.0,
      '2025-08-24'::DATE,
      '2025-08-24'::DATE,
      'pago',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 231: REBECCA (2025-08-10)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-10'::DATE 
    AND UPPER(nome) = 'REBECCA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'REBECCA',
      v_tipo_id,
      '2025-08-10'::DATE,
      630.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'REBECCA',
      'receita',
      630.0,
      '2025-08-25'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'REBECCA',
        'despesa',
        200.0,
        '2025-08-25'::DATE,
        NULL,
        'pendente',
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
        '2025-08-10'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 232: EVENTO SAGRADA (2025-08-11)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-11'::DATE 
    AND UPPER(nome) = 'EVENTO SAGRADA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'EVENTO SAGRADA',
      v_tipo_id,
      '2025-08-11'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'EVENTO SAGRADA',
        'despesa',
        200.0,
        '2025-08-26'::DATE,
        NULL,
        'pendente',
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
        '2025-08-11'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 233: MANIA DE BRINCAR (2025-08-16)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-16'::DATE 
    AND UPPER(nome) = 'MANIA DE BRINCAR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MANIA DE BRINCAR',
      v_tipo_id,
      '2025-08-16'::DATE,
      780.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MANIA DE BRINCAR',
      'receita',
      780.0,
      '2025-08-31'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'MANIA DE BRINCAR',
        'despesa',
        180.0,
        '2025-08-31'::DATE,
        NULL,
        'pendente',
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
        '2025-08-16'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 234: FEIJOADA FELIPE (2025-08-17)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-17'::DATE 
    AND UPPER(nome) = 'FEIJOADA FELIPE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FEIJOADA FELIPE',
      v_tipo_id,
      '2025-08-17'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FEIJOADA FELIPE',
      'receita',
      1090.0,
      '2025-01-09'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'FEIJOADA FELIPE',
        'despesa',
        200.0,
        '2025-01-09'::DATE,
        NULL,
        'pendente',
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
        '2025-08-17'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'FEIJOADA FELIPE',
        'despesa',
        180.0,
        '2025-01-09'::DATE,
        NULL,
        'pendente',
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
        '2025-08-17'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 235: FERNANDA (2025-08-17)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-17'::DATE 
    AND UPPER(nome) = 'FERNANDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FERNANDA',
      v_tipo_id,
      '2025-08-17'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FERNANDA',
      'receita',
      1090.0,
      '2025-01-09'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'FERNANDA',
        'despesa',
        180.0,
        '2025-01-09'::DATE,
        NULL,
        'pendente',
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
        '2025-08-17'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 236: CAMILA (2025-08-23)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-23'::DATE 
    AND UPPER(nome) = 'CAMILA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CAMILA',
      v_tipo_id,
      '2025-08-23'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CAMILA',
      'receita',
      730.0,
      '2025-07-09'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'CAMILA',
        'despesa',
        150.0,
        '2025-07-09'::DATE,
        NULL,
        'pendente',
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
        '2025-08-23'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 237: VANESSA (2025-08-24)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-24'::DATE 
    AND UPPER(nome) = 'VANESSA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'VANESSA',
      v_tipo_id,
      '2025-08-24'::DATE,
      900.0,
      300.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'VANESSA',
      'receita',
      900.0,
      '2025-08-09'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'VANESSA',
        'despesa',
        150.0,
        '2025-08-09'::DATE,
        NULL,
        'pendente',
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
        '2025-08-24'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'VANESSA',
        'despesa',
        150.0,
        '2025-08-09'::DATE,
        NULL,
        'pendente',
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
        '2025-08-24'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'VANESSA',
        'despesa',
        150.0,
        '2025-08-09'::DATE,
        NULL,
        'pendente',
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
        '2025-08-24'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 238: MADRE (2026-08-29)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2026-08-29'::DATE 
    AND UPPER(nome) = 'MADRE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MADRE',
      v_tipo_id,
      '2026-08-29'::DATE,
      900.0,
      NULL,
      'confirmado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MADRE',
      'receita',
      900.0,
      '2026-09-13'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MADRE',
        'despesa',
        200.0,
        '2026-09-13'::DATE,
        NULL,
        'pendente',
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
        '2026-08-29'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'MADRE',
        'despesa',
        200.0,
        '2026-09-13'::DATE,
        NULL,
        'pendente',
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
        '2026-08-29'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 239: PAMELA (2026-08-30)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2026-08-30'::DATE 
    AND UPPER(nome) = 'PAMELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PAMELA',
      v_tipo_id,
      '2026-08-30'::DATE,
      1940.0,
      1090.0,
      'confirmado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PAMELA',
      'receita',
      1940.0,
      '2026-09-14'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'PAMELA',
        'despesa',
        200.0,
        '2026-09-14'::DATE,
        NULL,
        'pendente',
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
        '2026-08-30'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 240: THIAGO (2025-08-31)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-31'::DATE 
    AND UPPER(nome) = 'THIAGO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'THIAGO',
      v_tipo_id,
      '2025-08-31'::DATE,
      630.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'THIAGO',
      'receita',
      630.0,
      '2025-09-15'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Gisa (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Gisa') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Gisa - ' || 'THIAGO',
        'despesa',
        200.0,
        '2025-09-15'::DATE,
        NULL,
        'pendente',
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
        '2025-08-31'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 241: JULIANA (2026-08-31)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2026-08-31'::DATE 
    AND UPPER(nome) = 'JULIANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'JULIANA',
      v_tipo_id,
      '2026-08-31'::DATE,
      1090.0,
      323.0,
      'confirmado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'JULIANA',
      'receita',
      1090.0,
      '2026-09-15'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Pepe (R$ 230.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'JULIANA',
        'despesa',
        230.0,
        '2026-09-15'::DATE,
        NULL,
        'pendente',
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
        '2026-08-31'::DATE,
        230.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'JULIANA',
        'despesa',
        210.0,
        '2026-09-15'::DATE,
        NULL,
        'pendente',
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
        '2026-08-31'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jojo (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jojo') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jojo - ' || 'JULIANA',
        'despesa',
        210.0,
        '2026-09-15'::DATE,
        NULL,
        'pendente',
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
        '2026-08-31'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Mari (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Mari') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Mari - ' || 'JULIANA',
        'despesa',
        210.0,
        '2026-09-15'::DATE,
        NULL,
        'pendente',
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
        '2026-08-31'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'JULIANA',
        'despesa',
        210.0,
        '2026-09-15'::DATE,
        NULL,
        'pendente',
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
        '2026-08-31'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 242: GCB (2025-08-31)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-08-31'::DATE 
    AND UPPER(nome) = 'GCB'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GCB',
      v_tipo_id,
      '2025-08-31'::DATE,
      3600.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GCB',
      'receita',
      3600.0,
      '2025-09-15'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'GCB',
        'despesa',
        180.0,
        '2025-09-15'::DATE,
        NULL,
        'pendente',
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
        '2025-08-31'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 243: PRISCILA (2025-09-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-05'::DATE 
    AND UPPER(nome) = 'PRISCILA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PRISCILA',
      v_tipo_id,
      '2025-09-05'::DATE,
      730.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PRISCILA',
      'receita',
      730.0,
      '2025-09-20'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'PRISCILA',
        'despesa',
        180.0,
        '2025-09-20'::DATE,
        NULL,
        'pendente',
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
        '2025-09-05'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Paçoca (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Paçoca') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Paçoca - ' || 'PRISCILA',
        'despesa',
        180.0,
        '2025-09-20'::DATE,
        NULL,
        'pendente',
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
        '2025-09-05'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Paçoca (R$ 42.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Paçoca') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Paçoca - ' || 'PRISCILA',
        'despesa',
        42.0,
        '2025-09-20'::DATE,
        NULL,
        'pendente',
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
        '2025-09-05'::DATE,
        42.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 244: BAND (2025-09-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-06'::DATE 
    AND UPPER(nome) = 'BAND'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BAND',
      v_tipo_id,
      '2025-09-06'::DATE,
      1800.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BAND',
      'receita',
      1800.0,
      '2025-09-21'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'BAND',
        'despesa',
        180.0,
        '2025-09-21'::DATE,
        NULL,
        'pendente',
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
        '2025-09-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'BAND',
        'despesa',
        180.0,
        '2025-09-21'::DATE,
        NULL,
        'pendente',
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
        '2025-09-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 245: LUIZ (2025-09-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-06'::DATE 
    AND UPPER(nome) = 'LUIZ'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LUIZ',
      v_tipo_id,
      '2025-09-06'::DATE,
      730.0,
      279.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LUIZ',
      'receita',
      730.0,
      '2025-09-21'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Pepe (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'LUIZ',
        'despesa',
        200.0,
        '2025-09-21'::DATE,
        NULL,
        'pendente',
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
        '2025-09-06'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Ravena (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Ravena') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Ravena - ' || 'LUIZ',
        'despesa',
        200.0,
        '2025-09-21'::DATE,
        NULL,
        'pendente',
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
        '2025-09-06'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 246: LUIZA (2025-09-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-06'::DATE 
    AND UPPER(nome) = 'LUIZA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'LUIZA',
      v_tipo_id,
      '2025-09-06'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'LUIZA',
      'receita',
      1090.0,
      '2025-09-21'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 247: SANDRA (2025-09-06)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-06'::DATE 
    AND UPPER(nome) = 'SANDRA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'SANDRA',
      v_tipo_id,
      '2025-09-06'::DATE,
      1480.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'SANDRA',
      'receita',
      1480.0,
      '2025-09-21'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'SANDRA',
        'despesa',
        180.0,
        '2025-09-21'::DATE,
        NULL,
        'pendente',
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
        '2025-09-06'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 200.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'SANDRA',
        'despesa',
        200.0,
        '2025-09-21'::DATE,
        NULL,
        'pendente',
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
        '2025-09-06'::DATE,
        200.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 248: BOLAGA (2025-09-07)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-07'::DATE 
    AND UPPER(nome) = 'BOLAGA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BOLAGA',
      v_tipo_id,
      '2025-09-07'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Poc (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'BOLAGA',
        'despesa',
        400.0,
        '2025-09-22'::DATE,
        NULL,
        'pendente',
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
        '2025-09-07'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Pepe (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'BOLAGA',
        'despesa',
        400.0,
        '2025-09-22'::DATE,
        NULL,
        'pendente',
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
        '2025-09-07'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Estrela (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'BOLAGA',
        'despesa',
        400.0,
        '2025-09-22'::DATE,
        NULL,
        'pendente',
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
        '2025-09-07'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 400.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'BOLAGA',
        'despesa',
        400.0,
        '2025-09-22'::DATE,
        NULL,
        'pendente',
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
        '2025-09-07'::DATE,
        400.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 249: ACAMPAMENTO SAGRADA (2025-09-12)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-12'::DATE 
    AND UPPER(nome) = 'ACAMPAMENTO SAGRADA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ACAMPAMENTO SAGRADA',
      v_tipo_id,
      '2025-09-12'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'ACAMPAMENTO SAGRADA',
        'despesa',
        180.0,
        '2025-09-27'::DATE,
        NULL,
        'pendente',
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
        '2025-09-12'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 250: TALITA (2025-09-13)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-13'::DATE 
    AND UPPER(nome) = 'TALITA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TALITA',
      v_tipo_id,
      '2025-09-13'::DATE,
      1340.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TALITA',
      'receita',
      1340.0,
      '2025-09-28'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'TALITA',
        'despesa',
        180.0,
        '2025-09-28'::DATE,
        NULL,
        'pendente',
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
        '2025-09-13'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 251: MAIARA (2025-09-13)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-13'::DATE 
    AND UPPER(nome) = 'MAIARA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MAIARA',
      v_tipo_id,
      '2025-09-13'::DATE,
      730.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MAIARA',
      'receita',
      730.0,
      '2025-09-28'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Pepe (R$ 150.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Pepe') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Pepe - ' || 'MAIARA',
        'despesa',
        150.0,
        '2025-09-28'::DATE,
        NULL,
        'pendente',
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
        '2025-09-13'::DATE,
        150.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 252: PAMELA (2025-09-13)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-13'::DATE 
    AND UPPER(nome) = 'PAMELA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'PAMELA',
      v_tipo_id,
      '2025-09-13'::DATE,
      730.0,
      219.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'PAMELA',
      'receita',
      730.0,
      '2025-09-28'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'PAMELA',
        'despesa',
        180.0,
        '2025-09-28'::DATE,
        NULL,
        'pendente',
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
        '2025-09-13'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 253: MANIA DE BRINCAR (2025-09-14)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-14'::DATE 
    AND UPPER(nome) = 'MANIA DE BRINCAR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MANIA DE BRINCAR',
      v_tipo_id,
      '2025-09-14'::DATE,
      780.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MANIA DE BRINCAR',
      'receita',
      780.0,
      '2025-09-29'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MANIA DE BRINCAR',
        'despesa',
        210.0,
        '2025-09-29'::DATE,
        NULL,
        'pendente',
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
        '2025-09-14'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 254: KARINA (2025-09-20)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-20'::DATE 
    AND UPPER(nome) = 'KARINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'KARINA',
      v_tipo_id,
      '2025-09-20'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'KARINA',
      'receita',
      1090.0,
      '2025-05-10'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

  -- Evento 255: FERNANDA (2025-09-21)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-21'::DATE 
    AND UPPER(nome) = 'FERNANDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'FERNANDA',
      v_tipo_id,
      '2025-09-21'::DATE,
      2250.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'FERNANDA',
      'receita',
      2250.0,
      '2025-06-10'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'FERNANDA',
        'despesa',
        210.0,
        '2025-06-10'::DATE,
        NULL,
        'pendente',
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
        '2025-09-21'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 256: NATÁLIA (2025-09-21)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-21'::DATE 
    AND UPPER(nome) = 'NATÁLIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'NATÁLIA',
      v_tipo_id,
      '2025-09-21'::DATE,
      1090.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'NATÁLIA',
      'receita',
      1090.0,
      '2025-06-10'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'NATÁLIA',
        'despesa',
        210.0,
        '2025-06-10'::DATE,
        NULL,
        'pendente',
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
        '2025-09-21'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 257: ANA LUISA (2025-09-24)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-24'::DATE 
    AND UPPER(nome) = 'ANA LUISA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA LUISA',
      v_tipo_id,
      '2025-09-24'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA LUISA',
      'receita',
      1090.0,
      '2025-09-10'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'ANA LUISA',
        'despesa',
        210.0,
        '2025-09-10'::DATE,
        NULL,
        'pendente',
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
        '2025-09-24'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'ANA LUISA',
        'despesa',
        180.0,
        '2025-09-10'::DATE,
        NULL,
        'pendente',
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
        '2025-09-24'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 258: ANA (2025-09-26)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-26'::DATE 
    AND UPPER(nome) = 'ANA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'ANA',
      v_tipo_id,
      '2025-09-26'::DATE,
      930.0,
      340.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'ANA',
      'receita',
      930.0,
      '2025-11-10'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Estrela (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'ANA',
        'despesa',
        210.0,
        '2025-11-10'::DATE,
        NULL,
        'pendente',
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
        '2025-09-26'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 259: CINARA (2025-09-27)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-27'::DATE 
    AND UPPER(nome) = 'CINARA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'CINARA',
      v_tipo_id,
      '2025-09-27'::DATE,
      730.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'CINARA',
      'receita',
      730.0,
      '2025-12-10'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 230.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'CINARA',
        'despesa',
        230.0,
        '2025-12-10'::DATE,
        NULL,
        'pendente',
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
        '2025-09-27'::DATE,
        230.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 260: GAUCHO (2025-09-27)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-27'::DATE 
    AND UPPER(nome) = 'GAUCHO'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GAUCHO',
      v_tipo_id,
      '2025-09-27'::DATE,
      1020.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'GAUCHO',
      'receita',
      1020.0,
      '2025-12-10'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'GAUCHO',
        'despesa',
        210.0,
        '2025-12-10'::DATE,
        NULL,
        'pendente',
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
        '2025-09-27'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Estrela (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'GAUCHO',
        'despesa',
        180.0,
        '2025-12-10'::DATE,
        NULL,
        'pendente',
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
        '2025-09-27'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 261: BVCC MEIA MARATONA (2025-09-28)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-09-28'::DATE 
    AND UPPER(nome) = 'BVCC MEIA MARATONA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BVCC MEIA MARATONA',
      v_tipo_id,
      '2025-09-28'::DATE,
      700.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BVCC MEIA MARATONA',
      'receita',
      700.0,
      '2025-10-13'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'BVCC MEIA MARATONA',
        'despesa',
        210.0,
        '2025-10-13'::DATE,
        NULL,
        'pendente',
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
        '2025-09-28'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Jujuba (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'BVCC MEIA MARATONA',
        'despesa',
        210.0,
        '2025-10-13'::DATE,
        NULL,
        'pendente',
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
        '2025-09-28'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 262: MICHEL (2025-10-03)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-10-03'::DATE 
    AND UPPER(nome) = 'MICHEL'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MICHEL',
      v_tipo_id,
      '2025-10-03'::DATE,
      930.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MICHEL',
      'receita',
      930.0,
      '2025-10-18'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'MICHEL',
        'despesa',
        210.0,
        '2025-10-18'::DATE,
        NULL,
        'pendente',
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
        '2025-10-03'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 263: AMANDA (2025-10-03)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-10-03'::DATE 
    AND UPPER(nome) = 'AMANDA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'AMANDA',
      v_tipo_id,
      '2025-10-03'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'AMANDA',
      'receita',
      1090.0,
      '2025-10-18'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'AMANDA',
        'despesa',
        210.0,
        '2025-10-18'::DATE,
        NULL,
        'pendente',
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
        '2025-10-03'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 264: GINCANA EXCELSIOR (2025-10-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-10-04'::DATE 
    AND UPPER(nome) = 'GINCANA EXCELSIOR'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'GINCANA EXCELSIOR',
      v_tipo_id,
      '2025-10-04'::DATE,
      NULL,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Alocação: Estrela (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Estrela') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Estrela - ' || 'GINCANA EXCELSIOR',
        'despesa',
        210.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Felicia (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'GINCANA EXCELSIOR',
        'despesa',
        210.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Paçoca (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Paçoca') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Paçoca - ' || 'GINCANA EXCELSIOR',
        'despesa',
        180.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Batata (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Batata') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Batata - ' || 'GINCANA EXCELSIOR',
        'despesa',
        180.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 265: TANIA (2025-10-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-10-04'::DATE 
    AND UPPER(nome) = 'TANIA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TANIA',
      v_tipo_id,
      '2025-10-04'::DATE,
      2150.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TANIA',
      'receita',
      2150.0,
      '2025-10-19'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Poc (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Poc') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Poc - ' || 'TANIA',
        'despesa',
        210.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Alice (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Alice') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Alice - ' || 'TANIA',
        'despesa',
        180.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 266: BETINA (2025-10-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-10-04'::DATE 
    AND UPPER(nome) = 'BETINA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BETINA',
      v_tipo_id,
      '2025-10-04'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BETINA',
      'receita',
      1090.0,
      '2025-10-19'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Babalu (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Babalu') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Babalu - ' || 'BETINA',
        'despesa',
        210.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;

    -- Alocação: Dora (R$ 180.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Dora') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Dora - ' || 'BETINA',
        'despesa',
        180.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        180.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 267: TÁBATA (2025-10-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Brinks+Recre' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-10-04'::DATE 
    AND UPPER(nome) = 'TÁBATA'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'TÁBATA',
      v_tipo_id,
      '2025-10-04'::DATE,
      1920.0,
      510.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'TÁBATA',
      'receita',
      1920.0,
      '2025-10-19'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Jujuba (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Jujuba') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Jujuba - ' || 'TÁBATA',
        'despesa',
        210.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 268: MARIANE (2025-10-04)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-10-04'::DATE 
    AND UPPER(nome) = 'MARIANE'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'MARIANE',
      v_tipo_id,
      '2025-10-04'::DATE,
      1090.0,
      327.0,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'MARIANE',
      'receita',
      1090.0,
      '2025-10-19'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );

    -- Alocação: Felicia (R$ 210.0)
    SELECT id INTO v_membro_id FROM equipe WHERE UPPER(nome) = UPPER('Felicia') LIMIT 1;
    IF v_membro_id IS NOT NULL THEN
      -- Criar transação de despesa
      INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
      VALUES (
        'Diária - Felicia - ' || 'MARIANE',
        'despesa',
        210.0,
        '2025-10-19'::DATE,
        NULL,
        'pendente',
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
        '2025-10-04'::DATE,
        210.0,
        v_transacao_id,
        'Importado da planilha'
      );
    END IF;
  END IF;

  -- Evento 269: BILLY (2025-10-05)
  SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  IF v_tipo_id IS NULL THEN
    SELECT id INTO v_tipo_id FROM tipos_evento WHERE nome = 'Recreação' LIMIT 1;
  END IF;
  
  -- Verificar se evento já existe
  SELECT id INTO v_evento_id FROM eventos 
  WHERE data_inicio = '2025-10-05'::DATE 
    AND UPPER(nome) = 'BILLY'
  LIMIT 1;
  
  IF v_evento_id IS NULL THEN
    INSERT INTO eventos (nome, tipo_id, data_inicio, valor_total, valor_sinal, status, observacoes)
    VALUES (
      'BILLY',
      v_tipo_id,
      '2025-10-05'::DATE,
      850.0,
      NULL,
      'realizado',
      'Importado da planilha'
    )
    RETURNING id INTO v_evento_id;

    -- Transação de receita
    INSERT INTO transacoes_financeiras (descricao, tipo, valor, data_vencimento, data_pagamento, status, categoria_id, evento_id, observacoes)
    VALUES (
      'Receita - ' || 'BILLY',
      'receita',
      850.0,
      '2025-10-20'::DATE,
      NULL,
      'pendente',
      v_categoria_receita_id,
      v_evento_id,
      'Importado da planilha'
    );
  END IF;

END $$;

COMMIT;

-- =============================================
-- FIM DA IMPORTAÇÃO
-- =============================================
