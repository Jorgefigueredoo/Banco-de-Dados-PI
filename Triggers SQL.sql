DELIMITER $$

-- 1. Trigger: Before Insert Pedido - Garantir usuário
CREATE TRIGGER trg_check_usuario_pedido BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.usuario_responsavel_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Todo pedido precisa de um usuário responsável';
    END IF;
END $$

-- 2. Trigger: After Insert Pedido - Log automático no Histórico
CREATE TRIGGER trg_log_novo_pedido AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    INSERT INTO historico_status (status_anterior, status_novo, pedido_id, usuario_id)
    VALUES (NULL, NEW.status, NEW.id, NEW.usuario_responsavel_id);
END $$

-- 3. Trigger: After Update Pedido Log de mudança de status
CREATE TRIGGER trg_log_update_pedido AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO historico_status (status_anterior, status_novo, pedido_id, usuario_id)
        VALUES (OLD.status, NEW.status, NEW.id, NEW.usuario_responsavel_id);
    END IF;
END $$

-- 4. Trigger: Before Insert Lote - Validade deve ser futura
CREATE TRIGGER trg_check_validade_lote BEFORE INSERT ON lotes
FOR EACH ROW
BEGIN
    IF NEW.data_validade <= CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A validade do lote deve ser futura';
    END IF;
END $$

-- 5. Trigger: Before Insert Itens - Não vender se vencido
CREATE TRIGGER trg_check_item_vencido BEFORE INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    DECLARE v_validade DATE;
    SELECT data_validade INTO v_validade FROM lotes WHERE id = NEW.lote_id;
    IF v_validade < CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido adicionar item de lote vencido';
    END IF;
END $$

-- 6. Trigger: Before Delete Agricultor - Bloquear se tiver pedidos
CREATE TRIGGER trg_block_del_agricultor BEFORE DELETE ON agricultores
FOR EACH ROW
BEGIN
    DECLARE qtd INT;
    SELECT COUNT(*) INTO qtd FROM pedidos WHERE agricultor_id = OLD.id;
    IF qtd > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode excluir agricultor com pedidos registrados';
    END IF;
END $$

-- 7. Trigger: Before Insert Agricultor - Nome em Maiúsculo
CREATE TRIGGER trg_upper_agricultor BEFORE INSERT ON agricultores
FOR EACH ROW
BEGIN
    SET NEW.nome_completo = UPPER(NEW.nome_completo);
END $$

-- 8. Trigger: Before Update Agricultor Nome em Maiúsculo
CREATE TRIGGER trg_upper_agricultor_upd BEFORE UPDATE ON agricultores
FOR EACH ROW
BEGIN
    SET NEW.nome_completo = UPPER(NEW.nome_completo);
END $$

-- 9. Trigger: Before Insert Usuario - Email minúsculo
CREATE TRIGGER trg_lower_email_user BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
    SET NEW.email = LOWER(NEW.email);
END $$

-- 10. Trigger: After Delete Itens - Devolver ao estoque se item for deletado
CREATE TRIGGER trg_estorno_estoque AFTER DELETE ON itens_pedido
FOR EACH ROW
BEGIN
    UPDATE lotes SET qtd_atual = qtd_atual + OLD.quantidade_solicitada WHERE id = OLD.lote_id;
END $$

-- 11. Trigger: Descrição Padrão se vazia
CREATE TRIGGER trg_default_desc_cat BEFORE INSERT ON categorias
FOR EACH ROW
BEGIN
    IF NEW.descricao IS NULL OR NEW.descricao = '' THEN
        SET NEW.descricao = 'Descrição não informada';
    END IF;
END $$

-- 12. Trigger: Before Update Lote (Impedir aumentar estoque "do nada" sem justificativa)
CREATE TRIGGER trg_prevent_negativo BEFORE UPDATE ON lotes
FOR EACH ROW
BEGIN
    IF NEW.qtd_atual < 0 THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque não pode ficar negativo';
    END IF;
END $$

DELIMITER ;