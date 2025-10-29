# 🍦 Paraíso Gelado - Sistema de Gestão de Franquia

![Python](https://img.shields.io/badge/Python-3.9%2B-blue?logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-3.0.0-green?logo=flask&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql&logoColor=white)
![License](https://img.shields.io/badge/License-Academic-yellow)
![Status](https://img.shields.io/badge/Status-Active-success)

Sistema completo de gerenciamento de franquia de sorveteria desenvolvido como projeto acadêmico, com foco em demonstrar a aplicação prática de diferentes estruturas de dados para otimização de operações em ambientes de Big Data.

---

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Estruturas de Dados](#-estruturas-de-dados-implementadas)
- [Funcionalidades](#-funcionalidades)
- [Tecnologias](#-tecnologias-utilizadas)
- [Instalação](#-instalação)
- [Configuração](#-configuração)
- [Uso](#-uso)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [API Endpoints](#-api-endpoints)
- [Testes de Performance](#-testes-de-performance)
- [Contribuindo](#-contribuindo)
- [Licença](#-licença)
- [Autores](#-autores)
- [Agradecimentos](#-agradecimentos)

---

## 🎯 Sobre o Projeto

O **Paraíso Gelado** é um sistema de gestão completo desenvolvido para demonstrar a aplicação prática de estruturas de dados em cenários reais de Big Data. O projeto foi criado como trabalho acadêmico da disciplina de Estruturas de Dados e apresenta:

- **Painel Administrativo Completo** - Gestão de produtos, funcionários, lojas e clientes
- **Estruturas de Dados Otimizadas** - AVL Tree, Hash Table, Grafo, Filas FIFO e de Prioridade
- **Sistema de Recomendações** - Baseado em análise de co-compras usando grafos
- **Controle de Estoque Inteligente** - Com alertas automáticos
- **Dashboard em Tempo Real** - Métricas e análises de performance
- **API RESTful** - Backend Flask com operações CRUD completas

### 🎓 Objetivos do Projeto

1. Explorar estruturas de dados eficientes para gerenciamento de grandes volumes de dados
2. Implementar protótipo funcional com operações reais de inserção, busca, remoção e agregação
3. Analisar performance comparando diferentes estruturas de dados
4. Demonstrar escalabilidade do sistema em cenários de carga real

---

## 🗃️ Estruturas de Dados Implementadas

### 1️⃣ Árvore AVL (Balanceada)
```python
class AVLTree:
    """Árvore AVL para indexação de produtos"""
```
- **Uso**: Indexação e busca de produtos
- **Complexidade**: 
  - Busca: O(log n)
  - Inserção: O(log n)
  - Remoção: O(log n)
- **Vantagens**: Mantém dados ordenados, balanceamento automático
- **Trade-off**: Overhead de rotações

### 2️⃣ Tabela Hash
```python
class HashTable:
    """Tabela Hash para cache de clientes e produtos"""
```
- **Uso**: Cache de clientes e produtos mais vendidos
- **Complexidade**: O(1) médio para busca e inserção
- **Vantagens**: Acesso extremamente rápido
- **Trade-off**: Pode ter colisões, não mantém ordem

### 3️⃣ Grafo (Lista de Adjacência)
```python
class Graph:
    """Grafo para recomendações de produtos"""
```
- **Uso**: Sistema de recomendações baseado em co-compras
- **Complexidade**: O(V + E) para travessia
- **Vantagens**: Modelar relacionamentos complexos
- **Algoritmo**: Análise de produtos comprados juntos

### 4️⃣ Fila FIFO
```python
class OrderQueue:
    """Fila de pedidos para processamento"""
```
- **Uso**: Processamento de pedidos locais
- **Complexidade**: O(1) para enqueue/dequeue
- **Vantagens**: Garantia de ordem justa (first-in, first-out)

### 5️⃣ Fila de Prioridade (Min-Heap)
```python
class PriorityOrderQueue:
    """Fila de prioridade para pedidos delivery"""
```
- **Uso**: Pedidos delivery com priorização
- **Complexidade**: O(log n) para inserção e extração
- **Vantagens**: Processar itens por prioridade (express vs normal)

### 6️⃣ Pilha LIFO
- **Uso**: Histórico de navegação (funcionalidade "Voltar")
- **Complexidade**: O(1) para push/pop

---

## ✨ Funcionalidades

### 🔐 Painel Administrativo

#### Dashboard Gerencial
- 📊 Métricas em tempo real (vendas, pedidos, clientes)
- 📈 Performance por loja
- ⚠️ Sistema de alertas e notificações
- 🎯 Indicadores visuais coloridos

#### Gestão de Produtos
- ➕ Cadastro completo de produtos
- 💰 Visualização de margem de lucro
- 📦 Controle de estoque com alertas visuais
- 🔍 Busca e filtros por categoria
- ✏️ Edição e exclusão de produtos

#### Gestão de Funcionários
- 👤 Cadastro de funcionários com CPF e cargo
- 🏪 Alocação por loja
- 💵 Controle de salários
- 📋 Cards visuais com informações completas
- 🟢 Sistema de status (ativo/inativo)

#### Gestão de Lojas/Franquias
- 🏢 Cadastro de novas franquias
- 📍 Controle de endereços
- 📊 Métricas de vendas por loja
- 🔄 Status operacional
- 📑 Botões para relatórios detalhados

#### Gestão de Clientes
- 👥 Visualização completa de clientes
- ⭐ Sistema de pontos e fidelidade
- 🏆 Classificação por nível (Regular/Premium/VIP)
- 💳 Total de compras por cliente
- 📈 Estatísticas gerais

#### Controle de Estoque
- 📦 Alertas de baixo estoque
- 📋 Ficha técnica de produtos
- 🔔 Previsão de reposição
- 🚨 Status crítico/baixo/ok

#### Relatórios
- 📊 Relatório de vendas
- 🍨 Relatório de produtos
- 👥 Relatório de clientes
- 📦 Relatório de estoque

---

## 🛠 Tecnologias Utilizadas

### Backend
- **Python 3.9+** - Linguagem principal
- **Flask 3.0.0** - Framework web
- **Flask-CORS** - Suporte a CORS
- **MySQL Connector** - Conexão com banco de dados
- **python-dotenv** - Gerenciamento de variáveis de ambiente

### Frontend
- **HTML5** - Estrutura
- **CSS3** - Estilização moderna com gradientes e animações
- **JavaScript (Vanilla)** - Interatividade e requisições AJAX

### Banco de Dados
- **MySQL 8.0** - Banco de dados relacional
- **Views** - Para consultas otimizadas
- **Triggers** - Para automatizações

### Análise de Performance
- **NumPy** - Computação numérica
- **Pandas** - Manipulação de dados
- **Matplotlib** - Geração de gráficos
- **Seaborn** - Visualizações estatísticas

---

## 🚀 Instalação

### Pré-requisitos

- Python 3.9 ou superior
- MySQL 8.0 ou superior
- pip (gerenciador de pacotes Python)
- Navegador web moderno (Chrome, Firefox, Edge)

### Passo 1: Clone o Repositório

```bash
git clone https://github.com/seu-usuario/paraiso-gelado.git
cd paraiso-gelado
```

### Passo 2: Crie um Ambiente Virtual

**Windows:**
```bash
python -m venv venv
venv\Scripts\activate
```

**Linux/Mac:**
```bash
python3 -m venv venv
source venv/bin/activate
```

### Passo 3: Instale as Dependências

```bash
pip install -r requirements.txt
```

### Passo 4: Configure o Banco de Dados

1. Inicie o MySQL:
```bash
# Windows
net start MySQL80

# Linux
sudo systemctl start mysql

# Mac
brew services start mysql
```

2. Importe o schema do banco de dados:
```bash
mysql -u root -p < paraiso_database.sql
```

Ou se preferir, crie o banco manualmente:
```sql
CREATE DATABASE paraiso_gelado;
USE paraiso_gelado;
SOURCE paraiso_database.sql;
```

---

## ⚙ Configuração

### Arquivo .env

Crie um arquivo `.env` na raiz do projeto com as seguintes variáveis:

```env
# Aplicação
FLASK_APP=main.py
FLASK_ENV=development
DEBUG=True
SECRET_KEY=sua_chave_secreta_muito_segura_aqui

# Banco de Dados
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=sua_senha_mysql
DB_NAME=paraiso_gelado

# API
API_HOST=0.0.0.0
API_PORT=5000

# CORS
CORS_ORIGINS=http://localhost:5000,http://127.0.0.1:5000

# Cache
CACHE_ENABLED=True
CACHE_TIMEOUT=300

# Logs
LOG_LEVEL=INFO
LOG_FILE=logs/paraiso_gelado.log

# Performance
ENABLE_PROFILING=False
```

### Arquivo paraiso_config.py

O sistema já vem com um arquivo de configuração padrão. Você pode ajustá-lo conforme necessário:

```python
class Config:
    # Configurações de estruturas de dados
    AVL_MAX_HEIGHT = 50
    HASH_TABLE_SIZE = 1000
    MAX_QUEUE_SIZE = 100
```

---

## 💻 Uso

### Iniciar o Sistema

```bash
python main.py
```

O servidor estará disponível em: **http://localhost:5000**

### Credenciais Padrão

**Usuário Admin:**
- **Email:** admin@paraisogelado.com
- **Senha:** admin123

**Gerentes (podem fazer login):**
- Qualquer gerente cadastrado no sistema pode usar seu CPF como login

### Acessando o Sistema

1. **Página de Login**: http://localhost:5000
2. **Painel Administrativo**: http://localhost:5000/admin (após login)

### Navegação

O sistema possui um menu lateral com as seguintes opções:

- 📊 **Dashboard** - Visão geral do negócio
- 🍨 **Produtos** - Gerenciar catálogo
- 👥 **Funcionários** - Gerenciar equipe
- 🏪 **Lojas** - Gerenciar franquias
- 👤 **Clientes** - Base de clientes
- 📦 **Estoque** - Controle de ingredientes
- 📈 **Relatórios** - Análises detalhadas

---

## 📁 Estrutura do Projeto

```
paraiso_gelado/
│
├── main.py                      # Backend Flask com estruturas de dados
├── paraiso_config.py            # Configurações do sistema
├── paraiso_database.sql         # Schema MySQL completo
├── requirements.txt             # Dependências Python
├── paraiso_tests.py             # Testes de performance
│
├── templates/
│   ├── login.html              # Página de login
│   └── admin.html              # Painel administrativo
│
├── static/
│   ├── css/                    # Estilos customizados
│   ├── js/                     # Scripts JavaScript
│   └── images/                 # Imagens e assets
│
├── logs/
│   └── paraiso_gelado.log      # Logs do sistema
│
├── uploads/                     # Arquivos de upload
│
├── docs/
│   ├── relatorio_abnt.pdf      # Relatório no formato ABNT
│   ├── apresentacao.pptx       # Slides para seminário
│   └── graficos/               # Gráficos de performance
│
├── .env                         # Variáveis de ambiente (não versionado)
├── .gitignore                  # Arquivos ignorados pelo git
└── README.md                   # Este arquivo
```

---

## 🔌 API Endpoints

### Autenticação

```http
POST /api/login
Content-Type: application/json

{
  "username": "admin@paraisogelado.com",
  "password": "admin123"
}
```

```http
POST /api/logout
```

### Dashboard

```http
GET /api/admin/dashboard
```

### Produtos

```http
GET    /api/admin/produtos
POST   /api/admin/produtos
DELETE /api/admin/produtos/{id}
```

**Exemplo de criação:**
```json
{
  "categoria_id": 1,
  "nome": "Sorvete Chocolate Belga",
  "descricao": "Sorvete cremoso de chocolate 70% cacau",
  "preco": 12.90,
  "custo": 4.50,
  "tamanho": "M",
  "calorias": 250,
  "ativo": 1
}
```

### Funcionários

```http
GET    /api/admin/funcionarios
POST   /api/admin/funcionarios
DELETE /api/admin/funcionarios/{id}
```

**Exemplo de criação:**
```json
{
  "loja_id": 1,
  "nome": "João Silva",
  "cpf": "123.456.789-00",
  "cargo": "atendente",
  "salario": 1800.00,
  "data_admissao": "2024-01-15"
}
```

### Lojas

```http
GET  /api/admin/lojas
POST /api/admin/lojas
```

**Exemplo de criação:**
```json
{
  "nome": "Paraíso Gelado - Centro",
  "endereco": "Av. Principal, 1000",
  "cidade": "Goiatuba",
  "estado": "GO",
  "cep": "75600-000",
  "telefone": "(64) 3495-1000",
  "email": "centro@paraisogelado.com",
  "data_abertura": "2024-01-15"
}
```

### Clientes

```http
GET /api/admin/clientes
```

### Estoque

```http
GET  /api/admin/estoque
POST /api/admin/estoque/{id}/repor
```

**Exemplo de reposição:**
```json
{
  "quantidade": 50.0
}
```

### Categorias

```http
GET /api/admin/categorias
```

### Relatórios

```http
GET /api/admin/relatorio/vendas?periodo=30
```

---

## 🧪 Testes de Performance

### Executar Testes Completos

```bash
python paraiso_tests.py
```

**Saída esperada:**
- Resultados detalhados no console
- Gráficos salvos em `performance_charts.png`
- CSV exportado em `performance_results.csv`

### Teste Rápido

```bash
python paraiso_tests.py quick
```

### Resultados Esperados

#### Performance de Buscas (10.000 elementos)

| Estrutura      | Tempo (ms) | Complexidade | Speedup    |
|---------------|------------|--------------|------------|
| Lista Linear  | 10.00      | O(n)         | 1x         |
| Árvore AVL    | 0.80       | O(log n)     | 12.5x      |
| Hash Table    | 0.30       | O(1)         | 33.3x      |

#### Análise de Memória

| Estrutura          | Memória (MB) | Overhead |
|-------------------|--------------|----------|
| Fila FIFO         | 10           | Baixo    |
| Hash Table        | 30           | Médio    |
| Árvore AVL        | 45           | Alto     |
| Grafo             | 25           | Médio    |

---

## 🤝 Contribuindo

Contribuições são sempre bem-vindas! Este é um projeto acadêmico, mas sugestões e melhorias são apreciadas.

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/NovaFuncionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/NovaFuncionalidade`)
5. Abra um Pull Request

### Diretrizes de Contribuição

- Siga o padrão PEP 8 para código Python
- Documente novas funcionalidades
- Adicione testes quando possível
- Mantenha o README atualizado

---

## 📄 Licença

Este projeto é de uso acadêmico.  
© 2025 Centro Universitário de Goiatuba

---

## 👥 Autores

**Grupo de Estruturas de Dados 2025**

- Aluno 1 - [email@institucional.edu.br]
- Aluno 2 - [email@institucional.edu.br]
- Aluno 3 - [email@institucional.edu.br]
- Aluno 4 - [email@institucional.edu.br]
- Aluno 5 - [email@institucional.edu.br]
- Aluno 6 - [email@institucional.edu.br]

**Professora Orientadora:** Pauliane Cardoso Alves Ferreira  
**Instituição:** Centro Universitário de Goiatuba

---

## 🙏 Agradecimentos

- **Professor(a)** pela orientação e suporte durante o desenvolvimento
- **Centro Universitário de Goiatuba** pela infraestrutura e recursos
- **Comunidade Open Source** pelas bibliotecas e frameworks utilizados
- Todos os colegas que contribuíram com ideias e feedback

---

## 📚 Referências Bibliográficas

1. CORMEN, T. H. et al. **Algoritmos: Teoria e Prática**. 3. ed. Rio de Janeiro: Elsevier, 2012.

2. GOODRICH, M. T.; TAMASSIA, R. **Estruturas de Dados e Algoritmos em Java**. 5. ed. Porto Alegre: Bookman, 2013.

3. SEDGEWICK, R.; WAYNE, K. **Algorithms**. 4th ed. Boston: Addison-Wesley, 2011.

4. SKIENA, S. S. **The Algorithm Design Manual**. 2nd ed. London: Springer, 2008.

5. TENENBAUM, A. M.; LANGSAM, Y.; AUGENSTEIN, M. J. **Estruturas de Dados Usando C**. São Paulo: Pearson, 1995.

---

## 🐛 Problemas Conhecidos

- O sistema requer conexão ativa com o banco de dados
- Testes de performance podem demorar em máquinas mais lentas
- O navegador Internet Explorer não é suportado

---

## 🔮 Roadmap

- [ ] Adicionar autenticação JWT
- [ ] Implementar websockets para updates em tempo real
- [ ] Criar app mobile com React Native
- [ ] Adicionar mais tipos de relatórios
- [ ] Implementar backup automático do banco de dados
- [ ] Adicionar suporte a múltiplos idiomas

---

## 📞 Suporte

Para dúvidas, sugestões ou problemas:

- **Email:** paraisogelado@institucional.edu.br
- **Issues:** [GitHub Issues](https://github.com/seu-usuario/paraiso-gelado/issues)
- **Documentação:** [Wiki do Projeto](https://github.com/seu-usuario/paraiso-gelado/wiki)

---

<div align="center">

### 🍦 Desenvolvido com dedicação para o aprendizado de Estruturas de Dados

**[⬆ Voltar ao topo](#-paraíso-gelado---sistema-de-gestão-de-franquia)**

---

[![Stars](https://img.shields.io/github/stars/seu-usuario/paraiso-gelado?style=social)](https://github.com/seu-usuario/paraiso-gelado/stargazers)
[![Forks](https://img.shields.io/github/forks/seu-usuario/paraiso-gelado?style=social)](https://github.com/seu-usuario/paraiso-gelado/network/members)
[![Issues](https://img.shields.io/github/issues/seu-usuario/paraiso-gelado)](https://github.com/seu-usuario/paraiso-gelado/issues)

</div>