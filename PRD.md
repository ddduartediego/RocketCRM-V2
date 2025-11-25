### 1. Resumo Executivo

**Produto:** Rocket CRM (nome provisório)
**Proprietário:** Dono(a) da empresa de viagens pedagógicas e festas infantis (sponsor)
**Status:** Rascunho
**Última Atualização:** 25/11/2025

**Visão (1 frase)**
Criar um CRM web simples e focado em operação que centralize contatos, eventos (viagens, festas, colônias), financeiro básico e alocação de recursos/pessoas em um único lugar. 

**Visão do Produto – Detalhado**

* **Usuário-alvo:**

  * Proprietário da empresa
  * Assistente administrativo/operacional
  * Vendedores/atendentes (quem fala com pais e escolas)
  * Financeiro 

* **Casos de uso principais:**

  * Registrar e acompanhar leads (WhatsApp, indicação, feira, Instagram etc.)
  * Transformar leads em eventos/viagens/festas com datas definidas
  * Alocar brinquedos, monitores e outros recursos por data/evento
  * Controlar contas a pagar/receber por evento/cliente
  * Visualizar agenda diária/semanal de serviços
* **Diferencial & Proposta de valor:**

  * CRM desenhado especificamente para **turismo pedagógico, viagens de formatura e festas infantis**, com “evento/roteiro” como objeto central, não apenas “venda genérica”.
  * Interface enxuta, pensada para **equipe pequena**, sem excesso de features corporativas.
* **Definição de sucesso (alto nível):**

  * Toda operação de vendas e execução de eventos/viagens passa a ser registrada no sistema; planilhas soltas e caderninhos viram exceção.
  * Proprietário consegue responder, em segundos, perguntas como: “Qual o faturamento previsto por mês?”, “Quais eventos estão confirmados na semana?” e “Quem está responsável por cada evento?”.

**Métricas de Sucesso (macro)**

* 80%+ dos leads gerados no mês registrados no CRM a partir do 3º mês.
* Aumento de 20–25% na taxa de conversão de leads em eventos/viagens em 12 meses (benchmark: pequenas empresas que adotam CRM frequentemente reportam +25% em conversões). ([Startups][1])
* Redução de pelo menos 50% em conflitos de agenda ou “dupla reserva” de recursos (brinquedos, monitores, ônibus) em 6 meses.
* Proprietário reporta economia de pelo menos 5 horas semanais de trabalho operacional/manual após 6 meses.

**Alinhamento Estratégico**

* **Objetivos de negócios:**

  * Aumentar faturamento anual por melhor conversão e organização.
  * Reduzir erros operacionais (agenda, financeiro, conflitos de recursos).
  * Criar base de dados estruturada para ações futuras (marketing, parcerias com escolas).
* **Oportunidade:**

  * Pequenas empresas estão migrando de planilhas + WhatsApp para soluções de CRM, buscando centralizar contatos, acompanhar leads e automatizar tarefas.([Salesforce][2])
  * Segmentos de **agências de viagens** e **educação** usam CRMs especializados para acompanhar funil de vendas, preferências de clientes, reservas e KPIs de satisfação — algo ainda pouco explorado por microempresas locais. ([ClickUp][3])

---

### 2. Problema e Oportunidade

**Definição do Problema**
Hoje a empresa opera com:
* Contatos espalhados (WhatsApp, caderno, planilhas).
* Nenhum funil estruturado para acompanhar leads (pais/escolas pedem orçamento e “somem”).
* Agenda de serviços descentralizada, o que gera:
  * risco de “vender” o mesmo brinquedo/estrutura em duas datas;
  * falta de visibilidade de equipe/monitores disponíveis.
* Financeiro sem visão por evento: difícil saber se uma viagem está sendo lucrativa, quem pagou, quem está em atraso etc.
* Falta de histórico consolidado por escola/turma/turma de formandos.

**Impacto Atual (qualitativo)**
* Perda de vendas por falta de follow-up (esquecimento).
* Tempo gasto “caçando informação” em conversas antigas e planilhas.
* Estresse em períodos de pico (finais de ano letivo, férias, feriados).
* Decisões financeiras pouco embasadas (falta de DRE por evento, previsões de caixa).

**Análise de Oportunidades**

* **Mercado alvo:** pequenas empresas de turismo pedagógico, viagens de formatura e festas infantis em nível regional.
* **Potencial de crescimento:**
  * Escalar posteriormente para outras cidades/estados com modelo SaaS.
  * Expandir para outros nichos parecidos (buffets infantis, empresas de recreação escolar).
* **Lacuna competitiva:** CRMs genéricos não tratam “evento/viagem” como unidade principal nem trazem nativamente conceitos como turma, escola, série, pacote pedagógico, monitores e brinquedos infláveis.

**Critérios de Sucesso (negócio + comportamento)**
* Leads passam a seguir um fluxo padrão (Novo → Em contato → Proposta enviada → Negociação → Fechado/vencido).
* Agenda de todos os eventos centralizada e filtrável por tipo de serviço (viagem, festa, gincana, colônia).
* Cada evento tem: contatos ligados, valores, status de pagamento, recursos e pessoas alocadas.
* Proprietário consegue planejar o mês olhando previsão de receita e compromissos de recursos.

---

### 3. Requisitos do Usuário

#### 3.1 Usuários Primários (Personas)

1. **Clô – Proprietária**

   * Cuida de tudo: vendas, decisões financeiras, relacionamento com escolas e pais.
   * Dor: vive apagando incêndio, sente falta de visão do todo e vive com medo de esquecer algo importante.
   * Sucesso para ele: ter **claridade**: lista de eventos confirmados, quanto vai entrar de dinheiro, quem está devendo, e equipe/resource organizados.

2. **Carlos – Assistente Operacional**

   * Organiza agenda, combina transporte, monta equipes de monitores, documentos de autorização.
   * Dor: precisa conferir muitas fontes para saber onde cada recurso estará em cada dia.
   * Sucesso: ter uma **agenda visual** com todos os eventos, recursos e pessoas, sem conflitos.

3. **Daniel – Vendedora / Atendimento**

   * Atende pais e escolas (WhatsApp, telefone, Instagram, indicações).
   * Dor: não tem onde registrar leads; se perde nos follow-ups; não sabe quem está mais perto de fechar.
   * Sucesso: ter um **funil claro** e lembretes automáticos para follow-ups.

#### 3.2 Casos de Uso Chave

1. **Cadastro e organização de contatos (pais, escolas, fornecedores)**
2. **Gestão do funil de leads** (do primeiro contato até o fechamento da viagem/festa)
3. **Criação e gerenciamento de eventos/viagens** (com datas, locais, serviços inclusos)
4. **Agenda de serviços e calendário unificado**
5. **Alocação de recursos e pessoas por evento/data**
6. **Gestão financeira básica por evento e por cliente**
7. **Relatórios simples** (faturamento por mês, pipeline, inadimplência, utilização de recursos)

#### 3.3 Critérios de Sucesso para os Usuários

* Em no máximo 2 minutos, a equipe consegue **criar um novo lead, associar a uma escola/turma e agendar um follow-up**.
* Em no máximo 5 minutos, é possível **criar um evento completo**, com data, tipo de serviço, cliente, valores e recursos principais.
* Em até 2 cliques, o usuário consegue ver **agenda da semana** e saber quais recursos e pessoas estão alocados.

---

### 4. Requisitos do Produto

#### 4.1 Recursos Obrigatórios (Must – MVP)

1. **Gestão de Contatos**

   * **Descrição:** cadastro de pessoas físicas (pais, responsáveis) e jurídicas (escolas, empresas) com:

     * Nome, telefone, WhatsApp, e-mail, endereço, tipo (cliente, pai, escola, fornecedor).
     * Tags (ex.: “Escola particular”, “Pública”, “Cliente VIP”, “Indicação”).
     * Histórico de interações (anotações de ligações, reuniões, mensagens importantes).
   * **Critérios de aceitação:**
     * Buscar contato por nome, telefone ou escola.
     * Visualizar, em um único lugar, histórico de interações e eventos vinculados.

2. **Funil de Leads / Oportunidades**
   * **Descrição:** pipeline visual (kanban) com etapas configuráveis:

     * Exemplo: Novo → Qualificado → Proposta enviada → Negociação → Aceito → Perdido.
   * Cada lead ligado a um contato e, opcionalmente, a uma escola/turma.
   * Data de criação, valor potencial, serviço de interesse (viagem, festa, colônia etc.).
   * Lembretes de atividades (ligar, enviar proposta, cobrar retorno).
   * **Critérios de aceitação:**

     * Arrastar e soltar cards entre etapas.
     * Ver total de negócios e valor por etapa.
     * Registrar motivo de perda.

3. **Eventos/Serviços (objeto central)**

   * **Descrição:** entidade “Evento/Viagem” que representa:

     * Viagem pedagógica, viagem de formatura, colônia de férias, festa infantil, gincana etc.
   * Campos principais:

     * Nome do evento, tipo, cliente (contato/escola), turma/série (9º, 3º ano etc.), data(s), local, status (planejamento, confirmado, realizado, cancelado).
     * Valores (valor total, sinal, saldo), forma de pagamento, condições.
     * Número estimado de participantes, lista básica de participantes (opcional no MVP, detalhamento para depois).
   * **Critérios de aceitação:**

     * Criar, editar e cancelar eventos.
     * Associar evento a leads/negócios fechados.
     * Ver todos os eventos em uma visão de lista e calendário.

4. **Agenda de Serviços (Calendário)**

   * **Descrição:** calendário mensal/semanal com todos os eventos e serviços prestados.
   * Filtros por tipo de serviço, status, recurso, pessoa.
   * Integração lógica com “Eventos” (ao criar evento com data, aparece na agenda).
   * **Critérios de aceitação:**

     * Visualizar conflitos básicos (dois eventos que usam o mesmo recurso no mesmo horário).
     * Visualização responsiva e rápida (desempenho similar a agendas usadas em CRMs de mercado). ([Pipedrive][5])

5. **Alocação de Recursos (brinquedos, veículos, espaços, equipamentos)**

   * **Descrição:** cadastro de recursos físicos com capacidade e restrições:

     * Ex.: “Brinquedo inflável X (1 unidade)”, “Ônibus 46 lugares”, “Sala de festas A”.
   * Para cada evento, é possível vincular os recursos utilizados, com datas e horários.
   * Controle básico de disponibilidade para evitar dupla reserva.
   * **Critérios de aceitação:**

     * Sistema impede alocação dupla para recursos de uso exclusivo no mesmo horário.
     * Tela de “recursos por dia” mostrando o que está reservado.

6. **Alocação de Pessoas (monitores, recreadores, coordenadores)**

   * **Descrição:** cadastro de pessoas da equipe (fixa ou freelancer) com:

     * Nome, contato, função, disponibilidade básica.
   * Alocação por evento/data, com tempo de chegada e saída.
   * **Critérios de aceitação:**

     * Visualização por pessoa: quais eventos essa pessoa tem em determinado dia/semana.
     * Alerta de conflito ao alocar a mesma pessoa em dois eventos simultâneos.

7. **Financeiro Básico (Contas a Pagar e Receber por evento)**

   * **Descrição:**

     * Registrar receitas: parcelas de pais, pagamentos de escolas, sinal, saldo etc.
     * Registrar despesas: transporte, hospedagem, alimentação, terceirizados, aluguel de brinquedos etc.
     * Classificação por evento, centro de custo e forma de pagamento.
   * Relatórios simples:

     * Fluxo de caixa previsto por mês.
     * Resultado (lucro bruto) por evento.
   * **Critérios de aceitação:**

     * Lançar contas com vencimento, valor e status (pago/em aberto/em atraso).
     * Exportar relatório em CSV/Excel.

8. **Relatórios & Dashboards Enxutos**

   * **Descrição:**

     * Visão de funil (quantos leads em cada etapa e valor total).
     * Faturamento previsto/realizado por mês.
     * Quantidade de eventos por tipo.
   * **Critérios de aceitação:**

     * Dashboard inicial com cards e gráficos simples (sem filtros avançados no MVP).

9. **Gestão de Atividades e Tarefas**

   * **Descrição:**

     * Tarefas por contato, lead ou evento: ex. “Ligar para coordenadora da escola X”, “Enviar contratos para pais”.
     * Lembretes por data/hora, com visão “Minhas tarefas”.
   * **Critérios de aceitação:**

     * Listar tarefas por usuário e por data.
     * Marcar tarefa como concluída.

10. **Gestão de Usuários e Permissões Simples**

* **Descrição:**

  * Níveis: Admin (Administrador do sistema), Usuario.
  * Controle básico de acesso (ex.: Administrador possui acessos de configuração).


### 5. Especificações Técnicas

#### 5.1 Arquitetura (alto nível)

* **Tipo:** Aplicação web SaaS
* **Front-end:** Next.js, TypeScript, React Hook Form, Zod, Recharts.
* **Back-end:** Supabase, Autenticação Google, Calendário utilizar Google Calendar.
* **Banco de Dados:**
  * PostreSQL single-tenant.
* **Infraestrutura:**
  * Hospedagem Vercel.
  
#### 5.2 Dependências Técnicas

  * Não desenvolver agenda, utilizar integração com Google Calendar.

#### 5.4 Requisitos de Segurança

* Login com usuario Google.
* Controles de autorização por perfil.

#### 5.5 Plataforma e Compatibilidade
* Design responsivo para tablet e smartphone (uso via navegador móvel).
* Idioma: PT-BR.

---

### 6. Requisitos de Experiência do Usuário

#### 6.1 Princípios de Design

* Simplicidade: Sistema minimalista, com foco na necessidade do usuario.
* Clareza visual: uso de cores para status.
* Consistência: padrões de UI reutilizáveis (botões, cards, modais).

#### 6.2 Requisitos de Interface (alto nível)

Módulos principais no menu:

1. **Dashboard** – visão geral (pipeline, próximos eventos, tarefas do dia).
2. **Leads & Vendas** – funil em kanban e lista.
3. **Contatos** – pessoas e organizações.
4. **Eventos** – lista + calendário + detalhe do evento.
5. **Agenda & Recursos** – visão de recursos e pessoas por data.
6. **Financeiro** – contas a pagar/receber, relatórios.
7. **Relatórios** – gráficos simples.
8. **Configurações** – usuários, etapas do funil, tipos de evento etc.

Exemplo de fluxo: **Criar viagem pedagógica**

1. Selecionar “Novo Evento” → “Viagem pedagógica”.
2. Escolher cliente.
3. Definir data(s), local, etc.
4. Inserir valor total, forma de pagamento.
5. Alocar recursos principais (ônibus, equipe base, etc).
6. Salvar → evento aparece na agenda e no dashboard.

#### 6.3 Critérios de Usabilidade

* Onboarding: novo usuário deve conseguir criar primeiro lead e primeiro evento com **pouco ou nenhum treinamento**.
* Erros: mensagens claras, com orientação (“Preencha a data da viagem”, “Esse brinquedo já está reservado nesse horário”).

---

### 7. Requisitos Não Funcionais

#### 7.1 Segurança

* Logs de acesso (quem entrou, quando).
* Logs de ações críticas (criação/edição de evento, exclusão de contato).
