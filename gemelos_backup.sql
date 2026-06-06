mysqldump: [Warning] Using a password on the command line interface can be insecure.
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
mysqldump: Error: 'Access denied; you need (at least one of) the PROCESS privilege(s) for this operation' when trying to dump tablespaces

--
-- Table structure for table `action_rules`
--

DROP TABLE IF EXISTS `action_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action_rules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `count` int NOT NULL,
  `effect` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `scene_id` bigint unsigned DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_rules`
--

LOCK TABLES `action_rules` WRITE;
/*!40000 ALTER TABLE `action_rules` DISABLE KEYS */;
INSERT INTO `action_rules` VALUES (1,'investigar',1,'lose_wallet_silent','Pierde la cartera sin darse cuenta',NULL,NULL,NULL,'Parece ser que no hay nada de interés'),(2,'investigar',2,'find_clue_restore_wallet','Encuentra pista y recupera cartera',NULL,NULL,NULL,'¡Has encontrado lo que parecen ser unas llaves de casa! Ademas has encontrado tu cartera, deberias andar con mas cuidado'),(3,'investigar',3,'nothing_more',NULL,NULL,NULL,NULL,'Ya no hay nada más que investigar aquí.'),(4,'examinar_cadaver',1,'find_item:1',NULL,NULL,NULL,1,'El hombre lleva traje. En el bolsillo interior encuentras su cartera. Hay un DNI a nombre de Tomás con una dirección en Barcelona.'),(5,'examinar_cadaver',2,'increase_suspicion',NULL,NULL,NULL,1,'Ya has examinado el cuerpo. Sigues tocando. Tus huellas están por todas partes ahora.'),(6,'examinar_cadaver',3,'nothing_more',NULL,NULL,NULL,1,'No hay nada más. Pero tus huellas están en el cuerpo.'),(7,'examinar_maleta',1,'nothing_more',NULL,NULL,NULL,1,'La maleta contiene ropa de hombre. Nada llamativo a primera vista.'),(8,'examinar_maleta',2,'nothing_more',NULL,NULL,NULL,1,'Sigues revisando. El forro interior parece cosido recientemente, como si hubieran escondido algo y lo hubieran vuelto a cerrar.'),(9,'examinar_bano',1,'nothing_more',NULL,NULL,NULL,1,'El baño huele a colonia cara. Hay dos cepillos de dientes. Dos personas vivían aquí. O al menos dos personas usaban esta habitación.'),(10,'examinar_bano',2,'nothing_more',NULL,NULL,NULL,1,'No hay nada más en el baño. Pero esos dos cepillos no dejan de llamarte la atención.'),(11,'mirar_cama',1,'find_item:2',NULL,NULL,NULL,1,'Debajo de la cama hay una pistola. El cargador casi lleno. Falta una bala. Una sola bala disparada.'),(12,'mirar_cama',2,'nothing_more',NULL,NULL,NULL,1,'No hay nada más bajo la cama.'),(13,'llamar_recepcion',1,'increase_suspicion',NULL,NULL,NULL,1,'Descuelgas el teléfono. \"Hay un hombre muerto en la habitación 209.\" Silencio. \"Ahora mismo subimos.\" Escuchas pasos en el pasillo. Te has delatado.'),(14,'llamar_recepcion',2,'nothing_more',NULL,NULL,NULL,1,'Ya has llamado. Los pasos se acercan.'),(15,'salir',1,'none',NULL,NULL,NULL,1,'Sales al pasillo. La puerta se cierra detrás de ti. Al fondo del corredor dos policías de uniforme avanzan hacia ti. No tienes a donde ir.'),(16,'decir_verdad',1,'decrease_suspicion',NULL,NULL,NULL,2,'Les cuentas lo que viste. La puerta abierta, el cuerpo. El inspector te mira fijamente. \"¿Y qué hacía usted en este hotel?\" La verdad a medias no es suficiente.'),(17,'mentir',1,'increase_suspicion',NULL,NULL,NULL,2,'Inventas una historia. El inspector asiente lentamente. Demasiado lentamente. \"Interesante.\" Anota algo en su libreta. No te cree.'),(18,'callar',1,'increase_suspicion',NULL,NULL,NULL,2,'No dices nada. Tu silencio habla por ti. \"Muy bien. Acompáñenos.\" No es una petición.'),(19,'entregar_dni',1,'decrease_suspicion',NULL,NULL,NULL,2,'Sacas el DNI de Rafael Vidal. El inspector frunce el ceño. \"¿Dónde encontró esto?\" Ahora tienen algo en lo que pensar además de en ti.'),(20,'hablar_izquierda',1,'none',NULL,NULL,NULL,3,'El hombre te mira fijamente.\n\"Rafael Vidal. Le conocía. Traficante de arte. Le vi entrar al hotel con una maleta enorme. La mujer que le acompañaba era pelirroja, abrigo rojo. Tienen una red en toda Europa.\"\nTe lo dice con total convicción.\nAlgo en su mirada no te convence del todo.'),(21,'hablar_izquierda',2,'none',NULL,NULL,NULL,3,'\"Te lo juro. Cuadros robados. El Museo del Prado lleva años buscándole.\"\nSigue insistiendo.\nCada vez suena menos creíble.'),(22,'hablar_izquierda',3,'none',NULL,NULL,NULL,3,'El hombre se gira y no dice nada más.\nHas sacado todo lo que podías sacar de él.\nQue no es nada.'),(23,'hablar_derecha',1,'none',NULL,NULL,NULL,3,'El hombre sonríe y se acerca a los barrotes.\n\n\"En la habitación 209 hay un muerto. La ventana está cerrada por dentro. La puerta estaba abierta. No hay arma. ¿Quién mató al inspector?\"\n\nUna pausa larga.\n\nSe aleja y se tumba en su catre.\n'),(24,'hablar_derecha',2,'none',NULL,NULL,NULL,3,'\"Ya te dije lo que sabía.\"\nSe gira hacia la pared.'),(25,'hablar_derecha',3,'none',NULL,NULL,NULL,3,'El preso cierra los ojos. No dice nada más.'),(26,'esperar',1,'none',NULL,NULL,NULL,3,'Te sientas en el catre.\nEl tiempo pasa.\nLas horas en este sitio pesan el doble.'),(27,'esperar',2,'none',NULL,NULL,NULL,3,'Sigues esperando.\nEl fluorescente parpadea.\nAlguien tose al fondo del pasillo.'),(28,'esperar',3,'none',NULL,NULL,NULL,3,'No queda nada más que hacer.\nSolo esperar a que pasen las 48 horas.'),(29,'intentar_salir',1,'none',NULL,NULL,NULL,3,'Te acercas a la puerta.\nUn guardia te mira desde el fondo del pasillo.\n\"Vuelva a su celda.\"\nNo es negociable.'),(30,'intentar_salir',2,'increase_suspicion',NULL,NULL,NULL,3,'Insistes.\nEl guardia se levanta.\n\"¿Quiere añadir resistencia a los cargos?\"\nDas un paso atrás.'),(31,'descansar',1,'decrease_suspicion',NULL,NULL,NULL,4,'Te recuestas un momento.\nLa tensión de los últimos días pesa.\nRespiras.\nAlgo en tu cabeza se asienta.'),(32,'descansar',2,'decrease_suspicion',NULL,NULL,NULL,4,'Sigues descansando.\nEl caso puede esperar un poco más.'),(33,'dormir',1,'decrease_suspicion',NULL,NULL,NULL,4,'Cierras los ojos.\nNo sabes cuánto tiempo pasa.\nCuando te despiertas, la cabeza te funciona mejor.\nLa sospecha sobre ti parece haberse disipado un poco.'),(34,'revisar_notas',1,'none',NULL,NULL,NULL,4,'Repasas mentalmente lo que sabes.\n\nUn hombre muerto en la habitación 209.\nNombre: Tomás.\nUna pistola con una bala disparada.\nDos cepillos de dientes en el baño.\nAlguien más estaba con él.'),(35,'revisar_notas',2,'none',NULL,NULL,NULL,4,'Ya lo has repasado.\nNo aparece nada nuevo.\nNecesitas más pistas.'),(36,'salir',1,'none',NULL,NULL,NULL,4,'Recoges tus cosas y sales.\nBarcelona te espera.'),(37,'hablar_barra',1,'none',NULL,NULL,NULL,5,'\"¿El hotel Mirador?\" El hombre da un sorbo largo.\n\"Ese sitio tiene historia. Hace años un político desapareció allí. Nunca encontraron el cuerpo.\"\nTe mira con ojos vidriosos.\n\"Dicen que el dueño actual tiene contactos con la mafia rusa.\"\nAsiente solemnemente.\n\"Te lo digo yo.\"'),(38,'hablar_barra',2,'none',NULL,NULL,NULL,5,'\"Y otra cosa.\" Se inclina hacia ti.\n\"La mujer que vive en el tercero del hotel. La del abrigo rojo. Lleva semanas vigilando la entrada.\"\nBebe otro sorbo.\n\"Yo lo he visto.\"'),(39,'hablar_barra',3,'none',NULL,NULL,NULL,5,'El hombre ya no tiene más que decir.\nO eso parece.\nSigue bebiendo en silencio.'),(40,'hablar_fondo',1,'none',NULL,NULL,NULL,5,'El hombre del fondo levanta la vista.\nTiene cara de no haber dormido bien en días.\n\n\"¿Del hotel Mirador preguntas?\"\n\nUna pausa.\n\n\"Conocía al tipo del 209. No mucho. Pero lo suficiente.\"\nBaja la voz.\n\"Tenía miedo de alguien. Me lo dijo una vez que coincidimos aquí. No me dijo quién.\"\n\nSe levanta para irse.\n\"Busca a su mujer. Ella sabe más de lo que aparenta.\"'),(41,'hablar_fondo',2,'none',NULL,NULL,NULL,5,'\"Ya te dije lo que sé.\"\nSe termina la copa.\n\"No sé nada más.\"'),(42,'hablar_fondo',3,'none',NULL,NULL,NULL,5,'El hombre te ignora.\nHa dicho todo lo que iba a decir.'),(43,'beber',1,'none',NULL,NULL,NULL,5,'El barman te sirve una cerveza fría.\nBeberte algo en un momento así no es la peor idea.\nEmpiezas a relajarte un poco.'),(44,'beber',2,'none',NULL,NULL,NULL,5,'Segunda cerveza.\nEl bar parece menos hostil ahora.\nO quizás eres tú el que has cambiado.'),(45,'beber',3,'none',NULL,NULL,NULL,5,'Tercera cerveza.\nTu vejiga protesta.\nNecesitas ir al servicio.'),(46,'ir_servicio',1,'find_item:7',NULL,NULL,NULL,5,'El servicio es pequeño y huele a ambientador barato.\nHay un hombre apoyado en la pared que te mira cuando entras.\n\nTe mira y aparta la vista.\nNo parece tener ganas de hablar.'),(47,'ir_servicio',2,'none',NULL,NULL,NULL,5,'El servicio está vacío ahora.\nEl hombre ya no está.'),(48,'salir',1,'none',NULL,NULL,NULL,5,'Sales del bar.\nEl aire de la noche es más frío de lo esperado.\nBarcelona sigue moviéndose a tu alrededor.'),(49,'entrar',1,'none',NULL,NULL,NULL,6,'La cerradura cede con menos resistencia de la esperada.\nEntras.\n\nEl piso es ordenado. Demasiado ordenado.\nComo si alguien hubiera limpiado con prisa.'),(50,'examinar_salon',1,'none',NULL,NULL,NULL,6,'Hay fotos en la estantería.\nUna pareja. Un hombre y una mujer.\nElla tiene el pelo oscuro y una sonrisa que no llega a los ojos.\nÉl es el hombre del 209. Tomás.\n\nEn otra foto, la misma mujer. Sola. En un parque.\nParece más joven. Más feliz.'),(51,'examinar_salon',2,'none',NULL,NULL,NULL,6,'No hay más fotos. No hay más pistas aquí.'),(52,'examinar_habitacion',1,'none',NULL,NULL,NULL,6,'La cama está hecha.\nEn la mesilla hay un libro abierto boca abajo.\nUn billete de avión sobresale entre las páginas como marcapáginas.\n\nBarcelona — París.\nFecha: dentro de tres días.\n\nDos asientos.'),(53,'examinar_habitacion',2,'find_item:3',NULL,NULL,NULL,6,'Coges el billete de avión.\nDos asientos. Dos nombres.\nUno es Tomás.\nEl otro está en blanco.\n\nAlguien iba a viajar con él.'),(54,'examinar_bano_casa',1,'find_item:6',NULL,NULL,NULL,6,'El baño de la casa es pequeño.\nEn la papelera encuentras un ticket de farmacia arrugado.\nAnsiolíticos. Dosis alta.\nEl nombre en el ticket: Gracia Vidal.\n\nGracia. La mujer de las fotos tiene nombre ahora.'),(55,'examinar_bano_casa',2,'none',NULL,NULL,NULL,6,'No hay nada más en el baño.'),(56,'salir',1,'none',NULL,NULL,NULL,6,'Sales de la casa.\nCierras la puerta como la encontraste.\nTienes más preguntas que respuestas.\nPero también tienes un nombre: Gracia.'),(57,'preguntar_receta',1,'none',NULL,NULL,NULL,7,'La farmacéutica frunce el ceño.\n\"La receta 4471...\"\nBusca en el ordenador.\nSu expresión cambia.\n\n\"Eso es confidencial.\"\n\nUna pausa.\n\n\"Pero le diré que esa receta lleva años renovándose. Y que la persona que la recoge no siempre es la misma.\"'),(58,'preguntar_receta',2,'none',NULL,NULL,NULL,7,'\"Ya le dije lo que podía decirle.\"\nVuelve a su trabajo.'),(59,'preguntar_gracia',1,'none',NULL,NULL,NULL,7,'La mujer levanta la vista.\nAlgo en su cara cambia.\n\n\"Gracia...\"\nUna pausa larga.\n\"Lleva meses sin venir ella misma.\nSiempre manda a alguien a recoger su medicación.\"\n\nBaja la voz.\n\"La última vez que la vi en persona parecía asustada.\nMe dijo que todo iba bien pero sus ojos decían otra cosa.\"'),(60,'preguntar_gracia',2,'none',NULL,NULL,NULL,7,'\"No sé nada más de ella.\nEspero que esté bien.\"'),(61,'preguntar_medicamento',1,'none',NULL,NULL,NULL,7,'\"Son ansiolíticos de alta dosis.\nDe los que se recetan en casos severos.\nDepresión profunda. Ansiedad crónica.\"\n\nTe mira.\n\n\"¿Es usted familiar?\"'),(62,'preguntar_medicamento',2,'none',NULL,NULL,NULL,7,'\"Ya le dije lo que podía.\nEl resto es confidencial.\"'),(63,'salir',1,'none',NULL,NULL,NULL,7,'Sales de la farmacia.\nGracia Vidal.\nDepresión profunda. Asustada. Alguien recoge su medicación por ella.\n\nEsta mujer está en el centro de todo.'),(64,'ir_casa',1,'none',NULL,NULL,NULL,11,'Te diriges a casa.'),(65,'ir_bar',1,'none',NULL,NULL,NULL,11,'Te diriges al bar.'),(66,'ir_hotel',1,'none',NULL,NULL,NULL,11,'Vuelves al hotel.'),(67,'ir_casa_tomas',1,'none',NULL,NULL,NULL,11,'Te diriges a la dirección del DNI.'),(68,'ir_farmacia',1,'none',NULL,NULL,NULL,11,'Te diriges a la farmacia.'),(69,'ir_casa',2,'none',NULL,NULL,NULL,11,'Te diriges a casa.'),(70,'ir_bar',2,'none',NULL,NULL,NULL,11,'Te diriges al bar.'),(71,'ir_hotel',2,'none',NULL,NULL,NULL,11,'Vuelves al hotel.'),(72,'ir_casa_tomas',2,'none',NULL,NULL,NULL,11,'Te diriges a la dirección del DNI.'),(73,'ir_farmacia',2,'none',NULL,NULL,NULL,11,'Te diriges a la farmacia.'),(74,'ir_casa',1,'none',NULL,NULL,NULL,12,'Te diriges a casa.'),(75,'ir_bar',1,'none',NULL,NULL,NULL,12,'Te diriges al bar.'),(76,'ir_hotel',1,'none',NULL,NULL,NULL,12,'Vuelves al hotel.'),(77,'ir_casa_tomas',1,'none',NULL,NULL,NULL,12,'Te diriges a la dirección del DNI.'),(78,'ir_farmacia',1,'none',NULL,NULL,NULL,12,'Te diriges a la farmacia.'),(79,'ir_casa',2,'none',NULL,NULL,NULL,12,'Te diriges a casa.'),(80,'ir_bar',2,'none',NULL,NULL,NULL,12,'Te diriges al bar.'),(81,'ir_hotel',2,'none',NULL,NULL,NULL,12,'Vuelves al hotel.'),(82,'ir_casa_tomas',2,'none',NULL,NULL,NULL,12,'Te diriges a la dirección del DNI.'),(83,'ir_farmacia',2,'none',NULL,NULL,NULL,12,'Te diriges a la farmacia.'),(84,'invitar_cerveza_servicio',1,'find_item:7',NULL,NULL,NULL,5,'Le ofreces una cerveza.\nEl hombre te mira un momento.\nAsiente.\n\n\"¿Investigas lo del hotel?\"\n\nNo espera tu respuesta.\n\n\"El tipo del 209 tenía una identidad falsa. Su nombre real no era Tomás.\"\nSaca un papel arrugado del bolsillo y te lo da.\n\"Esto lo encontré tirado fuera del hotel la noche del crimen.\"\n\nSale sin decir nada más.\n\nMiras el papel. Es una nota manuscrita:\n\"R.V. — Farmacia Mendoza — Receta 4471\"'),(85,'invitar_cerveza_servicio',2,'none',NULL,NULL,NULL,5,'El hombre ya se fue.\nNo hay nadie más en el servicio.'),(86,'jugar',1,'none',NULL,NULL,NULL,13,'Te acercas a la mesa de blackjack.\nEl crupier asiente.\n\"¿Cuánto apuesta?\"'),(87,'hablar_crupier',1,'none',NULL,NULL,NULL,13,'El crupier te mira sin dejar de barajar.\n\"Aquí solo hablo con los que juegan.\"'),(88,'hablar_crupier',2,'none',NULL,NULL,NULL,13,'Sigue barajando. No dice nada más.'),(89,'observar',1,'none',NULL,NULL,NULL,13,'Observas las mesas.\nTodos tienen cara de póker.\nNadie mira a nadie directamente.\nAsí funciona este sitio.'),(90,'salir',1,'none',NULL,NULL,NULL,13,'Sales a la calle.\nEl aire fresco contrasta con el ambiente cargado de dentro.');
/*!40000 ALTER TABLE `action_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scene_id` int DEFAULT NULL,
  `key_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scene_id` (`scene_id`),
  CONSTRAINT `actions_ibfk_1` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (5,4,'descansar','Descansar'),(6,4,'dormir','Dormir'),(12,8,'viajar_paris','Tomar vuelo a París'),(13,9,'explorar','Explorar el parque'),(14,10,'final','Desenlace final'),(21,1,'examinar_cadaver','Examinar el cadáver'),(22,1,'examinar_maleta','Examinar la maleta'),(23,1,'examinar_bano','Examinar el baño'),(24,1,'mirar_cama','Mirar debajo de la cama'),(25,1,'llamar_recepcion','Llamar a recepción'),(26,1,'salir','Salir de la habitación'),(31,3,'hablar_izquierda','Hablar con el preso de la izquierda'),(32,3,'hablar_derecha','Hablar con el preso de la derecha'),(33,3,'esperar','Esperar en silencio'),(34,3,'intentar_salir','Intentar salir'),(35,11,'ir_casa','Ir a mi casa'),(36,11,'ir_bar','Ir al bar'),(37,11,'ir_hotel','Volver al hotel'),(38,11,'ir_casa_tomas','Ir a la dirección del DNI'),(39,4,'descansar','Descansar'),(40,4,'dormir','Dormir'),(41,4,'revisar_notas','Revisar lo que sabes'),(42,4,'salir','Salir a investigar'),(43,5,'hablar_barra','Hablar con el hombre de la barra'),(44,5,'hablar_fondo','Acercarte a la mesa del fondo'),(45,5,'beber','Pedir una cerveza'),(46,5,'ir_servicio','Ir al servicio'),(47,5,'salir','Salir del bar'),(48,6,'entrar','Entrar a la casa'),(49,6,'examinar_salon','Examinar el salón'),(50,6,'examinar_habitacion','Examinar la habitación'),(51,6,'examinar_bano_casa','Examinar el baño'),(52,6,'salir','Salir de la casa'),(53,7,'preguntar_receta','Preguntar por la receta 4471'),(54,7,'preguntar_gracia','Preguntar por Gracia Vidal'),(55,7,'preguntar_medicamento','Preguntar por el medicamento'),(56,7,'salir','Salir de la farmacia'),(57,11,'ir_farmacia','Ir a la farmacia'),(58,12,'ir_casa','Ir a mi casa'),(59,12,'ir_bar','Ir al bar'),(60,12,'ir_hotel','Volver al hotel'),(61,12,'ir_casa_tomas','Ir a la dirección del DNI'),(62,12,'ir_farmacia','Ir a la farmacia'),(63,5,'invitar_cerveza_servicio','Invitar a una cerveza al hombre del servicio'),(64,5,'ir_casa','Ir a casa'),(65,5,'ir_hotel','Volver al hotel'),(66,5,'ir_casa_tomas','Ir a la dirección del DNI'),(67,5,'ir_farmacia','Ir a la farmacia'),(68,4,'ir_bar','Ir al bar'),(69,4,'ir_hotel','Volver al hotel'),(70,4,'ir_casa_tomas','Ir a la dirección del DNI'),(71,4,'ir_farmacia','Ir a la farmacia'),(72,6,'ir_casa','Ir a casa'),(73,6,'ir_bar','Ir al bar'),(74,6,'ir_hotel','Volver al hotel'),(75,6,'ir_farmacia','Ir a la farmacia'),(76,7,'ir_casa','Ir a casa'),(77,7,'ir_bar','Ir al bar'),(78,7,'ir_hotel','Volver al hotel'),(79,7,'ir_casa_tomas','Ir a la dirección del DNI'),(80,1,'ir_casa','Ir a casa'),(81,1,'ir_bar','Ir al bar'),(82,1,'ir_casa_tomas','Ir a la dirección del DNI'),(83,1,'ir_farmacia','Ir a la farmacia'),(84,13,'jugar','Jugar al blackjack'),(85,13,'hablar_crupier','Hablar con el crupier'),(86,13,'observar','Observar a los jugadores'),(87,13,'salir','Salir'),(88,12,'ir_apuestas','Ir a la casa de apuestas'),(89,11,'ir_apuestas','Ir a la casa de apuestas');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int DEFAULT NULL,
  `scene_id` int DEFAULT NULL,
  `action_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `is_player` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=475 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (164,4,1,'player_input','nada',1,'2026-05-02 00:41:39','2026-05-02 00:41:39'),(165,4,1,'salir','Sales al pasillo. La puerta se cierra detrás de ti. Al fondo del corredor dos policías de uniforme avanzan hacia ti. No tienes a donde ir.',0,'2026-05-02 00:41:40','2026-05-02 00:41:40'),(166,4,2,'player_input','Antonio',1,'2026-05-02 00:42:12','2026-05-02 00:42:12'),(167,4,2,'nombre',NULL,0,'2026-05-02 00:42:12','2026-05-02 00:42:12'),(168,4,2,'nombre','El inspector levanta una ceja. Compara lo que dices con tu documentación. \"Interesante.\" Anota algo en su libreta. Algo no cuadra.\n\n\"¿Ha tocado algo dentro de la habitación?\" — Sus ojos no se apartan de los tuyos.',0,'2026-05-02 00:42:12','2026-05-02 00:42:12'),(169,4,2,'player_input','No',1,'2026-05-02 00:42:22','2026-05-02 00:42:22'),(170,4,2,'conoce_victima',NULL,0,'2026-05-02 00:42:23','2026-05-02 00:42:23'),(171,4,2,'conoce_victima','Frunce el ceño. \"¿Cómo sabe su nombre?\" Le explicas lo del DNI. Asiente despacio.\n\n\"¿Llamó usted a recepción?\" — Ya sabe la respuesta. Solo quiere ver si mientes.',0,'2026-05-02 00:42:23','2026-05-02 00:42:23'),(180,6,1,'player_input','nada',1,'2026-05-02 00:46:27','2026-05-02 00:46:27'),(181,6,1,'salir','Sales al pasillo. La puerta se cierra detrás de ti. Al fondo del corredor dos policías de uniforme avanzan hacia ti. No tienes a donde ir.',0,'2026-05-02 00:46:28','2026-05-02 00:46:28'),(182,6,2,'player_input','Invitado',1,'2026-05-02 00:46:43','2026-05-02 00:46:43'),(183,6,2,'nombre',NULL,0,'2026-05-02 00:46:43','2026-05-02 00:46:43'),(184,6,2,'nombre','El inspector levanta una ceja. Compara lo que dices con tu documentación. \"Interesante.\" Anota algo en su libreta. Algo no cuadra.\n\n\"¿Ha tocado algo dentro de la habitación?\" — Sus ojos no se apartan de los tuyos.',0,'2026-05-02 00:46:43','2026-05-02 00:46:43'),(185,6,2,'player_input','No',1,'2026-05-02 00:46:49','2026-05-02 00:46:49'),(186,6,2,'conoce_victima',NULL,0,'2026-05-02 00:46:49','2026-05-02 00:46:49'),(187,6,2,'conoce_victima','Frunce el ceño. \"¿Cómo sabe su nombre?\" Le explicas lo del DNI. Asiente despacio.\n\n\"¿Llamó usted a recepción?\" — Ya sabe la respuesta. Solo quiere ver si mientes.',0,'2026-05-02 00:46:49','2026-05-02 00:46:49'),(294,2,1,'scene_load','Barcelona. España.\nHotel Mirador las estrellas.\nAcabas de hacer el checking. Subes las escaleras buscando tu habitación.\nPiso 2.\nAvanzas por el pasillo buscando tu número.\n204, 206, 208, 210...\nLa habitación 209 tiene la puerta abierta y al echar un vistazo te encuentras un cuerpo en el suelo.\n¿Hola? ¿Se encuentra bien?\n-...\nProcedes a entrar a ver si se encuentra bien.\nEstá muerto.\n...\n...\n...\n¿Qué haces?',0,'2026-05-03 00:42:39','2026-05-03 00:42:39'),(295,2,1,'player_input','investigar',1,'2026-05-03 00:42:46','2026-05-03 00:42:46'),(296,2,1,'examinar_cadaver','El hombre lleva traje. En el bolsillo interior encuentras su cartera. Hay un DNI a nombre de Tomás con una dirección en Barcelona.',0,'2026-05-03 00:42:47','2026-05-03 00:42:47'),(297,2,1,'player_input','salir',1,'2026-05-03 00:42:57','2026-05-03 00:42:57'),(298,2,1,'salir','Sales al pasillo. La puerta se cierra detrás de ti. Al fondo del corredor dos policías de uniforme avanzan hacia ti. No tienes a donde ir.',0,'2026-05-03 00:42:58','2026-05-03 00:42:58'),(299,2,2,'scene_load','Los dos agentes te rodean antes de que puedas decir nada.\n\"Documentación.\"\nLes muestras tu identificación con manos temblorosas.\nTe conducen a una sala pequeña.\nUna mesa. Dos sillas. Una bombilla.\n\nEl inspector entra y cierra la puerta.\n\n\"¿Cómo se llama usted?\" — Te mira fijamente esperando tu respuesta.',0,'2026-05-03 00:42:58','2026-05-03 00:42:58'),(300,2,2,'nombre',NULL,0,'2026-05-03 00:43:02','2026-05-03 00:43:02'),(301,2,2,'tocado',NULL,0,'2026-05-03 00:43:07','2026-05-03 00:43:07'),(302,2,2,'conoce_victima',NULL,0,'2026-05-03 00:43:12','2026-05-03 00:43:12'),(303,2,2,'llamo_recepcion',NULL,0,'2026-05-03 00:43:20','2026-05-03 00:43:20'),(304,2,3,'scene_load','Una celda fría. Luz fluorescente. El ruido metálico de una puerta al cerrarse.\n\nA tu izquierda, al otro lado de los barrotes, un hombre te observa en silencio.\nA tu derecha, otro. Este parece querer hablar.\n\n¿Qué haces?',0,'2026-04-01 00:43:20','2026-05-03 00:43:20'),(305,2,3,'player_input','hablar derecha',1,'2026-05-03 00:43:33','2026-05-03 00:43:33'),(306,2,3,'hablar_derecha','El hombre sonríe y se acerca a los barrotes.\n\n\"En la habitación 209 hay un muerto. La ventana está cerrada por dentro. La puerta estaba abierta. No hay arma. ¿Quién mató al inspector?\"\n\nUna pausa larga.\n\nSe aleja y se tumba en su catre.\n',0,'2026-05-03 00:43:33','2026-05-03 00:43:33'),(307,2,3,'player_input','salir',1,'2026-05-03 00:44:10','2026-05-03 00:44:10'),(308,2,11,'liberado','Un guardia abre tu celda.\n\"Es su hora. Recoja sus cosas.\"\n\nHan pasado 48 horas.',0,'2026-05-03 00:44:10','2026-05-03 00:44:10'),(309,2,11,'scene_load','Las puertas de la comisaría se abren.\nEl aire frío de Barcelona te golpea en la cara.\n\nUn agente te entrega una bolsa con tus pertenencias.\n\"Queda usted en libertad provisional.\"\nUna pausa.\n\"No abandone la ciudad. Podríamos necesitarle.\"\n\nAnte usted, Barcelona.\n¿A dónde va?',0,'2026-05-03 00:44:11','2026-05-03 00:44:11'),(310,2,11,'player_input','Mi casa',1,'2026-05-03 00:44:19','2026-05-03 00:44:19'),(311,2,11,'ir_casa','No ocurre nada relevante...',0,'2026-05-03 00:44:19','2026-05-03 00:44:19'),(312,2,4,'scene_load','Tu casa.\nEl silencio aquí es distinto.\nDejás las llaves sobre la mesa y te derrumbas en el sofá.\nBarcelona sigue ahí fuera, pero esta noche no te necesita.\nO eso te dices.\n\nEl caso da vueltas en tu cabeza.\nUn muerto en el 209.\nUn DNI.\nUna pistola con una bala menos.\n\n¿Qué haces?',0,'2026-05-03 00:44:19','2026-05-03 00:44:19'),(313,2,4,'player_input','descansar',1,'2026-05-03 00:44:31','2026-05-03 00:44:31'),(314,2,4,'descansar','Te recuestas un momento.\nLa tensión de los últimos días pesa.\nRespiras.\nAlgo en tu cabeza se asienta.',0,'2026-05-03 00:44:32','2026-05-03 00:44:32'),(315,2,4,'player_input','salir',1,'2026-05-03 00:44:39','2026-05-03 00:44:39'),(316,2,4,'salir','Recoges tus cosas y sales.\nBarcelona te espera.',0,'2026-05-03 00:44:39','2026-05-03 00:44:39'),(317,2,12,'scene_load','Estás en la calle.\nBarcelona se mueve a tu alrededor.\n\n¿A dónde vas?',0,'2026-05-03 00:44:41','2026-05-03 00:44:41'),(318,2,12,'player_input','a casa',1,'2026-05-03 00:48:55','2026-05-03 00:48:55'),(319,2,12,'ir_casa','Te diriges a casa.',0,'2026-05-03 00:48:56','2026-05-03 00:48:56'),(320,2,4,'scene_load','Tu casa.\nEl silencio aquí es distinto.\nDejás las llaves sobre la mesa y te derrumbas en el sofá.\nBarcelona sigue ahí fuera, pero esta noche no te necesita.\nO eso te dices.\n\nEl caso da vueltas en tu cabeza.\nUn muerto en el 209.\nUn DNI.\nUna pistola con una bala menos.\n\n¿Qué haces?',0,'2026-05-03 00:48:59','2026-05-03 00:48:59'),(321,2,4,'player_input','dormir',1,'2026-05-03 00:49:08','2026-05-03 00:49:08'),(322,2,4,'dormir','Cierras los ojos.\nNo sabes cuánto tiempo pasa.\nCuando te despiertas, la cabeza te funciona mejor.\nLa sospecha sobre ti parece haberse disipado un poco.',0,'2026-05-03 00:49:09','2026-05-03 00:49:09'),(323,2,4,'player_input','ir al bar',1,'2026-05-03 00:49:20','2026-05-03 00:49:20'),(324,2,4,'salir','Recoges tus cosas y sales.\nBarcelona te espera.',0,'2026-05-03 00:49:21','2026-05-03 00:49:21'),(325,2,12,'scene_load','Estás en la calle.\nBarcelona se mueve a tu alrededor.\n\n¿A dónde vas?',0,'2026-05-03 00:49:24','2026-05-03 00:49:24'),(326,2,12,'player_input','ir al bar',1,'2026-05-03 00:49:30','2026-05-03 00:49:30'),(327,2,12,'ir_bar','Te diriges al bar.',0,'2026-05-03 00:49:31','2026-05-03 00:49:31'),(328,2,5,'scene_load','El bar huele a tabaco frío y cerveza derramada.\nLuz tenue. Madera oscura. Ruido de fondo.\n\nHay tres tipos de gente aquí:\nlos que beben para olvidar,\nlos que beben para hablar,\ny los que observan.\n\nEn la barra, un hombre te mira de reojo.\nEn una mesa del fondo, otro parece estar esperando a alguien.\nEl servicio está al fondo a la izquierda.\n\n¿Qué haces?',0,'2026-05-03 00:49:33','2026-05-03 00:49:33'),(329,2,5,'player_input','pedir una cerveza',1,'2026-05-03 00:49:48','2026-05-03 00:49:48'),(330,2,5,'beber','El barman te sirve una cerveza fría.\nBeberte algo en un momento así no es la peor idea.\nEmpiezas a relajarte un poco.',0,'2026-05-03 00:49:49','2026-05-03 00:49:49'),(331,2,5,'player_input','beberme una copa',1,'2026-05-03 00:50:01','2026-05-03 00:50:01'),(332,2,5,'beber','Segunda cerveza.\nEl bar parece menos hostil ahora.\nO quizás eres tú el que has cambiado.',0,'2026-05-03 00:50:02','2026-05-03 00:50:02'),(333,2,5,'player_input','beber',1,'2026-05-03 00:50:11','2026-05-03 00:50:11'),(334,2,5,'beber','Tercera cerveza.\nTu vejiga protesta.\nNecesitas ir al servicio.',0,'2026-05-03 00:50:12','2026-05-03 00:50:12'),(335,2,5,'player_input','beber',1,'2026-05-03 00:50:19','2026-05-03 00:50:19'),(336,2,5,'necesita_servicio','Tres cervezas empiezan a hacer efecto.\nNecesitas ir al servicio urgentemente.\nNo puedes concentrarte en otra cosa.',0,'2026-05-03 00:50:19','2026-05-03 00:50:19'),(337,2,5,'player_input','beber',1,'2026-05-03 00:50:28','2026-05-03 00:50:28'),(338,2,5,'necesita_servicio','Tres cervezas empiezan a hacer efecto.\nNecesitas ir al servicio urgentemente.\nNo puedes concentrarte en otra cosa.',0,'2026-05-03 00:50:28','2026-05-03 00:50:28'),(339,2,5,'player_input','ir al servicio',1,'2026-05-03 00:50:39','2026-05-03 00:50:39'),(340,2,5,'ir_servicio','El servicio es pequeño y huele a ambientador barato.\nHay un hombre apoyado en la pared que te mira cuando entras.\n\n\"¿Investigas lo del hotel?\"\n\nNo espera tu respuesta.\n\n\"El tipo del 209 tenía una identidad falsa. Su nombre real no era Tomás.\"\nSaca un papel arrugado del bolsillo y te lo da.\n\"Esto lo encontré tirado fuera del hotel la noche del crimen.\"\n\nSale sin decir nada más.\n\nMiras el papel. Es una nota manuscrita:\n\"R.V. — Farmacia Mendoza — Receta 4471\"',0,'2026-05-03 00:50:39','2026-05-03 00:50:39'),(426,3,1,'scene_load','Barcelona. España.\nHotel Mirador las estrellas.\nAcabas de hacer el checking. Subes las escaleras buscando tu habitación.\nPiso 2.\nAvanzas por el pasillo buscando tu número.\n204, 206, 208, 210...\nLa habitación 209 tiene la puerta abierta y al echar un vistazo te encuentras un cuerpo en el suelo.\n¿Hola? ¿Se encuentra bien?\n-...\nProcedes a entrar a ver si se encuentra bien.\nEstá muerto.\n...\n...\n...\n¿Qué haces?',0,'2026-05-04 16:43:27','2026-05-04 16:43:27'),(427,7,1,'scene_load','Barcelona. España.\nHotel Mirador las estrellas.\nAcabas de hacer el checking. Subes las escaleras buscando tu habitación.\nPiso 2.\nAvanzas por el pasillo buscando tu número.\n204, 206, 208, 210...\nLa habitación 209 tiene la puerta abierta y al echar un vistazo te encuentras un cuerpo en el suelo.\n¿Hola? ¿Se encuentra bien?\n-...\nProcedes a entrar a ver si se encuentra bien.\nEstá muerto.\n...\n...\n...\n¿Qué haces?',0,'2026-05-04 16:45:03','2026-05-04 16:45:03'),(428,7,1,'player_input','Registro el cuerpo',1,'2026-05-04 16:45:29','2026-05-04 16:45:29'),(429,7,1,'examinar_cadaver','El hombre lleva traje. En el bolsillo interior encuentras su cartera. Hay un DNI a nombre de Tomás con una dirección en Barcelona.',0,'2026-05-04 16:45:30','2026-05-04 16:45:30'),(430,7,1,'player_input','Registro el baño',1,'2026-05-04 16:45:49','2026-05-04 16:45:49'),(431,7,1,'examinar_bano','El baño huele a colonia cara. Hay dos cepillos de dientes. Dos personas vivían aquí. O al menos dos personas usaban esta habitación.',0,'2026-05-04 16:45:50','2026-05-04 16:45:50'),(432,7,1,'player_input','Una mujer?',1,'2026-05-04 16:46:03','2026-05-04 16:46:03'),(433,7,1,'examinar_cadaver','Ya has examinado el cuerpo. Sigues tocando. Tus huellas están por todas partes ahora.',0,'2026-05-04 16:46:04','2026-05-04 16:46:04'),(434,7,1,'player_input','Huyo',1,'2026-05-04 16:46:28','2026-05-04 16:46:28'),(435,7,1,'examinar_cadaver','No hay nada más. Pero tus huellas están en el cuerpo.',0,'2026-05-04 16:46:28','2026-05-04 16:46:28'),(436,7,1,'player_input','Me voy a casa',1,'2026-05-04 16:47:20','2026-05-04 16:47:20'),(437,7,1,'salir','Sales al pasillo. La puerta se cierra detrás de ti. Al fondo del corredor dos policías de uniforme avanzan hacia ti. No tienes a donde ir.',0,'2026-05-04 16:47:20','2026-05-04 16:47:20'),(438,7,2,'scene_load','Los dos agentes te rodean antes de que puedas decir nada.\n\"Documentación.\"\nLes muestras tu identificación con manos temblorosas.\nTe conducen a una sala pequeña.\nUna mesa. Dos sillas. Una bombilla.\n\nEl inspector entra y cierra la puerta.\n\n\"¿Cómo se llama usted?\" — Te mira fijamente esperando tu respuesta.',0,'2026-05-04 16:47:25','2026-05-04 16:47:25'),(439,7,2,'nombre',NULL,0,'2026-05-04 16:47:42','2026-05-04 16:47:42'),(440,7,2,'tocado',NULL,0,'2026-05-04 16:47:58','2026-05-04 16:47:58'),(441,7,2,'conoce_victima',NULL,0,'2026-05-04 16:48:07','2026-05-04 16:48:07'),(442,7,2,'llamo_recepcion',NULL,0,'2026-05-04 16:48:22','2026-05-04 16:48:22'),(443,7,3,'scene_load','Una celda fría. Luz fluorescente. El ruido metálico de una puerta al cerrarse.\n\nA tu izquierda, al otro lado de los barrotes, un hombre te observa en silencio.\nA tu derecha, otro. Este parece querer hablar.\n\n¿Qué haces?',0,'2026-05-04 16:48:31','2026-05-04 16:48:31'),(444,7,3,'player_input','Esperar',1,'2026-05-04 16:48:43','2026-05-04 16:48:43'),(445,7,3,'esperar','Te sientas en el catre.\nEl tiempo pasa.\nLas horas en este sitio pesan el doble.',0,'2026-05-04 16:48:43','2026-05-04 16:48:43'),(446,7,3,'player_input','Esperar',1,'2026-05-04 16:48:51','2026-05-04 16:48:51'),(447,7,3,'esperar','Sigues esperando.\nEl fluorescente parpadea.\nAlguien tose al fondo del pasillo.',0,'2026-05-04 16:48:51','2026-05-04 16:48:51'),(448,7,3,'player_input','Toser',1,'2026-05-04 16:48:59','2026-05-04 16:48:59'),(449,7,3,'intentar_salir','Te acercas a la puerta.\nUn guardia te mira desde el fondo del pasillo.\n\"Vuelva a su celda.\"\nNo es negociable.',0,'2026-05-04 16:48:59','2026-05-04 16:48:59'),(450,2,5,'player_input','ir al casino',1,'2026-05-07 18:05:30','2026-05-07 18:05:30'),(451,2,5,'necesita_servicio','Tres cervezas empiezan a hacer efecto.\nNecesitas ir al servicio urgentemente.\nNo puedes concentrarte en otra cosa.',0,'2026-05-07 18:05:31','2026-05-07 18:05:31'),(452,2,5,'player_input','salir',1,'2026-05-07 18:05:40','2026-05-07 18:05:40'),(453,2,5,'salir','Sales del bar.\nEl aire de la noche es más frío de lo esperado.\nBarcelona sigue moviéndose a tu alrededor.',0,'2026-05-07 18:05:42','2026-05-07 18:05:42'),(454,2,12,'scene_load','Estás en la calle.\nBarcelona se mueve a tu alrededor.\n\n¿A dónde vas?',0,'2026-05-07 18:05:46','2026-05-07 18:05:46'),(455,2,12,'player_input','ir a la casa de apuestas',1,'2026-05-07 18:06:10','2026-05-07 18:06:10'),(456,2,12,'ir_apuestas','',0,'2026-05-07 18:06:11','2026-05-07 18:06:11'),(457,2,13,'scene_load','Luces tenues. Mesas de tapete verde.\nEl sonido de las fichas y las cartas mezclándose.\nEl ambiente huele a tabaco y dinero fácil.\n\nUn crupier te mira desde la mesa de blackjack.\nEn una esquina, un hombre con traje observa a los jugadores.\nNadie parece estar aquí por casualidad.\n\n¿Qué haces?',0,'2026-05-07 18:06:11','2026-05-07 18:06:11'),(458,2,13,'player_input','jugar',1,'2026-05-07 18:06:49','2026-05-07 18:06:49'),(459,2,13,'jugar','Te acercas a la mesa de blackjack.\nEl crupier asiente.\n\"¿Cuánto apuesta?\"',0,'2026-05-07 18:06:50','2026-05-07 18:06:50'),(460,2,13,'blackjack_lose','Pierdes. El dinero desaparece de la mesa.\\nAlguien al fondo te observa.',0,'2026-05-07 18:07:03','2026-05-07 18:07:03'),(461,2,13,'player_input','jugar',1,'2026-05-07 18:07:10','2026-05-07 18:07:10'),(462,2,13,'jugar','Te acercas a la mesa de blackjack.\nEl crupier asiente.\n\"¿Cuánto apuesta?\"',0,'2026-05-07 18:07:11','2026-05-07 18:07:11'),(463,2,13,'blackjack_win','Ganas la mano. El crupier te mira con respeto.\\nAlgo en el ambiente cambia.',0,'2026-05-07 18:07:18','2026-05-07 18:07:18'),(464,2,13,'player_input','jugar',1,'2026-05-07 18:07:31','2026-05-07 18:07:31'),(465,2,13,'jugar','Te acercas a la mesa de blackjack.\nEl crupier asiente.\n\"¿Cuánto apuesta?\"',0,'2026-05-07 18:07:32','2026-05-07 18:07:32'),(466,2,13,'blackjack_win','Ganas la mano. El crupier te mira con respeto.\\nAlgo en el ambiente cambia.',0,'2026-05-07 18:07:54','2026-05-07 18:07:54'),(467,2,13,'player_input','jugar',1,'2026-05-07 18:13:31','2026-05-07 18:13:31'),(468,2,13,'jugar','Te acercas a la mesa de blackjack.\nEl crupier asiente.\n\"¿Cuánto apuesta?\"',0,'2026-05-07 18:13:32','2026-05-07 18:13:32'),(469,2,13,'player_input','jugar',1,'2026-05-07 18:17:34','2026-05-07 18:17:34'),(470,2,13,'jugar','Te acercas a la mesa de blackjack.\nEl crupier asiente.\n\"¿Cuánto apuesta?\"',0,'2026-05-07 18:17:35','2026-05-07 18:17:35'),(471,2,13,'blackjack_lose','Pierdes. El dinero desaparece de la mesa.\\nAlguien al fondo te observa.',0,'2026-05-07 18:18:11','2026-05-07 18:18:11'),(472,2,13,'player_input','jugar',1,'2026-05-07 20:00:25','2026-05-07 20:00:25'),(473,2,13,'jugar','Te acercas a la mesa de blackjack.\nEl crupier asiente.\n\"¿Cuánto apuesta?\"',0,'2026-05-07 20:00:26','2026-05-07 20:00:26'),(474,2,13,'blackjack_draw','Empate. Recuperas lo apostado.\\nNadie gana. Nadie pierde.',0,'2026-05-07 20:00:37','2026-05-07 20:00:37');
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'DNI del muerto','Documento de identidad. Nombre: Rafael Vidal. Dirección en Barcelona.'),(2,'Pistola','Pistola con el cargador casi lleno. Falta una bala disparada.'),(3,'Billete de avión','Vuelo Barcelona-París. La fecha parece alterada.'),(4,'Foto antigua','Foto en blanco y negro. Una mujer con dos bebés. Detrás: Gracia, 2021.'),(5,'Llave de taquilla','Llave pequeña. Grabado: T-47. Parece de un aeropuerto.'),(6,'Ticket de farmacia','Compra de ansiolíticos a nombre de R. Mendoza.'),(7,'Nota manuscrita','Una nota arrugada: \"R.V. — Farmacia Mendoza — Receta 4471\". Alguien la tiró fuera del hotel la noche del crimen.');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc_dialogues`
--

DROP TABLE IF EXISTS `npc_dialogues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `npc_dialogues` (
  `id` int NOT NULL AUTO_INCREMENT,
  `npc_id` int DEFAULT NULL,
  `scene_id` int DEFAULT NULL,
  `trigger` text COLLATE utf8mb4_general_ci,
  `response` text COLLATE utf8mb4_general_ci,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `npcs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `personality` text COLLATE utf8mb4_general_ci,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_actions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `scene_id` int DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_player_action` (`player_id`,`action`),
  CONSTRAINT `fk_player_actions_player` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_actions`
--

LOCK TABLES `player_actions` WRITE;
/*!40000 ALTER TABLE `player_actions` DISABLE KEYS */;
INSERT INTO `player_actions` VALUES (102,6,NULL,'salir','2026-05-02 00:46:28','2026-05-02 00:46:28'),(126,2,1,'examinar_cadaver','2026-05-03 00:42:47','2026-05-03 00:42:47'),(127,2,1,'salir','2026-05-03 00:42:58','2026-05-03 00:42:58'),(128,2,3,'hablar_derecha','2026-05-03 00:43:33','2026-05-03 00:43:33'),(129,2,11,'ir_casa','2026-05-03 00:44:19','2026-05-03 00:44:19'),(130,2,4,'descansar','2026-05-03 00:44:32','2026-05-03 00:44:32'),(131,2,4,'salir','2026-05-03 00:44:39','2026-05-03 00:44:39'),(132,2,12,'ir_casa','2026-05-03 00:48:56','2026-05-03 00:48:56'),(133,2,4,'dormir','2026-05-03 00:49:09','2026-05-03 00:49:09'),(134,2,4,'salir','2026-05-03 00:49:21','2026-05-03 00:49:21'),(135,2,12,'ir_bar','2026-05-03 00:49:30','2026-05-03 00:49:30'),(136,2,5,'beber','2026-05-03 00:49:49','2026-05-03 00:49:49'),(137,2,5,'beber','2026-05-03 00:50:02','2026-05-03 00:50:02'),(138,2,5,'beber','2026-05-03 00:50:12','2026-05-03 00:50:12'),(139,2,5,'ir_servicio','2026-05-03 00:50:39','2026-05-03 00:50:39'),(168,7,1,'examinar_cadaver','2026-05-04 16:45:30','2026-05-04 16:45:30'),(169,7,1,'examinar_bano','2026-05-04 16:45:50','2026-05-04 16:45:50'),(170,7,1,'examinar_cadaver','2026-05-04 16:46:04','2026-05-04 16:46:04'),(171,7,1,'examinar_cadaver','2026-05-04 16:46:28','2026-05-04 16:46:28'),(172,7,1,'salir','2026-05-04 16:47:20','2026-05-04 16:47:20'),(173,7,3,'esperar','2026-05-04 16:48:43','2026-05-04 16:48:43'),(174,7,3,'esperar','2026-05-04 16:48:51','2026-05-04 16:48:51'),(175,7,3,'intentar_salir','2026-05-04 16:48:59','2026-05-04 16:48:59'),(176,2,5,'salir','2026-05-07 18:05:42','2026-05-07 18:05:42'),(177,2,12,'ir_apuestas','2026-05-07 18:06:11','2026-05-07 18:06:11'),(178,2,13,'jugar','2026-05-07 18:06:50','2026-05-07 18:06:50'),(179,2,13,'jugar','2026-05-07 18:07:10','2026-05-07 18:07:10'),(180,2,13,'jugar','2026-05-07 18:07:32','2026-05-07 18:07:32'),(181,2,13,'jugar','2026-05-07 18:13:32','2026-05-07 18:13:32'),(182,2,13,'jugar','2026-05-07 18:17:35','2026-05-07 18:17:35'),(183,2,13,'jugar','2026-05-07 20:00:26','2026-05-07 20:00:26');
/*!40000 ALTER TABLE `player_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_flags`
--

DROP TABLE IF EXISTS `player_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_flags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `flag` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `player_flags_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_flags`
--

LOCK TABLES `player_flags` WRITE;
/*!40000 ALTER TABLE `player_flags` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_items`
--

DROP TABLE IF EXISTS `player_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`),
  CONSTRAINT `player_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_items`
--

LOCK TABLES `player_items` WRITE;
/*!40000 ALTER TABLE `player_items` DISABLE KEYS */;
INSERT INTO `player_items` VALUES (25,2,1,'2026-05-03 00:42:47','2026-05-03 00:42:47'),(26,2,7,'2026-05-03 00:50:39','2026-05-03 00:50:39'),(28,7,1,'2026-05-04 16:45:30','2026-05-04 16:45:30');
/*!40000 ALTER TABLE `player_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT '0',
  `verify_token` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` enum('user','advanced','admin') COLLATE utf8mb4_general_ci DEFAULT 'user',
  `sanity` int DEFAULT '100',
  `suspicion` int DEFAULT '0',
  `location_scene_id` int DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (2,'Jesus Serrano Fernandez','jsf031994@gmail.com',NULL,0,NULL,'bSQ20Cf6GP5I79Tm9lHgWu1Gih289YQcA6yAvGguiWJKrOyEPdaky2gEbtnP','admin',100,5,13,'2026-04-30 01:48:53'),(3,'Robin','robinheell@gmail.com',NULL,0,NULL,'1PrkYay9EN0BwDGlDhTVXSxWJYs9ohTMKwOz8nJLGWLQNR8xLY9scoaWvW9g','admin',100,0,1,'2026-05-01 23:14:37'),(5,'Invitado_bu3zko','guest_Yk4DT6zo@guest.com',NULL,0,NULL,'1ZEVBY2xbi4vuCXc1Oc0D71GTr7TLQOFBYAAU7Lo7av9VCm7O2a0yJRCscmO','user',100,0,1,'2026-05-02 00:44:30'),(6,'Invitado_AexgJW','guest_Lv8cQeL0@guest.com',NULL,0,NULL,'S0S1qpIEQ0vktbnVpNZZ1bwhXvgfC2GpeeYvQVpF23ACic7ALnMSsNPKQeKC','user',100,15,2,'2026-05-02 00:45:55'),(7,'wos mc','deskartewos@gmail.com',NULL,0,NULL,'MVSEtkMtX04asyInzft95EmEFU9PwcNVX9hG4YHc0fLRowI88PBxBO2xzmQ8','user',100,0,3,'2026-02-09 16:12:14');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `scenes`
--

DROP TABLE IF EXISTS `scenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scenes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenes`
--

LOCK TABLES `scenes` WRITE;
/*!40000 ALTER TABLE `scenes` DISABLE KEYS */;
INSERT INTO `scenes` VALUES (1,'Habitación del Hotel','El cuerpo del marido está en la habitación.'),(2,'Pasillo del Hotel','Un pasillo oscuro lleno de puertas.'),(3,'Calabozo','La policía interroga al sospechoso.'),(4,'Casa del Jugador','Lugar seguro para descansar.'),(5,'Bar','NPCs y alcohol. Información oculta.'),(6,'Casa del Sospechoso','Lugar peligroso lleno de pistas.'),(7,'Farmacia','Medicamentos y pistas químicas.'),(8,'Aeropuerto','Solo accesible con pruebas suficientes.'),(9,'Paris - Parque','Inicio del final de la historia.'),(10,'Jardín de Tuileries','Escena final del caso.'),(11,'Puerta de la Comisaría','Libre pero vigilado. La ciudad te espera.'),(12,'Barcelona','La ciudad te espera. ¿A dónde vas?'),(13,'Casa de Apuestas','Luces tenues, dinero y secretos.');
/*!40000 ALTER TABLE `scenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transitions`
--

DROP TABLE IF EXISTS `transitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transitions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `from_scene_id` int DEFAULT NULL,
  `to_scene_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transitions`
--

LOCK TABLES `transitions` WRITE;
/*!40000 ALTER TABLE `transitions` DISABLE KEYS */;
INSERT INTO `transitions` VALUES (1,'salir',1,2),(2,'llamar_recepcion',1,2),(16,'salir',4,12),(17,'salir',5,12),(18,'salir',6,12),(19,'salir',7,12),(20,'ir_casa',11,4),(21,'ir_bar',11,5),(22,'ir_hotel',11,1),(23,'ir_casa_tomas',11,6),(24,'ir_farmacia',11,7),(25,'ir_casa',12,4),(26,'ir_bar',12,5),(27,'ir_hotel',12,1),(28,'ir_casa_tomas',12,6),(29,'ir_farmacia',12,7),(30,'ir_casa',5,4),(31,'ir_hotel',5,1),(32,'ir_casa_tomas',5,6),(33,'ir_farmacia',5,7),(34,'ir_bar',4,5),(35,'ir_hotel',4,1),(36,'ir_casa_tomas',4,6),(37,'ir_farmacia',4,7),(38,'ir_casa',6,4),(39,'ir_bar',6,5),(40,'ir_hotel',6,1),(41,'ir_farmacia',6,7),(42,'ir_casa',7,4),(43,'ir_bar',7,5),(44,'ir_hotel',7,1),(45,'ir_casa_tomas',7,6),(46,'ir_casa',1,4),(47,'ir_bar',1,5),(48,'ir_casa_tomas',1,6),(49,'ir_farmacia',1,7),(50,'salir',13,12),(51,'ir_apuestas',12,13),(52,'ir_apuestas',11,13);
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

-- Dump completed on 2026-06-06 22:57:47
