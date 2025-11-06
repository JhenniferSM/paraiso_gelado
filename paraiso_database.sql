CREATE DATABASE  IF NOT EXISTS "defaultdb" /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `defaultdb`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: paraiso-gelado-paraiso-gelado.f.aivencloud.com    Database: defaultdb
-- ------------------------------------------------------
-- Server version	8.0.35

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '60930544-ba6e-11f0-84f4-6211f22dfef6:1-311';

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Sorvetes','Sorvetes artesanais em diversos sabores','2025-10-28 15:25:19'),(2,'Picolés','Picolés gourmet e tradicionais','2025-10-28 15:25:19'),(3,'Açaí','Açaí na tigela e copos','2025-10-28 15:25:19'),(4,'Milk-shakes','Milk-shakes cremosos','2025-10-28 15:25:19'),(5,'Sundaes','Sundaes especiais com coberturas','2025-10-28 15:25:19'),(6,'Combos','Combos promocionais','2025-10-28 15:25:19'),(7,'Especiais de Inverno','Produtos sazonais de alto custo/valor','2025-10-28 15:25:19'),(8,'Adicionais/Toppings','Toppings, coberturas e extras','2025-10-28 15:25:19'),(9,'Bebidas Geladas','Bebidas refrescantes: chás gelados, cafés gelados, limonadas','2025-11-06 19:30:00'),(10,'Veganos','Linha vegana: sorvetes e opções sem laticínios','2025-11-06 19:30:00'),(11,'Sem Lactose','Sorvetes e milk-shakes sem lactose','2025-11-06 19:30:00'),(12,'Frozen Yogurt','Frozen yogurt com toppings variados','2025-11-06 19:30:00'),(13,'Infantis','Opções e combos para crianças, tamanhos P','2025-11-06 19:30:00');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `pontos_fidelidade` int DEFAULT '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'João Silva','joao.silva@email.com','123.456.789-00','(64) 99999-1111','1990-05-15',150,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(2,'Maria Santos','maria.santos@email.com','987.654.321-00','(64) 99999-2222','1985-08-22',320,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(3,'Pedro Oliveira','pedro.oliveira@email.com','456.789.123-00','(64) 99999-3333','1995-12-10',80,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(4,'Ana Costa','ana.costa@email.com','789.123.456-00','(64) 99999-4444','1988-03-28',450,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(5,'Carlos Ferreira','carlos.ferreira@email.com','321.654.987-00','(64) 99999-5555','1992-07-19',200,'55a5e9e78207b4df8699d60886fa070079463547b095d1a05bc719bb4e6cd251',1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(6,'Gabriel Moreira','gabriel.moreira@email.com','123.000.456-11','(64) 98888-6666','1998-01-20',100,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(7,'Camila Rocha','camila.rocha@email.com','987.000.321-22','(64) 97777-7777','1991-11-05',50,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(8,'Diego Souza','diego.souza@email.com','456.000.123-33','(64) 96666-8888','2000-06-30',250,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(9,'Helena Lima','helena.lima@email.com','789.000.456-44','(64) 95555-9999','1975-02-14',120,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(10,'Fábio Mendes','fabio.mendes@email.com','321.000.987-55','(64) 94444-1010','1982-04-25',180,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(11,'Isabela Costa','isabela.costa@email.com','111.222.333-66','(64) 93333-1111','1993-09-03',90,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(12,'Lucas Alencar','lucas.alencar@email.com','222.333.444-77','(64) 92222-2222','1987-12-12',300,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(13,'Renata Santos','renata.santos@email.com','333.444.555-88','(64) 91111-3333','1996-08-08',60,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(14,'Thiago Gomes','thiago.gomes@email.com','444.555.666-99','(64) 90000-4444','1984-05-01',110,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(15,'Vanessa Pereira','vanessa.pereira@email.com','555.666.777-00','(64) 98765-5555','1999-03-17',150,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(16,'Murilo Nunes','murilo.nunes@email.com','666.777.888-11','(64) 91234-6666','1994-10-10',40,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(17,'Beatriz Pires','beatriz.pires@email.com','777.888.999-22','(64) 93456-7777','1980-07-26',220,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(18,'Gustavo Vieira','gustavo.vieira@email.com','888.999.000-33','(64) 95678-8888','1997-04-04',70,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(19,'Lara Borges','lara.borges@email.com','999.000.111-44','(64) 97890-9999','1986-09-29',190,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(20,'Paulo Henrique','paulo.henrique@email.com','000.111.222-55','(64) 90123-0000','1990-11-11',130,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(21,'Viviane Sales','viviane.sales@email.com','101.202.303-12','(64) 91212-1212','1978-01-01',210,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(22,'Roger Machado','roger.machado@email.com','202.303.404-23','(64) 93434-3434','1983-02-02',10,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(23,'Silvana Tavares','silvana.tavares@email.com','303.404.505-34','(64) 95656-5656','1991-03-03',140,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(24,'Alexandre Neto','alexandre.neto@email.com','404.505.606-45','(64) 97878-7878','1970-04-04',30,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(25,'Bruna Melo','bruna.melo@email.com','505.606.707-56','(64) 99090-9090','2001-05-05',200,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(26,'Caio Ribeiro','caio.ribeiro@email.com','606.707.808-67','(64) 91313-1313','1989-06-06',75,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(27,'Diana Nogueira','diana.nogueira@email.com','707.808.909-78','(64) 92424-2424','1994-07-07',160,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(28,'Eduardo Paes','eduardo.paes@email.com','808.909.000-89','(64) 93535-3535','1981-08-08',85,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(29,'Fernanda Castro','fernanda.castro@email.com','909.000.111-90','(64) 94646-4646','1996-09-09',195,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(30,'Henrique Nunes','henrique.nunes@email.com','010.111.222-01','(64) 95757-5757','1976-10-10',45,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(31,'Ingrid Lins','ingrid.lins@email.com','111.212.313-12','(64) 96868-6868','1985-11-11',215,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(32,'Jorge Melo','jorge.melo@email.com','212.323.434-23','(64) 97979-7979','1990-12-12',55,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(33,'Kelly Silva','kelly.silva@email.com','313.414.515-34','(64) 98080-8080','1993-01-13',170,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(34,'Luan Vieira','luan.vieira@email.com','414.525.636-45','(64) 99191-9191','1988-02-14',95,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(35,'Márcia Sales','marcia.sales@email.com','515.636.747-56','(64) 90202-0202','2002-03-15',230,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(36,'Nelson Reis','nelson.reis@email.com','616.747.858-67','(64) 91414-1414','1979-04-16',65,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(37,'Olívia Pires','olivia.pires@email.com','717.858.969-78','(64) 92525-2525','1995-05-17',185,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(38,'Rafael Quadro','rafael.quadro@email.com','818.969.070-89','(64) 93636-3636','1984-06-18',105,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(39,'Sônia Telmo','sonia.telmo@email.com','919.070.181-90','(64) 94747-4747','1992-07-19',240,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(40,'Tadeu Urban','tadeu.urban@email.com','020.181.292-01','(64) 95858-5858','1977-08-20',70,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(41,'Úrsula Valadares','ursula.valadares@email.com','121.292.303-12','(64) 96969-6969','1999-09-21',155,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(42,'Victor Xavier','victor.xavier@email.com','222.303.414-23','(64) 97070-7070','1986-10-22',80,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(43,'Wallace Zico','wallace.zico@email.com','323.414.525-34','(64) 98181-8181','1994-11-23',205,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(44,'Yara Aguiar','yara.aguiar@email.com','424.525.636-45','(64) 99292-9292','1975-12-24',40,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(45,'Zélia Barroso','zelia.barroso@email.com','525.636.747-56','(64) 90303-0303','1983-01-25',125,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(46,'Artur Castro','artur.castro@email.com','626.747.858-67','(64) 91515-1515','1997-02-26',165,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(47,'Brenda Dantas','brenda.dantas@email.com','727.858.969-78','(64) 92626-2626','1989-03-27',55,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(48,'Cícero Elias','cicero.elias@email.com','828.969.070-89','(64) 93737-3737','1995-04-28',135,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(49,'Dora Farias','dora.farias@email.com','929.070.181-90','(64) 94848-4848','1980-05-29',245,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(50,'Érico Goes','erico.goes@email.com','030.181.292-01','(64) 95959-5959','1993-06-30',60,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(51,'Gisele Horta','gisele.horta@email.com','131.292.303-12','(64) 96060-6060','1987-07-01',175,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(52,'Hugo Isidoro','hugo.isidoro@email.com','232.303.414-23','(64) 97171-7171','1998-08-02',85,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(53,'Igor Justo','igor.justo@email.com','333.414.525-34','(64) 98282-8282','1982-09-03',200,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(54,'Janaína Leite','janaina.leite@email.com','434.525.636-45','(64) 99393-9393','1996-10-04',115,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(55,'Kleber Matos','kleber.matos@email.com','535.636.747-56','(64) 90404-0404','1985-11-05',90,'hash_simulado',1,'2025-11-06 19:05:34',NULL),(56,'Alice Ribeiro','alice.ribeiro@email.com','636.111.222-01','(64) 90011-0001','1994-02-02',10,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(57,'Bruno Castro','bruno.castro@email.com','737.222.333-02','(64) 90011-0002','1988-03-03',40,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(58,'Carla Vieira','carla.vieira@email.com','838.333.444-03','(64) 90011-0003','1990-04-04',25,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(59,'Diego Lima','diego.lima@email.com','939.444.555-04','(64) 90011-0004','1985-05-05',70,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(60,'Evelyn Moreira','evelyn.moreira@email.com','040.555.666-05','(64) 90011-0005','1998-06-06',15,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(61,'Fabiano Rezende','fabiano.rezende@email.com','141.666.777-06','(64) 90011-0006','1979-07-07',5,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(62,'Gabriela Rocha','gabriela.rocha2@email.com','242.777.888-07','(64) 90011-0007','1992-08-08',60,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(63,'Hugo Leite','hugo.leite@email.com','343.888.999-08','(64) 90011-0008','1991-09-09',35,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(64,'Íris Almeida','iris.almeida@email.com','444.999.000-09','(64) 90011-0009','2000-10-10',80,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(65,'Júlio Mendes','julio.mendes@email.com','545.000.111-10','(64) 90011-0010','1983-11-11',120,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(66,'Karine Fonseca','karine.fonseca@email.com','646.111.222-11','(64) 90011-0011','1996-12-12',30,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(67,'Leandro Duarte','leandro.duarte@email.com','747.222.333-12','(64) 90011-0012','1977-01-13',200,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(68,'Mariana Azevedo','mariana.azevedo@email.com','848.333.444-13','(64) 90011-0013','1995-02-14',85,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(69,'Natalia Gomes','natalia.gomes@email.com','949.444.555-14','(64) 90011-0014','1993-03-15',55,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(70,'Otávio Pinto','otavio.pinto@email.com','050.555.666-15','(64) 90011-0015','1980-04-16',40,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(71,'Patrícia Nascimento','patricia.nascimento@email.com','151.666.777-16','(64) 90011-0016','1986-05-17',95,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(72,'Queiroz Silva','queiroz.silva@email.com','252.777.888-17','(64) 90011-0017','1997-06-18',20,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(73,'Rafaela Campos','rafaela.campos@email.com','353.888.999-18','(64) 90011-0018','1999-07-19',65,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(74,'Samuel Borges','samuel.borges@email.com','454.999.000-19','(64) 90011-0019','1982-08-20',10,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(75,'Tatiana Barros','tatiana.barros@email.com','555.000.111-20','(64) 90011-0020','1994-09-21',150,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(76,'Ulisses Rocha','ulisses.rocha@email.com','656.111.222-21','(64) 90011-0021','1989-10-22',5,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(77,'Vera Sol','vera.sol@email.com','757.222.333-22','(64) 90011-0022','1975-11-23',180,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(78,'Wesley Tavares','wesley.tavares@email.com','858.333.444-23','(64) 90011-0023','1991-12-24',25,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(79,'Ximena Prado','ximena.prado@email.com','959.444.555-24','(64) 90011-0024','1998-01-25',35,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(80,'Yago Souza','yago.souza@email.com','060.555.666-25','(64) 90011-0025','1992-02-26',45,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(81,'Zara Lins','zara.lins@email.com','161.666.777-26','(64) 90011-0026','1987-03-27',75,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(82,'Adriano Faria','adriano.faria@email.com','262.777.888-27','(64) 90011-0027','1978-04-28',55,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(83,'Bel Oliveira','bel.oliveira@email.com','363.888.999-28','(64) 90011-0028','1996-05-29',95,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(84,'Cauã Reis','caua.reis@email.com','464.999.000-29','(64) 90011-0029','1993-06-30',20,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(85,'Dora Silva','dora.silva2@email.com','565.000.111-30','(64) 90011-0030','1990-07-01',60,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(86,'Emanuel Campos','emanuel.campos@email.com','666.111.222-31','(64) 90011-0031','1985-08-02',10,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(87,'Fernanda Lima','fernanda.lima2@email.com','767.222.333-32','(64) 90011-0032','1992-09-03',140,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(88,'Guilherme Pires','guilherme.pires@email.com','868.333.444-33','(64) 90011-0033','1991-10-04',35,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(89,'Helô Costa','helo.costa@email.com','969.444.555-34','(64) 90011-0034','1988-11-05',85,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(90,'Ícaro Melo','icaro.melo@email.com','070.555.666-35','(64) 90011-0035','1997-12-06',45,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(91,'Joana Prado','joana.prado@email.com','171.666.777-36','(64) 90011-0036','1995-01-07',75,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(92,'Kássia Martins','kassia.martins@email.com','272.777.888-37','(64) 90011-0037','1984-02-08',110,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(93,'Levi Santos','levi.santos@email.com','373.888.999-38','(64) 90011-0038','1990-03-09',95,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(94,'Marta Silva','marta.silva3@email.com','474.999.000-39','(64) 90011-0039','1976-04-10',40,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(95,'Noah Albuquerque','noah.albuquerque@email.com','575.000.111-40','(64) 90011-0040','2000-05-11',15,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(96,'Olga Duarte','olga.duarte@email.com','676.111.222-41','(64) 90011-0041','1982-06-12',140,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(97,'Paula Mendonça','paula.mendonca@email.com','777.222.333-42','(64) 90011-0042','1991-07-13',60,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(98,'Quésia Ramos','quesia.ramos@email.com','878.333.444-43','(64) 90011-0043','1993-08-14',70,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(99,'Ronaldo Silva','ronaldo.silva2@email.com','979.444.555-44','(64) 90011-0044','1980-09-15',30,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(100,'Sofia Carvalho','sofia.carvalho@email.com','080.555.666-45','(64) 90011-0045','1994-10-16',90,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(101,'Thiago Alves','thiago.alves2@email.com','181.666.777-46','(64) 90011-0046','1987-11-17',25,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(102,'Ursula Martins','ursula.martins2@email.com','282.777.888-47','(64) 90011-0047','1996-12-18',115,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(103,'Vitor Braga','vitor.braga@email.com','383.888.999-48','(64) 90011-0048','1992-01-19',50,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(104,'Wanda Lopes','wanda.lopes@email.com','484.999.000-49','(64) 90011-0049','1989-02-20',70,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(105,'Xavier Costa','xavier.costa2@email.com','585.000.111-50','(64) 90011-0050','1979-03-21',20,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(106,'Yasmin Franco','yasmin.franco@email.com','686.111.222-51','(64) 90011-0051','1998-04-22',85,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(107,'Zé Pedro','zepedro@email.com','787.222.333-52','(64) 90011-0052','1974-05-23',5,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(108,'Ana Vitória','ana.vitoria2@email.com','888.333.444-53','(64) 90011-0053','1997-06-24',110,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(109,'Brenda Souza','brenda.souza2@email.com','989.444.555-54','(64) 90011-0054','1990-07-25',45,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(110,'Caio Fernandes','caio.fernandes@email.com','090.555.666-55','(64) 90011-0055','1986-08-26',30,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(111,'Daniela Moura','daniela.moura@email.com','191.666.777-56','(64) 90011-0056','1995-09-27',95,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(112,'Eduardo Antunes','eduardo.antunes@email.com','292.777.888-57','(64) 90011-0057','1984-10-28',60,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(113,'Fabíola Dias','fabiola.dias@email.com','393.888.999-58','(64) 90011-0058','1991-11-29',100,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(114,'Gerson Pimenta','gerson.pimenta@email.com','494.999.000-59','(64) 90011-0059','1982-12-30',15,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(115,'Helena Rosa','helena.rosa2@email.com','595.000.111-60','(64) 90011-0060','1993-01-01',85,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(116,'Igor Batista','igor.batista2@email.com','696.111.222-61','(64) 90011-0061','1999-02-02',35,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(117,'Janice Pinto','janice.pinto@email.com','797.222.333-62','(64) 90011-0062','1976-03-03',40,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(118,'Kleber Rocha','kleber.rocha2@email.com','898.333.444-63','(64) 90011-0063','1981-04-04',50,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(119,'Larissa Neves','larissa.neves@email.com','999.444.555-64','(64) 90011-0064','1994-05-05',95,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(120,'Maurício Gomes','mauricio.gomes@email.com','100.555.666-65','(64) 90011-0065','1988-06-06',25,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(121,'Natália Freitas','natalia.freitas2@email.com','201.666.777-66','(64) 90011-0066','1996-07-07',115,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(122,'Orlando Lara','orlando.lara@email.com','302.777.888-67','(64) 90011-0067','1975-08-08',40,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(123,'Priscilla Dantas','priscilla.dantas@email.com','403.888.999-68','(64) 90011-0068','1990-09-09',85,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(124,'Rafael Mendes','rafael.mendes2@email.com','504.999.000-69','(64) 90011-0069','1983-10-10',55,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(125,'Sabrina Gomes','sabrina.gomes2@email.com','605.000.111-70','(64) 90011-0070','1992-11-11',65,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(126,'Tiago Rocha','tiago.rocha2@email.com','706.111.222-71','(64) 90011-0071','1989-12-12',30,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(127,'Ubiratan Silva','ubiratan.silva@email.com','807.222.333-72','(64) 90011-0072','1972-01-13',20,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(128,'Vanessa Cunha','vanessa.cunha2@email.com','908.333.444-73','(64) 90011-0073','1997-02-14',140,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(129,'Wagner Costa','wagner.costa2@email.com','009.444.555-74','(64) 90011-0074','1986-03-15',45,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(130,'Ylana Pereira','ylana.pereira@email.com','110.555.666-75','(64) 90011-0075','1999-04-16',60,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(131,'Zuleica Martins','zuleica.martins@email.com','211.666.777-76','(64) 90011-0076','1978-05-17',95,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(132,'Aline Furtado','aline.furtado2@email.com','312.777.888-77','(64) 90011-0077','1993-06-18',40,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(133,'Breno Mota','breno.mota2@email.com','413.888.999-78','(64) 90011-0078','1990-07-19',5,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(134,'Clara Nunes','clara.nunes2@email.com','514.999.000-79','(64) 90011-0079','1995-08-20',75,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(135,'Denise Ramos','denise.ramos2@email.com','615.000.111-80','(64) 90011-0080','1981-09-21',30,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(136,'Elias Duarte','elias.duarte2@email.com','716.111.222-81','(64) 90011-0081','1984-10-22',55,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(137,'Fátima Reis','fatima.reis2@email.com','817.222.333-82','(64) 90011-0082','1979-11-23',85,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(138,'Gustavo Rocha','gustavo.rocha2@email.com','918.333.444-83','(64) 90011-0083','1992-12-24',40,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(139,'Heloísa Prado','helo.prado2@email.com','019.444.555-84','(64) 90011-0084','1996-01-25',120,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(140,'Ivo Cardoso','ivo.cardoso@email.com','120.555.666-85','(64) 90011-0085','1987-02-26',15,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(141,'Jana Rocha','jana.rocha3@email.com','221.666.777-86','(64) 90011-0086','1991-03-27',65,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(142,'Kátia Silva','katia.silva3@email.com','322.777.888-87','(64) 90011-0087','1985-04-28',90,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(143,'Luís Alberto','luis.alberto@email.com','423.888.999-88','(64) 90011-0088','1973-05-29',35,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(144,'Marcos Vinicius','marcos.vinicius@email.com','524.999.000-89','(64) 90011-0089','1990-06-30',20,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(145,'Nadine Pinto','nadine.pinto2@email.com','625.000.111-90','(64) 90011-0090','1988-07-01',50,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(146,'Orlane Souza','orlane.souza@email.com','726.111.222-91','(64) 90011-0091','1994-08-02',105,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(147,'Paulo Ribeiro','paulo.ribeiro2@email.com','827.222.333-92','(64) 90011-0092','1982-09-03',30,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(148,'Quintino Alves','quintino.alves@email.com','928.333.444-93','(64) 90011-0093','1976-10-04',15,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(149,'Rute Amaro','rute.amaro@email.com','029.444.555-94','(64) 90011-0094','1991-11-05',70,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(150,'Sergio Nascimento','sergio.nascimento2@email.com','130.555.666-95','(64) 90011-0095','1989-12-06',45,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(151,'Tereza Lobo','tereza.lobo@email.com','231.666.777-96','(64) 90011-0096','1978-01-07',110,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(152,'Ulia Rocha','ulia.rocha@email.com','332.777.888-97','(64) 90011-0097','1995-02-08',60,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(153,'Vânia Silva','vania.silva3@email.com','433.888.999-98','(64) 90011-0098','1986-03-09',20,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(154,'Wellington Araújo','wellington.araujo@email.com','534.999.000-99','(64) 90011-0099','1993-04-10',95,'hash_simulado',1,'2025-11-06 19:30:00',NULL),(155,'Yvonne Campos','yvonne.campos@email.com','635.000.111-00','(64) 90011-0100','1990-05-11',55,'hash_simulado',1,'2025-11-06 19:30:00',NULL);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `loja_id` int NOT NULL,
  `ingrediente_id` int NOT NULL,
  `quantidade_atual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `data_ultima_atualizacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_loja_ingrediente` (`loja_id`,`ingrediente_id`),
  KEY `ingrediente_id` (`ingrediente_id`),
  KEY `idx_quantidade` (`quantidade_atual`),
  KEY `idx_estoque_alerta` (`loja_id`,`quantidade_atual`),
  CONSTRAINT `estoque_ibfk_1` FOREIGN KEY (`loja_id`) REFERENCES `lojas` (`id`),
  CONSTRAINT `estoque_ibfk_2` FOREIGN KEY (`ingrediente_id`) REFERENCES `ingredientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,1,1,55.00,'2025-11-06 19:06:50'),(2,1,2,40.00,'2025-10-28 15:25:19'),(3,1,3,90.00,'2025-11-06 19:06:50'),(4,1,4,100.00,'2025-11-06 19:06:51'),(5,1,5,150.00,'2025-11-06 19:06:51'),(6,1,6,8.00,'2025-10-28 15:25:19'),(7,1,7,600.00,'2025-10-28 15:25:19'),(8,1,8,20.00,'2025-10-28 15:25:19'),(9,1,9,25.00,'2025-11-06 19:06:50'),(10,1,10,15.00,'2025-11-06 19:06:50'),(11,1,11,20.00,'2025-11-06 19:06:51'),(12,1,12,12.00,'2025-10-28 15:25:19'),(13,2,1,50.00,'2025-11-06 19:06:50'),(14,2,2,38.00,'2025-10-28 15:25:19'),(15,2,3,85.00,'2025-11-06 19:06:50'),(16,2,4,13.00,'2025-10-28 15:25:19'),(17,2,9,20.00,'2025-11-06 19:06:50'),(18,2,10,12.00,'2025-11-06 19:06:50'),(19,2,11,17.00,'2025-11-06 19:06:51'),(20,3,1,70.00,'2025-10-28 15:25:19'),(21,3,2,35.00,'2025-10-28 15:25:19'),(22,3,3,110.00,'2025-10-28 15:25:19'),(23,3,4,12.00,'2025-10-28 15:25:19'),(24,3,9,15.00,'2025-11-06 19:06:50'),(25,3,10,10.00,'2025-11-06 19:06:50'),(26,3,11,15.00,'2025-11-06 19:06:51'),(27,1,13,40.00,'2025-11-06 19:06:51'),(28,2,13,35.00,'2025-11-06 19:06:51'),(29,3,13,30.00,'2025-11-06 19:06:51'),(30,1,14,10.00,'2025-11-06 19:06:51'),(31,2,14,8.00,'2025-11-06 19:06:51'),(32,3,14,7.00,'2025-11-06 19:06:51'),(33,1,15,10.00,'2025-11-06 19:06:51'),(34,2,15,9.00,'2025-11-06 19:06:51'),(35,3,15,8.00,'2025-11-06 19:06:51'),(36,4,1,60.00,'2025-11-06 19:30:00'),(37,4,2,40.00,'2025-11-06 19:30:00'),(38,4,3,120.00,'2025-11-06 19:30:00'),(39,4,4,25.00,'2025-11-06 19:30:00'),(40,4,5,30.00,'2025-11-06 19:30:00'),(41,4,6,10.00,'2025-11-06 19:30:00'),(42,4,7,400.00,'2025-11-06 19:30:00'),(43,4,8,20.00,'2025-11-06 19:30:00'),(44,4,9,40.00,'2025-11-06 19:30:00'),(45,4,10,18.00,'2025-11-06 19:30:00'),(46,5,1,55.00,'2025-11-06 19:30:00'),(47,5,2,36.00,'2025-11-06 19:30:00'),(48,5,3,110.00,'2025-11-06 19:30:00'),(49,5,4,20.00,'2025-11-06 19:30:00'),(50,5,5,25.00,'2025-11-06 19:30:00'),(51,5,6,8.00,'2025-11-06 19:30:00'),(52,5,7,350.00,'2025-11-06 19:30:00'),(53,5,8,18.00,'2025-11-06 19:30:00'),(54,5,9,30.00,'2025-11-06 19:30:00'),(55,5,10,15.00,'2025-11-06 19:30:00'),(56,6,1,50.00,'2025-11-06 19:30:00'),(57,6,2,34.00,'2025-11-06 19:30:00'),(58,6,3,100.00,'2025-11-06 19:30:00'),(59,6,4,18.00,'2025-11-06 19:30:00'),(60,6,5,28.00,'2025-11-06 19:30:00'),(61,6,6,6.00,'2025-11-06 19:30:00'),(62,6,7,320.00,'2025-11-06 19:30:00'),(63,6,8,15.00,'2025-11-06 19:30:00'),(64,6,9,25.00,'2025-11-06 19:30:00'),(65,6,10,12.00,'2025-11-06 19:30:00'),(66,7,1,65.00,'2025-11-06 19:30:00'),(67,7,2,38.00,'2025-11-06 19:30:00'),(68,7,3,125.00,'2025-11-06 19:30:00'),(69,7,4,22.00,'2025-11-06 19:30:00'),(70,7,5,33.00,'2025-11-06 19:30:00'),(71,7,6,9.00,'2025-11-06 19:30:00'),(72,7,7,450.00,'2025-11-06 19:30:00'),(73,7,8,22.00,'2025-11-06 19:30:00'),(74,7,9,35.00,'2025-11-06 19:30:00'),(75,7,10,20.00,'2025-11-06 19:30:00'),(76,8,1,45.00,'2025-11-06 19:30:00'),(77,8,2,30.00,'2025-11-06 19:30:00'),(78,8,3,90.00,'2025-11-06 19:30:00'),(79,8,4,15.00,'2025-11-06 19:30:00'),(80,8,5,20.00,'2025-11-06 19:30:00'),(81,8,6,7.00,'2025-11-06 19:30:00'),(82,8,7,280.00,'2025-11-06 19:30:00'),(83,8,8,12.00,'2025-11-06 19:30:00'),(84,8,9,22.00,'2025-11-06 19:30:00'),(85,8,10,10.00,'2025-11-06 19:30:00'),(86,9,1,70.00,'2025-11-06 19:30:00'),(87,9,2,45.00,'2025-11-06 19:30:00'),(88,9,3,140.00,'2025-11-06 19:30:00'),(89,9,4,28.00,'2025-11-06 19:30:00'),(90,9,5,40.00,'2025-11-06 19:30:00'),(91,9,6,11.00,'2025-11-06 19:30:00'),(92,9,7,500.00,'2025-11-06 19:30:00'),(93,9,8,24.00,'2025-11-06 19:30:00'),(94,9,9,45.00,'2025-11-06 19:30:00'),(95,9,10,22.00,'2025-11-06 19:30:00'),(96,10,1,48.00,'2025-11-06 19:30:00'),(97,10,2,35.00,'2025-11-06 19:30:00'),(98,10,3,105.00,'2025-11-06 19:30:00'),(99,10,4,16.00,'2025-11-06 19:30:00'),(100,10,5,21.00,'2025-11-06 19:30:00'),(101,10,6,8.50,'2025-11-06 19:30:00'),(102,10,7,300.00,'2025-11-06 19:30:00'),(103,10,8,14.00,'2025-11-06 19:30:00'),(104,10,9,28.00,'2025-11-06 19:30:00'),(105,10,10,14.00,'2025-11-06 19:30:00'),(106,11,1,60.00,'2025-11-06 19:30:00'),(107,11,2,40.00,'2025-11-06 19:30:00'),(108,11,3,115.00,'2025-11-06 19:30:00'),(109,11,4,21.00,'2025-11-06 19:30:00'),(110,11,5,26.00,'2025-11-06 19:30:00'),(111,11,6,9.00,'2025-11-06 19:30:00'),(112,11,7,380.00,'2025-11-06 19:30:00'),(113,11,8,16.00,'2025-11-06 19:30:00'),(114,11,9,32.00,'2025-11-06 19:30:00'),(115,11,10,16.00,'2025-11-06 19:30:00'),(116,12,1,52.00,'2025-11-06 19:30:00'),(117,12,2,36.00,'2025-11-06 19:30:00'),(118,12,3,98.00,'2025-11-06 19:30:00'),(119,12,4,17.00,'2025-11-06 19:30:00'),(120,12,5,23.00,'2025-11-06 19:30:00'),(121,12,6,8.00,'2025-11-06 19:30:00'),(122,12,7,305.00,'2025-11-06 19:30:00'),(123,12,8,13.00,'2025-11-06 19:30:00'),(124,12,9,26.00,'2025-11-06 19:30:00'),(125,12,10,13.00,'2025-11-06 19:30:00'),(126,13,1,58.00,'2025-11-06 19:30:00'),(127,13,2,39.00,'2025-11-06 19:30:00'),(128,13,3,112.00,'2025-11-06 19:30:00'),(129,13,4,19.00,'2025-11-06 19:30:00'),(130,13,5,29.00,'2025-11-06 19:30:00'),(131,13,6,9.50,'2025-11-06 19:30:00'),(132,13,7,360.00,'2025-11-06 19:30:00'),(133,13,8,17.00,'2025-11-06 19:30:00'),(134,13,9,34.00,'2025-11-06 19:30:00'),(135,13,10,17.00,'2025-11-06 19:30:00'),(136,14,1,46.00,'2025-11-06 19:30:00'),(137,14,2,33.00,'2025-11-06 19:30:00'),(138,14,3,92.00,'2025-11-06 19:30:00'),(139,14,4,15.00,'2025-11-06 19:30:00'),(140,14,5,22.00,'2025-11-06 19:30:00'),(141,14,6,7.50,'2025-11-06 19:30:00'),(142,14,7,290.00,'2025-11-06 19:30:00'),(143,14,8,12.50,'2025-11-06 19:30:00'),(144,14,9,24.00,'2025-11-06 19:30:00'),(145,14,10,12.50,'2025-11-06 19:30:00'),(146,15,1,62.00,'2025-11-06 19:30:00'),(147,15,2,42.00,'2025-11-06 19:30:00'),(148,15,3,130.00,'2025-11-06 19:30:00'),(149,15,4,24.00,'2025-11-06 19:30:00'),(150,15,5,36.00,'2025-11-06 19:30:00'),(151,16,6,12.00,'2025-11-06 19:30:00'),(152,16,7,410.00,'2025-11-06 19:30:00'),(153,16,8,20.00,'2025-11-06 19:30:00'),(154,16,9,38.00,'2025-11-06 19:30:00'),(155,16,10,19.00,'2025-11-06 19:30:00');
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ficha_tecnica`
--

DROP TABLE IF EXISTS `ficha_tecnica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ficha_tecnica` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produto_id` int NOT NULL,
  `ingrediente_id` int NOT NULL,
  `quantidade` decimal(10,3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_produto_ingrediente` (`produto_id`,`ingrediente_id`),
  KEY `ingrediente_id` (`ingrediente_id`),
  CONSTRAINT `ficha_tecnica_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ficha_tecnica_ibfk_2` FOREIGN KEY (`ingrediente_id`) REFERENCES `ingredientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ficha_tecnica`
--

LOCK TABLES `ficha_tecnica` WRITE;
/*!40000 ALTER TABLE `ficha_tecnica` DISABLE KEYS */;
INSERT INTO `ficha_tecnica` VALUES (1,1,1,0.300),(2,1,2,0.100),(3,1,3,0.050),(4,1,4,0.080),(5,2,1,0.300),(6,2,2,0.100),(7,2,3,0.050),(8,2,5,0.150),(9,9,9,0.300),(10,9,10,0.050),(11,9,11,0.100),(12,16,1,0.350),(13,16,2,0.150),(14,17,3,0.080),(15,17,5,0.200),(16,18,1,0.300),(17,18,7,0.050),(18,20,1,0.250),(19,20,7,0.030),(20,21,9,0.200),(21,21,10,0.030),(22,22,9,0.550),(23,22,10,0.080),(24,23,1,0.200),(25,23,3,0.020),(26,24,2,0.100),(27,24,4,0.050),(28,25,13,0.500),(29,25,14,0.050),(30,27,5,0.150),(31,28,3,0.070),(32,29,7,0.020),(33,30,5,0.180),(34,31,5,0.220),(35,32,3,0.050),(36,33,1,0.400),(37,33,2,0.180),(38,34,1,0.350),(39,35,5,0.250),(40,36,3,0.040),(41,37,3,0.030),(42,38,3,0.025),(43,39,1,0.100),(44,39,5,0.100),(45,40,3,0.030),(46,41,9,0.300),(47,41,5,0.050),(48,42,9,0.500),(49,43,9,0.300),(50,44,1,0.200),(51,45,1,0.250),(52,46,6,0.050),(53,46,14,0.060),(54,47,5,0.100),(55,47,15,0.040),(56,51,7,0.040),(57,53,9,0.500),(58,54,1,0.200),(59,55,13,0.800),(60,55,14,0.080),(61,56,3,0.080),(62,56,14,0.020),(63,57,3,0.050),(64,57,12,0.010),(65,58,1,0.200),(66,58,5,0.150),(67,59,5,0.200),(68,59,3,0.020),(69,60,2,0.200),(70,60,12,0.030),(71,61,1,0.150),(72,61,10,0.050),(73,62,1,0.200),(74,62,5,0.100),(75,63,13,0.020),(76,63,11,0.100),(77,64,13,0.020),(78,64,8,0.030),(79,65,2,0.180),(80,65,14,0.040),(81,66,5,0.200),(82,66,7,0.020),(83,67,3,0.150),(84,67,4,0.050),(85,68,1,0.200),(86,68,5,0.120),(87,69,5,0.150),(88,69,3,0.020),(89,70,4,0.120),(90,70,3,0.020),(91,71,9,0.450),(92,71,10,0.070),(93,72,12,0.060),(94,72,11,0.050),(95,73,13,0.200),(96,73,12,0.150),(97,74,5,0.120),(98,74,3,0.020),(99,75,4,0.200),(100,75,3,0.050),(101,76,13,0.120),(102,76,5,0.150),(103,77,13,0.350),(104,77,4,0.090),(105,78,9,0.600),(106,78,2,0.050),(107,79,4,0.220),(108,79,3,0.050),(109,80,16,0.150),(110,80,15,0.010),(111,81,3,0.120),(112,81,4,0.050),(113,82,5,0.200),(114,82,3,0.020),(115,83,1,0.120),(116,83,12,0.020),(117,84,13,0.800),(118,84,14,0.200),(119,85,2,0.200),(120,85,4,0.050);
/*!40000 ALTER TABLE `ficha_tecnica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `loja_id` int NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
INSERT INTO `funcionarios` VALUES (1,1,'Roberto Alves','111.222.333-44','gerente',3500.00,'2024-01-15',1),(2,1,'Juliana Lima','222.333.444-55','atendente',1800.00,'2024-02-01',1),(3,1,'Fernando Costa','333.444.555-66','caixa',2000.00,'2024-02-15',1),(4,2,'Patrícia Rocha','444.555.666-77','gerente',3500.00,'2024-03-20',1),(5,2,'Lucas Martins','555.666.777-88','atendente',1800.00,'2024-04-01',1),(6,3,'Amanda Silva','666.777.888-99','gerente',3500.00,'2024-06-10',1),(7,2,'Sabrina Freitas','353.754.157-32','atendente',1200.00,'2025-02-12',1),(8,1,'Marcos Paiva','101.202.303-13','atendente',1600.00,'2025-01-10',1),(9,1,'Soraia Mendes','102.303.404-14','caixa',1900.00,'2025-02-05',1),(10,2,'Roberta Silva','103.404.505-15','atendente',1500.00,'2025-02-10',1),(11,2,'Geraldo Pinto','104.505.606-16','entregador',1400.00,'2025-03-01',1),(12,3,'Lívia Andrade','105.606.707-17','atendente',1600.00,'2025-03-12',1),(13,3,'Mateus Ramos','106.707.808-18','caixa',1950.00,'2025-04-01',1),(14,4,'Natália Freitas','107.808.909-19','atendente',1500.00,'2025-04-10',1),(15,4,'Ronaldo Carneiro','108.909.010-20','entregador',1450.00,'2025-04-20',1),(16,5,'Suelen Pereira','109.010.111-21','atendente',1500.00,'2025-05-01',1),(17,5,'Vagner Leão','110.111.112-22','caixa',1800.00,'2025-05-15',1),(18,6,'Amanda Faria','111.121.131-23','atendente',1500.00,'2025-05-20',1),(19,6,'Breno Teles','112.131.141-24','entregador',1400.00,'2025-06-01',1),(20,7,'Cláudia Motta','113.141.151-25','atendente',1500.00,'2025-06-10',1),(21,7,'Diego Martins','114.151.161-26','caixa',1800.00,'2025-06-15',1),(22,8,'Ester Carvalho','115.161.171-27','atendente',1500.00,'2025-06-20',1),(23,8,'Fábio Teixeira','116.171.181-28','entregador',1400.00,'2025-07-01',1),(24,9,'Giovana Castro','117.181.191-29','atendente',1500.00,'2025-07-10',1),(25,9,'Humberto Siqueira','118.191.201-30','caixa',1850.00,'2025-07-20',1),(26,10,'Izadora Lopes','119.201.211-31','atendente',1500.00,'2025-08-01',1),(27,10,'João Vitor','120.211.221-32','entregador',1400.00,'2025-08-05',1),(28,11,'Karoline Araujo','121.221.231-33','atendente',1500.00,'2025-08-15',1),(29,11,'Luana Rodrigues','122.231.241-34','caixa',1800.00,'2025-08-25',1),(30,12,'Murilo Santos','123.241.251-35','atendente',1500.00,'2025-09-01',1),(31,12,'Nádia Pontes','124.251.261-36','entregador',1400.00,'2025-09-05',1),(32,13,'Otto Barros','125.261.271-37','atendente',1500.00,'2025-09-10',1),(33,13,'Paula Rocha','126.271.281-38','caixa',1850.00,'2025-09-15',1),(34,14,'Rita Lacerda','127.281.291-39','atendente',1500.00,'2025-09-20',1),(35,14,'Sandro Lima','128.291.301-40','entregador',1400.00,'2025-09-25',1),(36,15,'Tainá Moura','129.301.311-41','atendente',1500.00,'2025-10-01',1),(37,15,'Ulysses Maia','130.311.321-42','caixa',1850.00,'2025-10-05',1);
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredientes`
--

DROP TABLE IF EXISTS `ingredientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `unidade_medida` varchar(20) NOT NULL,
  `estoque_minimo` decimal(10,2) DEFAULT NULL,
  `custo_unitario` decimal(10,2) DEFAULT NULL,
  `fornecedor` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `id` int NOT NULL AUTO_INCREMENT,
  `pedido_id` int NOT NULL,
  `produto_id` int NOT NULL,
  `quantidade` int NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `observacoes` text,
  PRIMARY KEY (`id`),
  KEY `idx_pedido` (`pedido_id`),
  KEY `idx_produto` (`produto_id`),
  KEY `idx_itens_pedido_composto` (`pedido_id`,`produto_id`),
  CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens_pedido`
--

LOCK TABLES `itens_pedido` WRITE;
/*!40000 ALTER TABLE `itens_pedido` DISABLE KEYS */;
INSERT INTO `itens_pedido` VALUES (1,1,1,2,12.90,NULL),(2,2,15,1,49.90,NULL),(3,3,9,1,16.90,NULL),(4,4,1,1,12.90,NULL),(5,4,2,1,11.90,NULL),(6,4,5,1,10.90,NULL),(7,4,6,1,7.90,NULL),(8,5,9,1,16.90,NULL),(9,5,11,1,14.90,NULL),(10,6,13,1,18.90,NULL),(11,7,1,1,12.90,NULL),(12,7,11,1,14.90,NULL),(13,8,11,1,14.90,NULL),(14,9,3,1,15.90,NULL),(15,9,4,1,13.90,NULL),(16,9,7,1,6.90,NULL),(17,10,16,1,13.50,NULL),(18,11,1,1,12.90,NULL),(19,11,6,1,7.90,'Sem Açúcar'),(20,12,9,1,16.90,NULL),(21,13,15,1,49.90,NULL),(22,14,1,1,12.90,NULL),(23,14,11,1,14.90,NULL),(24,15,18,1,14.50,NULL),(25,16,10,1,24.90,NULL),(26,17,12,1,12.90,NULL),(27,18,26,1,39.90,NULL),(28,19,9,1,16.90,NULL),(29,20,1,1,12.90,NULL),(30,20,4,1,13.90,NULL),(31,21,2,1,11.90,NULL),(32,22,25,1,20.90,NULL),(33,23,14,1,17.90,NULL),(34,24,3,1,15.90,NULL),(35,25,1,1,12.90,NULL),(36,26,16,1,13.50,NULL),(37,27,10,1,24.90,NULL),(38,28,22,1,32.90,'Extra Granola'),(39,29,45,1,17.50,NULL),(40,30,3,1,15.90,NULL),(41,31,9,1,16.90,NULL),(42,32,26,1,39.90,NULL),(43,33,13,1,18.90,NULL),(44,34,2,1,11.90,NULL),(45,35,25,1,20.90,NULL),(46,36,41,1,17.90,'Açaí com Ninho'),(47,37,4,1,13.90,NULL),(48,38,10,1,24.90,NULL),(49,39,13,1,18.90,NULL),(50,40,15,1,49.90,NULL),(51,41,11,1,14.90,NULL),(52,42,1,1,12.90,NULL),(53,43,11,1,14.90,NULL),(54,43,12,1,12.90,NULL),(55,44,14,1,17.90,NULL),(56,45,3,1,15.90,NULL),(57,46,23,1,15.90,NULL),(58,46,7,1,6.90,NULL),(59,47,16,1,13.50,NULL),(60,48,9,1,16.90,NULL),(61,49,2,1,11.90,NULL),(62,50,1,1,12.90,NULL),(63,50,2,1,11.90,NULL),(64,51,25,1,20.90,NULL),(65,52,9,1,16.90,NULL),(66,53,46,1,21.90,NULL),(67,54,22,1,32.90,NULL),(68,55,13,1,18.90,NULL),(69,55,6,1,7.90,NULL),(70,26,31,1,13.90,'Adicional Amora'),(71,27,34,1,15.90,'Torta de Limão'),(72,28,43,1,18.90,'Açaí Light'),(73,29,55,1,23.90,'Brownie Duplo'),(74,30,52,1,7.50,'Picolé de Kiwi'),(75,32,20,1,8.90,'Picolé Coco Queimado'),(76,33,49,1,11.90,'Sorvete Ameixa'),(77,35,50,1,13.50,'Sorvete Canela'),(78,38,51,1,14.90,'Sorvete Gengibre'),(79,40,53,1,28.90,'Açaí Energy'),(80,44,40,1,7.90,'Picolé Chiclete'),(81,56,69,1,6.50,NULL),(82,57,10,1,24.90,NULL),(83,58,9,1,16.90,NULL),(84,59,13,1,18.90,NULL),(85,60,78,1,28.90,NULL),(86,61,60,1,15.50,NULL),(87,62,73,1,19.90,NULL),(88,63,56,1,12.90,NULL),(89,64,71,1,34.90,NULL),(90,65,69,2,6.50,'2 unidades'),(91,66,68,1,17.50,NULL),(92,67,15,1,49.90,NULL),(93,68,78,1,28.90,NULL),(94,69,4,1,13.90,NULL),(95,70,64,1,22.90,NULL),(96,71,80,1,15.90,NULL),(97,72,77,1,59.90,NULL),(98,73,56,1,12.90,NULL),(99,74,9,1,16.90,NULL),(100,75,71,1,39.90,NULL),(101,76,16,1,13.50,NULL),(102,77,13,1,18.90,NULL),(103,78,10,1,24.90,NULL),(104,79,81,1,14.90,NULL),(105,80,46,1,21.90,NULL),(106,81,1,1,12.90,NULL),(107,82,2,1,11.90,NULL),(108,83,25,1,20.90,NULL),(109,84,22,1,32.90,NULL),(110,85,61,1,12.90,NULL),(111,86,1,1,12.90,NULL),(112,87,56,2,12.90,'2 porções'),(113,88,62,1,12.90,NULL),(114,89,13,1,18.90,NULL),(115,90,11,1,14.90,NULL),(116,91,71,1,34.90,NULL),(117,92,3,1,15.90,NULL),(118,93,20,1,8.90,NULL),(119,94,22,1,32.90,NULL),(120,95,11,1,14.90,NULL),(121,96,15,1,49.90,NULL),(122,97,56,1,12.90,NULL),(123,98,59,1,6.90,NULL),(124,99,46,1,21.90,NULL),(125,100,25,1,20.90,NULL),(126,101,10,1,24.90,NULL),(127,102,9,1,16.90,NULL),(128,103,68,1,17.50,NULL),(129,104,16,1,13.50,NULL),(130,105,78,1,39.90,NULL),(131,106,1,1,12.90,NULL),(132,107,80,1,15.90,NULL),(133,108,83,1,13.50,NULL),(134,109,82,1,9.90,NULL),(135,110,84,1,59.90,NULL),(136,111,56,1,12.90,NULL),(137,112,12,1,12.90,NULL),(138,113,73,1,19.90,NULL),(139,114,79,1,17.90,NULL),(140,115,81,1,14.90,NULL),(141,116,76,1,18.90,NULL),(142,117,46,1,21.90,NULL),(143,118,83,1,13.50,NULL),(144,119,2,1,11.90,NULL),(145,120,78,1,39.90,NULL),(146,121,64,1,22.90,NULL),(147,122,82,1,9.90,NULL),(148,123,16,1,13.50,NULL),(149,124,10,1,24.90,NULL),(150,125,71,1,28.90,NULL),(151,126,56,1,12.90,NULL),(152,127,15,1,49.90,NULL),(153,128,59,1,6.90,NULL),(154,129,77,1,59.90,NULL),(155,130,82,1,9.90,NULL),(156,131,25,1,20.90,NULL),(157,132,3,1,15.90,NULL),(158,133,22,1,32.90,NULL),(159,134,84,1,59.90,NULL),(160,135,81,1,14.90,NULL),(161,136,71,1,28.90,NULL),(162,137,68,1,17.50,NULL),(163,138,46,1,21.90,NULL),(164,139,56,1,12.90,NULL),(165,140,78,1,39.90,NULL),(166,141,69,2,6.50,'2 unidades'),(167,142,22,1,32.90,NULL),(168,143,1,1,12.90,NULL),(169,144,84,1,59.90,NULL),(170,145,56,1,12.90,NULL),(171,146,71,1,28.90,NULL),(172,147,83,1,13.50,NULL),(173,148,80,1,15.90,NULL),(174,149,71,1,28.90,NULL),(175,150,78,1,34.90,NULL),(176,151,64,1,22.90,NULL),(177,152,69,1,6.50,NULL),(178,153,25,1,20.90,NULL),(179,154,22,1,32.90,NULL),(180,155,81,1,14.90,NULL);
/*!40000 ALTER TABLE `itens_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lojas`
--

DROP TABLE IF EXISTS `lojas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lojas` (
  `id` int NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lojas`
--

LOCK TABLES `lojas` WRITE;
/*!40000 ALTER TABLE `lojas` DISABLE KEYS */;
INSERT INTO `lojas` VALUES (1,'Paraiso Gelado - Centro','Av. Principal, 1000','Goiatuba','GO','75600-000','(64) 3495-1000','centro@paraisogelado.com',-18.01230000,-49.34560000,'2024-01-15',1,'2025-10-28 15:25:19'),(2,'Paraiso Gelado - Shopping','Shopping Center, Loja 205','Goiatuba','GO','75600-001','(64) 3495-2000','shopping@paraisogelado.com',-18.02340000,-49.35670000,'2024-03-20',1,'2025-10-28 15:25:19'),(3,'Paraiso Gelado - Parque','Rua das Flores, 500','Goiatuba','GO','75600-002','(64) 3495-3000','parque@paraisogelado.com',-18.03450000,-49.36780000,'2024-06-10',1,'2025-10-28 15:25:19'),(4,'Paraiso Gelado - Setor Sul','Rua 13, Quadra C, Lote 15','Goiânia','GO','74080-000','(62) 3212-4000','setorsul@paraisogelado.com',-16.68000000,-49.25000000,'2024-07-01',1,'2025-11-06 19:08:30'),(5,'Paraiso Gelado - Jundiaí','Av. São Francisco, 888','Anápolis','GO','75110-390','(62) 3311-5000','jundiai@paraisogelado.com',-16.33000000,-48.95000000,'2024-08-10',1,'2025-11-06 19:08:30'),(6,'Paraiso Gelado - Rio Verde Shopping','Av. Pres. Vargas, Loja 10','Rio Verde','GO','75901-010','(64) 3622-6000','rioverde@paraisogelado.com',-17.78000000,-50.92000000,'2024-09-05',1,'2025-11-06 19:08:30'),(7,'Paraiso Gelado - Caldas Novas','Rua do Turismo, 50','Caldas Novas','GO','75690-000','(64) 3453-7000','caldas@paraisogelado.com',-17.74000000,-48.62000000,'2024-10-20',1,'2025-11-06 19:08:30'),(8,'Paraiso Gelado - Setor Central','Av. Goiás, 1200','Itumbiara','GO','75503-100','(64) 3431-8000','itumbiara@paraisogelado.com',-18.42000000,-49.21000000,'2024-11-15',1,'2025-11-06 19:08:30'),(9,'Paraiso Gelado - Aeroporto','Praça do Avião, 350','Goiânia','GO','74070-000','(62) 3201-9000','aeroporto@paraisogelado.com',-16.67000000,-49.23000000,'2024-12-01',1,'2025-11-06 19:08:30'),(10,'Paraiso Gelado - Vila Brasília','Av. São João, 150','Aparecida de Goiânia','GO','74913-085','(62) 3548-1111','vilabrasilia@paraisogelado.com',-16.79000000,-49.23000000,'2025-01-20',1,'2025-11-06 19:08:30'),(11,'Paraiso Gelado - Lago das Rosas','Alameda das Rosas, 90','Goiânia','GO','74015-010','(62) 3215-1212','lago@paraisogelado.com',-16.66000000,-49.27000000,'2025-03-05',1,'2025-11-06 19:08:30'),(12,'Paraiso Gelado - Shopping Flamboyant','Av. Jamel Cecílio, Piso T3','Goiânia','GO','74810-100','(62) 3500-1313','flamboyant@paraisogelado.com',-16.70000000,-49.25000000,'2025-04-15',1,'2025-11-06 19:08:30'),(13,'Paraiso Gelado - Sudoeste','Rua C-60, 200','Goiânia','GO','74305-400','(62) 3287-1414','sudoeste@paraisogelado.com',-16.69000000,-49.30000000,'2025-05-01',1,'2025-11-06 19:08:30'),(14,'Paraiso Gelado - Centro Comercial','Rua XV de Novembro, 10','Catalão','GO','75701-000','(64) 3441-1515','catalao@paraisogelado.com',-18.17000000,-47.95000000,'2025-06-20',1,'2025-11-06 19:08:30'),(15,'Paraiso Gelado - Entroncamento','BR 153, Box 5','Anápolis','GO','75075-810','(62) 3317-1616','entroncamento@paraisogelado.com',-16.32000000,-48.93000000,'2025-07-07',1,'2025-11-06 19:08:30'),(16,'Paraiso Gelado - Buriti Shopping','Av. Rio Verde, Loja 110','Aparecida de Goiânia','GO','74916-770','(62) 3594-1717','buriti@paraisogelado.com',-16.73000000,-49.31000000,'2025-08-01',1,'2025-11-06 19:08:30'),(17,'Paraiso Gelado - Setor Bueno','T-5 com T-2, 99','Goiânia','GO','74210-000','(62) 3541-1818','bueno@paraisogelado.com',-16.70000000,-49.27000000,'2025-09-10',1,'2025-11-06 19:08:30'),(18,'Paraiso Gelado - Trindade','Praça da Matriz, 40','Trindade','GO','75380-000','(62) 3505-1919','trindade@paraisogelado.com',-16.65000000,-49.49000000,'2025-10-05',1,'2025-11-06 19:08:30'),(19,'Paraiso Gelado - Novo Horizonte','Rua C-25, 300','Goiânia','GO','74360-000','(62) 3093-2020','novohorizonte@paraisogelado.com',-16.73000000,-49.32000000,'2025-10-25',1,'2025-11-06 19:08:30');
/*!40000 ALTER TABLE `lojas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `loja_id` int NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `desconto` decimal(10,2) DEFAULT '0.00',
  `taxa_entrega` decimal(10,2) DEFAULT '0.00',
  `status` enum('pendente','em_preparo','pronto','entregue','cancelado') DEFAULT 'pendente',
  `tipo` enum('local','delivery','retirada') DEFAULT 'local',
  `forma_pagamento` enum('dinheiro','cartao_credito','cartao_debito','pix','voucher') DEFAULT 'dinheiro',
  `observacoes` text,
  `data_hora` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `data_entrega` timestamp NULL DEFAULT NULL,
  `avaliacao` int DEFAULT NULL,
  `comentario_avaliacao` text,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_data` (`data_hora`),
  KEY `idx_cliente` (`cliente_id`),
  KEY `idx_loja` (`loja_id`),
  KEY `idx_pedidos_data_status` (`data_hora`,`status`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`loja_id`) REFERENCES `lojas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,1,25.80,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-10-26 17:30:00','2025-10-26 17:45:00',5,'Excelente!'),(2,2,1,49.90,5.00,0.00,'entregue','local','pix',NULL,'2025-10-26 18:20:00','2025-10-26 18:35:00',5,'Adorei o combo!'),(3,3,2,16.90,0.00,5.00,'entregue','delivery','cartao_debito',NULL,'2025-10-26 19:10:00','2025-10-26 19:40:00',4,'Bom, mas demorou um pouco'),(4,4,1,42.60,2.00,0.00,'entregue','local','dinheiro',NULL,'2025-10-26 20:00:00','2025-10-26 20:15:00',5,'Perfeito!'),(5,5,3,31.80,0.00,6.00,'entregue','delivery','pix',NULL,'2025-10-26 21:30:00','2025-10-26 22:00:00',5,'Chegou quentinho!'),(6,1,2,18.90,0.00,0.00,'entregue','retirada','cartao_credito',NULL,'2025-10-27 13:15:00','2025-10-27 13:30:00',5,'Ótimo atendimento'),(7,2,1,27.80,0.00,0.00,'pronto','local','pix',NULL,'2025-10-27 14:00:00',NULL,NULL,NULL),(8,3,1,14.90,0.00,5.00,'em_preparo','delivery','cartao_credito',NULL,'2025-10-27 14:30:00',NULL,NULL,NULL),(9,4,2,33.70,0.00,0.00,'pendente','local','dinheiro',NULL,'2025-10-27 15:00:00',NULL,NULL,NULL),(10,6,1,13.50,0.00,0.00,'entregue','local','pix',NULL,'2025-10-28 16:00:00',NULL,NULL,NULL),(11,7,2,22.40,0.00,0.00,'entregue','delivery','cartao_credito',NULL,'2025-10-29 18:30:00',NULL,NULL,NULL),(12,8,3,16.90,0.00,0.00,'entregue','retirada','dinheiro',NULL,'2025-10-30 14:00:00',NULL,NULL,NULL),(13,9,1,49.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-10-30 20:10:00',NULL,NULL,NULL),(14,10,2,30.80,0.00,0.00,'entregue','delivery','pix',NULL,'2025-10-31 17:45:00',NULL,NULL,NULL),(15,11,3,14.50,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-01 13:00:00',NULL,NULL,NULL),(16,12,1,24.90,0.00,0.00,'entregue','retirada','dinheiro',NULL,'2025-11-01 19:20:00',NULL,NULL,NULL),(17,13,2,12.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-02 16:50:00',NULL,NULL,NULL),(18,14,3,39.90,0.00,0.00,'entregue','delivery','cartao_debito',NULL,'2025-11-03 15:35:00',NULL,NULL,NULL),(19,15,1,16.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-03 21:00:00',NULL,NULL,NULL),(20,16,2,27.80,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-04 14:10:00',NULL,NULL,NULL),(21,17,3,11.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-04 17:25:00',NULL,NULL,NULL),(22,18,1,20.90,0.00,0.00,'entregue','delivery','cartao_credito',NULL,'2025-11-05 13:40:00',NULL,NULL,NULL),(23,19,2,17.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-05 16:15:00',NULL,NULL,NULL),(24,20,3,15.90,0.00,0.00,'entregue','retirada','dinheiro',NULL,'2025-11-05 18:00:00',NULL,NULL,NULL),(25,21,1,12.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-05 20:30:00',NULL,NULL,NULL),(26,22,1,13.50,0.00,0.00,'entregue','local','pix',NULL,'2025-11-06 10:00:00',NULL,NULL,NULL),(27,23,2,24.90,0.00,0.00,'entregue','retirada','cartao_credito',NULL,'2025-11-06 11:30:00',NULL,NULL,NULL),(28,24,3,32.90,0.00,5.00,'entregue','delivery','pix',NULL,'2025-11-06 12:45:00',NULL,NULL,NULL),(29,25,1,17.50,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 13:00:00',NULL,NULL,NULL),(30,26,2,15.90,0.00,0.00,'pronto','local','cartao_debito',NULL,'2025-11-06 13:30:00',NULL,NULL,NULL),(31,27,3,16.90,0.00,0.00,'em_preparo','retirada','pix',NULL,'2025-11-06 14:00:00',NULL,NULL,NULL),(32,28,1,39.90,5.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-06 14:30:00',NULL,NULL,NULL),(33,29,2,18.90,0.00,5.00,'entregue','delivery','dinheiro',NULL,'2025-11-06 15:00:00',NULL,NULL,NULL),(34,30,3,11.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-06 15:30:00',NULL,NULL,NULL),(35,31,1,20.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-06 16:00:00',NULL,NULL,NULL),(36,32,2,16.90,0.00,5.00,'entregue','delivery','cartao_credito',NULL,'2025-11-06 16:30:00',NULL,NULL,NULL),(37,33,3,13.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-06 17:00:00',NULL,NULL,NULL),(38,34,1,24.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 17:30:00',NULL,NULL,NULL),(39,35,2,18.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-06 18:00:00',NULL,NULL,NULL),(40,36,3,49.90,0.00,5.00,'entregue','delivery','pix',NULL,'2025-11-06 18:30:00',NULL,NULL,NULL),(41,37,1,14.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-06 19:00:00',NULL,NULL,NULL),(42,38,2,12.90,0.00,0.00,'pronto','retirada','dinheiro',NULL,'2025-11-06 19:30:00',NULL,NULL,NULL),(43,39,3,27.80,0.00,5.00,'em_preparo','delivery','pix',NULL,'2025-11-06 20:00:00',NULL,NULL,NULL),(44,40,1,17.90,0.00,0.00,'pendente','local','cartao_debito',NULL,'2025-11-06 20:30:00',NULL,NULL,NULL),(45,41,2,15.90,0.00,0.00,'pendente','local','cartao_credito',NULL,'2025-11-06 21:00:00',NULL,NULL,NULL),(46,42,3,22.90,0.00,5.00,'pendente','delivery','pix',NULL,'2025-11-06 21:30:00',NULL,NULL,NULL),(47,43,1,13.50,0.00,0.00,'pendente','local','dinheiro',NULL,'2025-11-06 22:00:00',NULL,NULL,NULL),(48,44,2,16.90,0.00,0.00,'pendente','retirada','cartao_credito',NULL,'2025-11-06 22:30:00',NULL,NULL,NULL),(49,45,3,11.90,0.00,0.00,'pendente','local','pix',NULL,'2025-11-06 23:00:00',NULL,NULL,NULL),(50,46,1,12.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-06 13:10:00',NULL,NULL,NULL),(51,47,2,20.90,0.00,0.00,'entregue','retirada','cartao_credito',NULL,'2025-11-06 14:10:00',NULL,NULL,NULL),(52,48,3,16.90,0.00,5.00,'em_preparo','delivery','pix',NULL,'2025-11-06 15:10:00',NULL,NULL,NULL),(53,49,1,21.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 16:10:00',NULL,NULL,NULL),(54,50,2,32.90,0.00,0.00,'entregue','retirada','cartao_debito',NULL,'2025-11-06 17:10:00',NULL,NULL,NULL),(55,51,3,18.90,0.00,5.00,'pendente','delivery','pix',NULL,'2025-11-06 18:10:00',NULL,NULL,NULL),(56,56,1,13.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-06 09:10:00',NULL,NULL,NULL),(57,57,2,24.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-06 09:25:00',NULL,NULL,NULL),(58,58,3,16.90,0.00,5.00,'entregue','delivery','cartao_credito',NULL,'2025-11-06 09:40:00',NULL,NULL,NULL),(59,59,4,18.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 09:55:00',NULL,NULL,NULL),(60,60,5,28.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-06 10:10:00',NULL,NULL,NULL),(61,61,6,15.50,0.00,0.00,'pronto','local','cartao_debito',NULL,'2025-11-06 10:25:00',NULL,NULL,NULL),(62,62,7,19.90,0.00,0.00,'em_preparo','delivery','pix',NULL,'2025-11-06 10:40:00',NULL,NULL,NULL),(63,63,8,12.90,0.00,0.00,'entregue','retirada','dinheiro',NULL,'2025-11-06 10:55:00',NULL,NULL,NULL),(64,64,9,34.90,0.00,5.00,'entregue','delivery','cartao_credito',NULL,'2025-11-06 11:10:00',NULL,NULL,NULL),(65,65,10,13.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-06 11:25:00',NULL,NULL,NULL),(66,66,11,17.50,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-06 11:40:00',NULL,NULL,NULL),(67,67,12,49.90,5.00,0.00,'entregue','local','pix',NULL,'2025-11-06 11:55:00',NULL,NULL,NULL),(68,68,13,28.90,0.00,0.00,'entregue','delivery','cartao_debito',NULL,'2025-11-06 12:10:00',NULL,NULL,NULL),(69,69,14,15.90,0.00,0.00,'pronto','retirada','dinheiro',NULL,'2025-11-06 12:25:00',NULL,NULL,NULL),(70,70,15,22.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-06 12:40:00',NULL,NULL,NULL),(71,71,16,34.90,0.00,5.00,'entregue','delivery','pix',NULL,'2025-11-06 12:55:00',NULL,NULL,NULL),(72,72,17,18.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 13:10:00',NULL,NULL,NULL),(73,73,18,59.90,5.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-06 13:25:00',NULL,NULL,NULL),(74,74,19,16.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-06 13:40:00',NULL,NULL,NULL),(75,75,1,39.90,0.00,0.00,'entregue','delivery','cartao_credito',NULL,'2025-11-06 13:55:00',NULL,NULL,NULL),(76,76,2,13.50,0.00,0.00,'pronto','local','dinheiro',NULL,'2025-11-06 14:10:00',NULL,NULL,NULL),(77,77,3,18.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-06 14:25:00',NULL,NULL,NULL),(78,78,4,24.90,0.00,0.00,'entregue','retirada','cartao_debito',NULL,'2025-11-06 14:40:00',NULL,NULL,NULL),(79,79,5,17.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-06 14:55:00',NULL,NULL,NULL),(80,80,6,22.90,0.00,5.00,'em_preparo','delivery','pix',NULL,'2025-11-06 15:10:00',NULL,NULL,NULL),(81,81,7,12.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 15:25:00',NULL,NULL,NULL),(82,82,8,16.90,0.00,0.00,'entregue','retirada','cartao_debito',NULL,'2025-11-06 15:40:00',NULL,NULL,NULL),(83,83,9,20.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-06 15:55:00',NULL,NULL,NULL),(84,84,10,32.90,0.00,5.00,'entregue','delivery','cartao_credito',NULL,'2025-11-06 16:10:00',NULL,NULL,NULL),(85,85,11,15.90,0.00,0.00,'pendente','retirada','dinheiro',NULL,'2025-11-06 16:25:00',NULL,NULL,NULL),(86,86,12,12.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-06 16:40:00',NULL,NULL,NULL),(87,87,13,39.90,0.00,0.00,'entregue','delivery','cartao_debito',NULL,'2025-11-06 16:55:00',NULL,NULL,NULL),(88,88,14,24.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-06 17:10:00',NULL,NULL,NULL),(89,89,15,11.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-06 17:25:00',NULL,NULL,NULL),(90,90,16,18.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 17:40:00',NULL,NULL,NULL),(91,91,17,21.90,0.00,0.00,'entregue','delivery','cartao_credito',NULL,'2025-11-06 17:55:00',NULL,NULL,NULL),(92,92,18,13.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-06 18:10:00',NULL,NULL,NULL),(93,93,19,20.90,0.00,0.00,'entregue','retirada','cartao_debito',NULL,'2025-11-06 18:25:00',NULL,NULL,NULL),(94,94,1,32.90,0.00,5.00,'entregue','delivery','pix',NULL,'2025-11-06 18:40:00',NULL,NULL,NULL),(95,95,2,14.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 18:55:00',NULL,NULL,NULL),(96,96,3,17.90,0.00,0.00,'pronto','retirada','cartao_credito',NULL,'2025-11-06 19:10:00',NULL,NULL,NULL),(97,97,4,49.90,5.00,0.00,'entregue','local','pix',NULL,'2025-11-06 19:25:00',NULL,NULL,NULL),(98,98,5,12.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-06 19:40:00',NULL,NULL,NULL),(99,99,6,21.90,0.00,0.00,'entregue','delivery','cartao_credito',NULL,'2025-11-06 19:55:00',NULL,NULL,NULL),(100,100,7,18.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-06 20:10:00',NULL,NULL,NULL),(101,101,8,24.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 20:25:00',NULL,NULL,NULL),(102,102,9,15.90,0.00,0.00,'entregue','delivery','cartao_credito',NULL,'2025-11-06 20:40:00',NULL,NULL,NULL),(103,103,10,17.50,0.00,0.00,'entregue','local','pix',NULL,'2025-11-06 20:55:00',NULL,NULL,NULL),(104,104,11,13.50,0.00,0.00,'entregue','retirada','cartao_debito',NULL,'2025-11-06 21:10:00',NULL,NULL,NULL),(105,105,12,39.90,0.00,5.00,'entregue','delivery','pix',NULL,'2025-11-06 21:25:00',NULL,NULL,NULL),(106,106,13,11.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 21:40:00',NULL,NULL,NULL),(107,107,14,28.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-06 21:55:00',NULL,NULL,NULL),(108,108,15,16.90,0.00,0.00,'pendente','retirada','pix',NULL,'2025-11-06 22:10:00',NULL,NULL,NULL),(109,109,16,20.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-06 22:25:00',NULL,NULL,NULL),(110,110,17,32.90,0.00,5.00,'entregue','delivery','pix',NULL,'2025-11-06 22:40:00',NULL,NULL,NULL),(111,111,18,12.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-06 22:55:00',NULL,NULL,NULL),(112,112,19,14.90,0.00,0.00,'entregue','retirada','cartao_credito',NULL,'2025-11-06 23:10:00',NULL,NULL,NULL),(113,113,1,18.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-07 00:00:00',NULL,NULL,NULL),(114,114,2,17.90,0.00,0.00,'entregue','delivery','cartao_debito',NULL,'2025-11-07 00:15:00',NULL,NULL,NULL),(115,115,3,13.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-07 00:30:00',NULL,NULL,NULL),(116,116,4,24.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-07 00:45:00',NULL,NULL,NULL),(117,117,5,15.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-07 01:00:00',NULL,NULL,NULL),(118,118,6,21.90,0.00,0.00,'entregue','delivery','pix',NULL,'2025-11-07 01:15:00',NULL,NULL,NULL),(119,119,7,12.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-07 01:30:00',NULL,NULL,NULL),(120,120,8,39.90,0.00,0.00,'entregue','retirada','cartao_debito',NULL,'2025-11-07 01:45:00',NULL,NULL,NULL),(121,121,9,22.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-07 02:00:00',NULL,NULL,NULL),(122,122,10,16.90,0.00,0.00,'entregue','delivery','cartao_credito',NULL,'2025-11-07 02:15:00',NULL,NULL,NULL),(123,123,11,18.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-07 02:30:00',NULL,NULL,NULL),(124,124,12,13.50,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-07 02:45:00',NULL,NULL,NULL),(125,125,13,28.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-07 03:00:00',NULL,NULL,NULL),(126,126,14,12.90,0.00,0.00,'entregue','delivery','pix',NULL,'2025-11-07 03:15:00',NULL,NULL,NULL),(127,127,15,49.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-07 03:30:00',NULL,NULL,NULL),(128,128,16,16.90,0.00,0.00,'entregue','retirada','dinheiro',NULL,'2025-11-07 03:45:00',NULL,NULL,NULL),(129,129,17,17.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-07 04:00:00',NULL,NULL,NULL),(130,130,18,20.90,0.00,0.00,'entregue','delivery','cartao_debito',NULL,'2025-11-07 04:15:00',NULL,NULL,NULL),(131,131,19,15.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-07 04:30:00',NULL,NULL,NULL),(132,132,1,21.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-07 04:45:00',NULL,NULL,NULL),(133,133,2,11.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-07 05:00:00',NULL,NULL,NULL),(134,134,3,32.90,0.00,5.00,'entregue','delivery','cartao_credito',NULL,'2025-11-07 05:15:00',NULL,NULL,NULL),(135,135,4,14.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-07 05:30:00',NULL,NULL,NULL),(136,136,5,20.90,0.00,0.00,'entregue','retirada','cartao_debito',NULL,'2025-11-07 05:45:00',NULL,NULL,NULL),(137,137,6,24.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-07 06:00:00',NULL,NULL,NULL),(138,138,7,18.90,0.00,0.00,'entregue','delivery','pix',NULL,'2025-11-07 06:15:00',NULL,NULL,NULL),(139,139,8,13.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-07 06:30:00',NULL,NULL,NULL),(140,140,9,39.90,5.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-07 06:45:00',NULL,NULL,NULL),(141,141,10,15.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-07 07:00:00',NULL,NULL,NULL),(142,142,11,32.90,0.00,5.00,'entregue','delivery','cartao_credito',NULL,'2025-11-07 07:15:00',NULL,NULL,NULL),(143,143,12,12.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-07 07:30:00',NULL,NULL,NULL),(144,144,13,28.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-07 07:45:00',NULL,NULL,NULL),(145,145,14,13.90,0.00,0.00,'entregue','local','cartao_credito',NULL,'2025-11-07 08:00:00',NULL,NULL,NULL),(146,146,15,21.90,0.00,0.00,'entregue','delivery','pix',NULL,'2025-11-07 08:15:00',NULL,NULL,NULL),(147,147,16,16.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-07 08:30:00',NULL,NULL,NULL),(148,148,17,24.90,0.00,0.00,'entregue','retirada','cartao_debito',NULL,'2025-11-07 08:45:00',NULL,NULL,NULL),(149,149,18,18.90,0.00,0.00,'entregue','local','pix',NULL,'2025-11-07 09:00:00',NULL,NULL,NULL),(150,150,19,34.90,0.00,5.00,'entregue','delivery','cartao_credito',NULL,'2025-11-07 09:15:00',NULL,NULL,NULL),(151,151,1,22.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-07 09:30:00',NULL,NULL,NULL),(152,152,2,13.90,0.00,0.00,'entregue','retirada','pix',NULL,'2025-11-07 09:45:00',NULL,NULL,NULL),(153,153,3,17.90,0.00,0.00,'entregue','local','cartao_debito',NULL,'2025-11-07 10:00:00',NULL,NULL,NULL),(154,154,4,19.90,0.00,0.00,'entregue','delivery','cartao_credito',NULL,'2025-11-07 10:15:00',NULL,NULL,NULL),(155,155,5,15.90,0.00,0.00,'entregue','local','dinheiro',NULL,'2025-11-07 10:30:00',NULL,NULL,NULL);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria_id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text,
  `preco` decimal(10,2) NOT NULL,
  `custo` decimal(10,2) DEFAULT NULL,
  `tamanho` enum('P','M','G','ÚNICO') DEFAULT 'ÚNICO',
  `calorias` int DEFAULT NULL,
  `imagem_url` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_categoria` (`categoria_id`),
  KEY `idx_preco` (`preco`),
  KEY `idx_ativo` (`ativo`),
  CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,1,'Sorvete Chocolate Belga','Sorvete cremoso de chocolate belga 70% cacau',12.90,4.50,'M',250,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(2,1,'Sorvete Morango Premium','Feito com morangos frescos selecionados',11.90,4.00,'M',220,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(3,1,'Sorvete Pistache','Sabor exótico com pistaches importados',15.90,6.00,'M',280,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(4,1,'Sorvete Baunilha Madagascar','Baunilha pura de Madagascar',13.90,5.00,'M',240,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(5,1,'Sorvete Flocos','Sorvete com pedaços de chocolate flocos',10.90,3.50,'M',260,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(6,2,'Picolé Frutas Vermelhas','Mix de frutas vermelhas naturais',7.90,2.50,'ÚNICO',120,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(7,2,'Picolé Limão Siciliano','Refrescante picolé de limão',6.90,2.00,'ÚNICO',100,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(8,2,'Picolé Chocolate Trufado','Cobertura de chocolate belga',8.90,3.00,'ÚNICO',180,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(9,3,'Açaí Bowl 300ml','Açaí puro com granola e banana',16.90,6.00,'M',350,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(10,3,'Açaí Bowl 500ml','Açaí com frutas e complementos',24.90,9.00,'G',550,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(11,4,'Milk-shake Ovomaltine','Clássico milk-shake com Ovomaltine',14.90,5.00,'M',400,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(12,4,'Milk-shake Morango','Milk-shake cremoso de morango',12.90,4.50,'M',350,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(13,5,'Sundae Brownie','Sorvete com brownie e calda de chocolate',18.90,7.00,'ÚNICO',500,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(14,5,'Sundae Caramelo','Sorvete com calda de caramelo salgado',17.90,6.50,'ÚNICO',480,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(15,6,'Combo Família','4 sorvetes + 2 picolés',49.90,20.00,'G',1200,NULL,1,'2025-10-28 15:25:19','2025-10-28 15:25:19'),(16,1,'Sorvete Doce de Leite Artesanal','Sorvete cremoso com doce de leite caseiro',13.50,4.80,'M',280,NULL,1,'2025-11-06 19:02:31',NULL),(17,1,'Sorvete Abacaxi com Hortelã','Sabor refrescante, ideal para dias quentes',10.90,3.20,'M',180,NULL,1,'2025-11-06 19:02:31',NULL),(18,1,'Sorvete de Café Expresso','Sorvete com um toque amargo e intenso de café',14.50,5.50,'M',260,NULL,1,'2025-11-06 19:02:31',NULL),(19,2,'Picolé Açaí com Banana','Picolé de açaí com pedaços de banana',7.50,2.80,'ÚNICO',130,NULL,1,'2025-11-06 19:02:31',NULL),(20,2,'Picolé Coco Queimado','Sabor de coco tostado, cremoso',8.90,3.10,'ÚNICO',150,NULL,1,'2025-11-06 19:02:31',NULL),(21,3,'Açaí Bowl 200ml (P)','Açaí puro com granola. Porção pequena.',12.90,4.50,'P',250,NULL,1,'2025-11-06 19:02:31',NULL),(22,3,'Açaí Bowl 700ml (G)','Açaí com frutas, complementos e mais.',32.90,12.00,'G',750,NULL,1,'2025-11-06 19:02:31',NULL),(23,4,'Milk-shake Paçoca','Milk-shake com pedaços de paçoca e amendoim',15.90,5.80,'M',450,NULL,1,'2025-11-06 19:02:31',NULL),(24,4,'Milk-shake Chocolate Branco','Milk-shake suave de chocolate branco',16.90,6.50,'M',420,NULL,1,'2025-11-06 19:02:31',NULL),(25,5,'Sundae Cheesecake','Sorvete de baunilha, calda de morango e pedaços de cheesecake',20.90,8.00,'ÚNICO',550,NULL,1,'2025-11-06 19:02:31',NULL),(26,6,'Combo Casal','2 Milk-shakes Médios + 1 Sundae',39.90,15.00,'ÚNICO',900,NULL,1,'2025-11-06 19:02:31',NULL),(27,1,'Sorvete de Manga','Sorvete de fruta tropical',10.90,3.50,'P',150,NULL,1,'2025-11-06 19:02:31',NULL),(28,1,'Sorvete de Laranja','Sorvete cítrico e refrescante',9.90,3.00,'P',140,NULL,1,'2025-11-06 19:02:31',NULL),(29,1,'Sorvete de Pêra','Sabor suave e adocicado',11.50,4.00,'P',160,NULL,1,'2025-11-06 19:02:31',NULL),(30,1,'Sorvete de Melancia','Sorvete leve e saboroso',9.50,3.00,'M',130,NULL,1,'2025-11-06 19:02:31',NULL),(31,1,'Sorvete de Amora','Sorvete com sabor de fruta silvestre',13.90,5.20,'G',300,NULL,1,'2025-11-06 19:02:31',NULL),(32,1,'Sorvete de Limão','Sorvete azedo e refrescante',10.90,3.30,'G',210,NULL,1,'2025-11-06 19:02:31',NULL),(33,1,'Sorvete de Ninho com Nutella','Combinação popular e irresistível',16.90,7.00,'G',350,NULL,1,'2025-11-06 19:02:31',NULL),(34,1,'Sorvete de Torta de Limão','Sorvete com pedaços de biscoito e recheio de torta',15.90,6.50,'M',310,NULL,1,'2025-11-06 19:02:31',NULL),(35,1,'Sorvete de Frutas Vermelhas','Mix de morango, amora e framboesa',12.90,4.90,'P',190,NULL,1,'2025-11-06 19:02:31',NULL),(36,2,'Picolé de Tangerina','Sabor vibrante e cítrico',6.50,2.00,'ÚNICO',90,NULL,1,'2025-11-06 19:02:31',NULL),(37,2,'Picolé de Uva','Sabor clássico de uva',5.90,1.80,'ÚNICO',80,NULL,1,'2025-11-06 19:02:31',NULL),(38,2,'Picolé de Groselha','Sabor doce e nostálgico',5.50,1.50,'ÚNICO',70,NULL,1,'2025-11-06 19:02:31',NULL),(39,2,'Picolé de Morango com Leite Condensado','Sabor doce e cremoso',9.50,3.50,'ÚNICO',160,NULL,1,'2025-11-06 19:02:31',NULL),(40,2,'Picolé de Chiclete','Sabor divertido para crianças',7.90,2.50,'ÚNICO',110,NULL,1,'2025-11-06 19:02:31',NULL),(41,3,'Açaí com Morango e Leite Ninho (300ml)','Combinação clássica e favorita',17.90,7.00,'M',400,NULL,1,'2025-11-06 19:02:31',NULL),(42,3,'Açaí com Pasta de Amendoim (500ml)','Opção energética com pasta de amendoim',25.90,10.50,'G',600,NULL,1,'2025-11-06 19:02:31',NULL),(43,3,'Açaí Light 300ml','Opção de baixo teor de açúcar',18.90,6.50,'M',300,NULL,1,'2025-11-06 19:02:31',NULL),(44,4,'Milk-shake de Amendoim','Sabor rico e amanteigado',14.50,5.50,'M',410,NULL,1,'2025-11-06 19:02:31',NULL),(45,4,'Milk-shake de Banana Caramelada','Milk-shake com calda de caramelo e banana',17.50,6.80,'G',500,NULL,1,'2025-11-06 19:02:31',NULL),(46,5,'Sundae Pistache','Sorvete de pistache com calda de chocolate e castanhas',21.90,9.00,'ÚNICO',580,NULL,1,'2025-11-06 19:02:31',NULL),(47,5,'Sundae Frutas Tropicais','Sorvete de manga e abacaxi com calda de maracujá',16.90,6.00,'ÚNICO',450,NULL,1,'2025-11-06 19:02:31',NULL),(48,6,'Combo Solteiro','1 Sundae + 1 Milk-shake Pequeno',29.90,12.00,'ÚNICO',700,NULL,1,'2025-11-06 19:02:31',NULL),(49,1,'Sorvete de Ameixa','Sorvete de ameixa com calda',11.90,4.20,'M',240,NULL,1,'2025-11-06 19:02:31',NULL),(50,1,'Sorvete de Canela','Sabor exótico e aromático',13.50,4.80,'M',260,NULL,1,'2025-11-06 19:02:31',NULL),(51,1,'Sorvete de Gengibre','Sabor picante e refrescante',14.90,5.50,'M',220,NULL,1,'2025-11-06 19:02:31',NULL),(52,2,'Picolé de Kiwi','Picolé com sabor cítrico e doce',7.50,2.50,'ÚNICO',110,NULL,1,'2025-11-06 19:02:31',NULL),(53,3,'Açaí Energy 500ml','Açaí com guaraná e complementos energéticos',28.90,11.00,'G',650,NULL,1,'2025-11-06 19:02:31',NULL),(54,4,'Milk-shake de Hortelã','Sabor mentolado e refrescante',15.90,6.00,'M',380,NULL,1,'2025-11-06 19:02:31',NULL),(55,5,'Sundae Brownie Duplo','Com duas camadas de brownie e mais calda',23.90,9.50,'ÚNICO',650,NULL,1,'2025-11-06 19:02:31',NULL),(56,9,'Chá Gelado Limão Siciliano 500ml','Chá gelado artesanal com toque de limão',7.50,2.00,'ÚNICO',80,NULL,1,'2025-11-06 19:30:00',NULL),(57,9,'Café Gelado Expresso 350ml','Café expresso batido com gelo',9.90,3.20,'ÚNICO',120,NULL,1,'2025-11-06 19:30:00',NULL),(58,10,'Sorvete Coco Vegano','Feito com leite de coco e açúcar demerara',13.90,4.50,'M',220,NULL,1,'2025-11-06 19:30:00',NULL),(59,10,'Picolé Manga Vegano','Picolé 100% fruta, sem lactose',6.90,2.10,'ÚNICO',100,NULL,1,'2025-11-06 19:30:00',NULL),(60,11,'Milk-shake Sem Lactose Baunilha','Leite vegetal + baunilha',15.50,5.00,'M',330,NULL,1,'2025-11-06 19:30:00',NULL),(61,11,'Sundae Sem Lactose Caramelo','Calda sem lactose e toppings',18.90,6.50,'ÚNICO',420,NULL,1,'2025-11-06 19:30:00',NULL),(62,12,'Frozen Yogurt Natural 300ml','Iogurte grego fermentado, toppings à escolha',12.90,4.20,'M',260,NULL,1,'2025-11-06 19:30:00',NULL),(63,12,'Frozen Yogurt Mix 500ml','Yogurt com frutas e caldas',18.90,6.40,'G',420,NULL,1,'2025-11-06 19:30:00',NULL),(64,13,'Kid Combo Pequeno','1 sorvete P + 1 picolé + balão',22.90,9.00,'G',700,NULL,1,'2025-11-06 19:30:00',NULL),(65,13,'Kid Sundae Doce','Sundae infantil com granulados coloridos',14.90,5.20,'ÚNICO',360,NULL,1,'2025-11-06 19:30:00',NULL),(66,1,'Sorvete Maracujá com Gengibre','Maracujá fresco com toque de gengibre',13.50,4.00,'M',240,NULL,1,'2025-11-06 19:30:00',NULL),(67,1,'Sorvete Nutella Style','Creme de avelã inspirado em Nutella',16.90,6.00,'M',300,NULL,1,'2025-11-06 19:30:00',NULL),(68,1,'Sorvete Cheesecake','Base de cream-cheese com calda de frutas',17.50,6.50,'M',320,NULL,1,'2025-11-06 19:30:00',NULL),(69,2,'Picolé Limão com Hortelã','Refrescante e leve',6.50,1.80,'ÚNICO',95,NULL,1,'2025-11-06 19:30:00',NULL),(70,2,'Picolé Chocolate Branco','Cobertura cremosa',8.50,3.20,'ÚNICO',160,NULL,1,'2025-11-06 19:30:00',NULL),(71,3,'Açaí Bowl Protein 500ml','Açaí com whey vegano, frutas e granola',28.90,10.00,'G',600,NULL,1,'2025-11-06 19:30:00',NULL),(72,4,'Milk-shake Café com Ovomaltine','Café + Ovomaltine crocante',16.90,5.60,'M',410,NULL,1,'2025-11-06 19:30:00',NULL),(73,5,'Sundae Crocante','Sorvete com cookies e farofa crocante',19.90,7.20,'ÚNICO',480,NULL,1,'2025-11-06 19:30:00',NULL),(74,6,'Picolé Frutas Tropicais 2un','Pacote econômico',13.90,5.00,'ÚNICO',220,NULL,1,'2025-11-06 19:30:00',NULL),(75,8,'Picolé Trufado Branco 2un','Versão premium em embalagem dupla',15.90,6.50,'ÚNICO',340,NULL,1,'2025-11-06 19:30:00',NULL),(76,1,'Sorvete Cheesecake de Morango','Cheesecake com compota de morango',18.90,7.00,'M',330,NULL,1,'2025-11-06 19:30:00',NULL),(77,5,'Sundae Brownie Duplo','Brownie + calda + nutella',24.90,9.50,'ÚNICO',650,NULL,1,'2025-11-06 19:30:00',NULL),(78,3,'Açaí Energia 700ml','Açaí + guaraná + supplements',34.90,12.00,'G',800,NULL,1,'2025-11-06 19:30:00',NULL),(79,4,'Milk-shake Chocolate Intenso','Chocolate belga trufado',17.90,6.00,'M',430,NULL,1,'2025-11-06 19:30:00',NULL),(80,1,'Sorvete Doce de Leite com Flor de Sal','Versão especial com flor de sal',15.90,5.20,'M',300,NULL,1,'2025-11-06 19:30:00',NULL),(81,1,'Sorvete Cookies & Cream','Biscoitos crocantes na base de baunilha',14.90,5.00,'M',320,NULL,1,'2025-11-06 19:30:00',NULL),(82,8,'Picolé Frutas Vermelhas Gourmet','Picolé com pedaços inteiros de fruta',9.90,3.80,'ÚNICO',150,NULL,1,'2025-11-06 19:30:00',NULL),(83,12,'Frozen Yogurt Zero Açúcar 300ml','Opção sem açúcar',12.50,4.00,'M',220,NULL,1,'2025-11-06 19:30:00',NULL),(84,13,'Kit Festa Infantil 6 unidades','6 itens infantis surtidos para festas',59.90,22.00,'G',2400,NULL,1,'2025-11-06 19:30:00',NULL),(85,11,'Milk-shake Vegano Chocolate','Leite vegetal + chocolate 70%',16.50,6.00,'M',390,NULL,1,'2025-11-06 19:30:00',NULL);
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
-- Dumping events for database 'defaultdb'
--

--
-- Dumping routines for database 'defaultdb'
--

--
-- Final view structure for view `v_alertas_estoque`
--

/*!50001 DROP VIEW IF EXISTS `v_alertas_estoque`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
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
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_clientes_vip` AS select `c`.`id` AS `id`,`c`.`nome` AS `nome`,`c`.`email` AS `email`,`c`.`pontos_fidelidade` AS `pontos_fidelidade`,count(`p`.`id`) AS `total_pedidos`,sum(`p`.`total`) AS `total_gasto`,avg(`p`.`total`) AS `ticket_medio`,max(`p`.`data_hora`) AS `ultima_compra` from (`clientes` `c` left join `pedidos` `p` on((`c`.`id` = `p`.`cliente_id`))) where (`p`.`status` <> 'cancelado') group by `c`.`id`,`c`.`nome`,`c`.`email`,`c`.`pontos_fidelidade` having (`total_pedidos` >= 3) order by `total_gasto` desc */;
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
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_produtos_mais_vendidos` AS select `prod`.`id` AS `id`,`prod`.`nome` AS `nome`,`cat`.`nome` AS `categoria`,count(`ip`.`id`) AS `total_vendas`,sum(`ip`.`quantidade`) AS `quantidade_total`,sum((`ip`.`quantidade` * `ip`.`preco_unitario`)) AS `receita_total` from (((`produtos` `prod` join `categorias` `cat` on((`prod`.`categoria_id` = `cat`.`id`))) left join `itens_pedido` `ip` on((`prod`.`id` = `ip`.`produto_id`))) left join `pedidos` `ped` on((`ip`.`pedido_id` = `ped`.`id`))) where ((`ped`.`status` <> 'cancelado') or (`ped`.`status` is null)) group by `prod`.`id`,`prod`.`nome`,`cat`.`nome` order by `quantidade_total` desc */;
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
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_vendas_diarias` AS select cast(`p`.`data_hora` as date) AS `data`,`l`.`nome` AS `loja`,count(`p`.`id`) AS `total_pedidos`,sum(`p`.`total`) AS `receita`,avg(`p`.`total`) AS `ticket_medio`,sum((case when (`p`.`tipo` = 'delivery') then 1 else 0 end)) AS `pedidos_delivery`,sum((case when (`p`.`tipo` = 'local') then 1 else 0 end)) AS `pedidos_local` from (`pedidos` `p` join `lojas` `l` on((`p`.`loja_id` = `l`.`id`))) where (`p`.`status` <> 'cancelado') group by cast(`p`.`data_hora` as date),`l`.`nome` order by `data` desc,`loja` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-06 17:02:47
