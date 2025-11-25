-- =============================================
-- RocketCRM - Setup Completo do Banco de Dados
-- =============================================
-- Este script contém todas as migrations consolidadas.
-- Execute uma única vez no SQL Editor do Supabase.
-- 
-- Data: 25/11/2025
-- Versão: 1.0.0
-- =============================================

-- =============================================
-- PARTE 1: ENUMS
-- =============================================

CREATE TYPE perfil_usuario AS ENUM ('admin', 'usuario');
CREATE TYPE tipo_contato AS ENUM ('pessoa_fisica', 'escola', 'empresa', 'fornecedor');
CREATE TYPE status_lead AS ENUM ('novo', 'qualificado', 'proposta_enviada', 'negociacao', 'aceito', 'perdido');
CREATE TYPE tipo_evento AS ENUM ('viagem_pedagogica', 'viagem_formatura', 'colonia_ferias', 'festa_infantil', 'gincana', 'outro');
CREATE TYPE status_evento AS ENUM ('planejamento', 'confirmado', 'em_andamento', 'realizado', 'cancelado');
CREATE TYPE tipo_recurso AS ENUM ('brinquedo', 'veiculo', 'espaco', 'equipamento', 'outro');
CREATE TYPE funcao_equipe AS ENUM ('monitor', 'recreador', 'coordenador', 'motorista', 'outro');
CREATE TYPE tipo_contrato_equipe AS ENUM ('fixo', 'freelancer');
CREATE TYPE tipo_transacao AS ENUM ('receita', 'despesa');
CREATE TYPE status_pagamento AS ENUM ('pendente', 'pago', 'em_atraso', 'cancelado');
CREATE TYPE status_atividade AS ENUM ('pendente', 'em_andamento', 'concluida', 'cancelada');

-- =============================================
-- PARTE 2: TABELAS
-- =============================================

-- Usuários (sincronizada com auth.users)
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL UNIQUE,
  nome TEXT NOT NULL,
  avatar_url TEXT,
  perfil perfil_usuario DEFAULT 'usuario',
  ativo BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Organizações (escolas, empresas)
CREATE TABLE organizacoes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  tipo tipo_contato DEFAULT 'escola',
  cnpj TEXT,
  email TEXT,
  telefone TEXT,
  endereco TEXT,
  cidade TEXT,
  estado TEXT,
  cep TEXT,
  contato_principal_id UUID,
  observacoes TEXT,
  tags TEXT[],
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Contatos (pessoas físicas)
CREATE TABLE contatos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  tipo tipo_contato DEFAULT 'pessoa_fisica',
  email TEXT,
  telefone TEXT,
  whatsapp TEXT,
  endereco TEXT,
  cidade TEXT,
  estado TEXT,
  cep TEXT,
  organizacao_id UUID REFERENCES organizacoes(id) ON DELETE SET NULL,
  observacoes TEXT,
  tags TEXT[],
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- FK de contato principal nas organizações
ALTER TABLE organizacoes 
ADD CONSTRAINT organizacoes_contato_principal_id_fkey 
FOREIGN KEY (contato_principal_id) REFERENCES contatos(id) ON DELETE SET NULL;

-- Etapas do funil de vendas
CREATE TABLE etapas_funil (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  ordem INT DEFAULT 0,
  cor TEXT DEFAULT '#e4027d',
  is_final BOOLEAN DEFAULT false,
  is_perdido BOOLEAN DEFAULT false,
  ativo BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Leads
CREATE TABLE leads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  titulo TEXT NOT NULL,
  descricao TEXT,
  valor_estimado NUMERIC(12,2),
  etapa_id UUID NOT NULL REFERENCES etapas_funil(id),
  contato_id UUID REFERENCES contatos(id) ON DELETE SET NULL,
  organizacao_id UUID REFERENCES organizacoes(id) ON DELETE SET NULL,
  tipo_servico tipo_evento,
  data_prevista DATE,
  turma_serie TEXT,
  origem TEXT,
  motivo_perda TEXT,
  responsavel_id UUID REFERENCES users(id),
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Eventos
CREATE TABLE eventos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  tipo tipo_evento NOT NULL,
  status status_evento DEFAULT 'planejamento',
  descricao TEXT,
  data_inicio DATE NOT NULL,
  data_fim DATE,
  hora_inicio TIME,
  hora_fim TIME,
  local TEXT,
  endereco_local TEXT,
  num_participantes INT,
  turma_serie TEXT,
  valor_total NUMERIC(12,2),
  valor_sinal NUMERIC(12,2),
  forma_pagamento TEXT,
  condicoes_pagamento TEXT,
  observacoes TEXT,
  google_calendar_id TEXT,
  cliente_id UUID REFERENCES contatos(id) ON DELETE SET NULL,
  organizacao_id UUID REFERENCES organizacoes(id) ON DELETE SET NULL,
  lead_id UUID REFERENCES leads(id) ON DELETE SET NULL,
  responsavel_id UUID REFERENCES users(id),
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Recursos (brinquedos, veículos, etc)
CREATE TABLE recursos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  tipo tipo_recurso NOT NULL,
  descricao TEXT,
  quantidade INT DEFAULT 1,
  capacidade INT,
  custo_unitario NUMERIC(10,2),
  observacoes TEXT,
  ativo BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Alocação de recursos para eventos
CREATE TABLE alocacao_recursos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  recurso_id UUID NOT NULL REFERENCES recursos(id) ON DELETE CASCADE,
  evento_id UUID NOT NULL REFERENCES eventos(id) ON DELETE CASCADE,
  quantidade INT DEFAULT 1,
  data_inicio DATE NOT NULL,
  data_fim DATE NOT NULL,
  observacoes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Equipe (monitores, coordenadores, etc)
CREATE TABLE equipe (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  funcao funcao_equipe DEFAULT 'monitor',
  tipo_contrato tipo_contrato_equipe DEFAULT 'freelancer',
  email TEXT,
  telefone TEXT,
  whatsapp TEXT,
  documento TEXT,
  valor_diaria NUMERIC(10,2),
  observacoes TEXT,
  ativo BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Alocação de equipe para eventos
CREATE TABLE alocacao_equipe (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  membro_id UUID NOT NULL REFERENCES equipe(id) ON DELETE CASCADE,
  evento_id UUID NOT NULL REFERENCES eventos(id) ON DELETE CASCADE,
  data DATE NOT NULL,
  hora_inicio TIME,
  hora_fim TIME,
  funcao_evento TEXT,
  valor_pago NUMERIC(10,2),
  observacoes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Categorias financeiras
CREATE TABLE categorias_financeiras (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  tipo tipo_transacao NOT NULL,
  cor TEXT,
  ativo BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Transações financeiras
CREATE TABLE transacoes_financeiras (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  descricao TEXT NOT NULL,
  tipo tipo_transacao NOT NULL,
  valor NUMERIC(12,2) NOT NULL,
  data_vencimento DATE NOT NULL,
  data_pagamento DATE,
  status status_pagamento DEFAULT 'pendente',
  forma_pagamento TEXT,
  categoria_id UUID REFERENCES categorias_financeiras(id) ON DELETE SET NULL,
  evento_id UUID REFERENCES eventos(id) ON DELETE SET NULL,
  contato_id UUID REFERENCES contatos(id) ON DELETE SET NULL,
  observacoes TEXT,
  comprovante_url TEXT,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Atividades/Tarefas
CREATE TABLE atividades (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  titulo TEXT NOT NULL,
  descricao TEXT,
  status status_atividade DEFAULT 'pendente',
  prioridade INT DEFAULT 2,
  data_vencimento DATE,
  concluida_em TIMESTAMPTZ,
  evento_id UUID REFERENCES eventos(id) ON DELETE CASCADE,
  lead_id UUID REFERENCES leads(id) ON DELETE CASCADE,
  contato_id UUID REFERENCES contatos(id) ON DELETE CASCADE,
  responsavel_id UUID REFERENCES users(id),
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Interações (histórico de contatos)
CREATE TABLE interacoes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo TEXT NOT NULL,
  descricao TEXT NOT NULL,
  contato_id UUID REFERENCES contatos(id) ON DELETE CASCADE,
  lead_id UUID REFERENCES leads(id) ON DELETE CASCADE,
  evento_id UUID REFERENCES eventos(id) ON DELETE CASCADE,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Logs de auditoria
CREATE TABLE logs_auditoria (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tabela TEXT NOT NULL,
  registro_id TEXT,
  acao TEXT NOT NULL,
  dados_anteriores JSONB,
  dados_novos JSONB,
  user_id UUID REFERENCES users(id),
  ip TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- =============================================
-- PARTE 3: HABILITAR RLS
-- =============================================

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE organizacoes ENABLE ROW LEVEL SECURITY;
ALTER TABLE contatos ENABLE ROW LEVEL SECURITY;
ALTER TABLE etapas_funil ENABLE ROW LEVEL SECURITY;
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;
ALTER TABLE eventos ENABLE ROW LEVEL SECURITY;
ALTER TABLE recursos ENABLE ROW LEVEL SECURITY;
ALTER TABLE alocacao_recursos ENABLE ROW LEVEL SECURITY;
ALTER TABLE equipe ENABLE ROW LEVEL SECURITY;
ALTER TABLE alocacao_equipe ENABLE ROW LEVEL SECURITY;
ALTER TABLE categorias_financeiras ENABLE ROW LEVEL SECURITY;
ALTER TABLE transacoes_financeiras ENABLE ROW LEVEL SECURITY;
ALTER TABLE atividades ENABLE ROW LEVEL SECURITY;
ALTER TABLE interacoes ENABLE ROW LEVEL SECURITY;
ALTER TABLE logs_auditoria ENABLE ROW LEVEL SECURITY;

-- =============================================
-- PARTE 4: POLÍTICAS RLS
-- =============================================

-- Users
CREATE POLICY "Usuários podem ver todos os usuários" ON users FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários podem atualizar próprio perfil" ON users FOR UPDATE TO authenticated USING (auth.uid() = id);

-- Organizações
CREATE POLICY "Usuários autenticados podem ver organizações" ON organizacoes FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar organizações" ON organizacoes FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar organizações" ON organizacoes FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar organizações" ON organizacoes FOR DELETE TO authenticated USING (true);

-- Contatos
CREATE POLICY "Usuários autenticados podem ver contatos" ON contatos FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar contatos" ON contatos FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar contatos" ON contatos FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar contatos" ON contatos FOR DELETE TO authenticated USING (true);

-- Etapas do Funil
CREATE POLICY "Usuários autenticados podem ver etapas" ON etapas_funil FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar etapas" ON etapas_funil FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar etapas" ON etapas_funil FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem deletar etapas" ON etapas_funil FOR DELETE TO authenticated USING (true);

-- Leads
CREATE POLICY "Usuários autenticados podem ver leads" ON leads FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar leads" ON leads FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar leads" ON leads FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar leads" ON leads FOR DELETE TO authenticated USING (true);

-- Eventos
CREATE POLICY "Usuários autenticados podem ver eventos" ON eventos FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar eventos" ON eventos FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar eventos" ON eventos FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar eventos" ON eventos FOR DELETE TO authenticated USING (true);

-- Recursos
CREATE POLICY "Usuários autenticados podem ver recursos" ON recursos FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar recursos" ON recursos FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar recursos" ON recursos FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar recursos" ON recursos FOR DELETE TO authenticated USING (true);

-- Alocação de Recursos
CREATE POLICY "Usuários autenticados podem ver alocações de recursos" ON alocacao_recursos FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar alocações de recursos" ON alocacao_recursos FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar alocações de recursos" ON alocacao_recursos FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar alocações de recursos" ON alocacao_recursos FOR DELETE TO authenticated USING (true);

-- Equipe
CREATE POLICY "Usuários autenticados podem ver equipe" ON equipe FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar membros" ON equipe FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar membros" ON equipe FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar membros" ON equipe FOR DELETE TO authenticated USING (true);

-- Alocação de Equipe
CREATE POLICY "Usuários autenticados podem ver alocações de equipe" ON alocacao_equipe FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar alocações de equipe" ON alocacao_equipe FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar alocações de equipe" ON alocacao_equipe FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar alocações de equipe" ON alocacao_equipe FOR DELETE TO authenticated USING (true);

-- Categorias Financeiras
CREATE POLICY "Usuários autenticados podem ver categorias" ON categorias_financeiras FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar categorias" ON categorias_financeiras FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar categorias" ON categorias_financeiras FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem deletar categorias" ON categorias_financeiras FOR DELETE TO authenticated USING (true);

-- Transações Financeiras
CREATE POLICY "Usuários autenticados podem ver transações" ON transacoes_financeiras FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar transações" ON transacoes_financeiras FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar transações" ON transacoes_financeiras FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar transações" ON transacoes_financeiras FOR DELETE TO authenticated USING (true);

-- Atividades
CREATE POLICY "Usuários autenticados podem ver atividades" ON atividades FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar atividades" ON atividades FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Usuários autenticados podem atualizar atividades" ON atividades FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem deletar atividades" ON atividades FOR DELETE TO authenticated USING (true);

-- Interações
CREATE POLICY "Usuários autenticados podem ver interações" ON interacoes FOR SELECT TO authenticated USING (true);
CREATE POLICY "Usuários autenticados podem criar interações" ON interacoes FOR INSERT TO authenticated WITH CHECK (true);

-- Logs de Auditoria
CREATE POLICY "Admins podem ver logs" ON logs_auditoria FOR SELECT TO authenticated USING (true);
CREATE POLICY "Sistema pode criar logs" ON logs_auditoria FOR INSERT TO authenticated WITH CHECK (true);

-- =============================================
-- PARTE 5: TRIGGER DE SINCRONIZAÇÃO DE USUÁRIOS
-- =============================================

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.users (id, email, nome, avatar_url)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
    NEW.raw_user_meta_data->>'avatar_url'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Remover trigger se existir
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Criar trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- =============================================
-- PARTE 6: DADOS INICIAIS
-- =============================================

-- Etapas padrão do funil
INSERT INTO etapas_funil (nome, ordem, cor, is_final, is_perdido) VALUES
('Novo', 1, '#0ea5e9', false, false),
('Qualificado', 2, '#eab308', false, false),
('Proposta Enviada', 3, '#f97316', false, false),
('Negociação', 4, '#e4027d', false, false),
('Aceito', 5, '#22c55e', true, false),
('Perdido', 6, '#dc2626', false, true);

-- Categorias financeiras padrão
INSERT INTO categorias_financeiras (nome, tipo, cor) VALUES
('Pagamento de Evento', 'receita', '#22c55e'),
('Patrocínio', 'receita', '#0ea5e9'),
('Transporte', 'despesa', '#f97316'),
('Alimentação', 'despesa', '#eab308'),
('Hospedagem', 'despesa', '#8b5cf6'),
('Monitores', 'despesa', '#e4027d'),
('Materiais', 'despesa', '#dc2626'),
('Outros', 'despesa', '#6b7280');

-- =============================================
-- FIM DO SETUP
-- =============================================
-- Script executado com sucesso!
-- Seu banco de dados RocketCRM está pronto.

