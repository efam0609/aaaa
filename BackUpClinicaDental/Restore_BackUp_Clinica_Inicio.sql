CREATE DATABASE  IF NOT EXISTS `clinicadental` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `clinicadental`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: clinicadental
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `IdCita` char(6) NOT NULL,
  `IdPaciente` char(6) NOT NULL,
  `fecha` date NOT NULL,
  `hora` varchar(18) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`IdCita`),
  KEY `citas_ibfk_1_idx` (`IdPaciente`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`IdPaciente`) REFERENCES `paciente` (`IdPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultas` (
  `IdConsulta` char(6) NOT NULL,
  `IdPaciente` char(6) NOT NULL,
  `IdServicio` char(3) NOT NULL,
  `IdTratamiento` char(3) NOT NULL,
  `IdEspecialista` char(6) NOT NULL,
  `diagnostico` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `hora` varchar(13) NOT NULL,
  PRIMARY KEY (`IdConsulta`),
  KEY `consultas_ibfk_1_idx` (`IdPaciente`),
  KEY `consultas_ibfk_2_idx` (`IdEspecialista`),
  KEY `consultas_ibfk_3_idx` (`IdServicio`),
  KEY `consultas_ibfk_4_idx` (`IdTratamiento`),
  CONSTRAINT `consultas_ibfk_1` FOREIGN KEY (`IdPaciente`) REFERENCES `paciente` (`IdPaciente`),
  CONSTRAINT `consultas_ibfk_2` FOREIGN KEY (`IdEspecialista`) REFERENCES `especialista` (`IdEspecialista`),
  CONSTRAINT `consultas_ibfk_3` FOREIGN KEY (`IdServicio`) REFERENCES `servicios` (`IdServicio`),
  CONSTRAINT `consultas_ibfk_4` FOREIGN KEY (`IdTratamiento`) REFERENCES `tratamientos` (`IdTratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datosempresa`
--

DROP TABLE IF EXISTS `datosempresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datosempresa` (
  `IdEmpresa` int(11) NOT NULL AUTO_INCREMENT,
  `razonSocial` varchar(75) NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  `paisEmpresa` varchar(100) NOT NULL,
  `ciudadEmpresa` varchar(100) NOT NULL,
  `nit` varchar(25) DEFAULT NULL,
  `numeroRegistro` varchar(25) NOT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `whatsaap` varchar(25) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL,
  `facebook` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`IdEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datosempresa`
--

LOCK TABLES `datosempresa` WRITE;
/*!40000 ALTER TABLE `datosempresa` DISABLE KEYS */;
INSERT INTO `datosempresa` VALUES (1,'CLINICA DENTAL DRA. ANA VILMA JIMENEZ','BARRIO SANTA CRUZ, CASA Nº 125','El Salvador','San Salvador','0101-091105-102-4','12345678','24249874744','50373276379','dranavilmajimenez@gmail.com','www.facebook.com/dranavilmajimenez');
/*!40000 ALTER TABLE `datosempresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalleexpedientepaciente`
--

DROP TABLE IF EXISTS `detalleexpedientepaciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalleexpedientepaciente` (
  `IdExpediente` char(6) NOT NULL,
  `IdConsulta` char(6) NOT NULL,
  `fecha` date NOT NULL,
  KEY `FK_detalleexpedientepaciente_idx` (`IdExpediente`),
  CONSTRAINT `FK_detalleexpedientepaciente` FOREIGN KEY (`IdExpediente`) REFERENCES `expedientepaciente` (`IdExpediente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleexpedientepaciente`
--

LOCK TABLES `detalleexpedientepaciente` WRITE;
/*!40000 ALTER TABLE `detalleexpedientepaciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalleexpedientepaciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detallerecetamedica`
--

DROP TABLE IF EXISTS `detallerecetamedica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallerecetamedica` (
  `IdReceta` char(6) NOT NULL,
  `IdMedicamento` char(6) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `precio` double NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`IdReceta`,`IdMedicamento`),
  KEY `IdReceta` (`IdReceta`),
  KEY `detallerecetamedica_ibfk_2_idx` (`IdMedicamento`),
  CONSTRAINT `detallerecetamedica_ibfk_1` FOREIGN KEY (`IdReceta`) REFERENCES `recetamedica` (`IdReceta`),
  CONSTRAINT `detallerecetamedica_ibfk_2` FOREIGN KEY (`IdMedicamento`) REFERENCES `medicamentos` (`IdMedicamento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallerecetamedica`
--

LOCK TABLES `detallerecetamedica` WRITE;
/*!40000 ALTER TABLE `detallerecetamedica` DISABLE KEYS */;
/*!40000 ALTER TABLE `detallerecetamedica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialista`
--

DROP TABLE IF EXISTS `especialista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especialista` (
  `IdEspecialista` char(6) NOT NULL,
  `dui` char(11) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `apellidos` varchar(40) NOT NULL,
  `direccion` varchar(120) NOT NULL,
  `pais` varchar(100) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `telefono` char(25) NOT NULL,
  `celular` char(25) NOT NULL,
  PRIMARY KEY (`IdEspecialista`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialista`
--

LOCK TABLES `especialista` WRITE;
/*!40000 ALTER TABLE `especialista` DISABLE KEYS */;
/*!40000 ALTER TABLE `especialista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expedientepaciente`
--

DROP TABLE IF EXISTS `expedientepaciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expedientepaciente` (
  `IdExpediente` char(6) NOT NULL,
  `IdPaciente` char(6) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`IdExpediente`,`IdPaciente`),
  KEY `FK_expedientepaciente_idx` (`IdPaciente`),
  CONSTRAINT `FK_expedientepaciente` FOREIGN KEY (`IdPaciente`) REFERENCES `paciente` (`IdPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expedientepaciente`
--

LOCK TABLES `expedientepaciente` WRITE;
/*!40000 ALTER TABLE `expedientepaciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `expedientepaciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicamentos`
--

DROP TABLE IF EXISTS `medicamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicamentos` (
  `IdMedicamento` char(6) NOT NULL,
  `nombreMedicamento` varchar(75) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` double NOT NULL,
  PRIMARY KEY (`IdMedicamento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicamentos`
--

LOCK TABLES `medicamentos` WRITE;
/*!40000 ALTER TABLE `medicamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paciente` (
  `IdPaciente` char(6) NOT NULL,
  `dui` char(11) DEFAULT NULL,
  `nombres` varchar(40) NOT NULL,
  `apellidos` varchar(40) NOT NULL,
  `direccion` varchar(120) NOT NULL,
  `telefono1` char(20) NOT NULL,
  `telefono2` char(20) NOT NULL,
  `edad` int(2) NOT NULL,
  `pais` varchar(100) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  PRIMARY KEY (`IdPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recetamedica`
--

DROP TABLE IF EXISTS `recetamedica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recetamedica` (
  `IdReceta` char(6) NOT NULL,
  `IdPaciente` char(6) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`IdReceta`),
  KEY `recetamedica_ibfk_1_idx` (`IdPaciente`),
  CONSTRAINT `recetamedica_ibfk_1` FOREIGN KEY (`IdPaciente`) REFERENCES `paciente` (`IdPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recetamedica`
--

LOCK TABLES `recetamedica` WRITE;
/*!40000 ALTER TABLE `recetamedica` DISABLE KEYS */;
/*!40000 ALTER TABLE `recetamedica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rutabackup`
--

DROP TABLE IF EXISTS `rutabackup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutabackup` (
  `rutaBD` varchar(75) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutabackup`
--

LOCK TABLES `rutabackup` WRITE;
/*!40000 ALTER TABLE `rutabackup` DISABLE KEYS */;
INSERT INTO `rutabackup` VALUES ('C:\\BackUpClinicaDental');
/*!40000 ALTER TABLE `rutabackup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `IdServicio` char(3) NOT NULL,
  `nombreServicio` varchar(40) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  PRIMARY KEY (`IdServicio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tratamientos`
--

DROP TABLE IF EXISTS `tratamientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamientos` (
  `IdTratamiento` char(3) NOT NULL,
  `nombreTratamiento` varchar(35) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `tarifa` decimal(5,2) NOT NULL,
  `IdServicio` char(3) DEFAULT NULL,
  PRIMARY KEY (`IdTratamiento`),
  KEY `fk_tratamiento_servicios_id_idx` (`IdServicio`),
  CONSTRAINT `fk_tratamiento_servicios_id` FOREIGN KEY (`IdServicio`) REFERENCES `servicios` (`IdServicio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tratamientos`
--

LOCK TABLES `tratamientos` WRITE;
/*!40000 ALTER TABLE `tratamientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tratamientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `IdUsuario` char(3) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `apellidos` varchar(40) NOT NULL,
  `nombreUsuario` varchar(15) NOT NULL,
  `contrasenia` varchar(15) NOT NULL,
  `modificarPaciente` tinyint(1) NOT NULL,
  `gestionarCitas` tinyint(1) NOT NULL,
  `reservarCitas` tinyint(1) NOT NULL,
  `realizarConsultas` tinyint(1) NOT NULL,
  `modificarServicios` tinyint(1) NOT NULL,
  `modificarTratamientos` tinyint(1) NOT NULL,
  `modificarEspecialista` tinyint(1) NOT NULL,
  `modificarMedicamentos` tinyint(1) NOT NULL,
  `verImprimirReportes` tinyint(1) NOT NULL,
  `modificarUsuarios` tinyint(1) NOT NULL,
  `modificarDatosEmpresa` tinyint(1) NOT NULL,
  `manipularBD` tinyint(1) NOT NULL,
  PRIMARY KEY (`IdUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES ('1','Administrador','Administrador','admin','admin',1,1,1,1,1,1,1,1,1,1,1,1);
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

-- Dump completed on 2021-01-12 13:38:22
