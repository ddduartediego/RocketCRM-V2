-- =============================================
-- Migration: Remover Viagens Escolares
-- =============================================
-- Remove referências a viagens escolares do sistema:
-- - Tipos de evento: viagem_pedagogica, viagem_formatura
-- - Campo turma_serie das tabelas eventos e leads
-- - Tipo de contato: escola
-- 
-- Data: 26/11/2025
-- =============================================

-- =============================================
-- PARTE 1: REMOVER COLUNAS turma_serie
-- =============================================

ALTER TABLE eventos DROP COLUMN IF EXISTS turma_serie;
ALTER TABLE leads DROP COLUMN IF EXISTS turma_serie;

-- =============================================
-- PARTE 2: ALTERAR ENUM tipo_evento
-- =============================================
-- PostgreSQL não permite DROP VALUE de enum, então precisamos recriar

-- 2.1 Migrar dados existentes para tipos válidos
UPDATE eventos SET tipo = 'outro' WHERE tipo IN ('viagem_pedagogica', 'viagem_formatura');
UPDATE leads SET tipo_servico = 'outro' WHERE tipo_servico IN ('viagem_pedagogica', 'viagem_formatura');

-- 2.2 Criar novo enum sem os tipos de viagem
CREATE TYPE tipo_evento_new AS ENUM ('colonia_ferias', 'festa_infantil', 'gincana', 'outro');

-- 2.3 Alterar coluna para usar o novo enum
ALTER TABLE eventos 
  ALTER COLUMN tipo TYPE tipo_evento_new 
  USING tipo::text::tipo_evento_new;

ALTER TABLE leads 
  ALTER COLUMN tipo_servico TYPE tipo_evento_new 
  USING tipo_servico::text::tipo_evento_new;

-- 2.4 Remover enum antigo e renomear novo
DROP TYPE tipo_evento;
ALTER TYPE tipo_evento_new RENAME TO tipo_evento;

-- =============================================
-- PARTE 3: ALTERAR ENUM tipo_contato
-- =============================================

-- 3.1 Migrar dados existentes ANTES de alterar os tipos
UPDATE organizacoes SET tipo = 'empresa' WHERE tipo = 'escola';
UPDATE contatos SET tipo = 'empresa' WHERE tipo = 'escola';

-- 3.2 Remover defaults das colunas antes de alterar o tipo
ALTER TABLE organizacoes ALTER COLUMN tipo DROP DEFAULT;
ALTER TABLE contatos ALTER COLUMN tipo DROP DEFAULT;

-- 3.3 Criar novo enum sem escola
CREATE TYPE tipo_contato_new AS ENUM ('pessoa_fisica', 'empresa', 'fornecedor');

-- 3.4 Alterar colunas para usar o novo enum
ALTER TABLE organizacoes 
  ALTER COLUMN tipo TYPE tipo_contato_new 
  USING tipo::text::tipo_contato_new;

ALTER TABLE contatos 
  ALTER COLUMN tipo TYPE tipo_contato_new 
  USING tipo::text::tipo_contato_new;

-- 3.5 Remover enum antigo e renomear novo
DROP TYPE tipo_contato;
ALTER TYPE tipo_contato_new RENAME TO tipo_contato;

-- 3.6 Restaurar defaults com o novo tipo
ALTER TABLE organizacoes ALTER COLUMN tipo SET DEFAULT 'empresa'::tipo_contato;
ALTER TABLE contatos ALTER COLUMN tipo SET DEFAULT 'pessoa_fisica'::tipo_contato;

-- =============================================
-- FIM DA MIGRATION
-- =============================================

