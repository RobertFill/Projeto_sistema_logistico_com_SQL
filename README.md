# 🚚 Sistema Logístico Alimentício com SQL

Bem-vindo ao repositório/pacote do **Sistema Logístico Alimentício**. Este projeto contém a modelagem, o dicionário de dados e os scripts SQL para implementação e gestão da cadeia logística voltada ao setor alimentício.

---

## 📂 Estrutura do Pacote

O arquivo compactado contém todos os artefatos necessários para entender, executar e documentar a base de dados:

```text
Projeto_sistema_logistico_com_SQL-main/
│
├── 📁 Br.Modelo/
│   ├── SITEMA_LOGSTICO_ALIMENTICIOS.brM3   # Modelagem conceitual/lógica (editável no brModelo)
│   └── SITEMA_LOGSTICO_ALIMENTICIOS.png    # Diagrama de Entidade-Relacionamento (DER) em imagem
│
├── 📊 Dicionario_de_Dados_Sistema_Logistica_Alimenticio_Atualizado.xlsx  # Tabela detalhada das colunas, tipos e relacionamentos
├── 📜 Scripts certo.sql                         # Script principal com DDL e inserções de dados
├── 📜 sistema_logistico_alimenticio_COMENTADO.sql # Script SQL detalhado e comentado para estudo
└── 📄 README.md                                 # Documentação do projeto
```

---

## 🚀 Como Executar o Projeto

### 1. Visualizar a Modelagem de Dados
* **Imagem:** Abra o arquivo `SITEMA_LOGSTICO_ALIMENTICIOS.png` dentro da pasta `Br.Modelo/` para ter uma visão rápida de todo o esquema de tabelas e relacionamentos.
* **Modelo Editável:** Utilize o software **brModelo** para abrir o arquivo `.brM3` e editar a estrutura do banco de dados se necessário.

### 2. Consultar o Dicionário de Dados
* Abra a planilha `Dicionario_de_Dados_Sistema_Logistica_Alimenticio_Atualizado.xlsx` no Excel ou Google Sheets para entender a finalidade de cada tabela, chaves primárias/estrangeiras e tipos de dados.

### 3. Executar os Scripts SQL
Para criar o banco de dados no seu SGBD (ex: MySQL, PostgreSQL ou SQL Server):

1. **Para Execução Rápida:**
   Utilize o arquivo `Scripts certo.sql`. Ele contém o código pronto para criação das tabelas e população inicial dos dados.

2. **Para Estudo e Documentação:**
   Utilize o arquivo `sistema_logistico_alimenticio_COMENTADO.sql`. Ele contém explicações detalhadas sobre as regras de negócio, restrições e estrutura de cada comando.

---

## 🛠️ Tecnologias Utilizadas

* **SQL (ANSI Standard):** Compatível com os principais SGBDs relacionais.
* **brModelo:** Ferramenta para modelagem conceitual e lógica do DER.
* **Excel:** Para o dicionário e mapeamento de dados.

---

## 📝 Conteúdo Abordado

* **Gestão de Estoque e Armazenamento**
* **Controle de Produtos Alimentícios** (Validade, Lote, Categorias)
* **Fornecedores e Clientes**
* **Rotas de Transporte e Expedição**
