CREATE DATABASE  IF NOT EXISTS `sql10805055` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `sql10805055`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: sql10.freesqldatabase.com    Database: sql10805055
-- ------------------------------------------------------
-- Server version	5.5.62-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Sorvetes','Sorvetes artesanais em diversos sabores','2025-10-28 15:25:19'),(2,'Picolés','Picolés gourmet e tradicionais','2025-10-28 15:25:19'),(3,'Açaí','Açaí na tigela e copos','2025-10-28 15:25:19'),(4,'Milk-shakes','Milk-shakes cremosos','2025-10-28 15:25:19'),(5,'Sundaes','Sundaes especiais com coberturas','2025-10-28 15:25:19'),(6,'Combos','Combos promocionais','2025-10-28 15:25:19');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `pontos_fidelidade` int(11) DEFAULT '0',
  `senha_hash` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `idx_email` (`email`),
  KEY `idx_cpf` (`cpf`),
  KEY `idx_pontos` (`pontos_fidelidade`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'João Silva','joao.silva@email.com','123.456.789-00','(64) 99999-1111','1990-05-15',150,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(2,'Maria Santos','maria.santos@email.com','987.654.321-00','(64) 99999-2222','1985-08-22',320,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(3,'Pedro Oliveira','pedro.oliveira@email.com','456.789.123-00','(64) 99999-3333','1995-12-10',80,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(4,'Ana Costa','ana.costa@email.com','789.123.456-00','(64) 99999-4444','1988-03-28',450,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(5,'Carlos Ferreira','carlos.ferreira@email.com','321.654.987-00','(64) 99999-5555','1992-07-19',200,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loja_id` int(11) NOT NULL,
  `ingrediente_id` int(11) NOT NULL,
  `quantidade_atual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `data_ultima_atualizacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_loja_ingrediente` (`loja_id`,`ingrediente_id`),
  KEY `ingrediente_id` (`ingrediente_id`),
  KEY `idx_quantidade` (`quantidade_atual`),
  KEY `idx_estoque_alerta` (`loja_id`,`quantidade_atual`),
  CONSTRAINT `estoque_ibfk_1` FOREIGN KEY (`loja_id`) REFERENCES `lojas` (`id`),
  CONSTRAINT `estoque_ibfk_2` FOREIGN KEY (`ingrediente_id`) REFERENCES `ingredientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,1,1,80.00,'2025-10-28 15:25:19'),(2,1,2,40.00,'2025-10-28 15:25:19'),(3,1,3,120.00,'2025-10-28 15:25:19'),(4,1,4,15.00,'2025-10-28 15:25:19'),(5,1,5,25.00,'2025-10-28 15:25:19'),(6,1,6,8.00,'2025-10-28 15:25:19'),(7,1,7,600.00,'2025-10-28 15:25:19'),(8,1,8,20.00,'2025-10-28 15:25:19'),(9,1,9,60.00,'2025-10-28 15:25:19'),(10,1,10,25.00,'2025-10-28 15:25:19'),(11,1,11,35.00,'2025-10-28 15:25:19'),(12,1,12,12.00,'2025-10-28 15:25:19'),(13,2,1,75.00,'2025-10-28 15:25:19'),(14,2,2,38.00,'2025-10-28 15:25:19'),(15,2,3,115.00,'2025-10-28 15:25:19'),(16,2,4,13.00,'2025-10-28 15:25:19'),(17,2,9,55.00,'2025-10-28 15:25:19'),(18,2,10,22.00,'2025-10-28 15:25:19'),(19,2,11,32.00,'2025-10-28 15:25:19'),(20,3,1,70.00,'2025-10-28 15:25:19'),(21,3,2,35.00,'2025-10-28 15:25:19'),(22,3,3,110.00,'2025-10-28 15:25:19'),(23,3,4,12.00,'2025-10-28 15:25:19'),(24,3,9,50.00,'2025-10-28 15:25:19'),(25,3,10,20.00,'2025-10-28 15:25:19'),(26,3,11,30.00,'2025-10-28 15:25:19');
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ficha_tecnica`
--

DROP TABLE IF EXISTS `ficha_tecnica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ficha_tecnica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `produto_id` int(11) NOT NULL,
  `ingrediente_id` int(11) NOT NULL,
  `quantidade` decimal(10,3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_produto_ingrediente` (`produto_id`,`ingrediente_id`),
  KEY `ingrediente_id` (`ingrediente_id`),
  CONSTRAINT `ficha_tecnica_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ficha_tecnica_ibfk_2` FOREIGN KEY (`ingrediente_id`) REFERENCES `ingredientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ficha_tecnica`
--

LOCK TABLES `ficha_tecnica` WRITE;
/*!40000 ALTER TABLE `ficha_tecnica` DISABLE KEYS */;
INSERT INTO `ficha_tecnica` VALUES (1,1,1,0.300),(2,1,2,0.100),(3,1,3,0.050),(4,1,4,0.080),(5,2,1,0.300),(6,2,2,0.100),(7,2,3,0.050),(8,2,5,0.150),(9,9,9,0.300),(10,9,10,0.050),(11,9,11,0.100);
/*!40000 ALTER TABLE `ficha_tecnica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loja_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `cargo` enum('atendente','caixa','gerente','entregador') NOT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `data_admissao` date NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `idx_loja` (`loja_id`),
  KEY `idx_cargo` (`cargo`),
  CONSTRAINT `funcionarios_ibfk_1` FOREIGN KEY (`loja_id`) REFERENCES `lojas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
INSERT INTO `funcionarios` VALUES (1,1,'Roberto Alves','111.222.333-44','gerente',3500.00,'2024-01-15',1),(2,1,'Juliana Lima','222.333.444-55','atendente',1800.00,'2024-02-01',1),(3,1,'Fernando Costa','333.444.555-66','caixa',2000.00,'2024-02-15',1),(4,2,'Patrícia Rocha','444.555.666-77','gerente',3500.00,'2024-03-20',1),(5,2,'Lucas Martins','555.666.777-88','atendente',1800.00,'2024-04-01',1),(6,3,'Amanda Silva','666.777.888-99','gerente',3500.00,'2024-06-10',1),(7,2,'Sabrina Freitas','353.754.157-32','atendente',1200.00,'2025-02-12',1);
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredientes`
--

DROP TABLE IF EXISTS `ingredientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `unidade_medida` varchar(20) NOT NULL,
  `estoque_minimo` decimal(10,2) DEFAULT NULL,
  `custo_unitario` decimal(10,2) DEFAULT NULL,
  `fornecedor` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredientes`
--

LOCK TABLES `ingredientes` WRITE;
/*!40000 ALTER TABLE `ingredientes` DISABLE KEYS */;
INSERT INTO `ingredientes` VALUES (1,'Leite Integral','litro',50.00,4.50,'Laticínios Bom Gosto','2025-10-28 15:25:19'),(2,'Creme de Leite','litro',30.00,8.00,'Laticínios Bom Gosto','2025-10-28 15:25:19'),(3,'Açúcar','kg',100.00,3.50,'Açúcar União','2025-10-28 15:25:19'),(4,'Chocolate Belga','kg',10.00,45.00,'Callebaut','2025-10-28 15:25:19'),(5,'Morango Fresco','kg',20.00,12.00,'Frutas Premium','2025-10-28 15:25:19'),(6,'Pistache','kg',5.00,80.00,'Importadora Nuts','2025-10-28 15:25:19'),(7,'Baunilha Madagascar','grama',500.00,2.50,'Essências Naturais','2025-10-28 15:25:19'),(8,'Chocolate Flocos','kg',15.00,25.00,'Garoto','2025-10-28 15:25:19'),(9,'Açaí Polpa','kg',50.00,18.00,'Açaí Amazônia','2025-10-28 15:25:19'),(10,'Granola','kg',20.00,15.00,'Cereais Vida','2025-10-28 15:25:19'),(11,'Banana','kg',30.00,6.00,'Hortifruti Local','2025-10-28 15:25:19'),(12,'Ovomaltine','kg',10.00,35.00,'Nestlé','2025-10-28 15:25:19'),(13,'Brownie','unidade',50.00,3.50,'Confeitaria Doce Sabor','2025-10-28 15:25:19'),(14,'Calda Chocolate','litro',15.00,12.00,'Harald','2025-10-28 15:25:19'),(15,'Calda Caramelo','litro',15.00,14.00,'Harald','2025-10-28 15:25:19');
/*!40000 ALTER TABLE `ingredientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itens_pedido`
--

DROP TABLE IF EXISTS `itens_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itens_pedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `observacoes` text,
  PRIMARY KEY (`id`),
  KEY `idx_pedido` (`pedido_id`),
  KEY `idx_produto` (`produto_id`),
  KEY `idx_itens_pedido_composto` (`pedido_id`,`produto_id`),
  CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens_pedido`
--

LOCK TABLES `itens_pedido` WRITE;
/*!40000 ALTER TABLE `itens_pedido` DISABLE KEYS */;
INSERT INTO `itens_pedido` VALUES (1,1,1,2,12.90,NULL),(2,2,15,1,49.90,NULL),(3,3,9,1,16.90,NULL),(4,4,1,1,12.90,NULL),(5,4,2,1,11.90,NULL),(6,4,5,1,10.90,NULL),(7,4,6,1,7.90,NULL),(8,5,9,1,16.90,NULL),(9,5,11,1,14.90,NULL),(10,6,13,1,18.90,NULL),(11,7,1,1,12.90,NULL),(12,7,11,1,14.90,NULL),(13,8,11,1,14.90,NULL),(14,9,3,1,15.90,NULL),(15,9,4,1,13.90,NULL),(16,9,7,1,6.90,NULL);
/*!40000 ALTER TABLE `itens_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lojas`
--

DROP TABLE IF EXISTS `lojas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lojas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` char(2) NOT NULL,
  `cep` varchar(10) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `data_abertura` date DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_cidade` (`cidade`),
  KEY `idx_ativo` (`ativo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lojas`
--

LOCK TABLES `lojas` WRITE;
/*!40000 ALTER TABLE `lojas` DISABLE KEYS */;
INSERT INTO `lojas` VALUES (1,'Paraiso Gelado - Centro','Av. Principal, 1000','Goiatuba','GO','75600-000','(64) 3495-1000','centro@paraisogelado.com',-18.01230000,-49.34560000,'2024-01-15',1,'2025-10-28 15:25:19'),(2,'Paraiso Gelado - Shopping','Shopping Center, Loja 205','Goiatuba','GO','75600-001','(64) 3495-2000','shopping@paraisogelado.com',-18.02340000,-49.35670000,'2024-03-20',1,'2025-10-28 15:25:19'),(3,'Paraiso Gelado - Parque','Rua das Flores, 500','Goiatuba','GO','75600-002','(64) 3495-3000','parque@paraisogelado.com',-18.03450000,-49.36780000,'2024-06-10',1,'2025-10-28 15:25:19');
/*!40000 ALTER TABLE `lojas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `loja_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `desconto` decimal(10,2) DEFAULT '0.00',
  `taxa_entrega` decimal(10,2) DEFAULT '0.00',
  `status` enum('pendente','em_preparo','pronto','entregue','cancelado') DEFAULT 'pendente',
  `tipo` enum('local','delivery','retirada') DEFAULT 'local',
  `forma_pagamento` enum('dinheiro','cartao_credito','cartao_debito','pix','voucher') DEFAULT 'dinheiro',
  `observacoes` text,
  `data_hora` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `data_entrega` timestamp NULL DEFAULT NULL,
  `avaliacao` int(11) DEFAULT NULL,
  `comentario_avaliacao` text,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_data` (`data_hora`),
  KEY `idx_cliente` (`cliente_id`),
  KEY `idx_loja` (`loja_id`),
  KEY `idx_pedidos_data_status` (`data_hora`,`status`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`loja_id`) REFERENCES `lojas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,1,25.80,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-10-26 17:30:00','2025-10-26 17:45:00',5,'Excelente!'),(2,2,1,49.90,5.00,0.00,'entregue','local','pix',NULL,'2025-10-26 18:20:00','2025-10-26 18:35:00',5,'Adorei o combo!'),(3,3,2,16.90,0.00,5.00,'entregue','delivery','cartao_debito',NULL,'2025-10-26 19:10:00','2025-10-26 19:40:00',4,'Bom, mas demorou um pouco'),(4,4,1,42.60,2.00,0.00,'entregue','local','dinheiro',NULL,'2025-10-26 20:00:00','2025-10-26 20:15:00',5,'Perfeito!'),(5,5,3,31.80,0.00,6.00,'entregue','delivery','pix',NULL,'2025-10-26 21:30:00','2025-10-26 22:00:00',5,'Chegou quentinho!'),(6,1,2,18.90,0.00,0.00,'entregue','retirada','cartao_credito',NULL,'2025-10-27 13:15:00','2025-10-27 13:30:00',5,'Ótimo atendimento'),(7,2,1,27.80,0.00,0.00,'pronto','local','pix',NULL,'2025-10-27 14:00:00',NULL,NULL,NULL),(8,3,1,14.90,0.00,5.00,'em_preparo','delivery','cartao_credito',NULL,'2025-10-27 14:30:00',NULL,NULL,NULL),(9,4,2,33.70,0.00,0.00,'pendente','local','dinheiro',NULL,'2025-10-27 15:00:00',NULL,NULL,NULL);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text,
  `preco` decimal(10,2) NOT NULL,
  `custo` decimal(10,2) DEFAULT NULL,
  `tamanho` enum('P','M','G','ÚNICO') DEFAULT 'ÚNICO',
  `calorias` int(11) DEFAULT NULL,
  `imagem_url` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_categoria` (`categoria_id`),
  KEY `idx_preco` (`preco`),
  KEY `idx_ativo` (`ativo`),
  CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,1,'Sorvete Chocolate Belga','Sorvete cremoso de chocolate belga 70% cacau',12.90,4.50,'M',250,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(2,1,'Sorvete Morango Premium','Feito com morangos frescos selecionados',11.90,4.00,'M',220,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(3,1,'Sorvete Pistache','Sabor exótico com pistaches importados',15.90,6.00,'M',280,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(4,1,'Sorvete Baunilha Madagascar','Baunilha pura de Madagascar',13.90,5.00,'M',240,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(5,1,'Sorvete Flocos','Sorvete com pedaços de chocolate flocos',10.90,3.50,'M',260,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(6,2,'Picolé Frutas Vermelhas','Mix de frutas vermelhas naturais',7.90,2.50,'ÚNICO',120,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(7,2,'Picolé Limão Siciliano','Refrescante picolé de limão',6.90,2.00,'ÚNICO',100,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(8,2,'Picolé Chocolate Trufado','Cobertura de chocolate belga',8.90,3.00,'ÚNICO',180,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(9,3,'Açaí Bowl 300ml','Açaí puro com granola e banana',16.90,6.00,'M',350,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(10,3,'Açaí Bowl 500ml','Açaí com frutas e complementos',24.90,9.00,'G',550,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(11,4,'Milk-shake Ovomaltine','Clássico milk-shake com Ovomaltine',14.90,5.00,'M',400,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(12,4,'Milk-shake Morango','Milk-shake cremoso de morango',12.90,4.50,'M',350,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(13,5,'Sundae Brownie','Sorvete com brownie e calda de chocolate',18.90,7.00,'ÚNICO',500,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(14,5,'Sundae Caramelo','Sorvete com calda de caramelo salgado',17.90,6.50,'ÚNICO',480,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(15,6,'Combo Família','4 sorvetes + 2 picolés',49.90,20.00,'G',1200,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19');
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_alertas_estoque`
--

DROP TABLE IF EXISTS `v_alertas_estoque`;
/*!50001 DROP VIEW IF EXISTS `v_alertas_estoque`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_alertas_estoque` AS SELECT 
 1 AS `loja`,
 1 AS `ingrediente`,
 1 AS `quantidade_atual`,
 1 AS `estoque_minimo`,
 1 AS `unidade_medida`,
 1 AS `fornecedor`,
 1 AS `status_estoque`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_clientes_vip`
--

DROP TABLE IF EXISTS `v_clientes_vip`;
/*!50001 DROP VIEW IF EXISTS `v_clientes_vip`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_clientes_vip` AS SELECT 
 1 AS `id`,
 1 AS `nome`,
 1 AS `email`,
 1 AS `pontos_fidelidade`,
 1 AS `total_pedidos`,
 1 AS `total_gasto`,
 1 AS `ticket_medio`,
 1 AS `ultima_compra`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_produtos_mais_vendidos`
--

DROP TABLE IF EXISTS `v_produtos_mais_vendidos`;
/*!50001 DROP VIEW IF EXISTS `v_produtos_mais_vendidos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_produtos_mais_vendidos` AS SELECT 
 1 AS `id`,
 1 AS `nome`,
 1 AS `categoria`,
 1 AS `total_vendas`,
 1 AS `quantidade_total`,
 1 AS `receita_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_vendas_diarias`
--

DROP TABLE IF EXISTS `v_vendas_diarias`;
/*!50001 DROP VIEW IF EXISTS `v_vendas_diarias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_vendas_diarias` AS SELECT 
 1 AS `data`,
 1 AS `loja`,
 1 AS `total_pedidos`,
 1 AS `receita`,
 1 AS `ticket_medio`,
 1 AS `pedidos_delivery`,
 1 AS `pedidos_local`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_alertas_estoque`
--

/*!50001 DROP VIEW IF EXISTS `v_alertas_estoque`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`sql10805055`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_alertas_estoque` AS select `l`.`nome` AS `loja`,`i`.`nome` AS `ingrediente`,`e`.`quantidade_atual` AS `quantidade_atual`,`i`.`estoque_minimo` AS `estoque_minimo`,`i`.`unidade_medida` AS `unidade_medida`,`i`.`fornecedor` AS `fornecedor`,(case when (`e`.`quantidade_atual` <= (`i`.`estoque_minimo` * 0.5)) then 'CRÍTICO' when (`e`.`quantidade_atual` <= `i`.`estoque_minimo`) then 'BAIXO' else 'OK' end) AS `status_estoque` from ((`estoque` `e` join `lojas` `l` on((`e`.`loja_id` = `l`.`id`))) join `ingredientes` `i` on((`e`.`ingrediente_id` = `i`.`id`))) where (`e`.`quantidade_atual` <= `i`.`estoque_minimo`) order by (case when (`e`.`quantidade_atual` <= (`i`.`estoque_minimo` * 0.5)) then 1 when (`e`.`quantidade_atual` <= `i`.`estoque_minimo`) then 2 else 3 end),`e`.`quantidade_atual` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_clientes_vip`
--

/*!50001 DROP VIEW IF EXISTS `v_clientes_vip`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`sql10805055`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_clientes_vip` AS select `c`.`id` AS `id`,`c`.`nome` AS `nome`,`c`.`email` AS `email`,`c`.`pontos_fidelidade` AS `pontos_fidelidade`,count(`p`.`id`) AS `total_pedidos`,sum(`p`.`total`) AS `total_gasto`,avg(`p`.`total`) AS `ticket_medio`,max(`p`.`data_hora`) AS `ultima_compra` from (`clientes` `c` left join `pedidos` `p` on((`c`.`id` = `p`.`cliente_id`))) where (`p`.`status` <> 'cancelado') group by `c`.`id`,`c`.`nome`,`c`.`email`,`c`.`pontos_fidelidade` having (`total_pedidos` >= 3) order by sum(`p`.`total`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_produtos_mais_vendidos`
--

/*!50001 DROP VIEW IF EXISTS `v_produtos_mais_vendidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`sql10805055`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_produtos_mais_vendidos` AS select 1 AS `id`,1 AS `nome`,1 AS `categoria`,1 AS `total_vendas`,1 AS `quantidade_total`,1 AS `receita_total` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_vendas_diarias`
--

/*!50001 DROP VIEW IF EXISTS `v_vendas_diarias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`sql10805055`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_vendas_diarias` AS select 1 AS `data`,1 AS `loja`,1 AS `total_pedidos`,1 AS `receita`,1 AS `ticket_medio`,1 AS `pedidos_delivery`,1 AS `pedidos_local` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-29 14:02:10
