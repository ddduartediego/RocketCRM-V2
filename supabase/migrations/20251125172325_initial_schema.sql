-- =============================================
-- RocketCRM - Schema Inicial
-- =============================================

-- Enums
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

-- Tabela de usuários (sincronizada com auth.users)
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

-- Adicionar FK de contato principal nas organizações
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

-- Inserir etapas padrão do funil
INSERT INTO etapas_funil (nome, ordem, cor, is_final, is_perdido) VALUES
('Novo', 1, '#0ea5e9', false, false),
('Qualificado', 2, '#eab308', false, false),
('Proposta Enviada', 3, '#f97316', false, false),
('Negociação', 4, '#e4027d', false, false),
('Aceito', 5, '#22c55e', true, false),
('Perdido', 6, '#dc2626', false, true);

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

-- Inserir categorias padrão
INSERT INTO categorias_financeiras (nome, tipo, cor) VALUES
('Pagamento de Evento', 'receita', '#22c55e'),
('Patrocínio', 'receita', '#0ea5e9'),
('Transporte', 'despesa', '#f97316'),
('Alimentação', 'despesa', '#eab308'),
('Hospedagem', 'despesa', '#8b5cf6'),
('Monitores', 'despesa', '#e4027d'),
('Materiais', 'despesa', '#dc2626'),
('Outros', 'despesa', '#6b7280');

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

-- Habilitar RLS em todas as tabelas
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

