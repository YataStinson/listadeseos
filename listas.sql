-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 07, 2017 at 08:52 
-- Server version: 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `listas`
--

-- --------------------------------------------------------

--
-- Table structure for table `articulos_lista`
--

CREATE TABLE `articulos_lista` (
  `id_al` int(11) NOT NULL,
  `id_lista_al` int(11) NOT NULL,
  `comprador` int(11) DEFAULT NULL,
  `nombre_art_al` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `precio_art` double NOT NULL,
  `desc_art` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eventos`
--

CREATE TABLE `eventos` (
  `id_evento` int(11) NOT NULL,
  `nombre_evento` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `desc_evento` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invitados`
--

CREATE TABLE `invitados` (
  `id_lista_inv` int(11) NOT NULL,
  `id_usuario_inv` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lista`
--

CREATE TABLE `lista` (
  `id_lista` int(11) NOT NULL,
  `usuario_propietario` int(11) NOT NULL,
  `nombre_lista` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_exp` date NOT NULL,
  `lista_activa` enum('S','N') COLLATE utf8_spanish_ci NOT NULL,
  `evento_lista` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Triggers `lista`
--
DELIMITER $$
CREATE TRIGGER `AD_LISTA` AFTER DELETE ON `lista` FOR EACH ROW BEGIN
	DELETE FROM articulos_lista WHERE id_lista_al=old.id_lista;
    DELETE FROM invitados WHERE id_lista_inv=old.id_lista;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `apellido1_usuario` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `apellido2_usuario` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `e-mail_usuario` varchar(75) COLLATE utf8_spanish_ci NOT NULL,
  `clave_usuaio` varchar(130) COLLATE utf8_spanish_ci NOT NULL,
  `foto_perfil` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usuario_activo` enum('S','N') COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Triggers `usuario`
--
DELIMITER $$
CREATE TRIGGER `AU_USUARIO` AFTER UPDATE ON `usuario` FOR EACH ROW BEGIN
	UPDATE lista SET lista_activa=new.usuario_activo WHERE usuario_propietario=new.id_usuario;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articulos_lista`
--
ALTER TABLE `articulos_lista`
  ADD PRIMARY KEY (`id_al`),
  ADD KEY `id_lista_al` (`id_lista_al`),
  ADD KEY `comprador` (`comprador`);

--
-- Indexes for table `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id_evento`);

--
-- Indexes for table `invitados`
--
ALTER TABLE `invitados`
  ADD PRIMARY KEY (`id_lista_inv`,`id_usuario_inv`);

--
-- Indexes for table `lista`
--
ALTER TABLE `lista`
  ADD PRIMARY KEY (`id_lista`),
  ADD KEY `usuario_propieratio` (`usuario_propietario`),
  ADD KEY `evento_lista` (`evento_lista`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articulos_lista`
--
ALTER TABLE `articulos_lista`
  MODIFY `id_al` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `lista`
--
ALTER TABLE `lista`
  MODIFY `id_lista` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
