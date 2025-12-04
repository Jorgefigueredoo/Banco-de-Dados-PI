CREATE DATABASE conectahub;
USE conectahub;

-- 2. Tabela Categorias
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabela de Fornecedores
CREATE TABLE fornecedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(150) NOT NULL,
    cnpj VARCHAR(20) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    cidade VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tabela de Agricultores
CREATE TABLE agricultores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    cpf_cnpj VARCHAR(20) UNIQUE NOT NULL,
    endereco_propriedade TEXT,
    telefone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Tabela de Usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_perfil ENUM('ADMIN', 'OPERADOR', 'AGRICULTOR') NOT NULL,
    agricultor_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (agricultor_id) REFERENCES agricultores(id)
);

-- 6. Tabela Sementes (Catálogo)
CREATE TABLE sementes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_comercial VARCHAR(100) NOT NULL,
    nome_cientifico VARCHAR(100),
    instrucoes_plantio TEXT,
    categoria_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- 7. Tabela Lotes (Estoque)
CREATE TABLE lotes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_lote VARCHAR(50) UNIQUE NOT NULL,
    qtd_inicial INT NOT NULL,
    qtd_atual INT NOT NULL,
    data_validade DATE NOT NULL,
    semente_id INT NOT NULL,
    fornecedor_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (semente_id) REFERENCES sementes(id),
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
);

-- 8. Tabela Pedidos 
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Esse fica automático
    status VARCHAR(50) DEFAULT 'PENDENTE',
    agricultor_id INT NOT NULL,
    usuario_responsavel_id INT,
    created_at DATETIME,
    FOREIGN KEY (agricultor_id) REFERENCES agricultores(id),
    FOREIGN KEY (usuario_responsavel_id) REFERENCES usuarios(id)
);

-- 9. Tabela Itens do Pedido
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantidade_solicitada INT NOT NULL,
    pedido_id INT NOT NULL,
    lote_id INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (lote_id) REFERENCES lotes(id)
);

-- 10. Tabela Histórico de Status
CREATE TABLE historico_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_mudanca TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_anterior VARCHAR(50),
    status_novo VARCHAR(50),
    pedido_id INT NOT NULL,
    usuario_id INT,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);