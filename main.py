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

# Rota de teste de conexão com banco
@app.route('/test-db')
def test_db():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        cursor.execute("SELECT 1")
        result = cursor.fetchone()
        cursor.close()
        conn.close()
        return jsonify({
            "status": "success",
            "message": "Conexão com banco de dados OK!",
            "result": result
        })
    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e),
            "db_config": {
                "host": DB_CONFIG.get('host'),
                "user": DB_CONFIG.get('user'),
                "database": DB_CONFIG.get('database'),
                "port": DB_CONFIG.get('port')
            }
        }), 500

# Rota de health check
@app.route('/health')
def health():
    return jsonify({
        "status": "online",
        "env_loaded": bool(os.getenv('DB_HOST'))
    })

@app.route('/admin')
def admin_panel():
    """Painel administrativo"""
    return render_template('admin.html')

@app.route('/')
def index():
    """Página de login"""
    return render_template('login.html')

# ============= ROTA DE LOGIN =============

@app.route('/api/login', methods=['POST'])
def login():
    """Autentica usuário no sistema"""
    try:
        data = request.json
        username = data.get('username')
        password = data.get('password')
        
        # Credenciais de demonstração
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
        
        # Verificar no banco de dados (funcionários)
        conn = get_db_connection()
        if conn:
            cursor = conn.cursor(dictionary=True)
            
            # Buscar por email ou CPF
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

# ============= ROTAS ADMIN - DASHBOARD =============

@app.route('/api/admin/dashboard', methods=['GET'])
def admin_dashboard():
    """Retorna dados do dashboard administrativo"""
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    try:
        cursor = conn.cursor(dictionary=True)
        
        # Vendas hoje
        cursor.execute("""
            SELECT 
                COUNT(*) as total_pedidos, 
                COALESCE(SUM(total), 0) as receita_total
            FROM pedidos
            WHERE DATE(data_hora) = CURDATE() AND status != 'cancelado'
        """)
        vendas_hoje = cursor.fetchone()
        
        # Clientes ativos (com pedido nos últimos 30 dias)
        cursor.execute("""
            SELECT COUNT(DISTINCT cliente_id) as clientes_ativos
            FROM pedidos
            WHERE data_hora >= DATE_SUB(NOW(), INTERVAL 30 DAY)
        """)
        clientes = cursor.fetchone()
        
        # Alertas de estoque
        cursor.execute("""
            SELECT COUNT(*) as total_alertas
            FROM estoque e
            JOIN ingredientes i ON e.ingrediente_id = i.id
            WHERE e.quantidade_atual <= i.estoque_minimo
        """)
        alertas = cursor.fetchone()
        
        # Performance por loja
        cursor.execute("""
            SELECT 
                l.id,
                l.nome,
                l.cidade,
                COUNT(p.id) as total_pedidos,
                COALESCE(SUM(p.total), 0) as receita,
                COALESCE(AVG(p.total), 0) as ticket_medio
            FROM lojas l
            LEFT JOIN pedidos p ON l.id = p.loja_id 
                AND DATE(p.data_hora) = CURDATE()
                AND p.status != 'cancelado'
            WHERE l.ativo = 1
            GROUP BY l.id, l.nome, l.cidade
            ORDER BY receita DESC
        """)
        performance_lojas = cursor.fetchall()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            'vendas_hoje': vendas_hoje,
            'clientes_ativos': clientes['clientes_ativos'],
            'alertas_estoque': alertas['total_alertas'],
            'performance_lojas': performance_lojas
        })
        
    except Exception as e:
        print(f"Erro no dashboard: {e}")
        return jsonify({'error': str(e)}), 500

# ============= ROTAS ADMIN - PRODUTOS =============

@app.route('/api/admin/produtos', methods=['GET'])
def admin_get_produtos():
    """Lista todos os produtos"""
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT p.*, c.nome as categoria_nome,
        CASE 
            WHEN p.custo > 0 THEN ((p.preco - p.custo) / p.custo * 100)
            ELSE 0 
        END as margem_percentual
        FROM produtos p
        JOIN categorias c ON p.categoria_id = c.id
        ORDER BY p.nome
    """)
    produtos = cursor.fetchall()
    cursor.close()
    conn.close()
    
    return jsonify(produtos)

@app.route('/api/admin/produtos', methods=['POST'])
def admin_criar_produto():
    """Cria novo produto"""
    try:
        data = request.json
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
        
        cursor = conn.cursor()
        query = """
            INSERT INTO produtos 
            (categoria_id, nome, descricao, preco, custo, tamanho, calorias, ativo)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (
            data['categoria_id'],
            data['nome'],
            data.get('descricao', ''),
            data['preco'],
            data.get('custo', 0),
            data['tamanho'],
            data.get('calorias', 0),
            data.get('ativo', 1)
        ))
        conn.commit()
        produto_id = cursor.lastrowid
        cursor.close()
        conn.close()
        
        return jsonify({'success': True, 'id': produto_id, 'message': 'Produto criado com sucesso'})
    except Exception as e:
        print(f"Erro ao criar produto: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/admin/produtos/<int:id>', methods=['DELETE'])
def admin_excluir_produto(id):
    """Exclui produto (desativa)"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
        
        cursor = conn.cursor()
        cursor.execute("UPDATE produtos SET ativo = 0 WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({'success': True, 'message': 'Produto removido com sucesso'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

# ============= ROTAS ADMIN - FUNCIONÁRIOS =============

@app.route('/api/admin/funcionarios', methods=['GET'])
def admin_get_funcionarios():
    """Lista todos os funcionários"""
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT f.*, l.nome as loja_nome
        FROM funcionarios f
        JOIN lojas l ON f.loja_id = l.id
        ORDER BY f.nome
    """)
    funcionarios = cursor.fetchall()
    cursor.close()
    conn.close()
    
    return jsonify(funcionarios)

@app.route('/api/admin/funcionarios', methods=['POST'])
def admin_criar_funcionario():
    """Cria novo funcionário"""
    try:
        data = request.json
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
        
        cursor = conn.cursor()
        query = """
            INSERT INTO funcionarios 
            (loja_id, nome, cpf, cargo, salario, data_admissao, ativo)
            VALUES (%s, %s, %s, %s, %s, %s, 1)
        """
        cursor.execute(query, (
            data['loja_id'],
            data['nome'],
            data['cpf'],
            data['cargo'],
            data['salario'],
            data['data_admissao']
        ))
        conn.commit()
        func_id = cursor.lastrowid
        cursor.close()
        conn.close()
        
        return jsonify({'success': True, 'id': func_id, 'message': 'Funcionário criado com sucesso'})
    except Exception as e:
        print(f"Erro ao criar funcionário: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/admin/funcionarios/<int:id>', methods=['DELETE'])
def admin_excluir_funcionario(id):
    """Exclui funcionário (desativa)"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
        
        cursor = conn.cursor()
        cursor.execute("UPDATE funcionarios SET ativo = 0 WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({'success': True, 'message': 'Funcionário removido com sucesso'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

# ============= ROTAS ADMIN - LOJAS =============

@app.route('/api/admin/lojas', methods=['GET'])
def admin_get_lojas():
    """Lista todas as lojas"""
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT l.*,
            (SELECT COUNT(*) FROM pedidos p 
             WHERE p.loja_id = l.id AND DATE(p.data_hora) = CURDATE()) as total_pedidos_hoje,
            (SELECT COALESCE(SUM(total), 0) FROM pedidos p 
             WHERE p.loja_id = l.id AND DATE(p.data_hora) = CURDATE() AND status != 'cancelado') as receita_hoje
        FROM lojas l
        ORDER BY l.nome
    """)
    lojas = cursor.fetchall()
    cursor.close()
    conn.close()
    
    return jsonify(lojas)

@app.route('/api/admin/lojas', methods=['POST'])
def admin_criar_loja():
    """Cria nova loja"""
    try:
        data = request.json
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
        
        cursor = conn.cursor()
        query = """
            INSERT INTO lojas 
            (nome, endereco, cidade, estado, cep, telefone, email, data_abertura, ativo)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, 1)
        """
        cursor.execute(query, (
            data['nome'],
            data['endereco'],
            data['cidade'],
            data['estado'],
            data['cep'],
            data['telefone'],
            data['email'],
            data['data_abertura']
        ))
        conn.commit()
        loja_id = cursor.lastrowid
        cursor.close()
        conn.close()
        
        return jsonify({'success': True, 'id': loja_id, 'message': 'Loja criada com sucesso'})
    except Exception as e:
        print(f"Erro ao criar loja: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

# ============= ROTAS ADMIN - CLIENTES =============

@app.route('/api/admin/clientes', methods=['GET'])
def admin_get_clientes():
    """Lista todos os clientes com estatísticas"""
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT c.*,
            COUNT(p.id) as total_pedidos,
            COALESCE(SUM(p.total), 0) as total_gasto,
            CASE 
                WHEN c.pontos_fidelidade >= 500 THEN 'VIP'
                WHEN c.pontos_fidelidade >= 200 THEN 'PREMIUM'
                ELSE 'REGULAR'
            END as nivel
        FROM clientes c
        LEFT JOIN pedidos p ON c.id = p.cliente_id AND p.status != 'cancelado'
        WHERE c.ativo = 1
        GROUP BY c.id
        ORDER BY total_gasto DESC
    """)
    clientes = cursor.fetchall()
    cursor.close()
    conn.close()
    
    return jsonify(clientes)

# ============= ROTAS ADMIN - ESTOQUE =============

@app.route('/api/admin/estoque', methods=['GET'])
def admin_get_estoque():
    """Lista estoque com alertas"""
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT e.*, 
            i.nome as ingrediente_nome,
            i.unidade_medida,
            i.estoque_minimo,
            l.nome as loja_nome,
            CASE 
                WHEN e.quantidade_atual <= (i.estoque_minimo * 0.3) THEN 'CRÍTICO'
                WHEN e.quantidade_atual <= (i.estoque_minimo * 0.5) THEN 'MUITO BAIXO'
                WHEN e.quantidade_atual <= i.estoque_minimo THEN 'BAIXO'
                ELSE 'OK'
            END as status_alerta
        FROM estoque e
        JOIN ingredientes i ON e.ingrediente_id = i.id
        JOIN lojas l ON e.loja_id = l.id
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
    cursor.close()
    conn.close()
    
    return jsonify(estoque)

@app.route('/api/admin/estoque/<int:id>/repor', methods=['POST'])
def admin_repor_estoque(id):
    """Repõe estoque de um ingrediente"""
    try:
        data = request.json
        quantidade = data.get('quantidade', 0)
        
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
        
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE estoque 
            SET quantidade_atual = quantidade_atual + %s,
                data_ultima_atualizacao = NOW()
            WHERE id = %s
        """, (quantidade, id))
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({'success': True, 'message': f'Estoque reposto com {quantidade} unidades'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

# ============= ROTAS ADMIN - CATEGORIAS =============

@app.route('/api/admin/categorias', methods=['GET'])
def admin_get_categorias():
    """Lista todas as categorias"""
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM categorias ORDER BY nome")
    categorias = cursor.fetchall()
    cursor.close()
    conn.close()
    
    return jsonify(categorias)

# ============= ROTAS ADMIN - RELATÓRIOS =============

@app.route('/api/admin/relatorio/vendas', methods=['GET'])
def admin_relatorio_vendas():
    """Relatório de vendas por período"""
    periodo = request.args.get('periodo', 30)
    
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    cursor = conn.cursor(dictionary=True)
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
    cursor.close()
    conn.close()
    
    return jsonify(vendas)

# ============= ROTAS PÚBLICAS (mantidas do código original) =============

@app.route('/api/produtos', methods=['GET'])
def get_produtos():
    """Busca todos os produtos usando AVL Tree"""
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM produtos WHERE ativo = 1")
    produtos = cursor.fetchall()
    
    # Carregar produtos na árvore AVL
    for produto in produtos:
        avl_tree.root = avl_tree.insert(
            avl_tree.root,
            produto['id'],
            produto['nome'],
            float(produto['preco'])
        )
        produto_cache.insert(produto['id'], produto)
    
    cursor.close()
    conn.close()
    return jsonify(produtos)

@app.route('/api/dashboard', methods=['GET'])
def dashboard():
    """Dashboard com estatísticas"""
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500
    
    cursor = conn.cursor(dictionary=True)
    
    # Total de vendas hoje
    cursor.execute("""
        SELECT COUNT(*) as total_pedidos, COALESCE(SUM(total), 0) as receita_total
        FROM pedidos
        WHERE DATE(data_hora) = CURDATE()
    """)
    vendas_hoje = cursor.fetchone()
    
    # Produtos mais vendidos
    cursor.execute("""
        SELECT p.nome, SUM(ip.quantidade) as total_vendido
        FROM itens_pedido ip
        JOIN produtos p ON ip.produto_id = p.id
        JOIN pedidos ped ON ip.pedido_id = ped.id
        WHERE DATE(ped.data_hora) = CURDATE()
        GROUP BY p.id
        ORDER BY total_vendido DESC
        LIMIT 5
    """)
    top_produtos = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    return jsonify({
        'vendas_hoje': vendas_hoje,
        'top_produtos': top_produtos,
        'pedidos_fila': order_queue.size()
    })

if __name__ == '__main__':
    print("\n🦆 Paraíso Gelado - Sistema Iniciando...")
    print(f"📊 Servidor rodando em: https://paraiso-gelado.onrender.com/")
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
    
    app.run(debug=Config.DEBUG, host='0.0.0.0', port=5000, load_dotenv=False)