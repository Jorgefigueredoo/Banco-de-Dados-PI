DELIMITER $$

-- 1. Func: Contar Estoque Total de uma Semente
CREATE FUNCTION fn_estoque_total_semente(p_semente_id INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(qtd_atual) INTO total FROM lotes WHERE semente_id = p_semente_id;
    RETURN IFNULL(total, 0);
END $$

-- 2. Func: Verificar se Lote está Vencido
CREATE FUNCTION fn_is_vencido(p_lote_id INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE validade DATE;
    SELECT data_validade INTO validade FROM lotes WHERE id = p_lote_id;
    IF validade < CURDATE() THEN RETURN 1; ELSE RETURN 0; END IF;
END $$

-- 3. Func: Contar Pedidos de um Agricultor
CREATE FUNCTION fn_count_pedidos(p_agric_id INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE qtd INT;
    SELECT COUNT(*) INTO qtd FROM pedidos WHERE agricultor_id = p_agric_id;
    RETURN qtd;
END $$

-- 4. Func: Obter Nome do Agricultor pelo ID
CREATE FUNCTION fn_get_nome_agricultor(p_id INT) RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
    DECLARE v_nome VARCHAR(150);
    SELECT nome_completo INTO v_nome FROM agricultores WHERE id = p_id;
    RETURN v_nome;
END $$

-- 5. Proc: Cadastrar Novo Agricultor (Simples)
CREATE PROCEDURE sp_novo_agricultor(IN p_nome VARCHAR(150), IN p_cpf VARCHAR(20))
BEGIN
    INSERT INTO agricultores (nome_completo, cpf_cnpj) VALUES (p_nome, p_cpf);
END $$

-- 6. Proc: Criar Novo Pedido (Retorna ID criado)
CREATE PROCEDURE sp_criar_pedido(IN p_agric_id INT, IN p_user_id INT, OUT p_novo_id INT)
BEGIN
    INSERT INTO pedidos (agricultor_id, usuario_responsavel_id, status) VALUES (p_agric_id, p_user_id, 'PENDENTE');
    SET p_novo_id = LAST_INSERT_ID();
END $$

-- 7. Proc: Adicionar Item ao Pedido (Baixa Estoque)
CREATE PROCEDURE sp_add_item_pedido(IN p_pedido_id INT, IN p_lote_id INT, IN p_qtd INT)
BEGIN
    DECLARE v_estoque INT;
    SELECT qtd_atual INTO v_estoque FROM lotes WHERE id = p_lote_id;
    
    IF v_estoque >= p_qtd THEN
        INSERT INTO itens_pedido (pedido_id, lote_id, quantidade_solicitada) VALUES (p_pedido_id, p_lote_id, p_qtd);
        UPDATE lotes SET qtd_atual = qtd_atual - p_qtd WHERE id = p_lote_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para este lote';
    END IF;
END $$

-- 8. Proc: Atualizar Status do Pedido
CREATE PROCEDURE sp_atualiza_status(IN p_pedido_id INT, IN p_novo_status VARCHAR(50), IN p_user_id INT)
BEGIN
    UPDATE pedidos SET status = p_novo_status, usuario_responsavel_id = p_user_id WHERE id = p_pedido_id;
END $$

-- 9. Func: Formatar CPF
CREATE FUNCTION fn_format_texto(p_texto VARCHAR(100)) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    RETURN UPPER(TRIM(p_texto));
END $$

-- 10. Proc: Deletar Pedido (Se estiver pendente)
CREATE PROCEDURE sp_delete_pedido_pendente(IN p_id INT)
BEGIN
    DECLARE v_status VARCHAR(50);
    SELECT status INTO v_status FROM pedidos WHERE id = p_id;
    IF v_status = 'PENDENTE' THEN
        DELETE FROM itens_pedido WHERE pedido_id = p_id;
        DELETE FROM pedidos WHERE id = p_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Apenas pedidos pendentes podem ser excluídos';
    END IF;
END $$

-- 11. Proc: Reajustar Quantidade Lote 
CREATE PROCEDURE sp_correcao_estoque(IN p_lote_id INT, IN p_nova_qtd INT)
BEGIN
    UPDATE lotes SET qtd_atual = p_nova_qtd WHERE id = p_lote_id;
END $$

-- 12. Func: Calcular Dias para Vencimento
CREATE FUNCTION fn_dias_vencimento(p_lote_id INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_data DATE;
    SELECT data_validade INTO v_data FROM lotes WHERE id = p_lote_id;
    RETURN DATEDIFF(v_data, CURDATE());
END $$

-- 13. Proc: Relatório Rápido por Categoria (Select dentro de Proc)
CREATE PROCEDURE sp_relatorio_categoria(IN p_cat_id INT)
BEGIN
    SELECT * FROM sementes WHERE categoria_id = p_cat_id;
END $$

-- 14. Proc: Clonar Pedido (Para facilitar repetição)
CREATE PROCEDURE sp_clonar_pedido(IN p_pedido_origem INT)
BEGIN
    INSERT INTO pedidos (agricultor_id, usuario_responsavel_id, status)
    SELECT agricultor_id, usuario_responsavel_id, 'PENDENTE' FROM pedidos WHERE id = p_pedido_origem;
END $$

DELIMITER ;