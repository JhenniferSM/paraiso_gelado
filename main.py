import os
from flask import Flask, render_template, request, jsonify, session
from flask_cors import CORS
from datetime import datetime, timedelta
import hashlib
import json
from collections import deque
import heapq
from paraiso_config import Config

try:
    from dotenv import load_dotenv
    load_dotenv()
    print("✓ Variáveis de ambiente carregadas do .env")
except Exception as e:
    print(f"⚠️ Usando configurações padrão (erro ao carregar .env: {e})")

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

def calcular_margem(preco, custo):
    """Calcula margem de lucro percentual"""
    if custo and custo > 0:
        return round(((preco - custo) / custo) * 100, 1)
    return 0.0

def calcular_status_estoque(qtd_atual, qtd_minima):
    """Calcula status do estoque"""
    if qtd_minima <= 0:
        return 'OK'
    
    percentual = (qtd_atual / qtd_minima) * 100
    
    if percentual <= 30:
        return 'CRÍTICO'
    elif percentual <= 50:
        return 'MUITO BAIXO'
    elif percentual <= 100:
        return 'BAIXO'
    else:
        return 'OK'

def calcular_previsao_reposicao(qtd_atual, qtd_minima, consumo_medio_diario):
    """Calcula em quantos dias será necessário repor o estoque"""
    if consumo_medio_diario <= 0:
        return None
    
    dias_restantes = (qtd_atual - qtd_minima) / consumo_medio_diario
    
    if dias_restantes <= 0:
        return 0
    
    return int(dias_restantes)

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
    """Testa a conexão com o banco de dados"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({"status": "error", "message": "Não foi possível conectar ao banco"}), 500
        
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT 1")
        result = cursor.fetchone()
        
        tabelas_info = {}
        for tabela in ['funcionarios', 'lojas', 'estoque', 'ingredientes', 'produtos', 'categorias']:
            try:
                cursor.execute(f"DESCRIBE {tabela}")
                colunas = cursor.fetchall()
                tabelas_info[tabela] = [col['Field'] for col in colunas]
                
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
    """Autentica usuário no sistema"""
    try:
        data = request.json
        username = data.get('username')
        password = data.get('password')
        
        if username == 'admin@paraisogelado.com' and password == 'admin123':
            session['authenticated'] = True
            session['user'] = {
                'nome': 'Administrador',
                'email': username,
                'cargo': 'admin'
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
                JOIN lojas l ON f.loja_id = l.id
                WHERE f.cpf = %s OR %s LIKE CONCAT('%%', f.cpf, '%%')
            """
            cursor.execute(query, (username, username))
            funcionario = cursor.fetchone()
            
            cursor.close()
            conn.close()
            
            if funcionario and funcionario['cargo'] == 'gerente':
                session['authenticated'] = True
                session['user'] = {
                    'nome': funcionario['nome'],
                    'cpf': funcionario['cpf'],
                    'cargo': funcionario['cargo'],
                    'loja': funcionario['loja_nome']
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
    """Faz logout do sistema"""
    session.clear()
    return jsonify({'success': True, 'message': 'Logout realizado com sucesso'})

# ============= ROTAS API - PRODUTOS =============

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
                    WHEN p.custo > 0 THEN ROUND(((p.preco - p.custo) / p.custo) * 100, 1)
                    ELSE 0 
                END as margem_percentual
            FROM produtos p 
            LEFT JOIN categorias c ON p.categoria_id = c.id
            ORDER BY p.nome
        """)
        produtos = cursor.fetchall()
        
        # Garantir que margem está calculada
        for produto in produtos:
            if 'margem_percentual' not in produto or produto['margem_percentual'] is None:
                produto['margem_percentual'] = calcular_margem(
                    produto.get('preco', 0), 
                    produto.get('custo', 0)
                )
        
        cursor.close()
        conn.close()
        return jsonify(produtos)
    except Exception as e:
        print(f"Erro get_produtos: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/produtos/<int:id>', methods=['GET'])
def get_produto(id):
    """Busca um produto específico por ID"""
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
                    WHEN p.custo > 0 THEN ROUND(((p.preco - p.custo) / p.custo) * 100, 1)
                    ELSE 0 
                END as margem_percentual
            FROM produtos p 
            LEFT JOIN categorias c ON p.categoria_id = c.id
            WHERE p.id = %s
        """, (id,))
        produto = cursor.fetchone()
        cursor.close()
        conn.close()
        
        if produto:
            return jsonify(produto)
        else:
            return jsonify({'error': 'Produto não encontrado'}), 404
    except Exception as e:
        print(f"Erro get_produto: {e}")
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
        print(f"📝 Atualizando produto {id}: {dados}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE produtos 
            SET nome=%s, descricao=%s, preco=%s, custo=%s, categoria_id=%s, 
                tamanho=%s, ativo=%s, calorias=%s, updated_at=NOW()
            WHERE id=%s
        """, (
            dados.get('nome'), 
            dados.get('descricao'), 
            float(dados.get('preco', 0)), 
            float(dados.get('custo', 0)), 
            dados.get('categoria_id'), 
            dados.get('tamanho'), 
            dados.get('ativo', 1), 
            int(dados.get('calorias', 0)), 
            id
        ))
        conn.commit()
        cursor.close()
        conn.close()
        
        print(f"✅ Produto {id} atualizado com sucesso")
        return jsonify({'success': True, 'message': 'Produto atualizado com sucesso!'})
    except Exception as e:
        print(f"❌ Erro atualizar_produto: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/produtos/<int:id>', methods=['DELETE'])
def deletar_produto(id):
    try:
        print(f"🗑️ Deletando produto {id}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        
        # DELETE real do banco de dados
        cursor.execute("DELETE FROM produtos WHERE id=%s", (id,))
        
        conn.commit()
        rows_affected = cursor.rowcount
        cursor.close()
        conn.close()
        
        if rows_affected > 0:
            print(f"✅ Produto {id} deletado com sucesso")
            return jsonify({'success': True, 'message': 'Produto removido com sucesso!'})
        else:
            return jsonify({'success': False, 'error': 'Produto não encontrado'}), 404
            
    except Exception as e:
        print(f"❌ Erro deletar_produto: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

# ============= ROTAS API - CATEGORIAS =============

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

# ============= ROTAS API - FUNCIONÁRIOS =============

@app.route('/api/funcionarios', methods=['GET'])
def get_funcionarios():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        
        cursor.execute("""
            SELECT 
                f.*,
                COALESCE(l.nome, 'Sem loja') as loja_nome,
                COALESCE(f.ativo, 1) as ativo,
                COALESCE(f.salario, 0) as salario
            FROM funcionarios f
            LEFT JOIN lojas l ON f.loja_id = l.id
            ORDER BY f.nome
        """)
        funcionarios = cursor.fetchall()
        
        for func in funcionarios:
            if not func.get('loja_nome'):
                func['loja_nome'] = 'Sem loja'
            if 'ativo' not in func or func['ativo'] is None:
                func['ativo'] = 1
            if 'salario' not in func or func['salario'] is None:
                func['salario'] = 0
            if 'loja_id' not in func or func['loja_id'] is None:
                func['loja_id'] = 0
        
        cursor.close()
        conn.close()
        return jsonify(funcionarios)
    except Exception as e:
        print(f"❌ Erro get_funcionarios: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)}), 500

@app.route('/api/funcionarios/<int:id>', methods=['GET'])
def get_funcionario(id):
    """Busca um funcionário específico por ID"""
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
        print(f"Erro get_funcionario: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/funcionarios', methods=['POST'])
def criar_funcionario():
    try:
        dados = request.json
        print(f"👤 Criando funcionário: {dados}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO funcionarios (nome, cpf, cargo, loja_id, salario, data_admissao, ativo)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            dados.get('nome', ''),
            dados.get('cpf', ''),
            dados.get('cargo', ''),
            dados.get('loja_id'),
            float(dados.get('salario', 0)),
            dados.get('data_admissao', datetime.now().date()),
            1
        ))
        conn.commit()
        funcionario_id = cursor.lastrowid
        cursor.close()
        conn.close()
        
        print(f"✅ Funcionário criado com ID: {funcionario_id}")
        return jsonify({'success': True, 'id': funcionario_id, 'message': 'Funcionário criado com sucesso!'}), 201
        
    except Exception as e:
        print(f"❌ Erro criar_funcionario: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/funcionarios/<int:id>', methods=['PUT'])
def atualizar_funcionario(id):
    try:
        dados = request.json
        print(f"📝 Atualizando funcionário {id}: {dados}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE funcionarios 
            SET nome=%s, cpf=%s, cargo=%s, loja_id=%s, salario=%s, data_admissao=%s, ativo=%s
            WHERE id=%s
        """, (
            dados.get('nome'), 
            dados.get('cpf'), 
            dados.get('cargo'), 
            dados.get('loja_id'), 
            float(dados.get('salario', 0)), 
            dados.get('data_admissao'),
            dados.get('ativo', 1), 
            id
        ))
        conn.commit()
        cursor.close()
        conn.close()
        
        print(f"✅ Funcionário {id} atualizado com sucesso")
        return jsonify({'success': True, 'message': 'Funcionário atualizado com sucesso!'})
    except Exception as e:
        print(f"❌ Erro atualizar_funcionario: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/funcionarios/<int:id>', methods=['DELETE'])
def deletar_funcionario(id):
    try:
        print(f"🗑️ Deletando funcionário {id}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        
        # DELETE real do banco de dados
        cursor.execute("DELETE FROM funcionarios WHERE id=%s", (id,))
        
        conn.commit()
        rows_affected = cursor.rowcount
        cursor.close()
        conn.close()
        
        if rows_affected > 0:
            print(f"✅ Funcionário {id} deletado com sucesso")
            return jsonify({'success': True, 'message': 'Funcionário removido com sucesso!'})
        else:
            return jsonify({'success': False, 'error': 'Funcionário não encontrado'}), 404
            
    except Exception as e:
        print(f"❌ Erro deletar_funcionario: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

# ============= ROTAS API - LOJAS =============

@app.route('/api/lojas', methods=['GET'])
def get_lojas():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM lojas WHERE id = %s", (id,))
        loja = cursor.fetchone()
        cursor.close()
        conn.close()
        
        if loja:
            return jsonify(loja)
        else:
            return jsonify({'error': 'Loja não encontrada'}), 404
    except Exception as e:
        print(f"Erro get_loja: {e}")
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
            INSERT INTO lojas (nome, endereco, cidade, estado, cep, telefone, email, data_abertura, ativo)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            dados.get('nome', ''),
            dados.get('endereco', ''),
            dados.get('cidade', ''),
            dados.get('estado', ''),
            dados.get('cep', ''),
            dados.get('telefone', ''),
            dados.get('email', ''),
            dados.get('data_abertura', datetime.now().date()),
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
        print(f"📝 Atualizando loja {id}: {dados}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE lojas 
            SET nome=%s, endereco=%s, cidade=%s, estado=%s, cep=%s, telefone=%s, email=%s, data_abertura=%s, ativo=%s
            WHERE id=%s
        """, (
            dados.get('nome'), 
            dados.get('endereco'), 
            dados.get('cidade'), 
            dados.get('estado'), 
            dados.get('cep'),
            dados.get('telefone'), 
            dados.get('email'),
            dados.get('data_abertura'),
            dados.get('ativo', 1), 
            id
        ))
        conn.commit()
        cursor.close()
        conn.close()
        
        print(f"✅ Loja {id} atualizada com sucesso")
        return jsonify({'success': True, 'message': 'Loja atualizada com sucesso!'})
    except Exception as e:
        print(f"❌ Erro atualizar_loja: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/lojas/<int:id>', methods=['DELETE'])
def deletar_loja(id):
    try:
        print(f"🗑️ Deletando loja {id}")
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor()
        
        # DELETE real do banco de dados
        cursor.execute("DELETE FROM lojas WHERE id=%s", (id,))
        
        conn.commit()
        rows_affected = cursor.rowcount
        cursor.close()
        conn.close()
        
        if rows_affected > 0:
            print(f"✅ Loja {id} deletada com sucesso")
            return jsonify({'success': True, 'message': 'Loja removida com sucesso!'})
        else:
            return jsonify({'success': False, 'error': 'Loja não encontrada'}), 404
            
    except Exception as e:
        print(f"❌ Erro deletar_loja: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

# ============= ROTAS API - CLIENTES =============

@app.route('/api/clientes', methods=['GET'])
def get_clientes():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT 
                c.*,
                COUNT(DISTINCT p.id) as total_pedidos,
                COALESCE(SUM(p.total), 0) as total_gasto,
                CASE 
                    WHEN c.pontos_fidelidade >= 500 THEN 'VIP'
                    WHEN c.pontos_fidelidade >= 200 THEN 'Premium'
                    ELSE 'Regular'
                END as nivel
            FROM clientes c
            LEFT JOIN pedidos p ON c.id = p.cliente_id AND p.status != 'cancelado'
            GROUP BY c.id
            ORDER BY c.nome
        """)
        clientes = cursor.fetchall()
        
        for cliente in clientes:
            if 'nivel' not in cliente or not cliente['nivel']:
                cliente['nivel'] = 'Regular'
            if 'pontos_fidelidade' not in cliente:
                cliente['pontos_fidelidade'] = 0
            if 'total_pedidos' not in cliente:
                cliente['total_pedidos'] = 0
            if 'total_gasto' not in cliente:
                cliente['total_gasto'] = 0
        
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
            INSERT INTO clientes (nome, email, cpf, telefone, pontos_fidelidade)
            VALUES (%s, %s, %s, %s, %s)
        """, (dados.get('nome'), dados.get('email', ''), dados.get('cpf', ''), dados.get('telefone', ''), dados.get('pontos_fidelidade', 0)))
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
            SET nome=%s, email=%s, cpf=%s, telefone=%s, pontos_fidelidade=%s, updated_at=NOW()
            WHERE id=%s
        """, (dados.get('nome'), dados.get('email'), dados.get('cpf'), dados.get('telefone'), 
              dados.get('pontos_fidelidade', 0), id))
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

# ============= ROTAS API - ESTOQUE (COMPLETO) =============

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
                COALESCE(i.fornecedor, 'Não informado') as fornecedor
            FROM estoque e
            LEFT JOIN lojas l ON e.loja_id = l.id
            LEFT JOIN ingredientes i ON e.ingrediente_id = i.id
            ORDER BY e.quantidade_atual
        """)
        estoque = cursor.fetchall()
        
        # Calcular status e previsão para cada item
        for item in estoque:
            qtd_atual = float(item.get('quantidade_atual', 0))
            qtd_minima = float(item.get('estoque_minimo', 0))
            
            # Calcular status
            item['status_alerta'] = calcular_status_estoque(qtd_atual, qtd_minima)
            
            # Calcular consumo médio (últimos 7 dias)
            try:
                cursor.execute("""
                    SELECT COALESCE(AVG(quantidade_consumida), 0) as consumo_medio
                    FROM (
                        SELECT 
                            DATE(data_ultima_atualizacao) as data,
                            SUM(quantidade_atual) as quantidade_consumida
                        FROM estoque
                        WHERE ingrediente_id = %s 
                            AND loja_id = %s
                            AND data_ultima_atualizacao >= DATE_SUB(NOW(), INTERVAL 7 DAY)
                        GROUP BY DATE(data_ultima_atualizacao)
                    ) as consumo_diario
                """, (item['ingrediente_id'], item['loja_id']))
                
                resultado = cursor.fetchone()
                consumo_medio = float(resultado['consumo_medio']) if resultado else 0
                
                # Calcular previsão de reposição
                dias_reposicao = calcular_previsao_reposicao(qtd_atual, qtd_minima, consumo_medio)
                
                if dias_reposicao is not None:
                    if dias_reposicao <= 0:
                        item['previsao_reposicao'] = 'URGENTE - Repor imediatamente'
                    elif dias_reposicao <= 3:
                        item['previsao_reposicao'] = f'Repor em {dias_reposicao} dias'
                    elif dias_reposicao <= 7:
                        item['previsao_reposicao'] = f'Repor em {dias_reposicao} dias'
                    else:
                        item['previsao_reposicao'] = f'Estoque para {dias_reposicao} dias'
                else:
                    item['previsao_reposicao'] = 'Dados insuficientes'
                    
            except Exception as e:
                print(f"Erro ao calcular previsão: {e}")
                item['previsao_reposicao'] = 'Não calculado'
            
            # Buscar ficha técnica (produtos que usam este ingrediente)
            try:
                cursor.execute("""
                    SELECT 
                        p.nome as produto_nome,
                        ft.quantidade as quantidade_necessaria
                    FROM ficha_tecnica ft
                    INNER JOIN produtos p ON ft.produto_id = p.id
                    WHERE ft.ingrediente_id = %s
                    LIMIT 5
                """, (item['ingrediente_id'],))
                
                produtos_relacionados = cursor.fetchall()
                item['produtos_utilizam'] = [p['produto_nome'] for p in produtos_relacionados] if produtos_relacionados else []
                
            except Exception as e:
                print(f"Erro ao buscar ficha técnica: {e}")
                item['produtos_utilizam'] = []
            
            # Garantir todos os campos existem
            if not item.get('loja_nome'):
                item['loja_nome'] = 'Sem loja'
            if not item.get('ingrediente_nome'):
                item['ingrediente_nome'] = 'Ingrediente desconhecido'
            if 'quantidade_atual' not in item or item['quantidade_atual'] is None:
                item['quantidade_atual'] = 0
            if 'estoque_minimo' not in item or item['estoque_minimo'] is None:
                item['estoque_minimo'] = 0
            if not item.get('unidade_medida'):
                item['unidade_medida'] = 'un'
        
        cursor.close()
        conn.close()
        
        return jsonify(estoque)
    except Exception as e:
        print(f"❌ Erro get_estoque: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)}), 500

@app.route('/api/estoque/<int:id>/repor', methods=['POST'])
def repor_estoque(id):
    """Repõe quantidade no estoque"""
    try:
        dados = request.json
        quantidade = float(dados.get('quantidade', 0))
        
        if quantidade <= 0:
            return jsonify({'success': False, 'error': 'Quantidade inválida'}), 400
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'success': False, 'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        
        # Buscar item atual
        cursor.execute("SELECT * FROM estoque WHERE id = %s", (id,))
        item = cursor.fetchone()
        
        if not item:
            cursor.close()
            conn.close()
            return jsonify({'success': False, 'error': 'Item não encontrado'}), 404
        
        # Atualizar quantidade
        nova_quantidade = float(item['quantidade_atual']) + quantidade
        
        cursor.execute("""
            UPDATE estoque 
            SET quantidade_atual = %s, data_ultima_atualizacao = NOW()
            WHERE id = %s
        """, (nova_quantidade, id))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            'success': True, 
            'message': f'Estoque reposto com sucesso! Nova quantidade: {nova_quantidade}'
        })
        
    except Exception as e:
        print(f"❌ Erro repor_estoque: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/estoque/alertas', methods=['GET'])
def get_alertas_estoque():
    """Retorna apenas itens com alertas de estoque"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        
        cursor.execute("""
            SELECT 
                e.id,
                l.nome as loja_nome,
                i.nome as ingrediente_nome,
                e.quantidade_atual,
                i.estoque_minimo,
                i.unidade_medida,
                i.fornecedor,
                CASE 
                    WHEN e.quantidade_atual <= (i.estoque_minimo * 0.3) THEN 'CRÍTICO'
                    WHEN e.quantidade_atual <= (i.estoque_minimo * 0.5) THEN 'MUITO BAIXO'
                    WHEN e.quantidade_atual <= i.estoque_minimo THEN 'BAIXO'
                END as status_alerta
            FROM estoque e
            INNER JOIN lojas l ON e.loja_id = l.id
            INNER JOIN ingredientes i ON e.ingrediente_id = i.id
            WHERE e.quantidade_atual <= i.estoque_minimo
            ORDER BY 
                CASE 
                    WHEN e.quantidade_atual <= (i.estoque_minimo * 0.3) THEN 1
                    WHEN e.quantidade_atual <= (i.estoque_minimo * 0.5) THEN 2
                    ELSE 3
                END,
                e.quantidade_atual
        """)
        
        alertas = cursor.fetchall()
        cursor.close()
        conn.close()
        
        return jsonify({
            'total_alertas': len(alertas),
            'alertas': alertas
        })
        
    except Exception as e:
        print(f"Erro get_alertas_estoque: {e}")
        return jsonify({'error': str(e)}), 500

# ============= DASHBOARD =============

@app.route('/api/dashboard', methods=['GET'])
def get_dashboard():
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        
        # Totais básicos
        cursor.execute("SELECT COUNT(*) as total FROM produtos WHERE ativo = 1")
        total_produtos = cursor.fetchone()['total']
        
        cursor.execute("SELECT COUNT(*) as total FROM funcionarios WHERE ativo = 1")
        total_funcionarios = cursor.fetchone()['total']
        
        cursor.execute("SELECT COUNT(*) as total FROM lojas WHERE ativo = 1")
        total_lojas = cursor.fetchone()['total']
        
        cursor.execute("SELECT COUNT(*) as total FROM clientes")
        total_clientes = cursor.fetchone()['total']
        
        # Alertas de estoque
        cursor.execute("""
            SELECT COUNT(*) as total 
            FROM estoque e
            INNER JOIN ingredientes i ON e.ingrediente_id = i.id
            WHERE e.quantidade_atual <= i.estoque_minimo
        """)
        alertas_estoque = cursor.fetchone()['total']
        
        # Vendas e pedidos
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
        
        # Performance por loja
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
            performance_lojas = []
        
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
    """Relatório de vendas por período"""
    try:
        periodo = request.args.get('periodo', 30, type=int)
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)
        
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
                    WHEN p.custo > 0 THEN ROUND(((p.preco - p.custo) / p.custo) * 100, 1)
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

# ============= ROTAS ALIAS (ADMIN) =============

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
    
    test_conn = get_db_connection()
    if test_conn:
        print("✅ Conexão com banco de dados: OK")
        test_conn.close()
    else:
        print("❌ Conexão com banco de dados: FALHOU")
        print("⚠️  Verifique as configurações em paraiso_config.py")
    
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=Config.DEBUG, host='0.0.0.0', port=port) ORDER BY nome")
        lojas = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(lojas)
    except Exception as e:
        print(f"Erro get_lojas: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/lojas/<int:id>', methods=['GET'])
def get_loja(id):
    """Busca uma loja específica por ID"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco'}), 500
        
        cursor = conn.cursor(dictionary=True)