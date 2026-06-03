-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: rpg_game
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `action_rules`
--

DROP TABLE IF EXISTS `action_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_rules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  `effect` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `scene_id` bigint(20) unsigned DEFAULT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_rules`
--

LOCK TABLES `action_rules` WRITE;
/*!40000 ALTER TABLE `action_rules` DISABLE KEYS */;
INSERT INTO `action_rules` VALUES (1,'investigar',1,'lose_wallet_silent','Pierde la cartera sin darse cuenta',NULL,NULL,NULL,'Parece ser que no hay nada de interés'),(2,'investigar',2,'find_clue_restore_wallet','Encuentra pista y recupera cartera',NULL,NULL,NULL,'¡Has encontrado lo que parecen ser unas llaves de casa! Ademas has encontrado tu cartera, deberias andar con mas cuidado'),(3,'investigar',3,'nothing_more',NULL,NULL,NULL,NULL,'Ya no hay nada más que investigar aquí.');
/*!40000 ALTER TABLE `action_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scene_id` int(11) DEFAULT NULL,
  `key_name` varchar(100) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scene_id` (`scene_id`),
  CONSTRAINT `actions_ibfk_1` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (1,1,'investigar','Investigar la habitación'),(2,1,'salir','Salir de la habitación'),(3,3,'hablar_policia','Hablar con la policía'),(4,3,'salir','Salir del calabozo'),(5,4,'descansar','Descansar'),(6,4,'dormir','Dormir'),(7,5,'hablar','Hablar con NPCs'),(8,5,'beber','Beber alcohol'),(9,6,'buscar_pistas','Buscar pistas'),(10,6,'esconderse','Esconderse'),(11,7,'investigar_medicamentos','Investigar medicamentos'),(12,8,'viajar_paris','Tomar vuelo a París'),(13,9,'explorar','Explorar el parque'),(14,10,'final','Desenlace final');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) DEFAULT NULL,
  `scene_id` int(11) DEFAULT NULL,
  `action_key` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (1,1,1,'investigar','2026-04-12 23:11:35','2026-04-12 23:11:35'),(2,1,1,'investigar','2026-04-12 23:11:59','2026-04-12 23:11:59'),(3,1,1,'investigar','2026-04-12 23:20:26','2026-04-12 23:20:26'),(4,1,1,'investigar','2026-04-12 23:26:49','2026-04-12 23:26:49'),(5,1,1,'investigar','2026-04-12 23:27:47','2026-04-12 23:27:47'),(6,1,1,'investigar','2026-04-12 23:29:05','2026-04-12 23:29:05'),(7,1,1,'investigar','2026-04-12 23:29:20','2026-04-12 23:29:20'),(8,1,1,'investigar','2026-04-12 23:33:07','2026-04-12 23:33:07'),(9,1,1,'investigar','2026-04-12 23:33:50','2026-04-12 23:33:50'),(10,1,1,'investigar','2026-04-12 23:34:14','2026-04-12 23:34:14'),(11,1,1,'investigar','2026-04-12 23:34:24','2026-04-12 23:34:24'),(12,1,1,'investigar','2026-04-12 23:34:34','2026-04-12 23:34:34'),(13,1,1,'investigar','2026-04-12 23:34:41','2026-04-12 23:34:41'),(14,1,1,'investigar','2026-04-12 23:34:48','2026-04-12 23:34:48'),(15,1,1,'investigar','2026-04-12 23:34:53','2026-04-12 23:34:53'),(16,1,1,'investigar','2026-04-12 23:35:15','2026-04-12 23:35:15'),(17,1,1,'investigar','2026-04-12 23:35:34','2026-04-12 23:35:34'),(18,1,1,'investigar','2026-04-12 23:36:48','2026-04-12 23:36:48'),(19,1,1,'investigar','2026-04-12 23:37:04','2026-04-12 23:37:04'),(20,1,1,'investigar','2026-04-12 23:37:18','2026-04-12 23:37:18'),(21,1,1,'investigar','2026-04-12 23:38:00','2026-04-12 23:38:00'),(22,1,1,'investigar','2026-04-12 23:38:07','2026-04-12 23:38:07'),(23,1,1,'investigar','2026-04-12 23:38:21','2026-04-12 23:38:21'),(24,1,1,'investigar','2026-04-12 23:38:36','2026-04-12 23:38:36'),(25,1,1,'investigar','2026-04-12 23:40:04','2026-04-12 23:40:04'),(26,1,1,'investigar','2026-04-12 23:40:14','2026-04-12 23:40:14'),(27,1,1,'investigar','2026-04-12 23:40:32','2026-04-12 23:40:32'),(28,1,1,'investigar','2026-04-12 23:40:37','2026-04-12 23:40:37'),(29,1,1,'investigar','2026-04-12 23:40:42','2026-04-12 23:40:42'),(30,1,1,'investigar','2026-04-12 23:42:08','2026-04-12 23:42:08'),(31,1,1,'investigar','2026-04-12 23:42:12','2026-04-12 23:42:12'),(32,1,1,'investigar','2026-04-12 23:45:36','2026-04-12 23:45:36'),(33,1,1,'investigar','2026-04-12 23:45:53','2026-04-12 23:45:53'),(34,1,1,'investigar','2026-04-12 23:45:58','2026-04-12 23:45:58'),(35,1,1,'investigar','2026-04-12 23:46:09','2026-04-12 23:46:09'),(36,1,1,'investigar','2026-04-12 23:46:40','2026-04-12 23:46:40'),(37,1,1,'investigar','2026-04-12 23:46:44','2026-04-12 23:46:44'),(38,1,1,'investigar','2026-04-12 23:47:32','2026-04-12 23:47:32'),(39,1,1,'investigar','2026-04-12 23:48:05','2026-04-12 23:48:05'),(40,1,1,'investigar','2026-04-12 23:48:32','2026-04-12 23:48:32'),(41,1,1,'investigar','2026-04-12 23:50:08','2026-04-12 23:50:08'),(42,1,1,'investigar','2026-04-12 23:51:05','2026-04-12 23:51:05'),(43,1,1,'investigar','2026-04-12 23:52:20','2026-04-12 23:52:20'),(44,1,1,'investigar','2026-04-12 23:52:33','2026-04-12 23:52:33'),(45,1,1,'investigar','2026-04-12 23:52:58','2026-04-12 23:52:58'),(46,1,1,'investigar','2026-04-29 15:06:53','2026-04-29 15:06:53');
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Llaves de la casa de la víctima',NULL);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_dialogues`
--

DROP TABLE IF EXISTS `npc_dialogues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npc_dialogues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npc_id` int(11) DEFAULT NULL,
  `scene_id` int(11) DEFAULT NULL,
  `trigger` text DEFAULT NULL,
  `response` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc_dialogues`
--

LOCK TABLES `npc_dialogues` WRITE;
/*!40000 ALTER TABLE `npc_dialogues` DISABLE KEYS */;
/*!40000 ALTER TABLE `npc_dialogues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npcs`
--

DROP TABLE IF EXISTS `npcs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `npcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `personality` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npcs`
--

LOCK TABLES `npcs` WRITE;
/*!40000 ALTER TABLE `npcs` DISABLE KEYS */;
/*!40000 ALTER TABLE `npcs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_actions`
--

DROP TABLE IF EXISTS `player_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_actions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_player_action` (`player_id`,`action`),
  CONSTRAINT `fk_player_actions_player` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_actions`
--

LOCK TABLES `player_actions` WRITE;
/*!40000 ALTER TABLE `player_actions` DISABLE KEYS */;
INSERT INTO `player_actions` VALUES (29,1,'investigar','2026-04-12 23:46:40','2026-04-12 23:46:40'),(38,1,'investigar','2026-04-12 23:52:58','2026-04-12 23:52:58'),(39,1,'investigar','2026-04-29 15:06:53','2026-04-29 15:06:53');
/*!40000 ALTER TABLE `player_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_items`
--

DROP TABLE IF EXISTS `player_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`),
  CONSTRAINT `player_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_items`
--

LOCK TABLES `player_items` WRITE;
/*!40000 ALTER TABLE `player_items` DISABLE KEYS */;
INSERT INTO `player_items` VALUES (1,1,1,'2026-04-12 23:51:05','2026-04-12 23:51:05');
/*!40000 ALTER TABLE `player_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `sanity` int(11) DEFAULT 100,
  `suspicion` int(11) DEFAULT 0,
  `location_scene_id` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'TestPlayer',100,0,1,'2026-04-13 00:04:51');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scenes`
--

DROP TABLE IF EXISTS `scenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenes`
--

LOCK TABLES `scenes` WRITE;
/*!40000 ALTER TABLE `scenes` DISABLE KEYS */;
INSERT INTO `scenes` VALUES (1,'Habitación del Hotel','El cuerpo del marido está en la habitación.'),(2,'Pasillo del Hotel','Un pasillo oscuro lleno de puertas.'),(3,'Calabozo','La policía interroga al sospechoso.'),(4,'Casa del Jugador','Lugar seguro para descansar.'),(5,'Bar','NPCs y alcohol. Información oculta.'),(6,'Casa del Sospechoso','Lugar peligroso lleno de pistas.'),(7,'Farmacia','Medicamentos y pistas químicas.'),(8,'Aeropuerto','Solo accesible con pruebas suficientes.'),(9,'Paris - Parque','Inicio del final de la historia.'),(10,'Jardín de Tuileries','Escena final del caso.');
/*!40000 ALTER TABLE `scenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transitions`
--

DROP TABLE IF EXISTS `transitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_key` varchar(100) DEFAULT NULL,
  `from_scene_id` int(11) DEFAULT NULL,
  `to_scene_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transitions`
--

LOCK TABLES `transitions` WRITE;
/*!40000 ALTER TABLE `transitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transitions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-03  3:23:00
