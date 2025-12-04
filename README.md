# 🌱 ConectaHub - Sistema de Distribuição de Sementes

Sistema de gerenciamento de distribuição de sementes para agricultores, desenvolvido com banco de dados MySQL/MariaDB.

## 📋 Sobre o Projeto

O ConectaHub é uma solução completa para gerenciar a distribuição de sementes agrícolas, conectando fornecedores, agricultores e operadores em uma plataforma centralizada. O sistema controla estoques, pedidos, validades e históricos de transações.

## 🗃️ Estrutura do Banco de Dados

### 📐 Modelagem

O projeto inclui a modelagem completa do banco de dados:

#### Modelo Conceitual (Diagrama MER)

![Diagrama Entidade-Relacionamento](./diagrams/mer-conceitual.png)

O diagrama conceitual apresenta as principais entidades e seus relacionamentos:

- **Categorias** (1,n) → **Sementes**: Uma categoria possui várias sementes
- **Sementes** (0,n) → **Lotes**: Uma semente pode ter vários lotes em estoque
- **Fornecedores** (1,n) → **Lotes**: Um fornecedor fornece vários lotes
- **Agricultores** (1,n) → **Pedidos**: Um agricultor realiza vários pedidos
- **Agricultores** (1,n) → **Usuários**: Relacionamento de vinculação de conta
- **Usuários** (1,n) → **Pedidos**: Usuário responsável registra pedidos
- **Pedidos** (1,n) → **Itens_Pedido**: Um pedido contém vários itens
- **Lotes** (1,n) → **Itens_Pedido**: Um lote pode estar em vários itens
- **Pedidos** (1,n) → **Histórico_Status**: Registra todas as mudanças de status

#### Modelo Lógico (Diagrama MR)

![Diagrama Lógico](./diagrams/modelo-logico.png)

O modelo lógico detalha a estrutura das tabelas com:

- **Chaves primárias (PK)**: Identificadores únicos de cada tabela
- **Chaves estrangeiras (FK)**: Relacionamentos entre tabelas
- **Tipos de dados**: varchar, integer, timestamp, date, text, enum
- **Restrições**: NOT NULL, UNIQUE, DEFAULT values

> 💡 **Ferramentas utilizadas**: Os diagramas foram criados com MySQL Workbench / brModelo.

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

### Relacionamentos

```
categorias (1) ──→ (N) sementes
fornecedores (1) ──→ (N) lotes
sementes (1) ──→ (N) lotes
agricultores (1) ──→ (N) pedidos
usuarios (1) ──→ (N) pedidos
pedidos (1) ──→ (N) itens_pedido
lotes (1) ──→ (N) itens_pedido
```

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

- `fn_estoque_total_semente()`: Calcula estoque total de uma semente
- `fn_is_vencido()`: Verifica se lote está vencido
- `fn_count_pedidos()`: Conta pedidos por agricultor
- `fn_get_nome_agricultor()`: Retorna nome do agricultor
- `fn_format_texto()`: Formata texto em maiúsculas
- `fn_dias_vencimento()`: Calcula dias até vencimento
- E mais...

### Stored Procedures (14)

- `sp_novo_agricultor()`: Cadastra novo agricultor
- `sp_criar_pedido()`: Cria novo pedido
- `sp_add_item_pedido()`: Adiciona item e baixa estoque
- `sp_atualiza_status()`: Atualiza status do pedido
- `sp_delete_pedido_pendente()`: Remove pedidos pendentes
- `sp_correcao_estoque()`: Ajusta quantidade em lote
- `sp_clonar_pedido()`: Duplica pedido existente
- E mais...

### Triggers (12)

- **Validações**: Garante integridade dos dados
- **Logs Automáticos**: Registra mudanças no histórico
- **Formatação**: Padroniza textos (maiúsculas/minúsculas)
- **Proteção**: Impede exclusões indevidas
- **Estoque**: Gerencia entrada/saída automática

### Views (10)

- `vw_estoque_disponivel`: Lotes com saldo
- `vw_pedidos_pendentes`: Pedidos aguardando aprovação
- `vw_alerta_validade`: Lotes vencendo em 30 dias
- `vw_auditoria_pedidos`: Histórico completo de mudanças
- `vw_desempenho_operadores`: Estatísticas por operador
- E mais...

## 📈 Relatórios Disponíveis

O arquivo `Relatórios SQL.sql` contém 20 consultas prontas:

1. Sementes e categorias
2. Estoques com fornecedores
3. Pedidos por agricultor
4. Itens detalhados de pedidos
5. Total de sementes por categoria
6. Lotes vencendo em 2025
7. Usuários que aprovaram pedidos
8. Agricultores com pedidos cancelados
9. Sementes com estoque baixo
10. Saída total por semente
11. Fornecedores por categoria
12. Histórico de mudanças
13. Média de estoque por fornecedor
14. Agricultores sem pedidos
15. Admins sem registros de pedidos
16. Semente com maior estoque
17. Quantidade por status
18. Detalhes completos de pedidos
19. Fornecedores com lotes vencidos
20. Último status de cada pedido

## 🔐 Perfis de Usuário

- **ADMIN**: Acesso completo ao sistema
- **OPERADOR**: Gerencia pedidos e estoque
- **AGRICULTOR**: Visualiza e solicita sementes

### Credenciais de Teste

```
Admin: admin@conectahub.com / 123456
Operador: op1@conectahub.com / 123456
Agricultor: joao@gmail.com / 123456
```

## 💾 Dados Pré-Carregados

- 20 Categorias de sementes
- 20 Fornecedores
- 20 Agricultores
- 20 Usuários
- 20 Sementes diferentes
- 20 Lotes com validades variadas
- 20 Pedidos (diversos status)
- Histórico completo de mudanças

## 🛡️ Regras de Negócio

1. **Estoque**: Não permite venda sem saldo
2. **Validade**: Bloqueia inserção de lotes vencidos
3. **Pedidos**: Requer usuário responsável
4. **Histórico**: Log automático de todas mudanças
5. **Exclusão**: Protege dados com relacionamentos
6. **Padronização**: Formata dados automaticamente

## 📁 Estrutura de Arquivos

```
├── Estrutura SQL.sql          # DDL - Criação das tabelas
├── Inserts SQL.sql            # DML - Dados de exemplo
├── Procedures e Funções SQL.sql  # Lógica de negócio
├── Triggers SQL.sql           # Automatizações
├── Views SQL.sql              # Consultas otimizadas
├── Relatórios SQL.sql         # Queries prontas
└── README.md                  # Documentação
```

## 🔧 Requisitos

- MySQL 5.7+ ou MariaDB 10.3+
- Cliente MySQL (mysql-cli, MySQL Workbench, DBeaver, etc.)

## 📝 Exemplo de Uso

```sql
-- Criar novo pedido
CALL sp_criar_pedido(1, 2, @novo_id);

-- Adicionar item ao pedido
CALL sp_add_item_pedido(@novo_id, 1, 10);

-- Atualizar status
CALL sp_atualiza_status(@novo_id, 'APROVADO', 2);

-- Verificar estoque
SELECT fn_estoque_total_semente(1);

-- Consultar pedidos pendentes
SELECT * FROM vw_pedidos_pendentes;
```

## 🤝 Contribuindo

Este é um projeto acadêmico. Sugestões e melhorias são bem-vindas!

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais.

---

**Desenvolvido para o Projeto Integrador** 🎓
