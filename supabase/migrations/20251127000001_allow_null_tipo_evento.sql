-- =============================================
-- Migration: Permitir NULL no campo tipo (enum antigo)
-- =============================================
-- Após a migração para tipos_evento dinâmicos,
-- a coluna tipo (enum) não é mais obrigatória.
-- =============================================

-- Permitir NULL na coluna tipo (enum antigo) já que agora usamos tipo_id
ALTER TABLE eventos ALTER COLUMN tipo DROP NOT NULL;

-- Permitir NULL na coluna tipo_servico em leads também  
ALTER TABLE leads ALTER COLUMN tipo_servico DROP NOT NULL;


