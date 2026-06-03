-- MySQL dump 10.13  Distrib 8.4.9, for Linux (x86_64)
--
-- Host: localhost    Database: rpg_game
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `scene_texts`
--

DROP TABLE IF EXISTS `scene_texts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scene_texts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scene_id` int NOT NULL,
  `text` longtext NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `required_item_id` int DEFAULT NULL,
  `visit_number` int DEFAULT NULL,
  `min_visits` int DEFAULT NULL,
  `priority` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `scene_id` (`scene_id`),
  KEY `required_item_id` (`required_item_id`),
  CONSTRAINT `scene_texts_ibfk_1` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`id`),
  CONSTRAINT `scene_texts_ibfk_2` FOREIGN KEY (`required_item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scene_texts`
--

LOCK TABLES `scene_texts` WRITE;
/*!40000 ALTER TABLE `scene_texts` DISABLE KEYS */;
INSERT INTO `scene_texts` VALUES (1,1,'Barcelona. España. Hotel Mirador las estrellas.\nHas llegado esta mañana desde Madrid. Tres días de reuniones de trabajo que empiezan mañana.\nPor ahora, solo necesitas subir a la habitación y descansar.\n\nSubes las escaleras buscando tu número.\nPiso 2.\nAvanzas por el pasillo.\n204, 206, 208, 210...\nLa habitación 209 tiene la puerta abierta y al echar un vistazo te encuentras un cuerpo en el suelo.\n¿Hola? ¿Se encuentra bien?\n-...\nProcedes a entrar a ver si se encuentra bien.\nEstá muerto.\n...\n...\n...\n¿Qué haces?','/images/habitacion.jpg',NULL,NULL,1,10,'2026-04-30 01:16:34'),(2,2,'Los dos agentes te rodean antes de que puedas decir nada.\n\"Documentación.\"\nLes muestras tu identificación con manos temblorosas.\nTe conducen a una sala pequeña.\nUna mesa. Dos sillas. Una bombilla.\n\nEl inspector entra y cierra la puerta.\n\n\"¿Cómo se llama usted?\" — Te mira fijamente esperando tu respuesta.',NULL,NULL,NULL,1,10,'2026-04-30 21:35:46'),(4,3,'Una celda fría. Luz fluorescente. El ruido metálico de una puerta al cerrarse.\n\nA tu izquierda, al otro lado de los barrotes, un hombre te observa en silencio.\nA tu derecha, otro. Este parece querer hablar.\n\n¿Qué haces?',NULL,NULL,NULL,1,10,'2026-05-01 00:16:31'),(5,3,'Sigues en el calabozo.\nEl tiempo pasa lento aquí dentro.\n\nEl hombre de la izquierda sigue mirándote.\nEl de la derecha tamborilea los dedos en los barrotes.\n\n¿Qué haces?',NULL,NULL,NULL,2,10,'2026-05-01 00:16:31'),(6,11,'Las puertas de la comisaría se abren.\nEl aire frío de Barcelona te golpea en la cara.\n\nUn agente te entrega una bolsa con tus pertenencias.\n\"Queda usted en libertad provisional.\"\nUna pausa.\n\"No abandone la ciudad. Podríamos necesitarle.\"\n\nAnte usted, Barcelona.\n¿A dónde va?',NULL,NULL,NULL,1,10,'2026-05-01 00:16:32'),(7,4,'Tu casa.\nEl silencio aquí es distinto.\nDejás las llaves sobre la mesa y te derrumbas en el sofá.\nBarcelona sigue ahí fuera, pero esta noche no te necesita.\nO eso te dices.\n\nEl caso da vueltas en tu cabeza.\nUn muerto en el 209.\nUn DNI.\nUna pistola con una bala menos.\n\n¿Qué haces?',NULL,NULL,NULL,1,10,'2026-05-03 00:21:46'),(8,4,'De nuevo en casa.\nLas paredes empiezan a resultarte familiares de otra manera.\nComo si el caso las hubiera manchado también.\n\n¿Qué haces?',NULL,NULL,NULL,2,10,'2026-05-03 00:21:46'),(9,5,'El bar huele a tabaco frío y cerveza derramada.\nLuz tenue. Madera oscura. Ruido de fondo.\n\nHay tres tipos de gente aquí:\nlos que beben para olvidar,\nlos que beben para hablar,\ny los que observan.\n\nEn la barra, un hombre te mira de reojo.\nEn una mesa del fondo, otro parece estar esperando a alguien.\nEl servicio está al fondo a la izquierda.\n\n¿Qué haces?',NULL,NULL,NULL,1,10,'2026-05-03 00:21:46'),(10,5,'Vuelves al bar.\nEl ambiente es el mismo.\nLas mismas caras. El mismo olor.\n\n¿Qué haces?',NULL,NULL,NULL,2,10,'2026-05-03 00:21:46'),(11,6,'La dirección del DNI te ha traído hasta aquí.\nUn bloque de pisos en el Eixample.\nTercero segunda.\n\nLa puerta está cerrada pero la cerradura es vieja.\nNo sería difícil entrar.\n\nUn vecino pasa por el rellano y te mira.\n¿Qué haces?',NULL,NULL,NULL,1,10,'2026-05-03 00:21:46'),(12,6,'Vuelves a la casa de Tomás.\nEl silencio dentro es denso.\nComo si las paredes supieran algo.\n\n¿Qué haces?',NULL,NULL,NULL,2,10,'2026-05-03 00:21:46'),(13,7,'Farmacia Mendoza.\nUn local pequeño en una calle tranquila del Gràcia.\nEl letrero verde parpadea.\n\nDetrás del mostrador una mujer mayor te mira por encima de las gafas.\n\"¿En qué le puedo ayudar?\"\n\n¿Qué haces?',NULL,NULL,NULL,1,10,'2026-05-03 00:21:46'),(14,7,'Vuelves a la farmacia.\nLa mujer te reconoce.\nSu expresión cambia ligeramente.\n\n¿Qué haces?',NULL,NULL,NULL,2,10,'2026-05-03 00:21:46'),(15,12,'Estás en la calle.\nBarcelona se mueve a tu alrededor.\n\n¿A dónde vas?',NULL,NULL,NULL,1,10,'2026-05-03 00:35:40'),(16,13,'Luces tenues. Mesas de tapete verde.\nEl sonido de las fichas y las cartas mezclándose.\nEl ambiente huele a tabaco y dinero fácil.\n\nUn crupier te mira desde la mesa de blackjack.\nEn una esquina, un hombre con traje observa a los jugadores.\nNadie parece estar aquí por casualidad.\n\n¿Qué haces?',NULL,NULL,NULL,1,10,'2026-05-07 17:59:24');
/*!40000 ALTER TABLE `scene_texts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-03  2:30:31
