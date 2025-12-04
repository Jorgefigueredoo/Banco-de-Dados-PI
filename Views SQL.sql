-- 1. View Estoque Disponível
CREATE OR REPLACE VIEW vw_estoque_disponivel AS
SELECT s.nome_comercial, l.codigo_lote, l.qtd_atual, l.data_validade
FROM lotes l JOIN sementes s ON l.semente_id = s.id WHERE l.qtd_atual > 0;

-- 2. View Pedidos Pendentes
CREATE OR REPLACE VIEW vw_pedidos_pendentes AS
SELECT p.id, p.data_pedido, a.nome_completo 
FROM pedidos p JOIN agricultores a ON p.agricultor_id = a.id WHERE p.status = 'PENDENTE';

-- 3. View Total Pedido por Agricultor
CREATE OR REPLACE VIEW vw_total_pedidos_agricultor AS
SELECT a.nome_completo, COUNT(p.id) as total_pedidos
FROM agricultores a LEFT JOIN pedidos p ON a.id = p.agricultor_id GROUP BY a.nome_completo;

-- 4. View Sementes por Categoria
CREATE OR REPLACE VIEW vw_sementes_categorias AS
SELECT c.nome as categoria, s.nome_comercial, s.nome_cientifico
FROM sementes s JOIN categorias c ON s.categoria_id = c.id;

-- 5. View Histórico Completo Auditado
CREATE OR REPLACE VIEW vw_auditoria_pedidos AS
SELECT h.data_mudanca, p.id as pedido_id, h.status_anterior, h.status_novo, u.nome as usuario
FROM historico_status h 
JOIN pedidos p ON h.pedido_id = p.id 
JOIN usuarios u ON h.usuario_id = u.id;

-- 6. View Alerta Validade (Vencendo em 30 dias)
CREATE OR REPLACE VIEW vw_alerta_validade AS
SELECT codigo_lote, data_validade FROM lotes 
WHERE data_validade BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

-- 7. View Detalhes de Saída (Itens Vendidos)
CREATE OR REPLACE VIEW vw_detalhes_saida AS
SELECT p.id as pedido_id, p.data_pedido, s.nome_comercial, i.quantidade_solicitada
FROM pedidos p 
JOIN itens_pedido i ON p.id = i.pedido_id
JOIN lotes l ON i.lote_id = l.id
JOIN sementes s ON l.semente_id = s.id;

-- 8. View Fornecedores Ativos
CREATE OR REPLACE VIEW vw_fornecedores_ativos AS
SELECT DISTINCT f.razao_social, f.cidade FROM fornecedores f JOIN lotes l ON f.id = l.fornecedor_id;

-- 9. View Desempenho Operadores
CREATE OR REPLACE VIEW vw_desempenho_operadores AS
SELECT u.nome, COUNT(p.id) as pedidos_geridos 
FROM usuarios u JOIN pedidos p ON u.id = p.usuario_responsavel_id GROUP BY u.nome;

-- 10. View Catálogo Completo
CREATE OR REPLACE VIEW vw_catalogo_completo AS
SELECT s.nome_comercial, s.instrucoes_plantio, c.nome as tipo
FROM sementes s JOIN categorias c ON s.categoria_id = c.id;