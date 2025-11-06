# 🍦 Paraíso Gelado - Sistema de Gestão de Franquia

## 📋 Índice

- [Visão Geral](#visão-geral)
- [Status do Projeto](#status-do-projeto)
- [Funcionalidades](#funcionalidades)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Arquitetura do Sistema](#arquitetura-do-sistema)
- [Estruturas de Dados](#estruturas-de-dados-implementadas)
- [Acesso ao Sistema](#acesso-ao-sistema)
- [API Documentation](#api-documentation)
- [Deploy e Infraestrutura](#deploy-e-infraestrutura)
- [Desenvolvimento Local](#desenvolvimento-local)
- [Estrutura do Projeto](#estrutura-do-projeto)

## 🎯 Visão Geral

O **Paraíso Gelado** é um sistema completo de gestão empresarial desenvolvido para uma rede de franquias de sorveteria. A aplicação demonstra a aplicação prática de diferentes estruturas de dados em um ambiente de produção real, com foco em otimização e performance para cenários de Big Data.

**Contexto Acadêmico**: Projeto desenvolvido como trabalho final da disciplina de Estruturas de Dados no Centro Universitário de Goiatuba.

## 🌐 Status do Projeto

**✅ EM PRODUÇÃO**
- **URL**: https://paraiso-gelado.onrender.com/
- **Status**: Online e funcional
- **Ambiente**: Produção
- **Última Atualização**: Novembro 2025

## ✨ Funcionalidades

### 🔐 Sistema de Autenticação
- **Login Multi-nível**: Suporte a diferentes tipos de usuário
- **Controle de Permissões**: Hierarquia baseada em cargos
- **Sessões Seguras**: Gerenciamento de estado de usuário
- **Validação de Acesso**: Restrições por nível hierárquico

### 📊 Dashboard Gerencial
- **Métricas em Tempo Real**: Vendas, pedidos, clientes ativos
- **Performance por Loja**: Comparativo entre franquias
- **Sistema de Alertas**: Notificações de estoque crítico
- **Indicadores Visuais**: Gráficos e cards interativos

### 🍨 Gestão de Produtos
- **CRUD Completo**: Create, Read, Update, Delete
- **Controle de Categorias**: Organização por tipos
- **Cálculo de Margens**: Lucro percentual automático
- **Gestão de Preços**: Custo vs Preço de venda
- **Status de Atividade**: Controle de disponibilidade

### 👥 Gestão de Funcionários
- **Cadastro com CPF**: Identificação única
- **Alocação por Loja**: Vinculação a franquias específicas
- **Controle de Cargos**: Hierarquia organizacional
- **Gestão Salarial**: Controle de remuneração
- **Status de Atividade**: Ativo/Inativo

### 🏪 Gestão de Lojas/Franquias
- **Cadastro Completo**: Dados completos da unidade
- **Controle Regional**: Gestão por estado/cidade
- **Métricas Individuais**: Performance por unidade
- **Status Operacional**: Abertura/fechamento

### 👤 Gestão de Clientes
- **Base de Clientes**: Cadastro e consulta
- **Sistema de Fidelidade**: Pontuação por compras
- **Classificação por Nível**: Regular, Premium, VIP
- **Histórico de Compras**: Dados de consumo

### 📦 Controle de Estoque
- **Gestão de Ingredientes**: Controle por item
- **Alertas Inteligentes**: Níveis crítico/baixo/ok
- **Sistema de Reposição**: Solicitações de compra
- **Controle por Unidade**: Diferentes medidas

### 📈 Sistema de Relatórios
- **Relatório de Vendas**: Análise por período
- **Relatório de Produtos**: Performance do catálogo
- **Relatório de Clientes**: Base e fidelidade
- **Relatório de Estoque**: Situação atual

## 🛠 Tecnologias Utilizadas

### Backend
| Tecnologia | Versão | Finalidade |
|------------|---------|------------|
| Python | 3.9+ | Linguagem principal |
| Flask | 3.0.0 | Framework web |
| MySQL | 8.0+ | Banco de dados relacional |
| Gunicorn | 22.0.0 | Servidor WSGI production |

### Frontend
| Tecnologia | Finalidade |
|------------|------------|
| HTML5 | Estrutura semântica |
| CSS3 | Estilos e responsividade |
| JavaScript (Vanilla) | Interatividade e APIs |
| CSS Grid/Flexbox | Layout moderno |

### Segurança
| Componente | Implementação |
|------------|---------------|
| Autenticação | Sessions Flask |
| Hash Senhas | SHA-256 |
| CORS | Flask-CORS |
| SSL/HTTPS | Render + Aiven |

### Banco de Dados
| Característica | Detalhe |
|----------------|---------|
| Provider | Aiven MySQL |
| SSL | Obrigatório |
| Connection Pool | Gerenciado |
| Encoding | UTF-8 MB4 |

## 🏗 Arquitetura do Sistema

```
Cliente (Browser) → Render (Load Balancer) → Flask App → Aiven MySQL
       ↑                    ↑                      ↑           ↑
    HTML/CSS/JS         Gunicorn WSGI        Estruturas     SSL/TLS
                                           de Dados Python
```

### Componentes Principais

1. **Camada de Apresentação**
   - Templates HTML responsivos
   - CSS customizado com design system
   - JavaScript para interatividade

2. **Camada de Aplicação**
   - Flask como framework web
   - Gunicorn como servidor WSGI
   - Sistema de sessões e autenticação

3. **Camada de Dados**
   - MySQL para persistência
   - Estruturas de dados em memória
   - Cache estratégico com HashTables

4. **Camada de Segurança**
   - Autenticação por sessão
   - Controle de permissões hierárquico
   - SSL em todas as conexões

## 🗃️ Estruturas de Dados Implementadas

### 1️⃣ Árvore AVL (Balanceada)
```python
class AVLTree:
    """Árvore AVL para indexação de produtos"""
```
- **Complexidade**: O(log n) busca, inserção, remoção
- **Uso Real**: Indexação e busca de produtos
- **Vantagem**: Balanceamento automático, dados ordenados

### 2️⃣ Tabela Hash
```python
class HashTable:
    """Tabela Hash para cache de clientes e produtos"""
```
- **Complexidade**: O(1) médio para operações
- **Uso Real**: Cache de dados frequentes
- **Vantagem**: Acesso ultrarrápido, ideal para cache

### 3️⃣ Grafo (Lista de Adjacência)
```python
class Graph:
    """Grafo para recomendações de produtos"""
```
- **Complexidade**: O(V + E) para travessias
- **Uso Real**: Sistema de recomendações
- **Vantagem**: Modela relacionamentos complexos

### 4️⃣ Fila FIFO (deque)
```python
class OrderQueue:
    """Fila de pedidos para processamento"""
```
- **Complexidade**: O(1) para enqueue/dequeue
- **Uso Real**: Processamento de pedidos
- **Vantagem**: Ordem justa (first-in, first-out)

### 5️⃣ Fila de Prioridade (Min-Heap)
```python
class PriorityOrderQueue:
    """Fila de prioridade para pedidos delivery"""
```
- **Complexidade**: O(log n) inserção/extração
- **Uso Real**: Pedidos com prioridade
- **Vantagem**: Processamento por urgência

## 🔑 Acesso ao Sistema

### Credenciais de Teste

| Tipo | Email/CPF | Senha | Nível de Acesso |
|------|-----------|--------|-----------------|
| Gerente Geral | `eliel@paraisogelado.com` | `eliel` | Acesso total |
| Administrador | `admin@paraisogelado.com` | `admin123` | Acesso gerencial |
| Funcionário | CPF cadastrado | - | Acesso limitado |

### Níveis de Permissão

1. **Gerente Geral**
   - ✅ Acesso completo ao sistema
   - ✅ Cadastro de funcionários
   - ✅ Gestão de todas as lojas

2. **Gerente**
   - ✅ Dashboard e relatórios
   - ✅ Gestão de produtos e estoque
   - ✅ Visualização de clientes
   - ❌ Cadastro de funcionários

3. **Atendente**
   - ✅ Gestão de produtos
   - ✅ Controle de clientes
   - ✅ Visualização de estoque
   - ❌ Relatórios e funcionários

4. **Caixa**
   - ✅ Dashboard básico
   - ✅ Gestão de produtos
   - ✅ Controle de clientes
   - ❌ Estoque e relatórios

5. **Entregador**
   - ✅ Visualização de produtos
   - ✅ Gestão de clientes
   - ❌ Dashboard e outras funcionalidades

## 🔌 API Documentation

### Autenticação
```http
POST /api/login
Content-Type: application/json

{
  "username": "email@ou.cpf",
  "password": "senha"
}
```

### Endpoints Principais

| Método | Endpoint | Descrição | Autenticação |
|--------|----------|-----------|--------------|
| GET | `/api/dashboard` | Métricas gerais | ✅ |
| GET | `/api/produtos` | Listar produtos | ✅ |
| POST | `/api/produtos` | Criar produto | ✅ |
| GET | `/api/funcionarios` | Listar funcionários | ✅ |
| POST | `/api/funcionarios` | Criar funcionário | Gerente Geral |
| GET | `/api/lojas` | Listar lojas | ✅ |
| GET | `/api/clientes` | Listar clientes | ✅ |
| GET | `/api/estoque` | Situação do estoque | ✅ |
| GET | `/api/relatorio/vendas` | Relatório de vendas | ✅ |

### Exemplo de Uso
```javascript
// Buscar produtos
const response = await fetch('/api/produtos', {
    method: 'GET',
    credentials: 'include'
});
const produtos = await response.json();
```

## 🚀 Deploy e Infraestrutura

### Provedores Utilizados

| Serviço | Função | Plano |
|---------|--------|-------|
| **Render** | Hosting Web | Free Tier |
| **Aiven** | MySQL Database | Free Tier |
| **Cloudflare** | DNS & SSL | Free |

### Configuração de Produção

```python
# Configurações críticas
DB_CONFIG = {
    'host': 'mysql-aiven-cloud',
    'ssl_ca': 'ca-certificate.crt',
    'ssl_verify_cert': True
}

app.config = {
    'SECRET_KEY': 'hash-seguro',
    'SESSION_PROTECTION': 'strong'
}
```

### Monitoramento
- **Health Checks**: `/health` endpoint
- **Logs**: Console e arquivos
- **Performance**: Métricas de resposta

## 💻 Desenvolvimento Local

### Pré-requisitos
```bash
python --version  # Python 3.9+
mysql --version   # MySQL 8.0+
```

### Instalação
```bash
# 1. Clone o projeto
git clone <repository-url>
cd paraiso-gelado

# 2. Ambiente virtual
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows

# 3. Dependências
pip install -r requirements.txt

# 4. Variáveis de ambiente
cp .env.example .env
# Editar .env com suas configurações

# 5. Banco de dados
mysql -u root -p < setup_database.sql

# 6. Executar
python main.py
```

### Variáveis de Ambiente
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=sua_senha
DB_NAME=paraiso_gelado
SECRET_KEY=chave_secreta_flask
DB_SSL_CA=ca-certificate.crt  # Para produção
```

## 📁 Estrutura do Projeto

```
paraiso_gelado/
│
├── 📄 main.py                      # Aplicação Flask principal
├── 📄 requirements.txt             # Dependências Python
├── 📄 login.html                   # Página de autenticação
├── 📄 admin.html                   # Painel administrativo
├── 📄 cadastro_funcionario.html    # Cadastro de funcionários
│
├── 🔧 Configurações
│   ├── paraiso_config.py           # Configurações do sistema
│   └── .env                        # Variáveis ambiente (gitignore)
│
├── 📊 Funcionalidades
│   ├── Estruturas de dados (AVL, Hash, Graph, Queues)
│   ├── Sistema de autenticação
│   ├── CRUDs completos
│   └── Sistema de permissões
│
└── 🎨 Frontend
    ├── Design system CSS customizado
    ├── Componentes responsivos
    └── JavaScript vanilla para APIs
```

## 📞 Suporte e Contato

**Projeto Acadêmico** - Centro Universitário de Goiatuba  
**Disciplina**: Estruturas de Dados Aplicado à Big Data  
**Status**: Em produção e mantido

---

**🍦 Desenvolvido com excelência acadêmica e técnica**  
*[Voltar ao topo](#-paraíso-gelado---sistema-de-gestão-de-franquia)*