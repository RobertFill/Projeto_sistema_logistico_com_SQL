-- ============================================================================
-- SCRIPT 00: PREPARAÇÃO
-- ============================================================================
USE sist_logistico_alimenticio_db;

-- ============================================================================
-- SCRIPT 01: JOIN DE 2 TABELAS (FUNCIONÁRIOS E ESTOQUES).
-- ============================================================================
SELECT f.cpf AS cpf_funcionario,
       f.nome AS funcionario,
       f.cargo,
       e.nome AS estoque
FROM funcionario f
JOIN estoque e
  ON f.id_estoque = e.id_estoque;


-- ============================================================================
-- SCRIPT 02: JOIN DE 3 TABELAS (EXPEDIÇÕES, CLIENTES E TRANSPORTADORA)
-- ============================================================================
SELECT ex.nota_fiscal,
       ex.data_hora_expedicao,
       c.nome AS cliente,
       t.nome_motorista AS motorista,
       t.id_placa AS placa_veiculo
FROM expedicao ex
JOIN cliente c
  ON ex.cpf_cnpj_cliente = c.cpf_cnpj
JOIN transportadora t
  ON ex.id_placa_transportadora = t.id_placa;


-- ============================================================================
-- SCRIPT 03: JOIN DE 4 TABELAS (ITENS CONTIDOS NAS EXPEDIÇÕES)
-- ============================================================================
SELECT ex.nota_fiscal,
       c.nome AS cliente,
       p.nome AS produto,
       ct.quantidade
FROM expedicao ex
JOIN cliente c
  ON ex.cpf_cnpj_cliente = c.cpf_cnpj
JOIN contem ct
  ON ex.id_expedicao = ct.id_expedicao
JOIN produtos p
  ON ct.id_produto = p.id_produto
ORDER BY ex.nota_fiscal, ct.quantidade DESC;


-- ============================================================================
-- SCRIPT 04: AGREGAÇÃO - SUM + COUNT + GROUP BY
-- ============================================================================
SELECT ex.nota_fiscal,
       COUNT(ct.id_produto) AS qtd_itens_diferentes,
       SUM(ct.quantidade) AS total_unidades_expedidas
FROM expedicao ex
JOIN contem ct
  ON ex.id_expedicao = ct.id_expedicao
GROUP BY ex.nota_fiscal;


-- ============================================================================
-- SCRIPT 05: AGREGAÇÃO - COUNT + GROUP BY + HAVING
-- ============================================================================
SELECT c.nome AS cliente,
       COUNT(ex.id_expedicao) AS total_expedicoes
FROM cliente c
JOIN expedicao ex
  ON c.cpf_cnpj = ex.cpf_cnpj_cliente
GROUP BY c.nome
HAVING COUNT(ex.id_expedicao) > 1;


-- ============================================================================
-- SCRIPT 06: AGREGAÇÃO - COUNT + SUM + AVG + HAVING
-- ============================================================================
SELECT e.nome AS estoque,
       COUNT(a.id_produto) AS qtd_produtos,
       SUM(a.saldo) AS saldo_total,
       AVG(a.saldo) AS saldo_medio
FROM estoque e
JOIN armazena a
  ON e.id_estoque = a.id_estoque
GROUP BY e.nome
HAVING SUM(a.saldo) > 1000;


-- ============================================================================
-- SCRIPT 07: FILTROS - WHERE + LIKE + BETWEEN + ORDER BY
-- ============================================================================
SELECT nome,
       lote,
       validade
FROM produtos
WHERE nome LIKE '%kg%'
  AND validade BETWEEN '2027-01-01' AND '2027-12-31'
ORDER BY validade ASC;


-- ============================================================================
-- SCRIPT 08: GESTÃO DE VALIDADE - BETWEEN + JOIN
-- ============================================================================
SELECT p.nome AS produto,
       p.validade,
       SUM(a.saldo) AS saldo_em_estoque
FROM produtos p
JOIN armazena a
  ON p.id_produto = a.id_produto
WHERE p.validade BETWEEN '2026-10-27' AND '2027-04-25'
GROUP BY p.id_produto, p.nome, p.validade
ORDER BY p.validade ASC;


-- ============================================================================
-- SCRIPT 09: DML - UPDATE COM CHAVE COMPOSTA
-- ============================================================================
SELECT *
FROM armazena
WHERE id_produto = 1 AND id_estoque = 1;

UPDATE armazena
SET saldo = saldo - 50
WHERE id_produto = 1 AND id_estoque = 1;

SELECT *
FROM armazena
WHERE id_produto = 1 AND id_estoque = 1;


-- ============================================================================
-- SCRIPT 10: DML - INSERT + SELECT + DELETE
-- ============================================================================
INSERT INTO transportadora (id_placa, nome_motorista, matricula_motorista)
VALUES ('TST-0000', 'Motorista Teste', 'MT-99');

SELECT *
FROM transportadora
WHERE id_placa = 'TST-0000';

DELETE FROM transportadora
WHERE id_placa = 'TST-0000';

-- Deve retornar vazio
SELECT *
FROM transportadora
WHERE id_placa = 'TST-0000';


-- ============================================================================
-- SCRIPT 11: VIEW ESTRATÉGICA (PAINEL EXECUTIVO DE EXPEDIÇÕES)
-- ============================================================================
CREATE OR REPLACE VIEW vw_painel_expedicoes AS
SELECT ex.nota_fiscal,
       ex.data_hora_expedicao,
       c.nome AS cliente,
       t.nome_motorista AS motorista,
       f.nome AS funcionario_responsavel,
       COUNT(ct.id_produto) AS total_itens_diferentes,
       SUM(ct.quantidade) AS total_unidades
FROM expedicao ex
JOIN cliente c
  ON ex.cpf_cnpj_cliente = c.cpf_cnpj
JOIN transportadora t
  ON ex.id_placa_transportadora = t.id_placa
JOIN funcionario f
  ON ex.cpf_funcionario = f.cpf
JOIN contem ct
  ON ex.id_expedicao = ct.id_expedicao
GROUP BY ex.id_expedicao,
         ex.nota_fiscal,
         ex.data_hora_expedicao,
         c.nome,
         t.nome_motorista,
         f.nome;

SELECT * FROM vw_painel_expedicoes;