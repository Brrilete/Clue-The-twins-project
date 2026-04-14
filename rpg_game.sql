-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-04-2026 a las 00:34:43
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `rpg_game`
--
CREATE DATABASE IF NOT EXISTS `rpg_game` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `rpg_game`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actions`
--

DROP TABLE IF EXISTS `actions`;
CREATE TABLE `actions` (
  `id` int(11) NOT NULL,
  `scene_id` int(11) DEFAULT NULL,
  `key_name` varchar(100) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `actions`:
--   `scene_id`
--       `scenes` -> `id`
--

--
-- Volcado de datos para la tabla `actions`
--

INSERT INTO `actions` (`id`, `scene_id`, `key_name`, `label`) VALUES
(1, 1, 'investigar', 'Investigar la habitación'),
(2, 1, 'salir', 'Salir de la habitación'),
(3, 3, 'hablar_policia', 'Hablar con la policía'),
(4, 3, 'salir', 'Salir del calabozo'),
(5, 4, 'descansar', 'Descansar'),
(6, 4, 'dormir', 'Dormir'),
(7, 5, 'hablar', 'Hablar con NPCs'),
(8, 5, 'beber', 'Beber alcohol'),
(9, 6, 'buscar_pistas', 'Buscar pistas'),
(10, 6, 'esconderse', 'Esconderse'),
(11, 7, 'investigar_medicamentos', 'Investigar medicamentos'),
(12, 8, 'viajar_paris', 'Tomar vuelo a París'),
(13, 9, 'explorar', 'Explorar el parque'),
(14, 10, 'final', 'Desenlace final');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `action_rules`
--

DROP TABLE IF EXISTS `action_rules`;
CREATE TABLE `action_rules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  `effect` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `scene_id` bigint(20) UNSIGNED DEFAULT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `action_rules`:
--

--
-- Volcado de datos para la tabla `action_rules`
--

INSERT INTO `action_rules` (`id`, `action`, `count`, `effect`, `description`, `created_at`, `updated_at`, `scene_id`, `message`) VALUES
(1, 'investigar', 1, 'lose_wallet_silent', 'Pierde la cartera sin darse cuenta', NULL, NULL, NULL, 'Parece ser que no hay nada de interés'),
(2, 'investigar', 2, 'find_clue_restore_wallet', 'Encuentra pista y recupera cartera', NULL, NULL, NULL, '¡Has encontrado lo que parecen ser unas llaves de casa! Ademas has encontrado tu cartera, deberias andar con mas cuidado'),
(3, 'investigar', 3, 'nothing_more', NULL, NULL, NULL, NULL, 'Ya no hay nada más que investigar aquí.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `history`
--

DROP TABLE IF EXISTS `history`;
CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `player_id` int(11) DEFAULT NULL,
  `scene_id` int(11) DEFAULT NULL,
  `action_key` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `history`:
--

--
-- Volcado de datos para la tabla `history`
--

INSERT INTO `history` (`id`, `player_id`, `scene_id`, `action_key`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'investigar', '2026-04-12 23:11:35', '2026-04-12 23:11:35'),
(2, 1, 1, 'investigar', '2026-04-12 23:11:59', '2026-04-12 23:11:59'),
(3, 1, 1, 'investigar', '2026-04-12 23:20:26', '2026-04-12 23:20:26'),
(4, 1, 1, 'investigar', '2026-04-12 23:26:49', '2026-04-12 23:26:49'),
(5, 1, 1, 'investigar', '2026-04-12 23:27:47', '2026-04-12 23:27:47'),
(6, 1, 1, 'investigar', '2026-04-12 23:29:05', '2026-04-12 23:29:05'),
(7, 1, 1, 'investigar', '2026-04-12 23:29:20', '2026-04-12 23:29:20'),
(8, 1, 1, 'investigar', '2026-04-12 23:33:07', '2026-04-12 23:33:07'),
(9, 1, 1, 'investigar', '2026-04-12 23:33:50', '2026-04-12 23:33:50'),
(10, 1, 1, 'investigar', '2026-04-12 23:34:14', '2026-04-12 23:34:14'),
(11, 1, 1, 'investigar', '2026-04-12 23:34:24', '2026-04-12 23:34:24'),
(12, 1, 1, 'investigar', '2026-04-12 23:34:34', '2026-04-12 23:34:34'),
(13, 1, 1, 'investigar', '2026-04-12 23:34:41', '2026-04-12 23:34:41'),
(14, 1, 1, 'investigar', '2026-04-12 23:34:48', '2026-04-12 23:34:48'),
(15, 1, 1, 'investigar', '2026-04-12 23:34:53', '2026-04-12 23:34:53'),
(16, 1, 1, 'investigar', '2026-04-12 23:35:15', '2026-04-12 23:35:15'),
(17, 1, 1, 'investigar', '2026-04-12 23:35:34', '2026-04-12 23:35:34'),
(18, 1, 1, 'investigar', '2026-04-12 23:36:48', '2026-04-12 23:36:48'),
(19, 1, 1, 'investigar', '2026-04-12 23:37:04', '2026-04-12 23:37:04'),
(20, 1, 1, 'investigar', '2026-04-12 23:37:18', '2026-04-12 23:37:18'),
(21, 1, 1, 'investigar', '2026-04-12 23:38:00', '2026-04-12 23:38:00'),
(22, 1, 1, 'investigar', '2026-04-12 23:38:07', '2026-04-12 23:38:07'),
(23, 1, 1, 'investigar', '2026-04-12 23:38:21', '2026-04-12 23:38:21'),
(24, 1, 1, 'investigar', '2026-04-12 23:38:36', '2026-04-12 23:38:36'),
(25, 1, 1, 'investigar', '2026-04-12 23:40:04', '2026-04-12 23:40:04'),
(26, 1, 1, 'investigar', '2026-04-12 23:40:14', '2026-04-12 23:40:14'),
(27, 1, 1, 'investigar', '2026-04-12 23:40:32', '2026-04-12 23:40:32'),
(28, 1, 1, 'investigar', '2026-04-12 23:40:37', '2026-04-12 23:40:37'),
(29, 1, 1, 'investigar', '2026-04-12 23:40:42', '2026-04-12 23:40:42'),
(30, 1, 1, 'investigar', '2026-04-12 23:42:08', '2026-04-12 23:42:08'),
(31, 1, 1, 'investigar', '2026-04-12 23:42:12', '2026-04-12 23:42:12'),
(32, 1, 1, 'investigar', '2026-04-12 23:45:36', '2026-04-12 23:45:36'),
(33, 1, 1, 'investigar', '2026-04-12 23:45:53', '2026-04-12 23:45:53'),
(34, 1, 1, 'investigar', '2026-04-12 23:45:58', '2026-04-12 23:45:58'),
(35, 1, 1, 'investigar', '2026-04-12 23:46:09', '2026-04-12 23:46:09'),
(36, 1, 1, 'investigar', '2026-04-12 23:46:40', '2026-04-12 23:46:40'),
(37, 1, 1, 'investigar', '2026-04-12 23:46:44', '2026-04-12 23:46:44'),
(38, 1, 1, 'investigar', '2026-04-12 23:47:32', '2026-04-12 23:47:32'),
(39, 1, 1, 'investigar', '2026-04-12 23:48:05', '2026-04-12 23:48:05'),
(40, 1, 1, 'investigar', '2026-04-12 23:48:32', '2026-04-12 23:48:32'),
(41, 1, 1, 'investigar', '2026-04-12 23:50:08', '2026-04-12 23:50:08'),
(42, 1, 1, 'investigar', '2026-04-12 23:51:05', '2026-04-12 23:51:05'),
(43, 1, 1, 'investigar', '2026-04-12 23:52:20', '2026-04-12 23:52:20'),
(44, 1, 1, 'investigar', '2026-04-12 23:52:33', '2026-04-12 23:52:33'),
(45, 1, 1, 'investigar', '2026-04-12 23:52:58', '2026-04-12 23:52:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `items`:
--

--
-- Volcado de datos para la tabla `items`
--

INSERT INTO `items` (`id`, `name`, `description`) VALUES
(1, 'Llaves de la casa de la víctima', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `npcs`
--

DROP TABLE IF EXISTS `npcs`;
CREATE TABLE `npcs` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `personality` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `npcs`:
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `npc_dialogues`
--

DROP TABLE IF EXISTS `npc_dialogues`;
CREATE TABLE `npc_dialogues` (
  `id` int(11) NOT NULL,
  `npc_id` int(11) DEFAULT NULL,
  `scene_id` int(11) DEFAULT NULL,
  `trigger` text DEFAULT NULL,
  `response` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `npc_dialogues`:
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `players`
--

DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `sanity` int(11) DEFAULT 100,
  `suspicion` int(11) DEFAULT 0,
  `location_scene_id` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `players`:
--

--
-- Volcado de datos para la tabla `players`
--

INSERT INTO `players` (`id`, `name`, `sanity`, `suspicion`, `location_scene_id`, `created_at`) VALUES
(1, 'TestPlayer', 100, 0, 1, '2026-04-13 00:04:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `player_actions`
--

DROP TABLE IF EXISTS `player_actions`;
CREATE TABLE `player_actions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `player_actions`:
--   `player_id`
--       `players` -> `id`
--

--
-- Volcado de datos para la tabla `player_actions`
--

INSERT INTO `player_actions` (`id`, `player_id`, `action`, `created_at`, `updated_at`) VALUES
(29, 1, 'investigar', '2026-04-12 23:46:40', '2026-04-12 23:46:40'),
(38, 1, 'investigar', '2026-04-12 23:52:58', '2026-04-12 23:52:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `player_items`
--

DROP TABLE IF EXISTS `player_items`;
CREATE TABLE `player_items` (
  `id` int(11) NOT NULL,
  `player_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `player_items`:
--   `player_id`
--       `players` -> `id`
--   `item_id`
--       `items` -> `id`
--

--
-- Volcado de datos para la tabla `player_items`
--

INSERT INTO `player_items` (`id`, `player_id`, `item_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-04-12 23:51:05', '2026-04-12 23:51:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `scenes`
--

DROP TABLE IF EXISTS `scenes`;
CREATE TABLE `scenes` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `scenes`:
--

--
-- Volcado de datos para la tabla `scenes`
--

INSERT INTO `scenes` (`id`, `name`, `description`) VALUES
(1, 'Habitación del Hotel', 'El cuerpo del marido está en la habitación.'),
(2, 'Pasillo del Hotel', 'Un pasillo oscuro lleno de puertas.'),
(3, 'Calabozo', 'La policía interroga al sospechoso.'),
(4, 'Casa del Jugador', 'Lugar seguro para descansar.'),
(5, 'Bar', 'NPCs y alcohol. Información oculta.'),
(6, 'Casa del Sospechoso', 'Lugar peligroso lleno de pistas.'),
(7, 'Farmacia', 'Medicamentos y pistas químicas.'),
(8, 'Aeropuerto', 'Solo accesible con pruebas suficientes.'),
(9, 'Paris - Parque', 'Inicio del final de la historia.'),
(10, 'Jardín de Tuileries', 'Escena final del caso.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transitions`
--

DROP TABLE IF EXISTS `transitions`;
CREATE TABLE `transitions` (
  `id` int(11) NOT NULL,
  `action_key` varchar(100) DEFAULT NULL,
  `from_scene_id` int(11) DEFAULT NULL,
  `to_scene_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `transitions`:
--

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actions`
--
ALTER TABLE `actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `scene_id` (`scene_id`);

--
-- Indices de la tabla `action_rules`
--
ALTER TABLE `action_rules`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `npcs`
--
ALTER TABLE `npcs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `npc_dialogues`
--
ALTER TABLE `npc_dialogues`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `player_actions`
--
ALTER TABLE `player_actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_player_action` (`player_id`,`action`);

--
-- Indices de la tabla `player_items`
--
ALTER TABLE `player_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indices de la tabla `scenes`
--
ALTER TABLE `scenes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `transitions`
--
ALTER TABLE `transitions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actions`
--
ALTER TABLE `actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `action_rules`
--
ALTER TABLE `action_rules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `npcs`
--
ALTER TABLE `npcs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `npc_dialogues`
--
ALTER TABLE `npc_dialogues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `player_actions`
--
ALTER TABLE `player_actions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `player_items`
--
ALTER TABLE `player_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `scenes`
--
ALTER TABLE `scenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `transitions`
--
ALTER TABLE `transitions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actions`
--
ALTER TABLE `actions`
  ADD CONSTRAINT `actions_ibfk_1` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`id`);

--
-- Filtros para la tabla `player_actions`
--
ALTER TABLE `player_actions`
  ADD CONSTRAINT `fk_player_actions_player` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`),
  ADD CONSTRAINT `player_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
