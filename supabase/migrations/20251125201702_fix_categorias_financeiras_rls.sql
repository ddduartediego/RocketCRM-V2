-- =============================================
-- RocketCRM - Fix RLS Categorias Financeiras
-- =============================================
-- Adiciona políticas de INSERT, UPDATE e DELETE para categorias_financeiras

-- Remover políticas existentes se houver
DROP POLICY IF EXISTS "Usuários autenticados podem ver categorias" ON categorias_financeiras;
DROP POLICY IF EXISTS "Usuários autenticados podem criar categorias" ON categorias_financeiras;
DROP POLICY IF EXISTS "Usuários autenticados podem atualizar categorias" ON categorias_financeiras;
DROP POLICY IF EXISTS "Usuários autenticados podem deletar categorias" ON categorias_financeiras;

-- Criar políticas RLS para categorias_financeiras
CREATE POLICY "Usuários autenticados podem ver categorias"
ON categorias_financeiras FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Usuários autenticados podem criar categorias"
ON categorias_financeiras FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY "Usuários autenticados podem atualizar categorias"
ON categorias_financeiras FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Usuários autenticados podem deletar categorias"
ON categorias_financeiras FOR DELETE
TO authenticated
USING (true);

