# 🌱 ConectaHub - Sistema de Distribuição de Sementes

Sistema de gerenciamento de distribuição de sementes para agricultores, desenvolvido com banco de dados MySQL/MariaDB.

## 📋 Sobre o Projeto

O ConectaHub é uma solução completa para gerenciar a distribuição de sementes agrícolas, conectando fornecedores, agricultores e operadores em uma plataforma centralizada. O sistema controla estoques, pedidos, validades e históricos de transações.

## 🗃️ Estrutura do Banco de Dados

### 📐 Modelagem

O projeto possui modelagem completa do banco de dados:

**Modelo Conceitual (Diagrama MER)**
- Representa as entidades do sistema e seus relacionamentos
- Define as cardinalidades entre as entidades
- Mostra a estrutura abstrata do negócio

**Modelo Lógico (Diagrama MR)**
- Detalha a estrutura das tabelas
- Especifica chaves primárias e estrangeiras
- Define tipos de dados e restrições

### Principais Relacionamentos

- **Categorias** (1,n) → **Sementes**: Uma categoria possui várias sementes
- **Sementes** (0,n) → **Lotes**: Uma semente pode ter vários lotes em estoque
- **Fornecedores** (1,n) → **Lotes**: Um fornecedor fornece vários lotes
- **Agricultores** (1,n) → **Pedidos**: Um agricultor realiza vários pedidos
- **Agricultores** (1,n) → **Usuários**: Relacionamento de vinculação de conta
- **Usuários** (1,n) → **Pedidos**: Usuário responsável registra pedidos
- **Pedidos** (1,n) → **Itens_Pedido**: Um pedido contém vários itens
- **Lotes** (1,n) → **Itens_Pedido**: Um lote pode estar em vários itens
- **Pedidos** (1,n) → **Histórico_Status**: Registra todas as mudanças de status

### Tabelas Principais

- **categorias**: Classificação das sementes (Grãos, Hortaliças, Frutíferas, etc.)
- **fornecedores**: Cadastro de fornecedores de sementes
- **agricultores**: Cadastro de agricultores beneficiários
- **usuarios**: Usuários do sistema (Admin, Operador, Agricultor)
- **sementes**: Catálogo de sementes disponíveis
- **lotes**: Controle de estoque com validade
- **pedidos**: Solicitações de sementes
- **itens_pedido**: Detalhamento dos itens de cada pedido
- **historico_status**: Auditoria de mudanças de status

## 🚀 Como Usar

### 1. Criar o Banco de Dados

```bash
mysql -u root -p < "Estrutura SQL.sql"
```

### 2. Popular com Dados de Exemplo

```bash
mysql -u root -p conectahub < "Inserts SQL.sql"
```

### 3. Criar Procedures e Functions

```bash
mysql -u root -p conectahub < "Procedures e Funções SQL.sql"
```

### 4. Criar Triggers

```bash
mysql -u root -p conectahub < "Triggers SQL.sql"
```

### 5. Criar Views

```bash
mysql -u root -p conectahub < "Views SQL.sql"
```

## 📊 Recursos Implementados

### Functions (9)

| Função | Descrição |
|--------|-----------|
| `fn_estoque_total_semente()` | Calcula estoque total de uma semente |
| `fn_is_vencido()` | Verifica se lote está vencido |
| `fn_count_pedidos()` | Conta pedidos por agricultor |
| `fn_get_nome_agricultor()` | Retorna nome do agricultor |
| `fn_format_texto()` | Formata texto em maiúsculas |
| `fn_dias_vencimento()` | Calcula dias até vencimento |

### Stored Procedures (14)

| Procedure | Descrição |
|-----------|-----------|
| `sp_novo_agricultor()` | Cadastra novo agricultor |
| `sp_criar_pedido()` | Cria novo pedido e retorna ID |
| `sp_add_item_pedido()` | Adiciona item e baixa estoque automaticamente |
| `sp_atualiza_status()` | Atualiza status do pedido |
| `sp_delete_pedido_pendente()` | Remove apenas pedidos pendentes |
| `sp_correcao_estoque()` | Ajusta quantidade em lote |
| `sp_clonar_pedido()` | Duplica pedido existente |
| `sp_relatorio_categoria()` | Gera relatório por categoria |

### Triggers (12)

**Validações e Proteções:**
- `trg_check_usuario_pedido`: Garante usuário responsável em pedidos
- `trg_check_validade_lote`: Impede cadastro de lotes vencidos
- `trg_check_item_vencido`: Bloqueia venda de lotes vencidos
- `trg_block_del_agricultor`: Protege exclusão de agricultores com pedidos
- `trg_prevent_negativo`: Impede estoque negativo

**Logs Automáticos:**
- `trg_log_novo_pedido`: Registra criação de pedido no histórico
- `trg_log_update_pedido`: Registra mudanças de status

**Formatação Automática:**
- `trg_upper_agricultor`: Nome em maiúsculas (INSERT)
- `trg_upper_agricultor_upd`: Nome em maiúsculas (UPDATE)
- `trg_lower_email_user`: Email em minúsculas
- `trg_default_desc_cat`: Define descrição padrão em categorias

**Gestão de Estoque:**
- `trg_estorno_estoque`: Devolve estoque ao deletar item

### Views (10)

| View | Descrição |
|------|-----------|
| `vw_estoque_disponivel` | Lotes com saldo disponível |
| `vw_pedidos_pendentes` | Pedidos aguardando aprovação |
| `vw_total_pedidos_agricultor` | Total de pedidos por agricultor |
| `vw_sementes_categorias` | Catálogo completo de sementes |
| `vw_auditoria_pedidos` | Histórico completo de mudanças |
| `vw_alerta_validade` | Lotes vencendo em 30 dias |
| `vw_detalhes_saida` | Itens vendidos detalhados |
| `vw_fornecedores_ativos` | Fornecedores com lotes cadastrados |
| `vw_desempenho_operadores` | Estatísticas por operador |
| `vw_catalogo_completo` | Catálogo com instruções de plantio |

## 📈 Relatórios Disponíveis (20)

O arquivo `Relatórios SQL.sql` contém consultas prontas para:

1. Listar sementes e categorias
2. Mostrar estoques com fornecedores
3. Pedidos por agricultor
4. Itens detalhados de pedidos
5. Total de sementes por categoria
6. Lotes vencendo em 2025
7. Usuários que aprovaram pedidos
8. Agricultores com pedidos cancelados
9. Sementes com estoque baixo
10. Total de saída por semente
11. Fornecedores por categoria
12. Histórico de mudanças de status
13. Média de estoque por fornecedor
14. Agricultores sem pedidos
15. Admins sem registros
16. Semente com maior estoque
17. Quantidade de pedidos por status
18. Detalhes completos de pedidos
19. Fornecedores com lotes vencidos
20. Último status de cada pedido

## 🔐 Perfis de Usuário

### Tipos de Perfil

- **ADMIN**: Acesso completo ao sistema, gerenciamento de usuários e auditoria
- **OPERADOR**: Gerencia pedidos, estoque e operações do dia a dia
- **AGRICULTOR**: Visualiza catálogo e solicita sementes

### Credenciais de Teste

```
Admin Geral: admin@conectahub.com / 123456
Operador 1: op1@conectahub.com / 123456
Agricultor João: joao@gmail.com / 123456
```

## 💾 Dados Pré-Carregados

O sistema já vem populado com dados de exemplo:

- ✅ 20 Categorias de sementes (Grãos, Hortaliças, Frutíferas, PANC, etc.)
- ✅ 20 Fornecedores de diversas regiões do Brasil
- ✅ 20 Agricultores cadastrados
- ✅ 20 Usuários (Admins, Operadores e Agricultores)
- ✅ 20 Tipos de sementes diferentes
- ✅ 20 Lotes com validades variadas
- ✅ 20 Pedidos com diversos status
- ✅ Histórico completo de mudanças de status

## 🛡️ Regras de Negócio Implementadas

1. **Controle de Estoque**
   - Não permite venda sem saldo disponível
   - Baixa automática ao adicionar item no pedido
   - Estorno automático ao deletar item

2. **Gestão de Validade**
   - Bloqueia cadastro de lotes já vencidos
   - Impede venda de produtos vencidos
   - Alerta de lotes próximos ao vencimento

3. **Rastreabilidade**
   - Todo pedido requer usuário responsável
   - Log automático de todas as mudanças de status
   - Histórico completo de auditoria

4. **Integridade de Dados**
   - Protege exclusão de dados com relacionamentos
   - Padronização automática (maiúsculas/minúsculas)
   - Validações em tempo de inserção

5. **Segurança**
   - Controle de acesso por perfil
   - Senhas armazenadas (em produção use hash)
   - Restrições de exclusão para proteção de dados

## 📁 Estrutura de Arquivos

```
conectahub/
├── Estrutura SQL.sql              # DDL - Criação das tabelas
├── Inserts SQL.sql                # DML - Dados de exemplo
├── Procedures e Funções SQL.sql   # Lógica de negócio
├── Triggers SQL.sql               # Automatizações e validações
├── Views SQL.sql                  # Consultas otimizadas
├── Relatórios SQL.sql             # Queries prontas para análise
└── README.md                      # Documentação completa
```

## 🔧 Requisitos Técnicos

- **Banco de Dados**: MySQL 5.7+ ou MariaDB 10.3+
- **Cliente**: mysql-cli, MySQL Workbench, DBeaver, phpMyAdmin ou similar
- **Sistema Operacional**: Windows, Linux ou macOS

## 📝 Exemplos de Uso

### Criar e Processar Pedido Completo

```sql
-- 1. Criar novo pedido
CALL sp_criar_pedido(1, 2, @novo_pedido_id);
SELECT @novo_pedido_id; -- Exibe ID do pedido criado

-- 2. Adicionar itens ao pedido
CALL sp_add_item_pedido(@novo_pedido_id, 1, 10);  -- 10 unidades do lote 1
CALL sp_add_item_pedido(@novo_pedido_id, 2, 5);   -- 5 unidades do lote 2

-- 3. Atualizar status do pedido
CALL sp_atualiza_status(@novo_pedido_id, 'APROVADO', 2);

-- 4. Verificar estoque disponível
SELECT fn_estoque_total_semente(1) AS estoque_total;
```

### Consultas Úteis

```sql
-- Verificar pedidos pendentes
SELECT * FROM vw_pedidos_pendentes;

-- Alertas de validade
SELECT * FROM vw_alerta_validade;

-- Auditoria completa
SELECT * FROM vw_auditoria_pedidos WHERE pedido_id = @novo_pedido_id;

-- Verificar dias para vencimento de um lote
SELECT fn_dias_vencimento(1) AS dias_restantes;
```

### Relatórios Gerenciais

```sql
-- Desempenho dos operadores
SELECT * FROM vw_desempenho_operadores;

-- Fornecedores ativos
SELECT * FROM vw_fornecedores_ativos;

-- Catálogo completo
SELECT * FROM vw_catalogo_completo;
```

## 🎯 Casos de Uso

### Fluxo Completo de Pedido

1. **Agricultor solicita sementes** → Status: PENDENTE
2. **Operador analisa disponibilidade** → Consulta estoque
3. **Operador aprova pedido** → Status: APROVADO (baixa automática)
4. **Logística processa entrega** → Status: ENTREGUE
5. **Sistema registra histórico** → Auditoria completa

### Gestão de Estoque

- Cadastro de novos lotes com validade
- Consulta de disponibilidade em tempo real
- Alertas de produtos próximos ao vencimento
- Correção de estoque quando necessário

### Relatórios e Análises

- Sementes mais solicitadas
- Desempenho de operadores
- Fornecedores mais ativos
- Agricultores sem pedidos recentes
- 
## 📄 Licença

Este projeto foi desenvolvido para fins educacionais como parte do Projeto Integrador.

*Sistema ConectaHub - Conectando agricultores às melhores sementes* 🌾
