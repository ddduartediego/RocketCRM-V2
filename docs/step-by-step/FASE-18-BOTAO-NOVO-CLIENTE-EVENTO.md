# FASE 18 - Botão Novo Cliente nos Formulários

## Objetivo
Adicionar um botão "+" ao lado do campo Cliente/Contato nos formulários de evento, financeiro e leads, permitindo criar um novo contato diretamente sem sair do modal. Após a criação, o contato é automaticamente selecionado.

## Arquivos Modificados

### 1. `src/components/modules/contatos/contato-form.tsx`

**Função:** Componente de formulário para criação/edição de contatos.

**Alterações:**
- Adicionada nova prop `onCreated?: (contato: Contato) => void` na interface `ContatoFormProps`
- No callback `onSubmit`, quando um novo contato é criado com sucesso, a função `onCreated` é chamada passando os dados do contato recém-criado

**Utilidade:** Permite que componentes externos recebam os dados do contato criado para utilizá-los imediatamente.

### 2. `src/components/modules/eventos/evento-form.tsx`

**Função:** Componente de formulário para criação/edição de eventos.

**Alterações:**
- Importado o componente `ContatoForm` e o tipo `Contato`
- Importado o ícone `Plus` do lucide-react
- Adicionado estado `contatoFormOpen` para controlar a abertura do modal de contato
- Adicionado callback `handleContatoCreated` que:
  - Adiciona o novo contato à lista de contatos do select
  - Define automaticamente o `cliente_id` do formulário com o ID do novo contato
- Modificado o campo Cliente/Contato para incluir um botão "+" ao lado do select
- Renderizado o `ContatoForm` com a prop `onCreated` vinculada ao callback

**Utilidade:** Permite criar um novo cliente/contato inline sem fechar o formulário de evento.

### 3. `src/components/modules/financeiro/transacao-form.tsx`

**Função:** Componente de formulário para criação/edição de transações financeiras.

**Alterações:**
- Importado o componente `ContatoForm`, o tipo `Contato` e o ícone `Plus`
- Adicionado estado `contatoFormOpen` para controlar a abertura do modal
- Adicionado callback `handleContatoCreated` para atualizar lista e campo
- Modificado o campo Cliente/Fornecedor para incluir um botão "+" ao lado do select
- Renderizado o `ContatoForm` com a prop `onCreated`

**Utilidade:** Permite criar um novo cliente/fornecedor inline durante o cadastro de transação.

### 4. `src/components/modules/leads/lead-form.tsx`

**Função:** Componente de formulário para criação/edição de leads.

**Alterações:**
- Importado o componente `ContatoForm`, o tipo `Contato` e o ícone `Plus`
- Adicionado estado `contatoFormOpen` para controlar a abertura do modal
- Adicionado callback `handleContatoCreated` para atualizar lista e campo
- Modificado o campo Contato para incluir um botão "+" ao lado do select
- Renderizado o `ContatoForm` com a prop `onCreated`

**Utilidade:** Permite criar um novo contato inline durante o cadastro de lead.

## Fluxo de Funcionamento

```
1. Usuário abre qualquer formulário (evento, financeiro ou lead)
2. No campo de contato/cliente, clica no botão "+"
3. Modal de novo contato abre (sobrepõe o modal atual)
4. Usuário preenche os dados do contato e clica em "Criar contato"
5. Contato é criado no banco de dados
6. Callback onCreated é disparado com os dados do contato
7. Formulário pai:
   - Adiciona o contato à lista do select
   - Seleciona automaticamente o novo contato no campo
8. Modal de contato fecha, usuário volta ao formulário com o cliente já selecionado
```

## Módulos Implementados

| Módulo | Arquivo | Campo |
|--------|---------|-------|
| Eventos | evento-form.tsx | Cliente/Contato |
| Financeiro | transacao-form.tsx | Cliente/Fornecedor |
| Leads | lead-form.tsx | Contato |

## Considerações de Escalabilidade

Esta implementação segue o padrão de composição de componentes, mantendo cada formulário independente mas comunicável através de callbacks. O `ContatoForm` é reutilizado em 3 módulos diferentes com a mesma prop `onCreated`, demonstrando a flexibilidade do padrão.

Caso seja necessário adicionar a mesma funcionalidade em outros formulários no futuro, basta seguir o mesmo padrão:
1. Importar `ContatoForm` e tipo `Contato`
2. Adicionar estado para controlar abertura do modal
3. Criar callback que atualiza lista e campo do formulário
4. Renderizar botão "+" e o `ContatoForm`
