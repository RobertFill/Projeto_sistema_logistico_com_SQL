-- 1. CRIAÇÃO DO BANCO DE DADOS
-- =============================================================================
CREATE DATABASE IF NOT EXISTS sist_logistico_alimenticio_db;
USE sist_logistico_alimenticio_db;
-- ============================================================================
-- 2. TABELA PRODUTOS
-- =============================================================================
-- CREATE TABLE (DDL): define colunas, tipos e regras (restrições).
CREATE TABLE produtos (
    -- INT: número inteiro | AUTO_INCREMENT: o MySQL gera 1, 2, 3... sozinho
    -- PRIMARY KEY: identificador único e obrigatório de cada produto
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    -- VARCHAR(100): texto de até 100 caracteres | NOT NULL: preenchimento obrigatório
    nome VARCHAR(100) NOT NULL,
    -- Lote: código de rastreabilidade (essencial em alimentos, para recall)
    lote VARCHAR(20) NOT NULL,
    -- DATE: guarda apenas a data (AAAA-MM-DD). Controla o vencimento.
    validade DATE NOT NULL
);

-- INSERT (DML): adiciona linhas. Listamos as colunas e passamos os valores na mesma ordem
INSERT INTO produtos (nome, lote, validade) VALUES
('Feijão Carioca 1Kg', 'LOTE-GRA-14', '2027-08-14'),                  -- id 1
('Arroz Branco Tipo 1 5Kg', 'LOTE-GRA-10', '2027-10-16'),             -- id 2
('Queijo Mussarela 4kg', 'LOTE-LTI-01', '2028-11-10'),                -- id 3
('Carne Bovina Picanha 1,5kg', 'LOTE-CAR-04', '2028-09-11'),          -- id 4
('Peito de Frango Congelado 1kg', 'LOTE-CAR-08', '2027-02-15'),       -- id 5
('Iogurte de Morango 1,5kg', 'LOTE-LTI-06', '2026-12-18'),            -- id 6
('Biscoito Água e Sal 350g', 'LOTE-BIS-26', '2027-08-17'),            -- id 7
('Leite Condensado Semidesnatado 395g', 'LOTE-LTI-55', '2027-09-20'); -- id 8

SELECT * FROM produtos;
-- =============================================================================
-- 3. TABELA ESTOQUE 
-- =============================================================================
CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,   -- PK gerada automaticamente
    nome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(150)                     
);

INSERT INTO estoque (nome, localizacao) VALUES
('Depósito de Grãos e Secos A1', 'Galpão A - São José dos Campos - São Paulo'),   -- id 1
('Câmara de Congelados B2', 'Galpão B - São José dos Campos - São Paulo'),        -- id 2
('Câmara Fria de Laticínios C3', 'Galpão C - São José dos Campos - São Paulo'),   -- id 3
('Câmara Fria de Carnes D4', 'Galpão D - São José dos Campos - São Paulo');       -- id 4
-- =============================================================================
-- 4. TABELA FORNECEDOR
-- =============================================================================
CREATE TABLE fornecedor (
    id_cnpj CHAR(18) PRIMARY KEY,
    razao_social VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
INSERT INTO fornecedor (id_cnpj, razao_social, telefone, endereco, email) VALUES
('10.660.509/0001-55', 'Cereais e Grãos Vale da Mantiqueira', '(11) 94768-5513', 'Rua Pedro Alves, 201', 'cereiasegraos@gmail.com'),
('11.050.510/0001-80', 'Ponto Frio LTDA', '(11) 94768-4428', 'Rua Limoeira, 255', 'pontofrio@gmail.com'),
('11.090.820/0001-66', 'Italac LTDA', '(11) 94764-4502', 'Rua Vaca Dourada, 622', 'italac@gmail.com'),
('11.045.790/0001-35', 'Bauduco', '(11) 94764-4502', 'Rua José Sarney, 622', 'bauducobiscoitos@outlook.com');

-- SELECT * (DQL): lista todas as colunas e linhas. Usado aqui só para CONFERIR a carga.
SELECT * FROM fornecedor;
-- =============================================================================
-- 5. TABELA TRANSPORTADORA (veículo + motorista)
-- ============================================================================
CREATE TABLE transportadora (
    id_placa VARCHAR(10) PRIMARY KEY,            -- a placa identifica o veículo (PK natural)
    nome_motorista VARCHAR(100) NOT NULL,
    matricula_motorista VARCHAR(20)              
);

-- DADOS DA TABELA TRANSPORTADORA -- 
INSERT INTO transportadora (id_placa, nome_motorista, matricula_motorista) VALUES
('TRA-3507', 'Fabiano Lima', 'MT-01'),
('XYZ-9876', 'Julio Aparecido', 'MT-02'),
('FSA-5040', 'Alejandro Gonçalo', 'MT-03'),
('MSA-9870', 'Alexandre Nascimento', 'MT-04'),
('RVA-6060', 'Felipe Santos', 'MT-05'),
('PPR-1202', 'Jefferson Lima', 'MT-06'),
('UBA-7803', 'Roberto Soares', 'MT-07'),
('ARG-0895', 'Ricardo Teixeira', 'MT-08');

SELECT * FROM transportadora;  
-- =============================================================================
-- 6. TABELA CLIENTE (quem compra: supermercados)
-- =============================================================================
CREATE TABLE cliente (
    cpf_cnpj VARCHAR(18) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL
);
INSERT INTO cliente (cpf_cnpj, nome, endereco, telefone, email) VALUES
('11.222.333/0001-44', 'Supermercado Central S.A.', 'Av. Paulista, 1000', '(11) 97777-2222', 'compras@supercentral.com'),
('55.666.777/0001-88', 'Hortifruti & Mercadinho Mogi LTDA', 'Rua Central, 50', '(11) 96666-1111', 'contato@mercadomogi.com'),
('44.555.666/0001-22', 'Supermercado Assaí LTDA', 'Vila Mogilar, 20', '(11) 96666-1111', 'supermercadoassai@mercadomogi.com'),
('33.444.555/0001-11', 'Mercado Jacomé', 'Vila Natal, 30', '(11) 96666-1111', 'supermercadojacome@outlook.com');
SELECT * FROM cliente;
-- =============================================================================
-- 7. TABELA FUNCIONARIO  (primeira tabela com FOREIGN KEY)
-- =============================================================================
CREATE TABLE funcionario (
    cpf CHAR(14) PRIMARY KEY,                
    nome VARCHAR(100) NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL,      
    cargo VARCHAR(50) NOT NULL,
    id_estoque INT NOT NULL,                     
    -- FOREIGN KEY: garante INTEGRIDADE REFERENCIAL. Só aceita um id_estoque que
    -- JÁ EXISTA na tabela estoque. Impede "funcionário de um estoque fantasma".
    FOREIGN KEY (id_estoque) REFERENCES estoque(id_estoque)
);
-- Regra de negócio do modelo (cardinalidade 1,n): todo estoque tem pelo menos 1 funcionário.
INSERT INTO funcionario (cpf, nome, matricula, cargo, id_estoque) VALUES
('111.222.333-44', 'Carlos Pereira', 'MAT2026', 'Auxiliar de Expedição', 1),
('222.333.444-55', 'Mariana Souza', 'MAT2027', 'Supervisora de Cold Chain', 2),
('333.444.555-66', 'Paulo Henrique Lima', 'MAT2028', 'Auxiliar de Estoque', 3),
('444.555.666-77', 'Fernanda Alves', 'MAT2029', 'Operadora de Câmara Fria', 4);
-- =============================================================================
-- 8. TABELA EXPEDICAO (a "saída" de mercadoria; liga 3 tabelas por FK)
-- =============================================================================
CREATE TABLE expedicao (
    id_expedicao INT AUTO_INCREMENT PRIMARY KEY,
    nota_fiscal VARCHAR(50) UNIQUE NOT NULL,     -- cada NF é única
    boleto VARCHAR(50) NOT NULL,
    data_hora_expedicao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cpf_funcionario CHAR(14) NOT NULL,           -- quem conferiu/expediu (FK -> funcionario)
    id_placa_transportadora VARCHAR(10) NOT NULL,-- qual veículo levou (FK -> transportadora)
    cpf_cnpj_cliente VARCHAR(18) NOT NULL,       -- quem recebeu (FK -> cliente)
    -- Os tipos das colunas FK devem ser IGUAIS aos das PKs que elas referenciam.
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionario(cpf),
    FOREIGN KEY (id_placa_transportadora) REFERENCES transportadora(id_placa),
    FOREIGN KEY (cpf_cnpj_cliente) REFERENCES cliente(cpf_cnpj)
);

INSERT INTO expedicao (nota_fiscal, boleto, data_hora_expedicao, cpf_funcionario, id_placa_transportadora, cpf_cnpj_cliente) VALUES
('NF-001', 'BOL-1001', '2026-10-21 09:30:00', '111.222.333-44', 'TRA-3507', '11.222.333/0001-44'),  -- id 1
('NF-002', 'BOL-1002', '2026-10-21 11:15:00', '222.333.444-55', 'XYZ-9876', '55.666.777/0001-88'),  -- id 2
('NF-003', 'BOL-1003', '2026-10-22 08:45:00', '111.222.333-44', 'TRA-3507', '11.222.333/0001-44');  -- id 3

SELECT * FROM expedicao;  
-- =============================================================================
-- 9. TABELAS DE RELACIONAMENTO N:N (tabelas associativas)
-- =============================================================================
-- PRODUTO_FORNECEDOR
CREATE TABLE produto_fornecedor (
    id_produto INT,
    id_cnpj_fornecedor CHAR(18),
    PRIMARY KEY (id_produto, id_cnpj_fornecedor),   -- PK composta
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_cnpj_fornecedor) REFERENCES fornecedor(id_cnpj)
);

INSERT INTO produto_fornecedor (id_produto, id_cnpj_fornecedor) VALUES
(1, '10.660.509/0001-55'),  -- Feijão          <- Cereais e Grãos
(2, '10.660.509/0001-55'),  -- Arroz           <- Cereais e Grãos
(3, '11.090.820/0001-66'),  -- Queijo          <- Italac
(4, '11.050.510/0001-80'),  -- Picanha         <- Ponto Frio
(5, '11.050.510/0001-80'),  -- Peito de Frango <- Ponto Frio
(6, '11.090.820/0001-66'),  -- Iogurte         <- Italac
(7, '11.045.790/0001-35'),  -- Biscoito        <- Bauduco
(8, '11.090.820/0001-66');  -- Leite Condensado<- Italac

SELECT * FROM produto_fornecedor;

-- ABASTECE: quais fornecedores abastecem quais estoques
CREATE TABLE abastece (
    id_cnpj_fornecedor CHAR(18),
    id_estoque INT,
    PRIMARY KEY (id_cnpj_fornecedor, id_estoque),
    FOREIGN KEY (id_cnpj_fornecedor) REFERENCES fornecedor(id_cnpj),
    FOREIGN KEY (id_estoque) REFERENCES estoque(id_estoque)
);

INSERT INTO abastece (id_cnpj_fornecedor, id_estoque) VALUES
('10.660.509/0001-55', 1),  -- Cereais e Grãos -> Depósito de Grãos e Secos
('11.045.790/0001-35', 1),  -- Bauduco         -> Depósito de Grãos e Secos
('11.050.510/0001-80', 2),  -- Ponto Frio      -> Câmara de Congelados
('11.050.510/0001-80', 4),  -- Ponto Frio      -> Câmara Fria de Carnes
('11.090.820/0001-66', 3);  -- Italac          -> Câmara Fria de Laticínios

SELECT * FROM abastece;

-- ARMAZENA: quais produtos estão em quais estoques E em que quantidade (saldo)
CREATE TABLE armazena (
    id_produto INT,
    id_estoque INT,
    saldo INT NOT NULL DEFAULT 0,   
    PRIMARY KEY (id_produto, id_estoque),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_estoque) REFERENCES estoque(id_estoque)
);


INSERT INTO armazena (id_produto, id_estoque, saldo) VALUES
(1, 1, 1500),  -- Feijão no Estoque Seco
(2, 1, 300),   -- Arroz no Estoque Seco
(3, 2, 450),   -- Queijo no estoque 
(4, 2, 600),   -- Picanha no estoque 
(5, 2, 200),   -- Frango no estoque 
(6, 2, 350),   -- Iogurte no estoque 
(7, 1, 900),   -- Biscoito no Estoque Seco
(8, 3, 700);   -- Leite Condensado na Câmara de Laticínios

SELECT * FROM armazena;

-- CONTEM: itens de cada expedição 
CREATE TABLE contem (
    id_produto INT,
    id_expedicao INT,
    quantidade INT NOT NULL,        -- quantas unidades daquele produto naquela expedição
    PRIMARY KEY (id_produto, id_expedicao),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_expedicao) REFERENCES expedicao(id_expedicao)
);

-- Cada linha = um item (produto) dentro de uma expedição.
INSERT INTO contem (id_produto, id_expedicao, quantidade) VALUES
(1, 1, 200),  -- NF-001: 200 un. de Feijão
(2, 1, 50),   -- NF-001: 50 un. de Arroz
(3, 2, 30),   -- NF-002: 30 un. de Queijo
(2, 3, 40),   -- NF-003: 40 un. de Arroz
(1, 3, 100);  -- NF-003: 100 un. de Feijão

SELECT * FROM contem;
