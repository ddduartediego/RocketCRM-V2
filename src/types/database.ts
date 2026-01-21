export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "13.0.5"
  }
  public: {
    Tables: {
      alocacao_equipe: {
        Row: {
          created_at: string
          data: string
          evento_id: string
          funcao_evento: string | null
          hora_fim: string | null
          hora_inicio: string | null
          id: string
          membro_id: string
          observacoes: string | null
          transacao_id: string | null
          updated_at: string
          valor_pago: number | null
        }
        Insert: {
          created_at?: string
          data: string
          evento_id: string
          funcao_evento?: string | null
          hora_fim?: string | null
          hora_inicio?: string | null
          id?: string
          membro_id: string
          observacoes?: string | null
          transacao_id?: string | null
          updated_at?: string
          valor_pago?: number | null
        }
        Update: {
          created_at?: string
          data?: string
          evento_id?: string
          funcao_evento?: string | null
          hora_fim?: string | null
          hora_inicio?: string | null
          id?: string
          membro_id?: string
          observacoes?: string | null
          transacao_id?: string | null
          updated_at?: string
          valor_pago?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "alocacao_equipe_evento_id_fkey"
            columns: ["evento_id"]
            isOneToOne: false
            referencedRelation: "eventos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "alocacao_equipe_membro_id_fkey"
            columns: ["membro_id"]
            isOneToOne: false
            referencedRelation: "equipe"
            referencedColumns: ["id"]
          },
        ]
      }
      alocacao_recursos: {
        Row: {
          created_at: string
          data_fim: string
          data_inicio: string
          evento_id: string
          id: string
          observacoes: string | null
          quantidade: number
          recurso_id: string
          transacao_id: string | null
          updated_at: string
          valor: number | null
        }
        Insert: {
          created_at?: string
          data_fim: string
          data_inicio: string
          evento_id: string
          id?: string
          observacoes?: string | null
          quantidade?: number
          recurso_id: string
          transacao_id?: string | null
          updated_at?: string
          valor?: number | null
        }
        Update: {
          created_at?: string
          data_fim?: string
          data_inicio?: string
          evento_id?: string
          id?: string
          observacoes?: string | null
          quantidade?: number
          recurso_id?: string
          transacao_id?: string | null
          updated_at?: string
          valor?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "alocacao_recursos_evento_id_fkey"
            columns: ["evento_id"]
            isOneToOne: false
            referencedRelation: "eventos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "alocacao_recursos_recurso_id_fkey"
            columns: ["recurso_id"]
            isOneToOne: false
            referencedRelation: "recursos"
            referencedColumns: ["id"]
          },
        ]
      }
      atividades: {
        Row: {
          concluida_em: string | null
          contato_id: string | null
          created_at: string
          created_by: string | null
          data_vencimento: string | null
          descricao: string | null
          evento_id: string | null
          id: string
          lead_id: string | null
          prioridade: number | null
          responsavel_id: string | null
          status: Database["public"]["Enums"]["status_atividade"]
          titulo: string
          updated_at: string
        }
        Insert: {
          concluida_em?: string | null
          contato_id?: string | null
          created_at?: string
          created_by?: string | null
          data_vencimento?: string | null
          descricao?: string | null
          evento_id?: string | null
          id?: string
          lead_id?: string | null
          prioridade?: number | null
          responsavel_id?: string | null
          status?: Database["public"]["Enums"]["status_atividade"]
          titulo: string
          updated_at?: string
        }
        Update: {
          concluida_em?: string | null
          contato_id?: string | null
          created_at?: string
          created_by?: string | null
          data_vencimento?: string | null
          descricao?: string | null
          evento_id?: string | null
          id?: string
          lead_id?: string | null
          prioridade?: number | null
          responsavel_id?: string | null
          status?: Database["public"]["Enums"]["status_atividade"]
          titulo?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "atividades_contato_id_fkey"
            columns: ["contato_id"]
            isOneToOne: false
            referencedRelation: "contatos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "atividades_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "atividades_evento_id_fkey"
            columns: ["evento_id"]
            isOneToOne: false
            referencedRelation: "eventos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "atividades_lead_id_fkey"
            columns: ["lead_id"]
            isOneToOne: false
            referencedRelation: "leads"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "atividades_responsavel_id_fkey"
            columns: ["responsavel_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      categorias_financeiras: {
        Row: {
          ativo: boolean
          cor: string | null
          created_at: string
          id: string
          nome: string
          tipo: Database["public"]["Enums"]["tipo_transacao"]
        }
        Insert: {
          ativo?: boolean
          cor?: string | null
          created_at?: string
          id?: string
          nome: string
          tipo: Database["public"]["Enums"]["tipo_transacao"]
        }
        Update: {
          ativo?: boolean
          cor?: string | null
          created_at?: string
          id?: string
          nome?: string
          tipo?: Database["public"]["Enums"]["tipo_transacao"]
        }
        Relationships: []
      }
      contatos: {
        Row: {
          cep: string | null
          cidade: string | null
          created_at: string
          created_by: string | null
          email: string | null
          endereco: string | null
          estado: string | null
          id: string
          nome: string
          observacoes: string | null
          tags: string[] | null
          telefone: string | null
          tipo: Database["public"]["Enums"]["tipo_contato"]
          updated_at: string
          whatsapp: string | null
        }
        Insert: {
          cep?: string | null
          cidade?: string | null
          created_at?: string
          created_by?: string | null
          email?: string | null
          endereco?: string | null
          estado?: string | null
          id?: string
          nome: string
          observacoes?: string | null
          tags?: string[] | null
          telefone?: string | null
          tipo?: Database["public"]["Enums"]["tipo_contato"]
          updated_at?: string
          whatsapp?: string | null
        }
        Update: {
          cep?: string | null
          cidade?: string | null
          created_at?: string
          created_by?: string | null
          email?: string | null
          endereco?: string | null
          estado?: string | null
          id?: string
          nome?: string
          observacoes?: string | null
          tags?: string[] | null
          telefone?: string | null
          tipo?: Database["public"]["Enums"]["tipo_contato"]
          updated_at?: string
          whatsapp?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "contatos_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      equipe: {
        Row: {
          ativo: boolean
          created_at: string
          documento: string | null
          email: string | null
          funcao: Database["public"]["Enums"]["funcao_equipe"]
          id: string
          nome: string
          observacoes: string | null
          telefone: string | null
          tipo_contrato: Database["public"]["Enums"]["tipo_contrato_equipe"]
          updated_at: string
          valor_diaria: number | null
          whatsapp: string | null
        }
        Insert: {
          ativo?: boolean
          created_at?: string
          documento?: string | null
          email?: string | null
          funcao?: Database["public"]["Enums"]["funcao_equipe"]
          id?: string
          nome: string
          observacoes?: string | null
          telefone?: string | null
          tipo_contrato?: Database["public"]["Enums"]["tipo_contrato_equipe"]
          updated_at?: string
          valor_diaria?: number | null
          whatsapp?: string | null
        }
        Update: {
          ativo?: boolean
          created_at?: string
          documento?: string | null
          email?: string | null
          funcao?: Database["public"]["Enums"]["funcao_equipe"]
          id?: string
          nome?: string
          observacoes?: string | null
          telefone?: string | null
          tipo_contrato?: Database["public"]["Enums"]["tipo_contrato_equipe"]
          updated_at?: string
          valor_diaria?: number | null
          whatsapp?: string | null
        }
        Relationships: []
      }
      etapas_funil: {
        Row: {
          ativo: boolean
          cor: string
          created_at: string
          id: string
          is_final: boolean
          is_perdido: boolean
          nome: string
          ordem: number
          updated_at: string
        }
        Insert: {
          ativo?: boolean
          cor?: string
          created_at?: string
          id?: string
          is_final?: boolean
          is_perdido?: boolean
          nome: string
          ordem?: number
          updated_at?: string
        }
        Update: {
          ativo?: boolean
          cor?: string
          created_at?: string
          id?: string
          is_final?: boolean
          is_perdido?: boolean
          nome?: string
          ordem?: number
          updated_at?: string
        }
        Relationships: []
      }
      tipos_evento: {
        Row: {
          id: string
          nome: string
          icone: string
          cor: string
          ordem: number
          ativo: boolean
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          nome: string
          icone?: string
          cor?: string
          ordem?: number
          ativo?: boolean
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          nome?: string
          icone?: string
          cor?: string
          ordem?: number
          ativo?: boolean
          created_at?: string
          updated_at?: string
        }
        Relationships: []
      }
      eventos: {
        Row: {
          cliente_id: string | null
          condicoes_pagamento: string | null
          created_at: string
          created_by: string | null
          data_fim: string | null
          data_inicio: string
          descricao: string | null
          endereco_local: string | null
          forma_pagamento: string | null
          google_calendar_id: string | null
          hora_fim: string | null
          hora_inicio: string | null
          id: string
          lead_id: string | null
          local: string | null
          nome: string
          observacoes: string | null
          responsavel_id: string | null
          status: Database["public"]["Enums"]["status_evento"]
          tipo: Database["public"]["Enums"]["tipo_evento"] | null
          tipo_id: string | null
          updated_at: string
          valor_sinal: number | null
          valor_total: number | null
        }
        Insert: {
          cliente_id?: string | null
          condicoes_pagamento?: string | null
          created_at?: string
          created_by?: string | null
          data_fim?: string | null
          data_inicio: string
          descricao?: string | null
          endereco_local?: string | null
          forma_pagamento?: string | null
          google_calendar_id?: string | null
          hora_fim?: string | null
          hora_inicio?: string | null
          id?: string
          lead_id?: string | null
          local?: string | null
          nome: string
          observacoes?: string | null
          responsavel_id?: string | null
          status?: Database["public"]["Enums"]["status_evento"]
          tipo?: Database["public"]["Enums"]["tipo_evento"] | null
          tipo_id?: string | null
          updated_at?: string
          valor_sinal?: number | null
          valor_total?: number | null
        }
        Update: {
          cliente_id?: string | null
          condicoes_pagamento?: string | null
          created_at?: string
          created_by?: string | null
          data_fim?: string | null
          data_inicio?: string
          descricao?: string | null
          endereco_local?: string | null
          forma_pagamento?: string | null
          google_calendar_id?: string | null
          hora_fim?: string | null
          hora_inicio?: string | null
          id?: string
          lead_id?: string | null
          local?: string | null
          nome?: string
          observacoes?: string | null
          responsavel_id?: string | null
          status?: Database["public"]["Enums"]["status_evento"]
          tipo?: Database["public"]["Enums"]["tipo_evento"] | null
          tipo_id?: string | null
          updated_at?: string
          valor_sinal?: number | null
          valor_total?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "eventos_cliente_id_fkey"
            columns: ["cliente_id"]
            isOneToOne: false
            referencedRelation: "contatos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "eventos_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "eventos_lead_id_fkey"
            columns: ["lead_id"]
            isOneToOne: false
            referencedRelation: "leads"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "eventos_responsavel_id_fkey"
            columns: ["responsavel_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "eventos_tipo_id_fkey"
            columns: ["tipo_id"]
            isOneToOne: false
            referencedRelation: "tipos_evento"
            referencedColumns: ["id"]
          },
        ]
      }
      interacoes: {
        Row: {
          contato_id: string | null
          created_at: string
          created_by: string | null
          descricao: string
          evento_id: string | null
          id: string
          lead_id: string | null
          tipo: string
        }
        Insert: {
          contato_id?: string | null
          created_at?: string
          created_by?: string | null
          descricao: string
          evento_id?: string | null
          id?: string
          lead_id?: string | null
          tipo: string
        }
        Update: {
          contato_id?: string | null
          created_at?: string
          created_by?: string | null
          descricao?: string
          evento_id?: string | null
          id?: string
          lead_id?: string | null
          tipo?: string
        }
        Relationships: [
          {
            foreignKeyName: "interacoes_contato_id_fkey"
            columns: ["contato_id"]
            isOneToOne: false
            referencedRelation: "contatos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "interacoes_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "interacoes_evento_id_fkey"
            columns: ["evento_id"]
            isOneToOne: false
            referencedRelation: "eventos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "interacoes_lead_id_fkey"
            columns: ["lead_id"]
            isOneToOne: false
            referencedRelation: "leads"
            referencedColumns: ["id"]
          },
        ]
      }
      leads: {
        Row: {
          contato_id: string | null
          created_at: string
          created_by: string | null
          data_prevista: string | null
          descricao: string | null
          etapa_id: string
          id: string
          motivo_perda: string | null
          origem: string | null
          responsavel_id: string | null
          tipo_servico: Database["public"]["Enums"]["tipo_evento"] | null
          tipo_servico_id: string | null
          titulo: string
          updated_at: string
          valor_estimado: number | null
        }
        Insert: {
          contato_id?: string | null
          created_at?: string
          created_by?: string | null
          data_prevista?: string | null
          descricao?: string | null
          etapa_id: string
          id?: string
          motivo_perda?: string | null
          origem?: string | null
          responsavel_id?: string | null
          tipo_servico?: Database["public"]["Enums"]["tipo_evento"] | null
          tipo_servico_id?: string | null
          titulo: string
          updated_at?: string
          valor_estimado?: number | null
        }
        Update: {
          contato_id?: string | null
          created_at?: string
          created_by?: string | null
          data_prevista?: string | null
          descricao?: string | null
          etapa_id?: string
          id?: string
          motivo_perda?: string | null
          origem?: string | null
          responsavel_id?: string | null
          tipo_servico?: Database["public"]["Enums"]["tipo_evento"] | null
          tipo_servico_id?: string | null
          titulo?: string
          updated_at?: string
          valor_estimado?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "leads_contato_id_fkey"
            columns: ["contato_id"]
            isOneToOne: false
            referencedRelation: "contatos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "leads_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "leads_etapa_id_fkey"
            columns: ["etapa_id"]
            isOneToOne: false
            referencedRelation: "etapas_funil"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "leads_responsavel_id_fkey"
            columns: ["responsavel_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      logs_auditoria: {
        Row: {
          acao: string
          created_at: string
          dados_anteriores: Json | null
          dados_novos: Json | null
          id: string
          ip: string | null
          registro_id: string | null
          tabela: string
          user_id: string | null
        }
        Insert: {
          acao: string
          created_at?: string
          dados_anteriores?: Json | null
          dados_novos?: Json | null
          id?: string
          ip?: string | null
          registro_id?: string | null
          tabela: string
          user_id?: string | null
        }
        Update: {
          acao?: string
          created_at?: string
          dados_anteriores?: Json | null
          dados_novos?: Json | null
          id?: string
          ip?: string | null
          registro_id?: string | null
          tabela?: string
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "logs_auditoria_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      organizacoes: {
        Row: {
          cep: string | null
          cidade: string | null
          cnpj: string | null
          contato_principal_id: string | null
          created_at: string
          created_by: string | null
          email: string | null
          endereco: string | null
          estado: string | null
          id: string
          nome: string
          observacoes: string | null
          tags: string[] | null
          telefone: string | null
          tipo: Database["public"]["Enums"]["tipo_contato"]
          updated_at: string
        }
        Insert: {
          cep?: string | null
          cidade?: string | null
          cnpj?: string | null
          contato_principal_id?: string | null
          created_at?: string
          created_by?: string | null
          email?: string | null
          endereco?: string | null
          estado?: string | null
          id?: string
          nome: string
          observacoes?: string | null
          tags?: string[] | null
          telefone?: string | null
          tipo?: Database["public"]["Enums"]["tipo_contato"]
          updated_at?: string
        }
        Update: {
          cep?: string | null
          cidade?: string | null
          cnpj?: string | null
          contato_principal_id?: string | null
          created_at?: string
          created_by?: string | null
          email?: string | null
          endereco?: string | null
          estado?: string | null
          id?: string
          nome?: string
          observacoes?: string | null
          tags?: string[] | null
          telefone?: string | null
          tipo?: Database["public"]["Enums"]["tipo_contato"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "organizacoes_contato_principal_id_fkey"
            columns: ["contato_principal_id"]
            isOneToOne: false
            referencedRelation: "contatos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "organizacoes_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      recursos: {
        Row: {
          ativo: boolean
          capacidade: number | null
          created_at: string
          custo_unitario: number | null
          descricao: string | null
          id: string
          nome: string
          observacoes: string | null
          quantidade: number
          tipo: Database["public"]["Enums"]["tipo_recurso"]
          updated_at: string
        }
        Insert: {
          ativo?: boolean
          capacidade?: number | null
          created_at?: string
          custo_unitario?: number | null
          descricao?: string | null
          id?: string
          nome: string
          observacoes?: string | null
          quantidade?: number
          tipo: Database["public"]["Enums"]["tipo_recurso"]
          updated_at?: string
        }
        Update: {
          ativo?: boolean
          capacidade?: number | null
          created_at?: string
          custo_unitario?: number | null
          descricao?: string | null
          id?: string
          nome?: string
          observacoes?: string | null
          quantidade?: number
          tipo?: Database["public"]["Enums"]["tipo_recurso"]
          updated_at?: string
        }
        Relationships: []
      }
      transacoes_financeiras: {
        Row: {
          categoria_id: string | null
          comprovante_url: string | null
          contato_id: string | null
          created_at: string
          created_by: string | null
          data_pagamento: string | null
          data_vencimento: string
          descricao: string
          evento_id: string | null
          forma_pagamento: string | null
          id: string
          observacoes: string | null
          status: Database["public"]["Enums"]["status_pagamento"]
          tipo: Database["public"]["Enums"]["tipo_transacao"]
          updated_at: string
          valor: number
        }
        Insert: {
          categoria_id?: string | null
          comprovante_url?: string | null
          contato_id?: string | null
          created_at?: string
          created_by?: string | null
          data_pagamento?: string | null
          data_vencimento: string
          descricao: string
          evento_id?: string | null
          forma_pagamento?: string | null
          id?: string
          observacoes?: string | null
          status?: Database["public"]["Enums"]["status_pagamento"]
          tipo: Database["public"]["Enums"]["tipo_transacao"]
          updated_at?: string
          valor: number
        }
        Update: {
          categoria_id?: string | null
          comprovante_url?: string | null
          contato_id?: string | null
          created_at?: string
          created_by?: string | null
          data_pagamento?: string | null
          data_vencimento?: string
          descricao?: string
          evento_id?: string | null
          forma_pagamento?: string | null
          id?: string
          observacoes?: string | null
          status?: Database["public"]["Enums"]["status_pagamento"]
          tipo?: Database["public"]["Enums"]["tipo_transacao"]
          updated_at?: string
          valor?: number
        }
        Relationships: [
          {
            foreignKeyName: "transacoes_financeiras_categoria_id_fkey"
            columns: ["categoria_id"]
            isOneToOne: false
            referencedRelation: "categorias_financeiras"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "transacoes_financeiras_contato_id_fkey"
            columns: ["contato_id"]
            isOneToOne: false
            referencedRelation: "contatos"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "transacoes_financeiras_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "transacoes_financeiras_evento_id_fkey"
            columns: ["evento_id"]
            isOneToOne: false
            referencedRelation: "eventos"
            referencedColumns: ["id"]
          },
        ]
      }
      users: {
        Row: {
          ativo: boolean
          avatar_url: string | null
          created_at: string
          email: string
          google_access_token: string | null
          google_refresh_token: string | null
          google_token_expires_at: string | null
          id: string
          nome: string
          perfil: Database["public"]["Enums"]["perfil_usuario"]
          updated_at: string
        }
        Insert: {
          ativo?: boolean
          avatar_url?: string | null
          created_at?: string
          email: string
          google_access_token?: string | null
          google_refresh_token?: string | null
          google_token_expires_at?: string | null
          id: string
          nome: string
          perfil?: Database["public"]["Enums"]["perfil_usuario"]
          updated_at?: string
        }
        Update: {
          ativo?: boolean
          avatar_url?: string | null
          created_at?: string
          email?: string
          google_access_token?: string | null
          google_refresh_token?: string | null
          google_token_expires_at?: string | null
          id?: string
          nome?: string
          perfil?: Database["public"]["Enums"]["perfil_usuario"]
          updated_at?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      funcao_equipe:
        | "monitor"
        | "recreador"
        | "coordenador"
        | "motorista"
        | "outro"
      perfil_usuario: "admin" | "usuario"
      status_atividade: "pendente" | "em_andamento" | "concluida" | "cancelada"
      status_evento:
        | "planejamento"
        | "confirmado"
        | "em_andamento"
        | "realizado"
        | "cancelado"
      status_lead:
        | "novo"
        | "qualificado"
        | "proposta_enviada"
        | "negociacao"
        | "aceito"
        | "perdido"
      status_pagamento: "pendente" | "pago" | "em_atraso" | "cancelado"
      tipo_contato: "pessoa_fisica" | "empresa" | "fornecedor"
      tipo_contrato_equipe: "fixo" | "freelancer"
      tipo_evento:
        | "colonia_ferias"
        | "festa_infantil"
        | "gincana"
        | "outro"
      tipo_recurso: "brinquedo" | "veiculo" | "espaco" | "equipamento" | "outro"
      tipo_transacao: "receita" | "despesa"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type PublicSchema = Database["public"]

// Helper types para acesso simplificado às tabelas
export type Tables<T extends keyof PublicSchema["Tables"]> = PublicSchema["Tables"][T]["Row"]
export type TablesInsert<T extends keyof PublicSchema["Tables"]> = PublicSchema["Tables"][T]["Insert"]
export type TablesUpdate<T extends keyof PublicSchema["Tables"]> = PublicSchema["Tables"][T]["Update"]
export type Enums<T extends keyof PublicSchema["Enums"]> = PublicSchema["Enums"][T]

// Types específicos para facilitar o uso
export type User = Tables<"users">
export type Contato = Tables<"contatos">
export type Organizacao = Tables<"organizacoes">
export type Lead = Tables<"leads">
export type EtapaFunil = Tables<"etapas_funil">
export type Evento = Tables<"eventos">
export type Recurso = Tables<"recursos">
export type AlocacaoRecurso = Tables<"alocacao_recursos">
export type MembroEquipe = Tables<"equipe">
export type AlocacaoEquipe = Tables<"alocacao_equipe">
export type CategoriaFinanceira = Tables<"categorias_financeiras">
export type TransacaoFinanceira = Tables<"transacoes_financeiras">
export type Atividade = Tables<"atividades">
export type Interacao = Tables<"interacoes">
export type LogAuditoria = Tables<"logs_auditoria">
export type TipoEventoRow = Tables<"tipos_evento">

// Enums para uso no código
export type TipoContato = Enums<"tipo_contato">
export type StatusLead = Enums<"status_lead">
export type TipoEventoEnum = Enums<"tipo_evento">
export type StatusEvento = Enums<"status_evento">
export type TipoRecurso = Enums<"tipo_recurso">
export type FuncaoEquipe = Enums<"funcao_equipe">
export type TipoContratoEquipe = Enums<"tipo_contrato_equipe">
export type TipoTransacao = Enums<"tipo_transacao">
export type StatusPagamento = Enums<"status_pagamento">
export type PerfilUsuario = Enums<"perfil_usuario">
export type StatusAtividade = Enums<"status_atividade">

