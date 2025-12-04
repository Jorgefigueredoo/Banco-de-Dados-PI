
-- SCRIPT DE POPULAÇÃO DE DADOS (DML) - CONECTAHUB


-- 1. LIMPEZA TOTAL (Evitando erro de duplicidade
SET FOREIGN_KEY_CHECKS = 0; 
TRUNCATE TABLE historico_status;
TRUNCATE TABLE itens_pedido;
TRUNCATE TABLE pedidos;
TRUNCATE TABLE lotes;
TRUNCATE TABLE sementes;
TRUNCATE TABLE usuarios;
TRUNCATE TABLE agricultores;
TRUNCATE TABLE fornecedores;
TRUNCATE TABLE categorias;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. INSERINDO DADOS

-- Tabela: Categorias
INSERT INTO categorias (nome, descricao) VALUES 
('Grãos', 'Cereais cultivados por seus grãos comestíveis'),
('Hortaliças', 'Plantas onde as partes comestíveis são folhas, talos ou raízes'),
('Frutíferas', 'Plantas que produzem frutos comestíveis'),
('Raízes e Tubérculos', 'Plantas com órgãos de reserva subterrâneos'),
('Leguminosas', 'Grãos que dão em vagens'),
('Forrageiras', 'Plantas para alimentação animal'),
('Oleaginosas', 'Plantas ricas em óleos'),
('Ornamentais', 'Plantas para decoração'),
('Medicinais', 'Plantas com propriedades curativas'),
('Condimentares', 'Ervas e especiarias para tempero'),
('Fibras', 'Plantas para produção de tecidos e cordas'),
('Florestais', 'Árvores para madeira e reflorestamento'),
('PANC', 'Plantas Alimentícias Não Convencionais'),
('Cereais de Inverno', 'Culturas de clima frio'),
('Frutas Tropicais', 'Frutas adaptadas ao calor'),
('Frutas Vermelhas', 'Morangos, amoras e framboesas'),
('Cítricos', 'Laranjas, limões e tangerinas'),
('Palmeiras', 'Coco, dendê e palmito'),
('Estimulantes', 'Café, cacau e guaraná'),
('Adubação Verde', 'Plantas para recuperação de solo');

-- Tabela: Fornecedores (CNPJs fictícios sequenciais para garantir unicidade)
INSERT INTO fornecedores (razao_social, cnpj, telefone, cidade) VALUES
('AgroSementes Ltda', '10.000.000/0001-01', '81999990001', 'Recife'),
('BioTecno Sul', '10.000.000/0001-02', '11988887777', 'São Paulo'),
('Cooperativa Verde', '10.000.000/0001-03', '8133334444', 'Caruaru'),
('Sementes do Agreste', '10.000.000/0001-04', '87999998888', 'Garanhuns'),
('Nacional Insumos', '10.000.000/0001-05', '6133332222', 'Brasília'),
('Terra Fértil S.A.', '10.000.000/0001-06', '31999991111', 'Belo Horizonte'),
('AgroVida', '10.000.000/0001-07', '41988882222', 'Curitiba'),
('Sementes Ouro Verde', '10.000.000/0001-08', '62977773333', 'Goiânia'),
('Plantação Futuro', '10.000.000/0001-09', '71966664444', 'Salvador'),
('Raízes do Campo', '10.000.000/0001-10', '85955555555', 'Fortaleza'),
('EcoSementes', '10.000.000/0001-11', '92944446666', 'Manaus'),
('Sul Agrícola', '10.000.000/0001-12', '51933337777', 'Porto Alegre'),
('Minas Grãos', '10.000.000/0001-13', '31922228888', 'Uberlândia'),
('Nordeste Verde', '10.000.000/0001-14', '83911119999', 'João Pessoa'),
('Cerrado Insumos', '10.000.000/0001-15', '65900001111', 'Cuiabá'),
('Pantanal Sementes', '10.000.000/0001-16', '67899992222', 'Campo Grande'),
('Amazonia Viva', '10.000.000/0001-17', '91888883333', 'Belém'),
('Vale do São Francisco', '10.000.000/0001-18', '87877774444', 'Petrolina'),
('AgroTech Solutions', '10.000.000/0001-19', '19866665555', 'Campinas'),
('Global Seeds', '10.000.000/0001-20', '21855556666', 'Rio de Janeiro');

-- Tabela: Agricultores (CPFs fictícios sequenciais)
INSERT INTO agricultores (nome_completo, cpf_cnpj, endereco_propriedade) VALUES
('João da Silva', '111.111.111-01', 'Sítio Novo, Zona Rural'),
('Maria Oliveira', '111.111.111-02', 'Fazenda Alegria, km 10'),
('Pedro Santos', '111.111.111-03', 'Assentamento Terra Prometida'),
('Ana Costa', '111.111.111-04', 'Sítio Riacho Fundo'),
('Carlos Pereira', '111.111.111-05', 'Estrada Velha, 500'),
('Fernanda Lima', '111.111.111-06', 'Chácara das Flores'),
('Roberto Almeida', '111.111.111-07', 'Sítio Boa Esperança'),
('Juliana Souza', '111.111.111-08', 'Fazenda Santa Rita'),
('Marcos Rocha', '111.111.111-09', 'Sítio Vale Verde'),
('Patrícia Dias', '111.111.111-10', 'Assentamento Nova Vida'),
('Lucas Mendes', '111.111.111-11', 'Fazenda São José'),
('Camila Nunes', '111.111.111-12', 'Sítio Recanto Feliz'),
('Ricardo Gomes', '111.111.111-13', 'Estrada do Campo, 20'),
('Beatriz Lopes', '111.111.111-14', 'Chácara Primavera'),
('Gabriel Martins', '111.111.111-15', 'Fazenda Sol Nascente'),
('Vanessa Cardoso', '111.111.111-16', 'Sítio Água Limpa'),
('Felipe Barbosa', '111.111.111-17', 'Assentamento 17 de Abril'),
('Larissa Ferreira', '111.111.111-18', 'Sítio Morro Alto'),
('Eduardo Ribeiro', '111.111.111-19', 'Fazenda Bela Vista'),
('Renata Castro', '111.111.111-20', 'Chácara Sossego');

-- Tabela: Usuarios
INSERT INTO usuarios (nome, email, senha, tipo_perfil) VALUES
('Admin Geral', 'admin@conectahub.com', '123456', 'ADMIN'),
('Operador 1', 'op1@conectahub.com', '123456', 'OPERADOR'),
('Operador 2', 'op2@conectahub.com', '123456', 'OPERADOR'),
('Tecnico Campo', 'tec@conectahub.com', '123456', 'OPERADOR'),
('Supervisor', 'sup@conectahub.com', '123456', 'ADMIN'),
('João Agricultor', 'joao@gmail.com', '123456', 'AGRICULTOR'),
('Maria Agricultora', 'maria@gmail.com', '123456', 'AGRICULTOR'),
('Gerente Estoque', 'estoque@conectahub.com', '123456', 'OPERADOR'),
('Analista Dados', 'dados@conectahub.com', '123456', 'ADMIN'),
('Suporte TI', 'suporte@conectahub.com', '123456', 'ADMIN'),
('Operador 3', 'op3@conectahub.com', '123456', 'OPERADOR'),
('Operador 4', 'op4@conectahub.com', '123456', 'OPERADOR'),
('Pedro Agricultor', 'pedro@gmail.com', '123456', 'AGRICULTOR'),
('Ana Agricultora', 'ana@gmail.com', '123456', 'AGRICULTOR'),
('Auditor', 'auditor@conectahub.com', '123456', 'ADMIN'),
('Estagiario', 'estagio@conectahub.com', '123456', 'OPERADOR'),
('Coordenador', 'coord@conectahub.com', '123456', 'ADMIN'),
('Operador Noturno', 'op_noite@conectahub.com', '123456', 'OPERADOR'),
('Logistica', 'log@conectahub.com', '123456', 'OPERADOR'),
('Diretor', 'diretor@conectahub.com', '123456', 'ADMIN');

-- Tabela: Sementes
INSERT INTO sementes (nome_comercial, nome_cientifico, instrucoes_plantio, categoria_id) VALUES
('Milho Crioulo', 'Zea mays', 'Plantar no início das chuvas', 1),
('Feijão Carioca', 'Phaseolus vulgaris', 'Solo úmido e bem drenado', 5),
('Alface Crespa', 'Lactuca sativa', 'Meia sombra, rega constante', 2),
('Mandioca Mansa', 'Manihot esculenta', 'Solo arenoso e profundo', 4),
('Tomate Cereja', 'Solanum lycopersicum', 'Necessita tutoramento', 2),
('Arroz Agulhinha', 'Oryza sativa', 'Solo alagado ou úmido', 1),
('Soja Convencional', 'Glycine max', 'Pleno sol', 1),
('Trigo Panificável', 'Triticum aestivum', 'Clima ameno', 1),
('Cenoura Nantes', 'Daucus carota', 'Solo fofo sem pedras', 2),
('Abóbora Menina', 'Cucurbita moschata', 'Espaçamento largo', 2),
('Melancia Crimson', 'Citrullus lanatus', 'Solo arenoso', 3),
('Maracujá Azedo', 'Passiflora edulis', 'Precisa de espaldeira', 3),
('Banana Prata', 'Musa spp.', 'Clima tropical úmido', 3),
('Batata Doce Roxa', 'Ipomoea batatas', 'Rustica, pouco exigente', 4),
('Inhame', 'Dioscorea spp.', 'Solo fértil', 4),
('Girassol', 'Helianthus annuus', 'Pleno sol', 7),
('Café Arábica', 'Coffea arabica', 'Altitude elevada', 19),
('Cacau', 'Theobroma cacao', 'Sombra de outras árvores', 19),
('Eucalipto', 'Eucalyptus spp.', 'Reflorestamento rápido', 12),
('Hortelã Pimenta', 'Mentha piperita', 'Solo úmido', 9);

-- Tabela: Lotes
INSERT INTO lotes (codigo_lote, qtd_inicial, qtd_atual, data_validade, semente_id, fornecedor_id) VALUES
('LOT-25-001', 100, 100, '2026-12-31', 1, 1),
('LOT-25-002', 200, 150, '2026-06-30', 2, 2),
('LOT-25-003', 50, 50, '2025-08-15', 3, 3),
('LOT-25-004', 300, 280, '2027-01-01', 4, 1),
('LOT-25-005', 150, 150, '2025-12-25', 5, 4),
('LOT-25-006', 500, 500, '2026-11-20', 6, 5),
('LOT-25-007', 1000, 950, '2026-10-10', 7, 6),
('LOT-25-008', 400, 400, '2027-02-28', 8, 7),
('LOT-25-009', 120, 100, '2025-09-09', 9, 8),
('LOT-25-010', 80, 80, '2025-11-11', 10, 9),
('LOT-25-011', 60, 0, '2024-12-31', 11, 10), -- Lote zerado/vencido
('LOT-25-012', 90, 90, '2026-03-15', 12, 11),
('LOT-25-013', 200, 180, '2026-04-20', 13, 12),
('LOT-25-014', 350, 350, '2027-05-05', 14, 13),
('LOT-25-015', 150, 140, '2026-07-07', 15, 14),
('LOT-25-016', 75, 75, '2025-10-30', 16, 15),
('LOT-25-017', 500, 400, '2028-01-01', 17, 16),
('LOT-25-018', 300, 300, '2027-12-12', 18, 17),
('LOT-25-019', 1000, 1000, '2030-01-01', 19, 18),
('LOT-25-020', 40, 40, '2025-06-01', 20, 19);

-- Tabela: Pedidos
INSERT INTO pedidos (data_pedido, status, agricultor_id, usuario_responsavel_id) VALUES
(NOW(), 'PENDENTE', 1, 2),
(NOW(), 'ENTREGUE', 2, 2),
(NOW(), 'APROVADO', 3, 3),
(NOW(), 'CANCELADO', 4, 2),
(NOW(), 'PENDENTE', 5, 3),
(NOW(), 'ENTREGUE', 6, 4),
(NOW(), 'PENDENTE', 7, 2),
(NOW(), 'APROVADO', 8, 3),
(NOW(), 'ENTREGUE', 9, 4),
(NOW(), 'CANCELADO', 10, 2),
(NOW(), 'PENDENTE', 11, 3),
(NOW(), 'APROVADO', 12, 4),
(NOW(), 'ENTREGUE', 13, 2),
(NOW(), 'PENDENTE', 14, 3),
(NOW(), 'PENDENTE', 15, 4),
(NOW(), 'APROVADO', 16, 2),
(NOW(), 'ENTREGUE', 17, 3),
(NOW(), 'CANCELADO', 18, 4),
(NOW(), 'ENTREGUE', 19, 2),
(NOW(), 'APROVADO', 20, 3);

-- Tabela: Itens Pedido
INSERT INTO itens_pedido (quantidade_solicitada, pedido_id, lote_id) VALUES
(10, 1, 1), (5, 1, 2), -- Pedido 1
(20, 2, 4), -- Pedido 2
(2, 3, 3), -- Pedido 3
(50, 4, 1), -- Pedido 4
(5, 5, 5),
(10, 6, 6),
(5, 7, 7),
(8, 8, 8),
(20, 9, 9),
(10, 10, 10),
(15, 11, 11),
(5, 12, 12),
(20, 13, 13),
(10, 14, 14),
(5, 15, 15),
(5, 16, 16),
(100, 17, 17),
(5, 18, 18),
(50, 19, 1), -- Lote 1 de novo
(10, 20, 2);

-- Tabela: Historico Status
INSERT INTO historico_status (status_anterior, status_novo, pedido_id, usuario_id) VALUES
(NULL, 'PENDENTE', 1, 2),
('PENDENTE', 'APROVADO', 2, 3),
('APROVADO', 'ENTREGUE', 2, 3),
(NULL, 'PENDENTE', 3, 3),
(NULL, 'PENDENTE', 4, 2),
('PENDENTE', 'CANCELADO', 4, 2),
(NULL, 'PENDENTE', 5, 3),
('PENDENTE', 'APROVADO', 6, 4),
('APROVADO', 'ENTREGUE', 6, 4),
(NULL, 'PENDENTE', 7, 2),
(NULL, 'PENDENTE', 8, 3),
('PENDENTE', 'APROVADO', 8, 3),
('APROVADO', 'ENTREGUE', 9, 4),
('PENDENTE', 'CANCELADO', 10, 2),
(NULL, 'PENDENTE', 11, 3),
('PENDENTE', 'APROVADO', 12, 4),
('APROVADO', 'ENTREGUE', 13, 2),
(NULL, 'PENDENTE', 14, 3),
(NULL, 'PENDENTE', 15, 4),
('PENDENTE', 'APROVADO', 16, 2),
('APROVADO', 'ENTREGUE', 17, 3),
('PENDENTE', 'CANCELADO', 18, 4),
('APROVADO', 'ENTREGUE', 19, 2),
('PENDENTE', 'APROVADO', 20, 3);