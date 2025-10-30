import os
from flask import Flask, render_template, request, jsonify, session
from flask_cors import CORS
from datetime import datetime
import hashlib
import json
from collections import deque
import heapq
from paraiso_config import Config

# Tenta carregar variáveis de ambiente
try:
    from dotenv import load_dotenv
    load_dotenv()
    print("✓ Variáveis de ambiente carregadas do .env")
except Exception as e:
    print(f"⚠️ Usando configurações padrão (erro ao carregar .env: {e})")

# Tenta importar mysql.connector
try:
    import mysql.connector
except ImportError:
    print("❌ ERRO: mysql-connector-python não instalado!")
    print("Execute: pip install mysql-connector-python")
    exit(1)

app = Flask(__name__)
app.secret_key = Config.SECRET_KEY
CORS(app)

# ============= CONFIGURAÇÃO DO BANCO DE DADOS =============

DB_CONFIG = {
    'host': os.getenv('DB_HOST'),
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'database': os.getenv('DB_NAME'),
    'port': int(os.getenv('DB_PORT', 3306))
}

def get_db_connection():
    """Retorna uma conexão com o banco de dados"""
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        return conn
    except mysql.connector.Error as err:
        print(f"❌ Erro ao conectar ao banco de dados: {err}")
        return None

# ============= ESTRUTURAS DE DADOS =============

class AVLNode:
    def __init__(self, produto_id, nome, preco):
        self.produto_id = produto_id
        self.nome = nome
        self.preco = preco
        self.left = None
        self.right = None
        self.height = 1

class AVLTree:
    def __init__(self):
        self.root = None
    
    def get_height(self, node):
        if not node:
            return 0
        return node.height
    
    def get_balance(self, node):
        if not node:
            return 0
        return self.get_height(node.left) - self.get_height(node.right)
    
    def rotate_right(self, y):
        x = y.left
        T2 = x.right
        x.right = y
        y.left = T2
        y.height = max(self.get_height(y.left), self.get_height(y.right)) + 1
        x.height = max(self.get_height(x.left), self.get_height(x.right)) + 1
        return x
    
    def rotate_left(self, x):
        y = x.right
        T2 = y.left
        y.left = x
        x.right = T2
        x.height = max(self.get_height(x.left), self.get_height(x.right)) + 1
        y.height = max(self.get_height(y.left), self.get_height(y.right)) + 1
        return y
    
    def insert(self, node, produto_id, nome, preco):
        if not node:
            return AVLNode(produto_id, nome, preco)
        
        if produto_id < node.produto_id:
            node.left = self.insert(node.left, produto_id, nome, preco)
        else:
            node.right = self.insert(node.right, produto_id, nome, preco)
        
        node.height = 1 + max(self.get_height(node.left), self.get_height(node.right))
        balance = self.get_balance(node)
        
        if balance > 1 and produto_id < node.left.produto_id:
            return self.rotate_right(node)
        if balance < -1 and produto_id > node.right.produto_id:
            return self.rotate_left(node)
        if balance > 1 and produto_id > node.left.produto_id:
            node.left = self.rotate_left(node.left)
            return self.rotate_right(node)
        if balance < -1 and produto_id < node.right.produto_id:
            node.right = self.rotate_right(node.right)
            return self.rotate_left(node)
        
        return node
    
    def search(self, node, produto_id):
        if not node or node.produto_id == produto_id:
            return node
        if produto_id < node.produto_id:
            return self.search(node.left, produto_id)
        return self.search(node.right, produto_id)

class HashTable:
    def __init__(self, size=100):
        self.size = size
        self.table = [[] for _ in range(size)]
    
    def hash_function(self, key):
        return hash(key) % self.size
    
    def insert(self, key, value):
        index = self.hash_function(key)
        for i, (k, v) in enumerate(self.table[index]):
            if k == key:
                self.table[index][i] = (key, value)
                return
        self.table[index].append((key, value))
    
    def get(self, key):
        index = self.hash_function(key)
        for k, v in self.table[index]:
            if k == key:
                return v
        return None
    
    def delete(self, key):
        index = self.hash_function(key)
        for i, (k, v) in enumerate(self.table[index]):
            if k == key:
                del self.table[index][i]
                return True
        return False

class Graph:
    def __init__(self):
        self.adjacency_list = {}
    
    def add_node(self, node):
        if node not in self.adjacency_list:
            self.adjacency_list[node] = {}
    
    def add_edge(self, node1, node2, weight=1):
        self.add_node(node1)
        self.add_node(node2)
        self.adjacency_list[node1][node2] = self.adjacency_list[node1].get(node2, 0) + weight
        self.adjacency_list[node2][node1] = self.adjacency_list[node2].get(node1, 0) + weight
    
    def get_recommendations(self, node, limit=5):
        if node not in self.adjacency_list:
            return []
        recommendations = sorted(
            self.adjacency_list[node].items(),
            key=lambda x: x[1],
            reverse=True
        )
        return [item[0] for item in recommendations[:limit]]

class OrderQueue:
    def __init__(self):
        self.queue = deque()
    
    def enqueue(self, order):
        self.queue.append(order)
    
    def dequeue(self):
        if self.queue:
            return self.queue.popleft()
        return None
    
    def is_empty(self):
        return len(self.queue) == 0
    
    def size(self):
        return len(self.queue)

class PriorityOrderQueue:
    def __init__(self):
        self.heap = []
        self.counter = 0
    
    def enqueue(self, order, priority):
        heapq.heappush(self.heap, (priority, self.counter, order))
        self.counter += 1
    
    def dequeue(self):
        if self.heap:
            return heapq.heappop(self.heap)[2]
        return None

# ============= INSTÂNCIAS GLOBAIS =============
avl_tree = AVLTree()
cliente_cache = HashTable()
produto_cache = HashTable()
recommendation_graph = Graph()
order_queue = OrderQueue()
priority_queue = PriorityOrderQueue()

# ============= FUNÇÕES AUXILIARES =============

def hash_password(password):
    """Gera hash SHA-256 da senha"""
    return hashlib.sha256(password.encode()).hexdigest()

def verificar_autenticacao():
    """Verifica se o usuário está autenticado"""
    return session.get('authenticated', False)

# ============= ROTAS PRINCIPAIS =============

@app.route('/admin')
def admin_panel():
    """Painel administrativo"""
    return render_template('admin.html')

@app.route('/')
def index():
    """Página de login"""
    return render_template('login.html')

@app.route('/test-db')
def test_db():
    """Testa a conexão com o banco de dados e mostra estrutura das tabelas"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({"status": "error", "message": "Não foi possível conectar ao banco"}), 500
        
        cursor = conn.cursor(dictionary=True)
        
        # Testa conexão básica
        cursor.execute("SELECT 1")
        result = cursor.fetchone()
        
        # Mostra estrutura de tabelas importantes
        tabelas_info = {}
        
        for tabela in ['funcionarios', 'lojas', 'estoque', 'ingredientes', 'produtos', 'categorias']:
            try:
                cursor.execute(f"DESCRIBE {tabela}")
                colunas = cursor.fetchall()
                tabelas_info[tabela] = [col['Field'] for col in colunas]
                
                # Conta registros
                cursor.execute(f"SELECT COUNT(*) as total FROM {tabela}")
                total = cursor.fetchone()
                tabelas_info[f"{tabela}_count"] = total['total']
            except Exception as e:
                tabelas_info[tabela] = f"Erro: {str(e)}"
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "status": "success",
            "message": "Conexão com banco de dados OK!",
            "connection_test": result,
            "db_config": {
                "host": DB_CONFIG.get('host'),
                "user": DB_CONFIG.get('user'),
                "database": DB_CONFIG.get('database'),
                "port": DB_CONFIG.get('port')
            },
            "tabelas": tabelas_info
        })
    except Exception as e:
        import traceback
        return jsonify({
            "status": "error",
            "message": str(e),
            "traceback": traceback.format_exc()
        }), 500

@app.route('/health')
def health():
    """Health check"""
    return jsonify({
        "status": "online",
        "env_loaded": bool(os.getenv('DB_HOST'))
    })

# ============= ROTA DE LOGIN =============

@app.route('/api/login', methods=['POST'])
def login():
    try:
        data = request.json
        username = data.get('username')
        password = data.get('password')
        
        if username == 'eliel@paraisogelado.com' and password == 'eliel':
            session['authenticated'] = True
            session['user'] = {
                'nome': 'Eliel (Dono)',
                'email': username,
                'cargo': 'gerente_geral',
                'nivel_acesso': 'total'
            }
            return jsonify({
                'success': True,
                'message': 'Login realizado com sucesso',
                'user': session['user']
            })
        
        if username == 'admin@paraisogelado.com' and password == 'admin123':
            session['authenticated'] = True
            session['user'] = {
                'nome': 'Administrador',
                'email': username,
                'cargo': 'gerente',
                'nivel_acesso': 'gerente'
            }
            return jsonify({
                'success': True,
                'message': 'Login realizado com sucesso',
                'user': session['user']
            })
        
        conn = get_db_connection()
        if conn:
            cursor = conn.cursor(dictionary=True)
            
            query = """
                SELECT f.*, l.nome as loja_nome 
                FROM funcionarios f
                LEFT JOIN lojas l ON f.loja_id = l.id
                WHERE (f.cpf = %s OR %s LIKE CONCAT('%%', f.cpf, '%%')) AND f.ativo = 1
            """
            cursor.execute(query, (username, username))
            funcionario = cursor.fetchone()
            
            cursor.close()
            conn.close()
            
            if funcionario:
                nivel_acesso = 'total' if funcionario['cargo'] == 'gerente' else 'limitado'
                
                session['authenticated'] = True
                session['user'] = {
                    'id': funcionario['id'],
                    'nome': funcionario['nome'],
                    'cpf': funcionario['cpf'],
                    'cargo': funcionario['cargo'],
                    'loja': funcionario['loja_nome'],
                    'loja_id': funcionario['loja_id'],
                    'nivel_acesso': nivel_acesso
                }
                return jsonify({
                    'success': True,
                    'message': 'Login realizado com sucesso',
                    'user': session['user']
                })
        
        return jsonify({
            'success': False,
            'message': 'Email/CPF ou senha incorretos'
        }), 401
        
    except Exception as e:
        print(f"Erro no login: {e}")
        return jsonify({
            'success': False,
            'message': 'Erro ao processar login'
        }), 500

@app.route('/api/logout', methods=['POST'])
def logout():
    session.clear()
    return jsonify({'success': True, 'message': 'Logout realizado com sucesso'})

@app.route('/api/verificar-permissao', methods=['GET'])
def verificar_permissao():
    if not session.get('authenticated'):
        return jsonify({'authenticated': False}), 401
    
    user = session.get('user', {})
    cargo = user.get('cargo', '')
    
    permissoes = {
        'gerente_geral': {
            'dashboard': True,
            'produtos': True,
            'funcionarios': True,
            'lojas': True,
            'clientes': True,
            'estoque': True,
            'relatorios': True
        },
        'gerente': {
            'dashboard': True,
            'produtos': True,
            'funcionarios': True,
            'lojas': True,
            'clientes': True,
            'estoque': True,
            'relatorios': True
        },
        'atendente': {
            'dashboard': True,
            'produtos': True,
            'funcionarios': False,
            'lojas': False,
            'clientes': True,
            'estoque': True,
            'relatorios': False
        },
        'caixa': {
            'dashboard': True,
            'produtos': True,
            'funcionarios': False,
            'lojas': False,
            'clientes': True,
            'estoque': False,
            'relatorios': False
        },
        'entregador': {
            'dashboard': False,
            'produtos': True,
            'funcionarios': False,
            'lojas': False,
            'clientes': True,
            'estoque': False,
            'relatorios': False
        }
    }
    
    return jsonify({
        'authenticated': True,
        'user': user,
        'permissoes': permissoes.get(cargo, {})
    })

# ============= ROTAS API SIMPLIFICADAS =============

@app.route('/api/produtos', methods=['GET'])
def get_produtos():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT 
                p.*,
                c.nome as categoria_nome,
                CASE 
                    WHEN p.custo > 0 THEN ROUND(((p.preco - p.custo) / p.preco * 100), 2)
                    ELSE 0 
                END as margem_percentual
            FROM produtos p 
            LEFT JOIN categorias c ON p.categoria_id = c.id
            ORDER BY p.nome
        """)
        produtos = cursor.fetchall()
        
        for produto in produtos:
            if 'margem_percentual' not in produto or produto['margem_percentual'] is None:
                if produto.get('custo') and produto.get('preco') and float(produto['custo']) > 0:
                    custo = float(produto['custo'])
                    preco = float(produto['preco'])
                    produto['margem_percentual'] = round(((preco - custo) / preco * 100), 2)
                else:
                    produto['margem_percentual'] = 0
        
        cursor.close()
        conn.close()
        return jsonify(produtos)
    except Exception as e:
        print(f"Erro get_produtos: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/produtos', methods=['POST'])
def criar_produto():
    try:
        dados = request.json
        print(f"📦 Criando produto: {dados}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO produtos (nome, descricao, preco, custo, categoria_id, tamanho, ativo, calorias)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            dados.get('nome', ''),
            dados.get('descricao', ''),
            float(dados.get('preco', 0)),
            float(dados.get('custo', 0)),
            dados.get('categoria_id'),
            dados.get('tamanho', 'M'),
            1,
            int(dados.get('calorias', 0))
        ))
        conn.commit()
        produto_id = cursor.lastrowid
        cursor.close()
        conn.close()
        
        print(f"✅ Produto criado com ID: {produto_id}")
        return jsonify({'success': True, 'id': produto_id, 'message': 'Produto criado com sucesso!'}), 201
        
    except Exception as e:
        print(f"❌ Erro criar_produto: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/produtos/<int:id>', methods=['PUT'])
def atualizar_produto(id):
    try:
        dados = request.json
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE produtos 
            SET nome=%s, descricao=%s, preco=%s, custo=%s, categoria_id=%s, 
                tamanho=%s, ativo=%s, calorias=%s
            WHERE id=%s
        """, (dados.get('nome'), dados.get('descricao'), dados.get('preco'), 
              dados.get('custo'), dados.get('categoria_id'), 
              dados.get('tamanho'), dados.get('ativo', 1), dados.get('calorias'), id))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True, 'message': 'Produto atualizado com sucesso!'})
    except Exception as e:
        print(f"Erro atualizar_produto: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/produtos/<int:id>', methods=['DELETE'])
def deletar_produto(id):
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("UPDATE produtos SET ativo = 0 WHERE id=%s", (id,))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True, 'message': 'Produto removido com sucesso!'})
    except Exception as e:
        print(f"Erro deletar_produto: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

# CATEGORIAS
@app.route('/api/categorias', methods=['GET'])
def get_categorias():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM categorias ORDER BY nome")
        categorias = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(categorias)
    except Exception as e:
        print(f"Erro get_categorias: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/categorias', methods=['POST'])
def criar_categoria():
    try:
        dados = request.json
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("INSERT INTO categorias (nome) VALUES (%s)", (dados.get('nome'),))
        conn.commit()
        categoria_id = cursor.lastrowid
        cursor.close()
        conn.close()
        return jsonify({'id': categoria_id, 'message': 'Categoria criada!'}), 201
    except Exception as e:
        print(f"Erro criar_categoria: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/funcionarios', methods=['POST'])
def criar_funcionario():
    """Cria novo funcionário - REQUER AUTENTICAÇÃO DE GERENTE GERAL"""
    try:
        if not session.get('authenticated'):
            return jsonify({'success': False, 'error': 'Não autenticado'}), 401
        
        user = session.get('user', {})
        if user.get('cargo') != 'gerente_geral':
            return jsonify({
                'success': False, 
                'error': 'Apenas o Gerente Geral pode cadastrar funcionários'
            }), 403
        
        dados = request.json
        print(f"👤 Criando funcionário: {dados}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        
        cursor.execute("SELECT id FROM funcionarios WHERE cpf = %s", (dados.get('cpf'),))
        if cursor.fetchone():
            cursor.close()
            conn.close()
            return jsonify({'success': False, 'error': 'CPF já cadastrado'}), 400
        
            cursor.execute("""
            INSERT INTO funcionarios (nome, cpf, cargo, loja_id, salario, data_admissao, ativo)
            VALUES (%s, %s, %s, %s, %s, %s, 1)
        """, (
            dados.get('nome', ''),
            dados.get('cpf', ''),
            dados.get('cargo', ''),
            dados.get('loja_id'),
            float(dados.get('salario', 0)),
            dados.get('data_admissao', datetime.now().date())
        ))
        
        conn.commit()
        funcionario_id = cursor.lastrowid
        cursor.close()
        conn.close()
        
        print(f"✅ Funcionário criado com ID: {funcionario_id}")
        return jsonify({
            'success': True, 
            'id': funcionario_id, 
            'message': 'Funcionário cadastrado com sucesso!'
        }), 201
        
    except Exception as e:
        print(f"❌ Erro criar_funcionario: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500
    
@app.route('/cadastro-funcionario')
def cadastro_funcionario_page():
    if not session.get('authenticated'):
        return redirect('/')
    
    user = session.get('user', {})
    if user.get('cargo') != 'gerente_geral':
        return redirect('/admin')
    
    return render_template('cadastro_funcionario.html')
    
@app.route('/api/funcionarios/<int:id>', methods=['PUT'])
def atualizar_funcionario(id):
    try:
        dados = request.json
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE funcionarios 
            SET nome=%s, cpf=%s, cargo=%s, loja_id=%s, salario=%s, ativo=%s
            WHERE id=%s
        """, (dados.get('nome'), dados.get('cpf'), dados.get('cargo'), 
              dados.get('loja_id'), dados.get('salario'), dados.get('ativo', 1), id))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True, 'message': 'Funcionário atualizado com sucesso!'})
    except Exception as e:
        print(f"Erro atualizar_funcionario: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/funcionarios/<int:id>', methods=['DELETE'])
def deletar_funcionario(id):
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("UPDATE funcionarios SET ativo = 0 WHERE id=%s", (id,))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True, 'message': 'Funcionário removido com sucesso!'})
    except Exception as e:
        print(f"Erro deletar_funcionario: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/funcionarios/<int:id>', methods=['GET'])
def get_funcionario(id):
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT 
                f.*,
                COALESCE(l.nome, 'Sem loja') as loja_nome
            FROM funcionarios f
            LEFT JOIN lojas l ON f.loja_id = l.id
            WHERE f.id = %s
        """, (id,))
        funcionario = cursor.fetchone()
        
        cursor.close()
        conn.close()
        
        if funcionario:
            return jsonify(funcionario)
        else:
            return jsonify({'error': 'Funcionário não encontrado'}), 404
            
    except Exception as e:
        print(f"❌ Erro get_funcionario: {e}")
        return jsonify({'error': str(e)}), 500
    
@app.route('/api/lojas', methods=['GET'])
def get_lojas():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM lojas ORDER BY nome")
        lojas = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(lojas)
    except Exception as e:
        print(f"Erro get_lojas: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/lojas', methods=['POST'])
def criar_loja():
    try:
        dados = request.json
        print(f"🏪 Criando loja: {dados}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO lojas (nome, endereco, cidade, estado, telefone, ativo)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            dados.get('nome', ''),
            dados.get('endereco', ''),
            dados.get('cidade', ''),
            dados.get('estado', ''),
            dados.get('telefone', ''),
            1
        ))
        conn.commit()
        loja_id = cursor.lastrowid
        cursor.close()
        conn.close()
        
        print(f"✅ Loja criada com ID: {loja_id}")
        return jsonify({'success': True, 'id': loja_id, 'message': 'Loja criada com sucesso!'}), 201
        
    except Exception as e:
        print(f"❌ Erro criar_loja: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/lojas/<int:id>', methods=['PUT'])
def atualizar_loja(id):
    try:
        dados = request.json
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE lojas 
            SET nome=%s, endereco=%s, cidade=%s, estado=%s, telefone=%s, ativo=%s
            WHERE id=%s
        """, (dados.get('nome'), dados.get('endereco'), dados.get('cidade'), 
              dados.get('estado'), dados.get('telefone'), dados.get('ativo', 1), id))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True, 'message': 'Loja atualizada com sucesso!'})
    except Exception as e:
        print(f"Erro atualizar_loja: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/lojas/<int:id>', methods=['DELETE'])
def deletar_loja(id):
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("UPDATE lojas SET ativo = 0 WHERE id=%s", (id,))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True, 'message': 'Loja removida com sucesso!'})
    except Exception as e:
        print(f"Erro deletar_loja: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

# CLIENTES
@app.route('/api/clientes', methods=['GET'])
def get_clientes():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM clientes ORDER BY nome")
        clientes = cursor.fetchall()
        
        # Garantir campos
        for cliente in clientes:
            if 'nivel' not in cliente or not cliente['nivel']:
                cliente['nivel'] = 'Regular'
            if 'pontos' not in cliente:
                cliente['pontos'] = 0
            if 'total_compras' not in cliente:
                cliente['total_compras'] = 0
        
        cursor.close()
        conn.close()
        return jsonify(clientes)
    except Exception as e:
        print(f"Erro get_clientes: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/clientes', methods=['POST'])
def criar_cliente():
    try:
        dados = request.json
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO clientes (nome, email, telefone, pontos)
            VALUES (%s, %s, %s, %s)
        """, (dados.get('nome'), dados.get('email', ''), dados.get('telefone', ''), dados.get('pontos', 0)))
        conn.commit()
        cliente_id = cursor.lastrowid
        cursor.close()
        conn.close()
        return jsonify({'success': True, 'id': cliente_id, 'message': 'Cliente criado com sucesso!'}), 201
    except Exception as e:
        print(f"Erro criar_cliente: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/clientes/<int:id>', methods=['PUT'])
def atualizar_cliente(id):
    try:
        dados = request.json
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE clientes 
            SET nome=%s, email=%s, telefone=%s, pontos=%s
            WHERE id=%s
        """, (dados.get('nome'), dados.get('email'), dados.get('telefone'), 
              dados.get('pontos', 0), id))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True, 'message': 'Cliente atualizado com sucesso!'})
    except Exception as e:
        print(f"Erro atualizar_cliente: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/clientes/<int:id>', methods=['DELETE'])
def deletar_cliente(id):
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("DELETE FROM clientes WHERE id=%s", (id,))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True, 'message': 'Cliente removido com sucesso!'})
    except Exception as e:
        print(f"Erro deletar_cliente: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

# ESTOQUE
@app.route('/api/estoque', methods=['GET'])
def get_estoque():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
                
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT 
                e.id,
                e.loja_id,
                e.ingrediente_id,
                COALESCE(e.quantidade_atual, 0) as quantidade_atual,
                COALESCE(l.nome, 'Sem loja') as loja_nome,
                COALESCE(i.nome, 'Ingrediente desconhecido') as ingrediente_nome,
                COALESCE(i.unidade_medida, 'un') as unidade_medida,
                COALESCE(i.estoque_minimo, 0) as estoque_minimo,
                COALESCE(i.custo_unitario, 0) as custo_unitario,
                COALESCE(i.fornecedor, 'Não informado') as fornecedor,
                e.data_ultima_atualizacao,
                CASE 
                    WHEN e.quantidade_atual <= (i.estoque_minimo * 0.3) THEN 'CRÍTICO'
                    WHEN e.quantidade_atual <= (i.estoque_minimo * 0.5) THEN 'BAIXO'
                    WHEN e.quantidade_atual <= i.estoque_minimo THEN 'ATENÇÃO'
                    ELSE 'OK'
                END as status
            FROM estoque e
            LEFT JOIN lojas l ON e.loja_id = l.id
            LEFT JOIN ingredientes i ON e.ingrediente_id = i.id
            ORDER BY 
                CASE 
                    WHEN e.quantidade_atual <= (i.estoque_minimo * 0.3) THEN 1
                    WHEN e.quantidade_atual <= (i.estoque_minimo * 0.5) THEN 2
                    WHEN e.quantidade_atual <= i.estoque_minimo THEN 3
                    ELSE 4
                END,
                e.quantidade_atual
        """)
        
        estoque = cursor.fetchall()
        
        print(f"✅ Total de itens no estoque: {len(estoque)}")
        
        cursor.close()
        conn.close()
        
        return jsonify(estoque)
        
    except Exception as e:
        print(f"❌ Erro get_estoque: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)}), 500

@app.route('/api/dashboard', methods=['GET'])
def get_dashboard():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT COUNT(*) as total FROM produtos WHERE ativo = 1")
        total_produtos = cursor.fetchone()['total']
        
        cursor.execute("SELECT COUNT(*) as total FROM funcionarios WHERE ativo = 1")
        total_funcionarios = cursor.fetchone()['total']
        
        cursor.execute("SELECT COUNT(*) as total FROM lojas WHERE ativo = 1")
        total_lojas = cursor.fetchone()['total']
        
        cursor.execute("SELECT COUNT(*) as total FROM clientes")
        total_clientes = cursor.fetchone()['total']
       
        alertas_estoque = 0
        try:
            cursor.execute("""
                SELECT COUNT(*) as total 
                FROM estoque e
                INNER JOIN ingredientes i ON e.ingrediente_id = i.id
                WHERE e.quantidade_atual <= i.estoque_minimo
            """)
            result = cursor.fetchone()
            alertas_estoque = result['total'] if result else 0
        except:
            pass
        
        total_pedidos = 0
        receita_total = 0
        pedidos_hoje = 0
        receita_hoje = 0
        
        try:
            cursor.execute("""
                SELECT 
                    COUNT(*) as total, 
                    COALESCE(SUM(total), 0) as receita 
                FROM pedidos 
                WHERE status != 'cancelado'
            """)
            result = cursor.fetchone()
            total_pedidos = result['total'] if result else 0
            receita_total = float(result['receita']) if result and result['receita'] else 0
            
            cursor.execute("""
                SELECT 
                    COUNT(*) as total,
                    COALESCE(SUM(total), 0) as receita
                FROM pedidos 
                WHERE DATE(data_hora) = CURDATE() AND status != 'cancelado'
            """)
            result = cursor.fetchone()
            pedidos_hoje = result['total'] if result else 0
            receita_hoje = float(result['receita']) if result and result['receita'] else 0
        except Exception as e:
            print(f"Aviso dashboard pedidos: {e}")
        
        performance_lojas = []
        try:
            cursor.execute("""
                SELECT 
                    l.id,
                    l.nome,
                    COUNT(DISTINCT p.id) as total_pedidos,
                    COALESCE(SUM(p.total), 0) as receita,
                    COALESCE(AVG(p.total), 0) as ticket_medio
                FROM lojas l
                LEFT JOIN pedidos p ON l.id = p.loja_id 
                    AND DATE(p.data_hora) = CURDATE()
                    AND p.status != 'cancelado'
                WHERE l.ativo = 1
                GROUP BY l.id, l.nome
                ORDER BY receita DESC
            """)
            performance_lojas = cursor.fetchall()
        except Exception as e:
            print(f"Erro performance lojas: {e}")
        
        cursor.close()
        conn.close()
        
        ticket_medio = receita_total / total_pedidos if total_pedidos > 0 else 0
        
        return jsonify({
            'vendas_hoje': {
                'receita_total': receita_hoje,
                'total_pedidos': pedidos_hoje
            },
            'total_pedidos': total_pedidos,
            'receita_total': receita_total,
            'pedidos_hoje': pedidos_hoje,
            'ticket_medio': ticket_medio,
            'produtos': total_produtos,
            'funcionarios': total_funcionarios,
            'lojas': total_lojas,
            'clientes': total_clientes,
            'clientes_ativos': total_clientes,
            'alertas_estoque': alertas_estoque,
            'performance_lojas': performance_lojas
        })
    except Exception as e:
        print(f"Erro dashboard: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)}), 500

# ============= ROTAS DE RELATÓRIOS =============

@app.route('/api/relatorio/vendas', methods=['GET'])
def relatorio_vendas():
    try:
        periodo = request.args.get('periodo', 30, type=int)
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        
        # Tenta buscar de pedidos
        try:
            cursor.execute("""
                SELECT 
                    DATE(data_hora) as data,
                    COUNT(*) as total_pedidos,
                    SUM(total) as receita,
                    AVG(total) as ticket_medio
                FROM pedidos
                WHERE data_hora >= DATE_SUB(NOW(), INTERVAL %s DAY)
                    AND status != 'cancelado'
                GROUP BY DATE(data_hora)
                ORDER BY data DESC
            """, (periodo,))
            vendas = cursor.fetchall()
        except:
           vendas = []
        
        cursor.close()
        conn.close()
        
        return jsonify(vendas)
    except Exception as e:
        print(f"Erro relatorio_vendas: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/relatorio/produtos', methods=['GET'])
def relatorio_produtos():
    """Relatório de produtos mais vendidos"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT p.*, c.nome as categoria_nome,
                CASE 
                    WHEN p.custo > 0 THEN ((p.preco - p.custo) / p.custo * 100)
                    ELSE 0 
                END as margem_percentual
            FROM produtos p
            LEFT JOIN categorias c ON p.categoria_id = c.id
            WHERE p.ativo = 1
            ORDER BY p.nome
        """)
        produtos = cursor.fetchall()
        cursor.close()
        conn.close()
        
        return jsonify(produtos)
    except Exception as e:
        print(f"Erro relatorio_produtos: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/admin/dashboard', methods=['GET'])
def admin_dashboard():
    return get_dashboard()

@app.route('/api/admin/produtos', methods=['GET'])
def admin_get_produtos():
    return get_produtos()

@app.route('/api/admin/funcionarios', methods=['GET'])
def admin_get_funcionarios():
    return get_funcionarios()

@app.route('/api/admin/lojas', methods=['GET'])
def admin_get_lojas():
    return get_lojas()

@app.route('/api/admin/clientes', methods=['GET'])
def admin_get_clientes():
    return get_clientes()

@app.route('/api/admin/categorias', methods=['GET'])
def admin_get_categorias():
    return get_categorias()

@app.route('/api/admin/estoque', methods=['GET'])
def admin_get_estoque():
    return get_estoque()

# ============= INICIALIZAÇÃO =============

if __name__ == '__main__':
    print("\n🍦 Paraíso Gelado - Sistema Iniciando...")
    print(f"🌐 Servidor rodando em: http://0.0.0.0:5000")
    print(f"🗄️  Banco de dados: {DB_CONFIG['database']}")
    print(f"🔧 Debug mode: {Config.DEBUG}")
    print(f"👤 Login padrão: admin@paraisogelado.com / admin123\n")
    
    # Testa conexão com banco
    test_conn = get_db_connection()
    if test_conn:
        print("✅ Conexão com banco de dados: OK")
        test_conn.close()
    else:
        print("❌ Conexão com banco de dados: FALHOU")
        print("⚠️  Verifique as configurações em paraiso_config.py")
    
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=Config.DEBUG, host='0.0.0.0', port=port)