# Fase 2 - Agenda e Alocações

## 📋 Resumo

Esta fase implementou a integração com Google Calendar e os módulos de gerenciamento de Recursos e Equipe, permitindo controle completo de alocações para eventos.

---

## ✅ Tarefas Concluídas

### 1. Integração Google Calendar

**Arquivo:** `src/lib/google/calendar.ts`

- Criação de eventos no Google Calendar automaticamente ao criar eventos no CRM
- Atualização de eventos sincronizados
- Deleção de eventos do Google Calendar ao deletar do CRM
- Mapeamento de cores por tipo de evento
- Suporte a eventos com horário específico e de dia inteiro

**Funcionalidades:**
- `createGoogleCalendarEvent()` - Cria evento no Google Calendar
- `updateGoogleCalendarEvent()` - Atualiza evento existente
- `deleteGoogleCalendarEvent()` - Remove evento do calendário

**Eventos atualizado:** `src/actions/eventos.ts`
- Integração transparente com Google Calendar na criação/edição/exclusão
- Função `syncEventoComGoogle()` para sincronizar eventos antigos

---

### 2. Módulo Recursos

Gerenciamento de brinquedos, veículos, espaços e equipamentos.

#### Arquivos Criados:

| Arquivo | Função |
|---------|--------|
| `src/lib/validations/recurso.ts` | Schema Zod para validação |
| `src/actions/recursos.ts` | Server Actions (CRUD + Alocações) |
| `src/components/modules/recursos/recursos-table.tsx` | Tabela de recursos |
| `src/components/modules/recursos/recurso-form.tsx` | Formulário criar/editar |
| `src/components/modules/recursos/recursos-filters.tsx` | Filtros de busca |
| `src/components/modules/recursos/alocacoes-modal.tsx` | Modal de alocações |
| `src/components/modules/recursos/recursos-client.tsx` | Lógica client-side |
| `src/app/(dashboard)/recursos/page.tsx` | Página principal |
| `src/app/(dashboard)/recursos/recurso-form-trigger.tsx` | Botão trigger |

#### Funcionalidades:

**CRUD de Recursos:**
- Cadastro com nome, tipo, descrição, quantidade, capacidade, custo
- Edição e exclusão (com verificação de alocações)
- Filtros por tipo e busca textual
- Paginação

**Tipos de Recursos:**
- Brinquedo
- Veículo
- Espaço
- Equipamento
- Outro

**Alocações:**
- Verificação de disponibilidade por período
- Controle de conflitos de data
- Visualização de alocações por recurso

---

### 3. Módulo Equipe

Gerenciamento de monitores, recreadores e colaboradores.

#### Arquivos Criados:

| Arquivo | Função |
|---------|--------|
| `src/lib/validations/equipe.ts` | Schema Zod para validação |
| `src/actions/equipe.ts` | Server Actions (CRUD + Alocações) |
| `src/components/modules/equipe/equipe-table.tsx` | Tabela de membros |
| `src/components/modules/equipe/membro-form.tsx` | Formulário criar/editar |
| `src/components/modules/equipe/equipe-filters.tsx` | Filtros de busca |
| `src/components/modules/equipe/agenda-modal.tsx` | Modal de agenda |
| `src/components/modules/equipe/equipe-client.tsx` | Lógica client-side |
| `src/app/(dashboard)/equipe/page.tsx` | Página principal |
| `src/app/(dashboard)/equipe/membro-form-trigger.tsx` | Botão trigger |

#### Funcionalidades:

**CRUD de Membros:**
- Cadastro com nome, função, tipo de contrato, contatos, valor diária
- Status ativo/inativo
- Edição e exclusão (com verificação de alocações)
- Filtros por função e tipo de contrato

**Funções da Equipe:**
- Monitor
- Recreador
- Coordenador
- Motorista
- Outro

**Tipos de Contrato:**
- Fixo
- Freelancer

**Alocações:**
- Verificação de disponibilidade por data
- Agenda mensal individual
- Valor pago por alocação

---

## 🔧 Server Actions Criadas

### Recursos (`src/actions/recursos.ts`)

```typescript
// Recursos
getRecursos(filters)
getRecursosDisponiveis(dataInicio, dataFim, tipo?)
getRecursoById(id)
createRecurso(formData)
updateRecurso(id, formData)
deleteRecurso(id)

// Alocações de Recursos
getAlocacoesRecurso(recursoId)
getAlocacoesEvento(eventoId)
createAlocacaoRecurso(formData)
updateAlocacaoRecurso(id, formData)
deleteAlocacaoRecurso(id)
```

### Equipe (`src/actions/equipe.ts`)

```typescript
// Membros
getMembrosEquipe(filters)
getMembrosDisponiveis(data, funcao?)
getMembroById(id)
createMembro(formData)
updateMembro(id, formData)
deleteMembro(id)

// Alocações de Equipe
getAlocacoesMembro(membroId)
getAlocacoesEvento(eventoId)
getAgendaMembro(membroId, mes?)
createAlocacaoEquipe(formData)
updateAlocacaoEquipe(id, formData)
deleteAlocacaoEquipe(id)
```

---

## 📊 Estrutura de Dados

### Tabela: recursos

| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | uuid | PK |
| nome | text | Nome do recurso |
| tipo | enum | brinquedo, veiculo, espaco, equipamento, outro |
| descricao | text | Descrição |
| quantidade | int | Quantidade disponível |
| capacidade | int | Capacidade (pessoas) |
| custo_unitario | decimal | Custo por unidade |
| ativo | boolean | Status ativo |

### Tabela: alocacao_recursos

| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | uuid | PK |
| recurso_id | uuid | FK recursos |
| evento_id | uuid | FK eventos |
| quantidade | int | Quantidade alocada |
| data_inicio | date | Data início |
| data_fim | date | Data fim |
| observacoes | text | Observações |

### Tabela: equipe

| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | uuid | PK |
| nome | text | Nome completo |
| funcao | enum | monitor, recreador, coordenador, motorista, outro |
| tipo_contrato | enum | fixo, freelancer |
| telefone | text | Telefone |
| whatsapp | text | WhatsApp |
| email | text | E-mail |
| documento | text | CPF/Documento |
| valor_diaria | decimal | Valor da diária |
| ativo | boolean | Status ativo |

### Tabela: alocacao_equipe

| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | uuid | PK |
| membro_id | uuid | FK equipe |
| evento_id | uuid | FK eventos |
| data | date | Data da alocação |
| hora_inicio | time | Hora início |
| hora_fim | time | Hora fim |
| funcao_evento | text | Função no evento |
| valor_pago | decimal | Valor pago |
| observacoes | text | Observações |

---

## 🎨 Componentes UI Utilizados

- `Table` - Listagem de dados
- `Dialog/Modal` - Formulários e visualizações
- `Form` com React Hook Form + Zod
- `Badge` - Status e categorias
- `Avatar` - Identificação de membros
- `ScrollArea` - Listas com scroll
- `Dropdown Menu` - Ações rápidas
- `Alert Dialog` - Confirmação de exclusão
- `Switch` - Toggle ativo/inativo
- `Select` - Seleção de tipos/funções

---

## 🚀 Próximos Passos (Fase 3)

1. **Módulo Financeiro**
   - Transações (receitas/despesas)
   - Categorias financeiras
   - Formas de pagamento
   - Relatórios financeiros

2. **Relatórios e Dashboard**
   - Cards de métricas
   - Gráficos com Tremor
   - Exportação de dados

---

## 📝 Notas Técnicas

### Google Calendar Integration

Para a integração funcionar, o usuário precisa:
1. Estar autenticado via Google OAuth
2. Ter concedido permissão de acesso ao Google Calendar
3. O token do Google é obtido automaticamente da sessão do Supabase

### Controle de Conflitos

- **Recursos:** Verifica quantidade disponível no período solicitado
- **Equipe:** Verifica se o membro já está alocado na mesma data (um membro = uma alocação por dia)

### Performance

- Uso de `useTransition` para loading states sem bloquear UI
- Dados iniciais carregados no servidor (SSR)
- Revalidação automática via `revalidatePath`

