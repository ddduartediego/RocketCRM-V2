-- Migration: Adicionar colunas para armazenar tokens do Google
-- Isso permite que o sistema use as APIs do Google (Calendar) em Server Actions

-- Adicionar colunas de token do Google na tabela users
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS google_access_token TEXT,
ADD COLUMN IF NOT EXISTS google_refresh_token TEXT,
ADD COLUMN IF NOT EXISTS google_token_expires_at TIMESTAMPTZ;

-- Comentários para documentação
COMMENT ON COLUMN users.google_access_token IS 'Token de acesso do Google OAuth para APIs como Calendar';
COMMENT ON COLUMN users.google_refresh_token IS 'Token de refresh do Google OAuth para renovar o access token';
COMMENT ON COLUMN users.google_token_expires_at IS 'Data/hora de expiração do access token do Google';
