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

O Paraíso Gelado é um sistema de gestão empresarial desenvolvido para demonstrar a aplicação prática de estruturas de dados complexas em ambientes de produção real. O projeto simula o gerenciamento completo de uma rede de franquias de sorveteria, abordando desde o controle de estoque até análise de dados de vendas.
🎓 Contexto Acadêmico
Este projeto foi desenvolvido como trabalho final da disciplina de Estruturas de Dados no Centro Universitário de Goiatuba, com os seguintes objetivos:

✅ Implementar e comparar diferentes estruturas de dados (AVL, Hash, Grafos, Filas)
✅ Demonstrar aplicações práticas em cenários de Big Data
✅ Desenvolver sistema full-stack funcional com arquitetura escalável
✅ Aplicar boas práticas de engenharia de software
✅ Criar interface intuitiva e responsiva

🌟 Por que este projeto é diferente?
Ao contrário de muitos projetos acadêmicos que ficam apenas na teoria, o Paraíso Gelado é um sistema funcional e deployado, com:

🔴 Aplicação em produção acessível via web
🔴 Banco de dados real com dados consistentes
🔴 Interface profissional desenvolvida do zero
🔴 Múltiplos níveis de acesso (Gerente Geral, Gerente, Atendente, Caixa, Entregador)
🔴 Métricas em tempo real e dashboards interativos

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

## Backend: Python 3.9+ | Flask 3.0.0 | MySQL 8.0 | Gunicorn
## Frontend: HTML5 | CSS3 | JavaScript (Vanilla)
## Deploy: Render | FreeSQLDatabase
## Segurança: SHA-256 | Flask Sessions | CORS

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

🚀 Instalação

# 1. Clone o repositório
git clone https://github.com/seu-usuario/paraiso-gelado.git
cd paraiso-gelado

# 2. Crie o ambiente virtual
python -m venv venv
source venv/bin/activate  # Linux/Mac
# venv\Scripts\activate   # Windows

# 3. Instale as dependências
pip install -r requirements.txt

# 4. Configure o .env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=sua_senha
DB_NAME=sql10805055
SECRET_KEY=sua_chave_secreta

# 5. Importe o banco de dados
mysql -u root -p < paraiso_database.sql

# 6. Execute o sistema
python main.py

Acesse: http://localhost:5000

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

### 🍦 Desenvolvido com dedicação para o aprendizado de Estruturas de Dados

**[⬆ Voltar ao topo](#-paraíso-gelado---sistema-de-gestão-de-franquia)**
