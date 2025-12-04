-- 1. Listar todas as sementes e suas categorias
SELECT s.nome_comercial, c.nome as categoria 
FROM sementes s 
INNER JOIN categorias c ON s.categoria_id = c.id;

-- 2. Mostrar estoques (lotes) com nome do fornecedor
SELECT l.codigo_lote, l.qtd_atual, f.razao_social 
FROM lotes l 
JOIN fornecedores f ON l.fornecedor_id = f.id;

-- 3. Pedidos feitos por cada agricultor
SELECT p.id as pedido_id, a.nome_completo, p.data_pedido
FROM pedidos p 
JOIN agricultores a ON p.agricultor_id = a.id;

-- 4. Itens detalhados de cada pedido 
SELECT i.pedido_id, s.nome_comercial, i.quantidade_solicitada
FROM itens_pedido i
JOIN lotes l ON i.lote_id = l.id
JOIN sementes s ON l.semente_id = s.id;

-- 5. Total de sementes cadastradas por categoria
SELECT c.nome, COUNT(s.id) as total_sementes
FROM categorias c
LEFT JOIN sementes s ON c.id = s.categoria_id
GROUP BY c.nome;

-- 6. Lotes que estão vencendo em 2025
SELECT codigo_lote, data_validade 
FROM lotes 
WHERE YEAR(data_validade) = 2025;

-- 7. Quem são os usuários que aprovaram pedidos
SELECT nome 
FROM usuarios 
WHERE id IN (SELECT usuario_responsavel_id FROM pedidos WHERE status != 'PENDENTE');

-- 8. Listar agricultores que fizeram pedidos CANCELADOS
SELECT DISTINCT a.nome_completo
FROM agricultores a
JOIN pedidos p ON a.id = p.agricultor_id
WHERE p.status = 'CANCELADO';

-- 9. Sementes que possuem estoque zerado 
SELECT s.nome_comercial
FROM sementes s
JOIN lotes l ON s.id = l.semente_id
WHERE l.qtd_atual < 10;

-- 10. Valor total de itens pedidos por semente 
SELECT s.nome_comercial, SUM(i.quantidade_solicitada) as total_saida
FROM itens_pedido i
JOIN lotes l ON i.lote_id = l.id
JOIN sementes s ON l.semente_id = s.id
GROUP BY s.nome_comercial;

-- 11. Fornecedores que forneceram sementes da categoria 'Grãos'
SELECT DISTINCT f.razao_social
FROM fornecedores f
JOIN lotes l ON f.id = l.fornecedor_id
JOIN sementes s ON l.semente_id = s.id
JOIN categorias c ON s.categoria_id = c.id
WHERE c.nome = 'Grãos';

-- 12. Histórico de mudanças do pedido 2
SELECT h.data_mudanca, h.status_anterior, h.status_novo, u.nome as usuario
FROM historico_status h
JOIN usuarios u ON h.usuario_id = u.id
WHERE h.pedido_id = 2;

-- 13. Média de estoque atual por fornecedor
SELECT f.razao_social, AVG(l.qtd_atual) as media_estoque
FROM lotes l
JOIN fornecedores f ON l.fornecedor_id = f.id
GROUP BY f.razao_social;

-- 14. Agricultores que nunca fizeram pedidos
SELECT a.nome_completo
FROM agricultores a
LEFT JOIN pedidos p ON a.id = p.agricultor_id
WHERE p.id IS NULL;

-- 15. Usuários do tipo ADMIN que nunca registraram pedidos
SELECT u.nome
FROM usuarios u
LEFT JOIN pedidos p ON u.id = p.usuario_responsavel_id
WHERE u.tipo_perfil = 'ADMIN' AND p.id IS NULL;

-- 16. Semente com maior quantidade em estoque 
SELECT s.nome_comercial, l.qtd_atual
FROM sementes s
JOIN lotes l ON s.id = l.semente_id
ORDER BY l.qtd_atual DESC LIMIT 1;

-- 17. Quantidade de pedidos por status
SELECT status, COUNT(*) as qtd
FROM pedidos
GROUP BY status;

-- 18. Detalhes completos: Pedido, Agricultor, Semente e Lote
SELECT p.id, a.nome_completo, s.nome_comercial, l.codigo_lote
FROM pedidos p
JOIN agricultores a ON p.agricultor_id = a.id
JOIN itens_pedido i ON p.id = i.pedido_id
JOIN lotes l ON i.lote_id = l.id
JOIN sementes s ON l.semente_id = s.id;

-- 19. Fornecedores com lotes vencidos (Comparação com data atual)
SELECT DISTINCT f.razao_social
FROM fornecedores f
JOIN lotes l ON f.id = l.fornecedor_id
WHERE l.data_validade < CURDATE();

-- 20. Selecionar último status de cada pedido (Subselect correlacionado)
SELECT p.id, (SELECT status_novo FROM historico_status WHERE pedido_id = p.id ORDER BY data_mudanca DESC LIMIT 1) as ultimo_historico
FROM pedidos p;