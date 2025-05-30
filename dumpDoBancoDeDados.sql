-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: greenlife
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `adm_codigo` int NOT NULL AUTO_INCREMENT,
  `adm_email` char(50) NOT NULL,
  `adm_senha` char(15) NOT NULL,
  `adm_nome` char(20) DEFAULT NULL,
  PRIMARY KEY (`adm_codigo`),
  UNIQUE KEY `adm_email` (`adm_email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin1@greenlife.com','admSenha1','Admin One'),(2,'admin2@greenlife.com','admSenha2','Admin Two');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `cat_codigo` int NOT NULL AUTO_INCREMENT,
  `cat_nome` char(50) NOT NULL,
  `cat_nomenormal` char(50) NOT NULL,
  PRIMARY KEY (`cat_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Meio Ambiente','meio-ambiente'),(2,'Reciclagem','reciclagem'),(3,'Saúde & Bem-Estar','saude'),(4,'Sustentabilidade','sustentabilidade'),(5,'Alimentação Saudável','alimentacao'),(6,'Reciclagem e Reutilização','reciclagem'),(7,'Consumo Consciente','consumo');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentarios` (
  `com_codigo` int NOT NULL AUTO_INCREMENT,
  `com_conteudo` text NOT NULL,
  `com_criado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `com_curtidas` int DEFAULT '0',
  `com_deslikes` int DEFAULT '0',
  `usu_codigo` int NOT NULL,
  `dic_codigo` int DEFAULT NULL,
  `pub_codigo` int DEFAULT NULL,
  `com_resposta` int DEFAULT NULL,
  PRIMARY KEY (`com_codigo`),
  KEY `usu_codigo` (`usu_codigo`),
  KEY `dic_codigo` (`dic_codigo`),
  KEY `pub_codigo` (`pub_codigo`),
  KEY `com_resposta` (`com_resposta`),
  CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`usu_codigo`) REFERENCES `usuarios` (`usu_codigo`),
  CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`dic_codigo`) REFERENCES `dicas` (`dic_codigo`),
  CONSTRAINT `comentarios_ibfk_3` FOREIGN KEY (`pub_codigo`) REFERENCES `publicacoes` (`pub_codigo`),
  CONSTRAINT `comentarios_ibfk_4` FOREIGN KEY (`com_resposta`) REFERENCES `comentarios` (`com_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES (1,'Que legal! Você começou com quais plantas?','2025-05-17 21:43:59',0,0,1,NULL,1,NULL),(2,'Boa iniciativa! Já pensei em fazer uma horta na varanda aqui de casa.','2025-05-17 21:43:59',0,0,2,NULL,1,NULL),(3,'Adoro ver esse tipo de atitude! Cultivar alimentos é um ótimo hábito ?','2025-05-17 21:43:59',0,0,3,NULL,1,NULL),(4,'Muito bom! Já plantou manjericão? Cresce rapidinho!','2025-05-17 21:43:59',0,0,4,NULL,1,NULL),(5,'Você deveria tentar sim! Tomates cereja são ótimos pra começar.','2025-05-17 21:44:02',0,0,1,NULL,1,2),(6,'Com certeza! E é até terapêutico!','2025-05-17 21:44:02',0,0,2,NULL,1,3),(7,'Você plantou o quê? Estou pensando em começar também!','2025-05-17 21:21:54',0,0,3,NULL,1,NULL),(8,'Muito bom! Horta caseira é um passo enorme para a sustentabilidade ?','2025-05-17 21:21:54',0,0,4,NULL,1,NULL),(21,'asdasdsadasdas','2025-05-17 22:49:56',0,0,4,NULL,1,NULL),(22,'Cara to perdendo a cabeça com isso ja','2025-05-17 22:51:05',1,0,4,NULL,1,NULL),(23,'Seu primeiro Comentário','2025-05-17 22:51:29',0,0,4,NULL,2,NULL),(24,'Relaxa que o teste da publicação com imagem funcionou, não precisa repostar\r\n','2025-05-17 22:51:58',0,1,4,NULL,15,NULL),(25,'asdasdasdsadasdasda','2025-05-18 15:25:18',0,0,4,NULL,19,NULL),(26,'Na moral bicho, faze esse bagulho já ta chato já','2025-05-18 15:59:29',0,0,4,NULL,1,22),(27,'Concordo com você, ta realmente difícil\r\n','2025-05-18 15:59:49',0,0,4,NULL,1,26),(28,'Teste de comentario','2025-05-18 16:25:15',0,0,4,NULL,1,NULL),(29,'asdasdads','2025-05-18 16:27:46',1,0,4,NULL,1,NULL),(30,'dsadasdasd','2025-05-18 16:28:43',2,0,4,NULL,1,NULL),(31,'qweqweqweqweqwe','2025-05-18 16:29:47',1,0,4,NULL,1,30),(32,'adasdasdasdas','2025-05-18 16:31:30',0,1,4,NULL,1,31),(33,'sdfdsfdsfdsf','2025-05-18 16:33:21',0,1,4,NULL,1,32),(34,'Garai\r\n','2025-05-18 17:19:51',1,0,5,NULL,1,NULL),(35,'Por enquanto tudo certo\r\n','2025-05-18 19:48:12',0,0,4,NULL,15,24),(36,'Teste de Comentário','2025-05-18 23:06:32',0,1,4,3,NULL,NULL),(37,'Outro TEste\r\n\r\n\r\n\r\n\r\n','2025-05-18 23:14:07',0,0,4,3,NULL,NULL),(38,'Ta funcionando?','2025-05-18 23:15:59',0,0,4,3,NULL,37),(39,'Sim\r\n','2025-05-18 23:16:05',0,0,4,3,NULL,38),(40,'Boa então','2025-05-18 23:16:14',0,0,4,3,NULL,39),(41,'qsdpjaiodjaios\r\n','2025-05-19 21:35:57',0,1,4,NULL,22,NULL),(42,'eduardo','2025-05-22 20:22:50',0,0,4,NULL,1,NULL),(43,'gay','2025-05-22 20:22:58',0,0,4,NULL,1,42),(44,'guvugvgvgvgvg\r\n','2025-05-22 21:55:10',0,0,4,NULL,1,33),(45,'jnjnkjnkjn\r\n','2025-05-22 21:55:18',0,0,4,NULL,1,44),(46,'kjnknknkjnkjnkjjkjnkj','2025-05-22 21:55:41',0,0,4,NULL,1,45),(47,'uyuuygyugyugyu','2025-05-22 21:55:54',0,0,4,NULL,1,46),(48,'bhbhbhjbhjjhbjhhjb','2025-05-22 21:56:35',0,0,4,NULL,1,47),(49,'uyyuyuyubuyyubuyhb','2025-05-22 21:56:46',0,0,4,NULL,1,48),(50,'bubhjbjhbjhb','2025-05-22 21:56:58',0,0,4,NULL,1,49),(51,'vvghvghvghvgvghvgvg','2025-05-22 21:57:19',0,0,4,NULL,1,50),(52,'asdasd','2025-05-23 21:59:57',0,0,4,NULL,3,3),(53,'Teste123012312312312','2025-05-23 22:00:52',0,0,4,NULL,2,NULL),(54,'Sim! Concordo Plenamente.','2025-05-23 22:01:32',0,0,4,NULL,1,6),(55,'asdasdasdas','2025-05-23 22:04:13',0,0,4,NULL,4,54);
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curtidas_comentarios`
--

DROP TABLE IF EXISTS `curtidas_comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curtidas_comentarios` (
  `usu_codigo` int NOT NULL,
  `com_codigo` int NOT NULL,
  PRIMARY KEY (`usu_codigo`,`com_codigo`),
  KEY `com_codigo` (`com_codigo`),
  CONSTRAINT `curtidas_comentarios_ibfk_1` FOREIGN KEY (`usu_codigo`) REFERENCES `usuarios` (`usu_codigo`),
  CONSTRAINT `curtidas_comentarios_ibfk_2` FOREIGN KEY (`com_codigo`) REFERENCES `comentarios` (`com_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curtidas_comentarios`
--

LOCK TABLES `curtidas_comentarios` WRITE;
/*!40000 ALTER TABLE `curtidas_comentarios` DISABLE KEYS */;
INSERT INTO `curtidas_comentarios` VALUES (4,22),(4,29),(4,30),(5,30),(4,31),(5,34);
/*!40000 ALTER TABLE `curtidas_comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curtidas_publicacoes`
--

DROP TABLE IF EXISTS `curtidas_publicacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curtidas_publicacoes` (
  `usu_codigo` int NOT NULL,
  `pub_codigo` int NOT NULL,
  PRIMARY KEY (`usu_codigo`,`pub_codigo`),
  KEY `pub_codigo` (`pub_codigo`),
  CONSTRAINT `curtidas_publicacoes_ibfk_1` FOREIGN KEY (`usu_codigo`) REFERENCES `usuarios` (`usu_codigo`),
  CONSTRAINT `curtidas_publicacoes_ibfk_2` FOREIGN KEY (`pub_codigo`) REFERENCES `publicacoes` (`pub_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curtidas_publicacoes`
--

LOCK TABLES `curtidas_publicacoes` WRITE;
/*!40000 ALTER TABLE `curtidas_publicacoes` DISABLE KEYS */;
INSERT INTO `curtidas_publicacoes` VALUES (4,1),(5,1),(4,2),(4,10),(4,19),(5,22);
/*!40000 ALTER TABLE `curtidas_publicacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deslikes_comentarios`
--

DROP TABLE IF EXISTS `deslikes_comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deslikes_comentarios` (
  `usu_codigo` int NOT NULL,
  `com_codigo` int NOT NULL,
  PRIMARY KEY (`usu_codigo`,`com_codigo`),
  KEY `com_codigo` (`com_codigo`),
  CONSTRAINT `deslikes_comentarios_ibfk_1` FOREIGN KEY (`usu_codigo`) REFERENCES `usuarios` (`usu_codigo`),
  CONSTRAINT `deslikes_comentarios_ibfk_2` FOREIGN KEY (`com_codigo`) REFERENCES `comentarios` (`com_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deslikes_comentarios`
--

LOCK TABLES `deslikes_comentarios` WRITE;
/*!40000 ALTER TABLE `deslikes_comentarios` DISABLE KEYS */;
INSERT INTO `deslikes_comentarios` VALUES (4,24),(4,32),(4,33),(4,36),(4,41);
/*!40000 ALTER TABLE `deslikes_comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dia_dica`
--

DROP TABLE IF EXISTS `dia_dica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dia_dica` (
  `dia_codigo` int NOT NULL AUTO_INCREMENT,
  `dia_conteudo` varchar(255) NOT NULL,
  `dia_criado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dia_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dia_dica`
--

LOCK TABLES `dia_dica` WRITE;
/*!40000 ALTER TABLE `dia_dica` DISABLE KEYS */;
INSERT INTO `dia_dica` VALUES (1,'Beba água regularmente ao longo do dia para manter-se hidratado.','2025-05-17 15:55:14'),(2,'Organize suas tarefas por prioridade para aumentar sua produtividade.','2025-05-17 15:56:10'),(3,'Lembre-se de fazer pausas durante longos períodos de estudo ou trabalho.','2025-05-17 15:57:17'),(4,'Lembre-se de fazer pausas durante longos períodos de estudo ou trabalho.','2025-05-18 17:17:35');
/*!40000 ALTER TABLE `dia_dica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dicas`
--

DROP TABLE IF EXISTS `dicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dicas` (
  `dic_codigo` int NOT NULL AUTO_INCREMENT,
  `dic_titulo` varchar(100) NOT NULL,
  `dic_conteudo` text NOT NULL,
  `dic_imagem` varchar(255) DEFAULT NULL,
  `dic_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `adm_codigo` int NOT NULL,
  `cat_codigo` int DEFAULT NULL,
  PRIMARY KEY (`dic_codigo`),
  KEY `adm_codigo` (`adm_codigo`),
  KEY `cat_codigo` (`cat_codigo`),
  CONSTRAINT `dicas_ibfk_1` FOREIGN KEY (`adm_codigo`) REFERENCES `admins` (`adm_codigo`),
  CONSTRAINT `dicas_ibfk_2` FOREIGN KEY (`cat_codigo`) REFERENCES `categorias` (`cat_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dicas`
--

LOCK TABLES `dicas` WRITE;
/*!40000 ALTER TABLE `dicas` DISABLE KEYS */;
INSERT INTO `dicas` VALUES (1,'Como reciclar plástico corretamente','defaultTxt.txt','defalutDica.png','2025-05-16 22:49:20',1,2),(2,'Benefícios da compostagem','defaultTxt.txt','defalutDica.png','2025-05-16 22:49:20',2,1),(3,'Beba mais água diariamente','defaultTxt.txt','defalutDica.png','2025-05-18 17:33:28',1,1),(4,'Reduza o uso de plástico','defaultTxt.txt','defalutDica.png','2025-05-18 17:33:28',1,2),(5,'Inclua vegetais na dieta diária','defaultTxt.txt','defalutDica.png','2025-05-18 17:33:28',1,3),(6,'Separe seu lixo corretamente','defaultTxt.txt','defalutDica.png','2025-05-18 17:33:28',1,4),(7,'Compre apenas o necessário','defaultTxt.txt','defalutDica.png','2025-05-18 17:33:28',1,5);
/*!40000 ALTER TABLE `dicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicacoes`
--

DROP TABLE IF EXISTS `publicacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicacoes` (
  `pub_codigo` int NOT NULL AUTO_INCREMENT,
  `pub_conteudo` varchar(255) DEFAULT NULL,
  `pub_criado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pub_bloqueado` tinyint DEFAULT '0',
  `pub_resposta` int DEFAULT NULL,
  `pub_repostado` int DEFAULT NULL,
  `pub_qtdrespostas` int DEFAULT '0',
  `pub_qtdrepostado` int DEFAULT '0',
  `pub_qtdcurtiu` int DEFAULT '0',
  `pub_qtdsalvo` int DEFAULT '0',
  `pub_anexo` varchar(255) DEFAULT NULL,
  `usu_codigo` int NOT NULL,
  PRIMARY KEY (`pub_codigo`),
  KEY `usu_codigo` (`usu_codigo`),
  KEY `pub_resposta` (`pub_resposta`),
  KEY `pub_repostado` (`pub_repostado`),
  CONSTRAINT `publicacoes_ibfk_1` FOREIGN KEY (`usu_codigo`) REFERENCES `usuarios` (`usu_codigo`),
  CONSTRAINT `publicacoes_ibfk_2` FOREIGN KEY (`pub_resposta`) REFERENCES `publicacoes` (`pub_codigo`),
  CONSTRAINT `publicacoes_ibfk_3` FOREIGN KEY (`pub_repostado`) REFERENCES `publicacoes` (`pub_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacoes`
--

LOCK TABLES `publicacoes` WRITE;
/*!40000 ALTER TABLE `publicacoes` DISABLE KEYS */;
INSERT INTO `publicacoes` VALUES (1,'? Comecei minha horta orgânica hoje!','2025-05-16 22:49:20',0,NULL,NULL,23,5,2,2,NULL,1),(2,'♻️ Dica: separe seu lixo reciclável corretamente!','2025-05-16 22:49:20',0,NULL,NULL,1,0,1,1,NULL,3),(3,'? Que dia lindo para plantar árvores!','2025-05-16 22:49:20',0,NULL,NULL,1,1,0,1,'plantio.jpeg',2),(4,NULL,'2025-05-17 16:16:48',0,NULL,NULL,1,0,0,0,NULL,4),(5,NULL,'2025-05-17 16:17:00',0,NULL,NULL,0,0,0,0,NULL,4),(6,NULL,'2025-05-17 16:17:29',0,NULL,NULL,0,0,0,0,NULL,4),(7,'sadasdasdasdas','2025-05-17 16:23:45',0,NULL,NULL,0,0,0,0,NULL,4),(8,'Testando publicação','2025-05-17 16:24:00',0,NULL,NULL,0,0,0,0,NULL,4),(9,'Testando publicação com imagem','2025-05-17 16:24:16',0,NULL,NULL,0,1,0,0,'07c1dab726ba48119223897ed9790568',4),(10,'? Que dia lindo para plantar árvores!','2025-05-17 16:55:03',0,NULL,3,0,1,1,0,'plantio.jpeg',4),(11,'asdasda','2025-05-17 17:20:15',0,NULL,NULL,0,1,0,0,NULL,4),(12,'asdasda','2025-05-17 17:20:17',0,NULL,11,0,1,0,0,NULL,4),(13,'asdasda','2025-05-17 17:20:21',0,NULL,12,0,0,0,0,NULL,4),(14,'? Que dia lindo para plantar árvores!','2025-05-17 17:20:27',0,NULL,10,0,0,0,0,'plantio.jpeg',4),(15,'Testando publicação com imagem','2025-05-17 17:20:33',0,NULL,9,1,0,0,0,'07c1dab726ba48119223897ed9790568',4),(16,'asd','2025-05-17 17:32:31',0,NULL,NULL,0,1,0,0,NULL,4),(17,'asd','2025-05-17 17:32:32',0,NULL,16,0,0,0,0,NULL,4),(18,'? Comecei minha horta orgânica hoje!','2025-05-17 22:05:52',0,NULL,1,0,0,0,0,NULL,4),(19,'asdasdasdasdasdasdasdas','2025-05-17 22:44:51',0,NULL,NULL,0,0,1,0,NULL,4),(20,'? Comecei minha horta orgânica hoje!','2025-05-18 16:28:22',0,NULL,1,0,0,0,0,NULL,4),(21,'? Comecei minha horta orgânica hoje!','2025-05-18 16:28:25',0,NULL,1,0,0,0,0,NULL,4),(22,'? Comecei minha horta orgânica hoje!','2025-05-18 16:28:27',0,NULL,1,1,0,1,0,NULL,4),(23,'Bom dia Comunidade! Espero que estejam bem','2025-05-23 19:45:19',0,NULL,NULL,0,0,0,0,NULL,6),(26,NULL,'2025-05-23 19:59:48',0,NULL,NULL,1,1,0,0,NULL,6),(27,'? Comecei minha horta orgânica hoje!','2025-05-23 21:57:10',0,NULL,1,0,0,0,0,NULL,4),(28,NULL,'2025-05-23 22:04:39',0,NULL,26,0,0,0,0,NULL,4),(38,'Bom dia Comunidade! Espero que estejam bem','2025-05-25 18:18:11',0,NULL,NULL,0,0,0,0,NULL,6),(40,NULL,'2025-05-25 18:18:11',0,NULL,NULL,0,0,0,0,NULL,6);
/*!40000 ALTER TABLE `publicacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salvos_dicas`
--

DROP TABLE IF EXISTS `salvos_dicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salvos_dicas` (
  `usu_codigo` int NOT NULL,
  `dic_codigo` int NOT NULL,
  PRIMARY KEY (`usu_codigo`,`dic_codigo`),
  KEY `dic_codigo` (`dic_codigo`),
  CONSTRAINT `salvos_dicas_ibfk_1` FOREIGN KEY (`usu_codigo`) REFERENCES `usuarios` (`usu_codigo`),
  CONSTRAINT `salvos_dicas_ibfk_2` FOREIGN KEY (`dic_codigo`) REFERENCES `dicas` (`dic_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salvos_dicas`
--

LOCK TABLES `salvos_dicas` WRITE;
/*!40000 ALTER TABLE `salvos_dicas` DISABLE KEYS */;
INSERT INTO `salvos_dicas` VALUES (4,1),(4,2),(4,6),(4,7);
/*!40000 ALTER TABLE `salvos_dicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salvos_publicacoes`
--

DROP TABLE IF EXISTS `salvos_publicacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salvos_publicacoes` (
  `usu_codigo` int NOT NULL,
  `pub_codigo` int NOT NULL,
  PRIMARY KEY (`usu_codigo`,`pub_codigo`),
  KEY `pub_codigo` (`pub_codigo`),
  CONSTRAINT `salvos_publicacoes_ibfk_1` FOREIGN KEY (`usu_codigo`) REFERENCES `usuarios` (`usu_codigo`),
  CONSTRAINT `salvos_publicacoes_ibfk_2` FOREIGN KEY (`pub_codigo`) REFERENCES `publicacoes` (`pub_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salvos_publicacoes`
--

LOCK TABLES `salvos_publicacoes` WRITE;
/*!40000 ALTER TABLE `salvos_publicacoes` DISABLE KEYS */;
INSERT INTO `salvos_publicacoes` VALUES (4,1),(5,1),(4,2),(4,3);
/*!40000 ALTER TABLE `salvos_publicacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguidores`
--

DROP TABLE IF EXISTS `seguidores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seguidores` (
  `seguidor_id` int NOT NULL,
  `seguido_id` int NOT NULL,
  PRIMARY KEY (`seguidor_id`,`seguido_id`),
  KEY `seguido_id` (`seguido_id`),
  CONSTRAINT `seguidores_ibfk_1` FOREIGN KEY (`seguidor_id`) REFERENCES `usuarios` (`usu_codigo`),
  CONSTRAINT `seguidores_ibfk_2` FOREIGN KEY (`seguido_id`) REFERENCES `usuarios` (`usu_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguidores`
--

LOCK TABLES `seguidores` WRITE;
/*!40000 ALTER TABLE `seguidores` DISABLE KEYS */;
/*!40000 ALTER TABLE `seguidores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `usu_codigo` int NOT NULL AUTO_INCREMENT,
  `usu_nomeusuario` varchar(50) NOT NULL,
  `usu_email` varchar(255) NOT NULL,
  `usu_senha` varchar(255) NOT NULL,
  `usu_foto` varchar(255) DEFAULT 'default.png',
  `usu_imgBackground` varchar(50) DEFAULT 'default.png',
  `usu_bio` varchar(255) DEFAULT NULL,
  `usu_criado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usu_suspenso` tinyint DEFAULT '0',
  PRIMARY KEY (`usu_codigo`),
  UNIQUE KEY `UQ_usu_nomeusuario` (`usu_nomeusuario`),
  UNIQUE KEY `UQ_usu_email` (`usu_email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Alice','alice@email.com','senha123','alice.png','default.png',NULL,'2025-05-16 22:49:20',0),(2,'Bob','bob@email.com','senha456','bob.png','default.png',NULL,'2025-05-16 22:49:20',0),(3,'Carol','carol@email.com','senha789','carol.png','default.png',NULL,'2025-05-16 22:49:20',0),(4,'Teste','teste@gmail.com','$2b$10$83yDy5kSn88C2gEys0iQDuJZ15h2paWSS4ZM.M/bF7sqiOLsaTYce','default.png','default.png',NULL,'2025-05-16 22:50:21',0),(5,'Fulano','ful@teste.com','$2b$10$4Zh78YeBwSTsxC4zRZW8I.t33DglzRUAvxZk2DpPuD5.bv0AuleTa','default.png','default.png',NULL,'2025-05-18 17:18:14',0),(6,'VictoryGrey','victory@gmail.com','$2b$10$UCD0zrI5y/EoM4cAlJDzr.mZVKNcif6I/2kQ1qAJp8UBRiVn/Ga4a','default.png','default.png',NULL,'2025-05-22 18:54:40',0),(10,'VictoryGrey123','victory123123@gmail.com','$2b$10$Q.IYvHRI9ufmGcotsJTNbOz9bvMY12GpASJ970PuyOby42sQU4/Z2','default.png','default.png',NULL,'2025-05-25 18:18:11',0);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-30 14:00:10
