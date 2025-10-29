"""
Paraíso Gelado - CONFIGURAÇÕES
Sistema de Gestão de Franquia de Sorveteria
"""

import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    """Configurações base do sistema"""
    
    # Aplicação
    SECRET_KEY = os.getenv('SECRET_KEY', 'CHAVE_PADRAO_SECRETA_MUITO_LONGA_E_COMPLEXA')
    DEBUG = os.getenv('DEBUG', 'True') == 'True'
    
    # Banco de Dados
    DB_HOST = os.getenv('DB_HOST')
    DB_USER = os.getenv('DB_USER')
    DB_PASSWORD = os.getenv('DB_PASSWORD')
    DB_NAME = os.getenv('DB_NAME')
    DB_PORT = int(os.getenv('DB_PORT', 3306))
    
    # Configurações de Pool de Conexões
    DB_POOL_SIZE = 5
    DB_POOL_RECYCLE = 3600
    
    # API
    API_TITLE = 'Paraíso Gelado API'
    API_VERSION = '1.0.0'
    
    # Estruturas de Dados - Configurações
    AVL_MAX_HEIGHT = 50  # Altura máxima da árvore AVL
    HASH_TABLE_SIZE = 1000  # Tamanho da tabela hash
    MAX_QUEUE_SIZE = 100  # Tamanho máximo da fila
    
    # Cache
    CACHE_ENABLED = True
    CACHE_TIMEOUT = 300  # 5 minutos
    
    # Sessão
    SESSION_TIMEOUT = 3600  # 1 hora
    
    # Upload
    UPLOAD_FOLDER = 'uploads'
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB
    
    # Logs
    LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
    LOG_FILE = 'logs/paraiso_gelado.log'
    
    # Performance
    ENABLE_PROFILING = os.getenv('ENABLE_PROFILING', 'False') == 'True'
    
    # Segurança
    CORS_ORIGINS = os.getenv('CORS_ORIGINS', '*').split(',')
    
    @staticmethod
    def get_db_uri():
        """Retorna URI de conexão com o banco"""
        return f"mysql+pymysql://{Config.DB_USER}:{Config.DB_PASSWORD}@{Config.DB_HOST}:{Config.DB_PORT}/{Config.DB_NAME}"
    
    @staticmethod
    def get_db_config():
        """Retorna configurações do banco como dicionário"""
        return {
            'host': Config.DB_HOST,
            'user': Config.DB_USER,
            'password': Config.DB_PASSWORD,
            'database': Config.DB_NAME,
            'port': Config.DB_PORT
        }


class DevelopmentConfig(Config):
    """Configurações para desenvolvimento"""
    DEBUG = True
    TESTING = False


class ProductionConfig(Config):
    """Configurações para produção"""
    DEBUG = False
    TESTING = False
    
    # Em produção, SECRET_KEY deve ser definida
    def __init__(self):
        if not os.getenv('SECRET_KEY'):
            import warnings
            warnings.warn("SECRET_KEY não está definida! Use uma chave segura em produção.")


class TestingConfig(Config):
    """Configurações para testes"""
    TESTING = True
    DB_NAME = 'paraiso_gelado_test'


# Mapeamento de ambientes
config_by_name = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'testing': TestingConfig,
    'default': DevelopmentConfig
}


def get_config(env_name='default'):
    """Retorna configuração baseada no ambiente"""
    return config_by_name.get(env_name, DevelopmentConfig)