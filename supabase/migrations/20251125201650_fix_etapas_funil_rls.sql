-- =============================================
-- RocketCRM - Fix RLS Etapas do Funil
-- =============================================
-- Adiciona políticas de INSERT, UPDATE e DELETE para etapas_funil

-- Remover políticas existentes se houver
DROP POLICY IF EXISTS "Usuários autenticados podem ver etapas" ON etapas_funil;
DROP POLICY IF EXISTS "Usuários autenticados podem criar etapas" ON etapas_funil;
DROP POLICY IF EXISTS "Usuários autenticados podem atualizar etapas" ON etapas_funil;
DROP POLICY IF EXISTS "Usuários autenticados podem deletar etapas" ON etapas_funil;

-- Criar políticas RLS para etapas_funil
CREATE POLICY "Usuários autenticados podem ver etapas"
ON etapas_funil FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Usuários autenticados podem criar etapas"
ON etapas_funil FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY "Usuários autenticados podem atualizar etapas"
ON etapas_funil FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Usuários autenticados podem deletar etapas"
ON etapas_funil FOR DELETE
TO authenticated
USING (true);

