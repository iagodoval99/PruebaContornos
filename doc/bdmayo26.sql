-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-10-2026 a las 09:02:19
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdmayo26`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasificacion`
--

CREATE TABLE `clasificacion` (
  `pos` int(11) NOT NULL COMMENT 'Posición final',
  `num` int(11) NOT NULL COMMENT 'Número del piloto',
  `nombre` varchar(50) NOT NULL COMMENT 'Nombre del piloto',
  `escuderia` int(11) DEFAULT NULL COMMENT 'Escudería del piloto',
  `Q1` time(3) DEFAULT NULL COMMENT 'Tiempo en la Q1',
  `Q2` time(3) DEFAULT NULL COMMENT 'Tiempo en la Q2',
  `Q3` time(3) DEFAULT NULL COMMENT 'Tiempo en la Q3',
  `gap` float(4,3) DEFAULT NULL COMMENT 'Distancia con el anterior',
  `vueltas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `clasificacion`
--
DELIMITER $$
CREATE TRIGGER `actualizarPosiciones` BEFORE UPDATE ON `clasificacion` FOR EACH ROW BEGIN

    -- El piloto empeora posición
    IF NEW.pos > OLD.pos THEN

        UPDATE clasificacion
        SET pos = pos - 1
        WHERE pos > OLD.pos
        AND pos <= NEW.pos
        AND num <> NEW.num;

    -- El piloto mejora posición
    ELSEIF NEW.pos < OLD.pos THEN

        UPDATE clasificacion
        SET pos = pos + 1
        WHERE pos >= NEW.pos
        AND pos < OLD.pos
        AND num <> NEW.num;

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `id_equipo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `entrenador` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `victorias` int(11) DEFAULT NULL,
  `derrotas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escuderias`
--

CREATE TABLE `escuderias` (
  `CodEscuderia` int(11) NOT NULL,
  `Escuderia` varchar(50) NOT NULL,
  `Empresa` varchar(40) DEFAULT NULL,
  `Debut` int(11) DEFAULT NULL,
  `Nacionalidad` varchar(20) DEFAULT NULL,
  `Sede` varchar(30) DEFAULT NULL,
  `Modelo` varchar(20) DEFAULT NULL COMMENT 'Modelo del monoplaza',
  `Motorista` varchar(20) DEFAULT NULL COMMENT 'Fabricante del motor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadisticas`
--

CREATE TABLE `estadisticas` (
  `escuderia` int(11) NOT NULL,
  `Carreras` int(4) UNSIGNED ZEROFILL DEFAULT NULL,
  `TConstructores` int(11) DEFAULT NULL COMMENT 'Títulos de constructores',
  `Tpilotos` int(11) DEFAULT NULL COMMENT 'Títulos de pilotos',
  `Victorias` int(11) DEFAULT NULL COMMENT 'Victorias',
  `Poles` int(11) DEFAULT NULL COMMENT 'Poles',
  `Podios` int(11) DEFAULT NULL COMMENT 'Podios'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadisticas_jugadores`
--

CREATE TABLE `estadisticas_jugadores` (
  `id_estadistica` int(11) NOT NULL,
  `id_jugador` int(11) DEFAULT NULL,
  `puntos` decimal(4,1) DEFAULT NULL,
  `rebotes` decimal(4,1) DEFAULT NULL,
  `asistencias` decimal(4,1) DEFAULT NULL,
  `porcentaje_triples` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugadores`
--

CREATE TABLE `jugadores` (
  `id_jugador` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `posicion` varchar(5) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `salario` decimal(12,2) DEFAULT NULL,
  `id_equipo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clasificacion`
--
ALTER TABLE `clasificacion`
  ADD PRIMARY KEY (`num`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `escuderia` (`escuderia`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`id_equipo`);

--
-- Indices de la tabla `escuderias`
--
ALTER TABLE `escuderias`
  ADD PRIMARY KEY (`CodEscuderia`);

--
-- Indices de la tabla `estadisticas`
--
ALTER TABLE `estadisticas`
  ADD PRIMARY KEY (`escuderia`),
  ADD KEY `escuderia` (`escuderia`);

--
-- Indices de la tabla `estadisticas_jugadores`
--
ALTER TABLE `estadisticas_jugadores`
  ADD PRIMARY KEY (`id_estadistica`),
  ADD KEY `id_jugador` (`id_jugador`);

--
-- Indices de la tabla `jugadores`
--
ALTER TABLE `jugadores`
  ADD PRIMARY KEY (`id_jugador`),
  ADD KEY `id_equipo` (`id_equipo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `escuderias`
--
ALTER TABLE `escuderias`
  MODIFY `CodEscuderia` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clasificacion`
--
ALTER TABLE `clasificacion`
  ADD CONSTRAINT `fkEscuderia1` FOREIGN KEY (`escuderia`) REFERENCES `escuderias` (`CodEscuderia`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `estadisticas`
--
ALTER TABLE `estadisticas`
  ADD CONSTRAINT `fkEscuderia2` FOREIGN KEY (`escuderia`) REFERENCES `escuderias` (`CodEscuderia`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `estadisticas_jugadores`
--
ALTER TABLE `estadisticas_jugadores`
  ADD CONSTRAINT `estadisticas_jugadores_ibfk_1` FOREIGN KEY (`id_jugador`) REFERENCES `jugadores` (`id_jugador`);

--
-- Filtros para la tabla `jugadores`
--
ALTER TABLE `jugadores`
  ADD CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
