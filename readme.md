# 🍦 Paraíso Gelado - Sistema de Gestão de Franquia

Sistema completo de gerenciamento de franquia de sorveteria desenvolvido como projeto acadêmico, com foco em demonstrar a aplicação prática de diferentes estruturas de dados para otimização de operações em ambientes de Big Data.

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Estruturas de Dados](#-estruturas-de-dados-implementadas)
- [Funcionalidades](#-funcionalidades)
- [Tecnologias](#-tecnologias-utilizadas)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Licença](#-licença)


## 🎯 Sobre o Projeto

O Paraíso Gelado é um sistema de gestão completo desenvolvido para demonstrar a aplicação prática de estruturas de dados em cenários reais de Big Data. O projeto foi criado como trabalho acadêmico da disciplina de Estruturas de Dados e apresenta:

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
- **Triggers** - Para automatizações

O servidor estará disponível em: **https://paraiso-gelado.onrender.com/**

### Acessando o Sistema

1. **Página de Login**: https://paraiso-gelado.onrender.com/

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

## 📄 Licença

Este projeto é de uso acadêmico.  
© 2025 Centro Universitário de Goiatuba

## 🐛 Problemas Conhecidos

- O sistema requer conexão ativa com o banco de dados
- Testes de performance podem demorar em máquinas mais lentas
- O navegador Internet Explorer não é suportado

### 🍦 Desenvolvido com dedicação para o aprendizado de Estruturas de Dados

**[⬆ Voltar ao topo](#-paraíso-gelado---sistema-de-gestão-de-franquia)**
