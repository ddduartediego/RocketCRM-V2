-- =============================================
-- Migration: Adicionar categoria "Sinal"
-- Data: 25/11/2025
-- Descrição: Adiciona categoria de receita para sinais de eventos
-- =============================================

-- Adicionar categoria "Sinal" se não existir
INSERT INTO categorias_financeiras (nome, tipo, cor)
SELECT 'Sinal', 'receita', '#f97316'
WHERE NOT EXISTS (
  SELECT 1 FROM categorias_financeiras WHERE nome = 'Sinal' AND tipo = 'receita'
);

