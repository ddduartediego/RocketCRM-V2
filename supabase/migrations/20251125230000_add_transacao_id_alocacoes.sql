-- =============================================
-- Migration: Adicionar transacao_id nas tabelas de alocação
-- =============================================
-- Este campo vincula alocações às transações financeiras geradas automaticamente
-- Data: 25/11/2025
-- =============================================

-- Adicionar campo transacao_id na tabela alocacao_equipe
ALTER TABLE alocacao_equipe
ADD COLUMN transacao_id UUID REFERENCES transacoes_financeiras(id) ON DELETE SET NULL;

-- Adicionar campo transacao_id na tabela alocacao_recursos
ALTER TABLE alocacao_recursos
ADD COLUMN transacao_id UUID REFERENCES transacoes_financeiras(id) ON DELETE SET NULL;

-- Adicionar campo valor na tabela alocacao_recursos (valor manual informado pelo usuário)
ALTER TABLE alocacao_recursos
ADD COLUMN valor NUMERIC(10,2);

-- Criar índices para melhorar performance das consultas
CREATE INDEX IF NOT EXISTS idx_alocacao_equipe_transacao_id ON alocacao_equipe(transacao_id);
CREATE INDEX IF NOT EXISTS idx_alocacao_recursos_transacao_id ON alocacao_recursos(transacao_id);

-- Comentários para documentação
COMMENT ON COLUMN alocacao_equipe.transacao_id IS 'Referência à transação financeira de despesa gerada ao alocar o membro';
COMMENT ON COLUMN alocacao_recursos.transacao_id IS 'Referência à transação financeira de despesa gerada ao alocar o recurso';

