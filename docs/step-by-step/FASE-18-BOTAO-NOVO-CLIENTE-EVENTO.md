# FASE 18 - Botão Novo Cliente no Formulário de Evento

## Objetivo
Adicionar um botão "+" ao lado do campo Cliente/Contato no formulário de evento, permitindo criar um novo contato diretamente sem sair do modal. Após a criação, o contato é automaticamente selecionado.

## Arquivos Modificados

### 1. `src/components/modules/contatos/contato-form.tsx`

**Função:** Componente de formulário para criação/edição de contatos.

**Alterações:**
- Adicionada nova prop `onCreated?: (contato: Contato) => void` na interface `ContatoFormProps`
- No callback `onSubmit`, quando um novo contato é criado com sucesso, a função `onCreated` é chamada passando os dados do contato recém-criado

**Utilidade:** Permite que componentes externos (como o EventoForm) recebam os dados do contato criado para utilizá-los imediatamente.

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

**Utilidade:** Permite criar um novo cliente/contato inline sem fechar o formulário de evento, melhorando a experiência do usuário.

## Fluxo de Funcionamento

```
1. Usuário abre o formulário de novo evento
2. No campo Cliente/Contato, clica no botão "+"
3. Modal de novo contato abre (sobrepõe o modal de evento)
4. Usuário preenche os dados do contato e clica em "Criar contato"
5. Contato é criado no banco de dados
6. Callback onCreated é disparado com os dados do contato
7. EventoForm:
   - Adiciona o contato à lista do select
   - Seleciona automaticamente o novo contato no campo
8. Modal de contato fecha, usuário volta ao formulário de evento com o cliente já selecionado
```

## Considerações de Escalabilidade

Esta implementação segue o padrão de composição de componentes, mantendo cada formulário independente mas comunicável através de callbacks. Caso seja necessário adicionar a mesma funcionalidade em outros formulários (ex: financeiro), basta reutilizar o `ContatoForm` com a prop `onCreated`.
