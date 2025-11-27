-- =============================================
-- Migration: Tipos de Evento Configuráveis
-- =============================================
-- Esta migration cria a tabela tipos_evento para permitir
-- que os usuários configurem seus próprios tipos de eventos.
-- =============================================

-- 1. Criar tabela tipos_evento
CREATE TABLE tipos_evento (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  icone TEXT DEFAULT '📅',
  cor TEXT DEFAULT '#0ea5e9',
  ordem INT DEFAULT 0,
  ativo BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Habilitar RLS
ALTER TABLE tipos_evento ENABLE ROW LEVEL SECURITY;

-- 3. Criar políticas RLS
CREATE POLICY "Usuários autenticados podem ver tipos de evento" 
  ON tipos_evento FOR SELECT TO authenticated USING (true);

CREATE POLICY "Usuários autenticados podem criar tipos de evento" 
  ON tipos_evento FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Usuários autenticados podem atualizar tipos de evento" 
  ON tipos_evento FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Usuários autenticados podem deletar tipos de evento" 
  ON tipos_evento FOR DELETE TO authenticated USING (true);

-- 4. Inserir tipos padrão (baseados no enum antigo)
INSERT INTO tipos_evento (nome, icone, cor, ordem) VALUES
  ('Colônia de Férias', '🏕️', '#22c55e', 1),
  ('Festa Infantil', '🎈', '#e4027d', 2),
  ('Gincana', '🏃', '#f97316', 3),
  ('Outro', '📅', '#6b7280', 4);

-- 5. Adicionar coluna tipo_id na tabela eventos (nullable inicialmente)
ALTER TABLE eventos ADD COLUMN tipo_id UUID REFERENCES tipos_evento(id) ON DELETE SET NULL;

-- 6. Migrar dados existentes (converter enum para FK)
-- Colônia de Férias
UPDATE eventos SET tipo_id = (SELECT id FROM tipos_evento WHERE nome = 'Colônia de Férias' LIMIT 1)
WHERE tipo = 'colonia_ferias';

-- Festa Infantil
UPDATE eventos SET tipo_id = (SELECT id FROM tipos_evento WHERE nome = 'Festa Infantil' LIMIT 1)
WHERE tipo = 'festa_infantil';

-- Gincana
UPDATE eventos SET tipo_id = (SELECT id FROM tipos_evento WHERE nome = 'Gincana' LIMIT 1)
WHERE tipo = 'gincana';

-- Outro
UPDATE eventos SET tipo_id = (SELECT id FROM tipos_evento WHERE nome = 'Outro' LIMIT 1)
WHERE tipo = 'outro';

-- 7. Fazer o mesmo para leads.tipo_servico
ALTER TABLE leads ADD COLUMN tipo_servico_id UUID REFERENCES tipos_evento(id) ON DELETE SET NULL;

UPDATE leads SET tipo_servico_id = (SELECT id FROM tipos_evento WHERE nome = 'Colônia de Férias' LIMIT 1)
WHERE tipo_servico = 'colonia_ferias';

UPDATE leads SET tipo_servico_id = (SELECT id FROM tipos_evento WHERE nome = 'Festa Infantil' LIMIT 1)
WHERE tipo_servico = 'festa_infantil';

UPDATE leads SET tipo_servico_id = (SELECT id FROM tipos_evento WHERE nome = 'Gincana' LIMIT 1)
WHERE tipo_servico = 'gincana';

UPDATE leads SET tipo_servico_id = (SELECT id FROM tipos_evento WHERE nome = 'Outro' LIMIT 1)
WHERE tipo_servico = 'outro';

-- =============================================
-- NOTA: As colunas antigas 'tipo' (enum) nas tabelas eventos e leads
-- são mantidas por compatibilidade. Podem ser removidas em uma
-- migration futura após confirmar que tudo funciona corretamente.
-- =============================================

