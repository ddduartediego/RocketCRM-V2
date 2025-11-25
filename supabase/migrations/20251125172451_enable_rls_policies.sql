-- =============================================
-- RocketCRM - Políticas RLS
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

