# Fase 8 - Integração Google Calendar com Convites por Email

Esta fase implementou a funcionalidade de enviar convites por email do Google Calendar para os membros da equipe quando são alocados em eventos.

## Data de Implementação
Novembro de 2025

## Resumo das Alterações

### 1. Atualização da Integração Google Calendar

**Arquivo:** `src/lib/google/calendar.ts`

#### Novas Interfaces

```typescript
export interface GoogleCalendarAttendee {
  email: string;
  displayName?: string;
  responseStatus?: "needsAction" | "declined" | "tentative" | "accepted";
  optional?: boolean;
}
```

#### Novas Funções

- `addAttendeeToGoogleEvent(googleCalendarId, attendee)` - Adiciona um participante a um evento existente
- `removeAttendeeFromGoogleEvent(googleCalendarId, email)` - Remove um participante de um evento
- `getGoogleCalendarEvent(googleCalendarId)` - Busca dados de um evento (função interna)

### 2. Integração com Alocações de Equipe

**Arquivo:** `src/actions/equipe.ts`

#### Alterações em `createAlocacaoEquipe`

- Ao criar uma alocação, se o membro tiver email cadastrado e o evento estiver sincronizado com Google Calendar:
  - O membro é adicionado como participante do evento
  - O Google envia automaticamente um convite por email
  - Retorna `googleCalendarInviteSent: true` se o convite foi enviado

#### Alterações em `deleteAlocacaoEquipe`

- Ao excluir uma alocação:
  - O membro é removido do evento no Google Calendar
  - O Google notifica o participante sobre a remoção

### 3. Sincronização de Participantes em Eventos Existentes

**Arquivo:** `src/actions/eventos.ts`

#### Nova Função

```typescript
syncParticipantesEvento(eventoId: string)
```

Permite sincronizar todos os membros alocados de um evento com o Google Calendar. Útil para:
- Eventos criados antes da integração
- Membros alocados quando o evento não estava sincronizado
- Re-sincronização após problemas de conexão

**Retorno:**
```typescript
{
  success: boolean;
  error: string | null;
  participantesSincronizados: number;
  totalMembros: number;
  membrosComEmail: number;
  membrosSemEmail: number;
}
```

## Fluxo de Funcionamento

### Criação de Alocação

```
1. Usuário aloca membro no evento
2. Sistema cria registro na tabela alocacao_equipe
3. Sistema verifica se:
   - Membro possui email cadastrado
   - Evento possui google_calendar_id
4. Se sim, adiciona participante via API do Google Calendar
5. Google envia convite por email automaticamente
```

### Remoção de Alocação

```
1. Usuário remove alocação do evento
2. Sistema exclui registro da tabela alocacao_equipe
3. Sistema verifica se havia integração com Google Calendar
4. Se sim, remove participante via API do Google Calendar
5. Google notifica participante sobre a remoção
```

## Pré-requisitos

### Configuração do Google OAuth

Para que os convites funcionem, é necessário:

1. **Google Cloud Console:**
   - Ativar a **Google Calendar API**
   - Configurar OAuth 2.0 com os escopos:
     - `https://www.googleapis.com/auth/calendar`
     - `https://www.googleapis.com/auth/calendar.events`

2. **Supabase:**
   - Configurar o provider Google com os escopos corretos
   - Habilitar `calendar.events` nos scopes do OAuth

### Membros da Equipe

- Para receber convites, os membros precisam ter **email cadastrado** na tabela `equipe`
- Membros sem email serão alocados normalmente, mas não receberão convites

## Considerações Importantes

### Limitações

1. **Token do Usuário:** Os convites são enviados usando o token do usuário logado. Se o token expirar ou não tiver as permissões necessárias, os convites não serão enviados.

2. **Eventos não Sincronizados:** Se o evento não foi sincronizado com o Google Calendar (`google_calendar_id` é null), as alocações funcionam normalmente, mas sem envio de convites.

3. **Membros sem Email:** Membros sem email cadastrado não recebem convites, mas podem ser alocados normalmente.

### Boas Práticas

1. **Cadastrar Emails:** Incentive o cadastro de emails dos membros da equipe
2. **Sincronizar Eventos:** Mantenha eventos sincronizados com o Google Calendar
3. **Verificar Escopos:** Certifique-se de que o usuário autorizou os escopos do Calendar

## Arquivos Modificados

| Arquivo | Tipo de Alteração |
|---------|-------------------|
| `src/lib/google/calendar.ts` | Adicionadas interfaces e funções para gerenciar participantes |
| `src/actions/equipe.ts` | Integração de alocações com convites do Calendar |
| `src/actions/eventos.ts` | Nova função para sincronizar participantes |

## Testando a Integração

1. Criar um evento com sincronização Google Calendar habilitada
2. Verificar se o evento aparece no Google Calendar do usuário
3. Alocar um membro que tenha email cadastrado
4. Verificar se o membro recebeu convite por email
5. Remover a alocação e verificar se o membro foi removido do evento

## Próximas Melhorias Sugeridas

1. **Botão de Sincronização na UI:** Adicionar botão no detalhe do evento para chamar `syncParticipantesEvento`
2. **Status de Resposta:** Exibir se o participante aceitou/recusou o convite
3. **Notificações no Sistema:** Informar quando convites são enviados ou há erros
4. **Configuração por Evento:** Permitir desabilitar convites para eventos específicos

