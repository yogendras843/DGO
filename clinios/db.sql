-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: localhost    Database: clinios
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `appointment_type`
--

DROP TABLE IF EXISTS `appointment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `appointment_type` varchar(50) DEFAULT NULL,
  `appointment_name_portal` varchar(50) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `allow_patients_schedule` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `descr` varchar(200) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_type`
--

LOCK TABLES `appointment_type` WRITE;
/*!40000 ALTER TABLE `appointment_type` DISABLE KEYS */;
INSERT INTO `appointment_type` VALUES (1,1,'Initial appointment 1 hour','Initial appointment 1 hour',60,1,0,NULL,'2019-10-01',1,'2019-10-01',1),(2,1,'Initial appointment 1/2 hour','Initial appointment 1/2 hour',30,1,0,NULL,'2019-10-01',1,'2019-10-01',1);
/*!40000 ALTER TABLE `appointment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_type_user`
--

DROP TABLE IF EXISTS `appointment_type_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_type_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `appointment_type_id` int(11) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_type_user`
--

LOCK TABLES `appointment_type_user` WRITE;
/*!40000 ALTER TABLE `appointment_type_user` DISABLE KEYS */;
INSERT INTO `appointment_type_user` VALUES (1,1,1,1,'2019-10-01',1,'2019-10-01',1),(2,1,2,1,'2019-10-01',1,'2019-10-01',1),(3,1,1,2,'2019-10-01',1,'2019-10-01',1),(4,1,2,2,'2019-10-01',1,'2019-10-01',1);
/*!40000 ALTER TABLE `appointment_type_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client` varchar(255) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `postal` varchar(10) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `website` varchar(50) DEFAULT NULL,
  `appointment_confirmation` varchar(3000) DEFAULT NULL,
  `portal_header` varchar(1000) DEFAULT NULL,
  `portal_header_home` varchar(1000) DEFAULT NULL,
  `portal_header_messages` varchar(1000) DEFAULT NULL,
  `portal_header_encounters` varchar(1000) DEFAULT NULL,
  `portal_header_documents` varchar(1000) DEFAULT NULL,
  `portal_header_tests` varchar(1000) DEFAULT NULL,
  `portal_header_appointments` varchar(1000) DEFAULT NULL,
  `portal_header_supplements` varchar(1000) DEFAULT NULL,
  `portal_header_medications` varchar(1000) DEFAULT NULL,
  `portal_header_pharmacies` varchar(1000) DEFAULT NULL,
  `portal_header_forms` varchar(1000) DEFAULT NULL,
  `portal_header_profile` varchar(1000) DEFAULT NULL,
  `doctors_data_id` int(11) DEFAULT NULL,
  `doctors_data_username` int(11) DEFAULT NULL,
  `doctors_data_password` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Western Center For Functional Medicine','100 Main St','Suite #100','Concord','CA','94521','US','800-555-1212','hello@western.org','www.springcenter.com','\nHi {patient_firstname},\n\nThis is a confirmation and reminder of your upcoming appointment.\n\nDay: {appointment_day_of_week}\nDate: {appointment_date}\nTime: {appointment_time}\nWith: {appointment_user}\n \nPlease remember, you are welcome to change your appointment up to two business days prior to your scheduled time by calling my staff at the number below. Changes less than two business days will incur a fee as described below.\n\nPlease NOTE:\nDue to a large number of our patients & staff who are very chemical sensitive, please refrain from wearing ANY perfume, cologne or fragrances of any kind including body washes, lotions or hair products, to the office on the day of your appointment. Failure to do so may result in cancellation of appointment and charge for late notice cancel of $75. Thank you.\n\nWe look forward to seeing you soon!\n\n\"What we put into our bodies affects how we feel both physically and emotionally. This is not just true with what we eat but also what we think. You can look at thoughts as food for the mind. Since you have a choice, why not choose healthy thoughts.\"\n\nFondly,\n\n{appointment_user}\n{client_name}\n{client_address}\n{client_city_state_postal}\n{client_website}\n{client_phone}\n','<img style=\'width: 500px;\' src=\'https://thespringcenter.com/wp-content/uploads/2019/05/newlogo-01.png\'>\n<center>\nWelcome to the Spring Center Patient Portal!\n</center>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05','2019-09-16 22:54:05',NULL);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_range`
--

DROP TABLE IF EXISTS `client_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_range` (
  `client_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `range_low` decimal(5,1) DEFAULT NULL,
  `range_high` decimal(5,1) DEFAULT NULL,
  `range_low_female` decimal(5,1) DEFAULT NULL,
  `range_high_female` decimal(5,1) DEFAULT NULL,
  `range_low_male` decimal(5,1) DEFAULT NULL,
  `range_high_male` decimal(5,1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`client_id`,`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_range`
--

LOCK TABLES `client_range` WRITE;
/*!40000 ALTER TABLE `client_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_range_default`
--

DROP TABLE IF EXISTS `client_range_default`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_range_default` (
  `test_id` int(11) NOT NULL,
  `range_low` decimal(5,1) DEFAULT NULL,
  `range_high` decimal(5,1) DEFAULT NULL,
  `range_low_female` decimal(5,1) DEFAULT NULL,
  `range_high_female` decimal(5,1) DEFAULT NULL,
  `range_low_male` decimal(5,1) DEFAULT NULL,
  `range_high_male` decimal(5,1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_range_default`
--

LOCK TABLES `client_range_default` WRITE;
/*!40000 ALTER TABLE `client_range_default` DISABLE KEYS */;
INSERT INTO `client_range_default` VALUES (1,85.0,100.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(2,NULL,NULL,3.2,5.5,3.7,6.0,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(3,13.0,18.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(4,0.7,1.1,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(5,13.0,20.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(6,59.0,127.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(8,135.0,140.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(9,4.0,4.5,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(10,100.0,106.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(11,25.0,30.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(12,7.0,12.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(13,9.2,10.1,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(14,2.0,2.5,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(15,3.5,4.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(16,6.9,7.4,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(17,4.0,5.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(18,2.4,2.8,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(19,1.5,2.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(20,0.2,1.2,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(21,70.0,90.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(22,140.0,180.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(23,10.0,26.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(24,10.0,26.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(25,10.0,26.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(26,85.0,130.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(29,12.5,150.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(30,250.0,350.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(31,155.0,355.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(33,15.0,45.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(100,5.0,8.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(101,NULL,NULL,3.9,4.5,4.2,4.9,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(102,NULL,NULL,13.5,14.5,14.0,15.0,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(103,NULL,NULL,37.0,44.0,40.0,48.0,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(104,85.0,92.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(105,27.0,32.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(106,32.0,35.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(107,0.0,13.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(108,155.0,385.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(150,40.0,60.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(152,25.0,40.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(154,0.0,7.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(156,0.0,3.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(158,0.0,1.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(200,150.0,200.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(201,55.0,120.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(203,50.0,120.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(204,0.0,20.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(205,75.0,100.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(206,0.0,3.1,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(300,1.8,3.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(301,1.0,1.8,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(302,3.0,4.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(303,6.0,12.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(304,1.0,1.5,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(305,28.0,38.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(306,0.0,32.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(307,0.0,9.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(309,90.0,330.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(310,1.2,4.9,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(400,5.0,5.5,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(401,50.0,100.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(402,0.0,1.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(403,0.0,7.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(414,100.0,140.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(430,0.0,140.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL),(431,0.0,120.0,NULL,NULL,NULL,NULL,'2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL);
/*!40000 ALTER TABLE `client_range_default` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `history` varchar(5000) DEFAULT NULL,
  `treatment` varchar(5000) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
INSERT INTO `encounter` VALUES (1,1,1,1,'Patient was exposed to mold in a water damaged home.','Take PC, glutathione and charcoal for three months.','2019-01-01 00:00:00',1,NULL,NULL),(2,1,1,1,'Patient moved to new home.','Continue for 1 more month.','2019-04-01 00:00:00',1,NULL,NULL);
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `form` varchar(10000) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
INSERT INTO `form` VALUES (1,1,'Client Agreement','Welcome to Western Center for Functional Medicine.  We are going to help you return your health... ','2019-09-16 22:54:05',NULL,'2019-09-16 22:54:05',NULL);
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab`
--

DROP TABLE IF EXISTS `lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `lab_dt` datetime DEFAULT NULL,
  `physician` varchar(255) DEFAULT NULL,
  `upload_error` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `source` char(1) DEFAULT NULL,
  `vendor` varchar(10) DEFAULT NULL,
  `hl7` char(1) DEFAULT NULL,
  `approved_user_id` int(11) DEFAULT NULL,
  `approved_dt` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab`
--

LOCK TABLES `lab` WRITE;
/*!40000 ALTER TABLE `lab` DISABLE KEYS */;
/*!40000 ALTER TABLE `lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_test`
--

DROP TABLE IF EXISTS `lab_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `lab_id` int(11) DEFAULT NULL,
  `lab_dt` datetime DEFAULT NULL,
  `test_id` int(11) DEFAULT NULL,
  `line_nbr` int(11) DEFAULT NULL,
  `value` decimal(6,2) DEFAULT NULL,
  `range_low` decimal(5,1) DEFAULT NULL,
  `range_high` decimal(5,1) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`,`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_test`
--

LOCK TABLES `lab_test` WRITE;
/*!40000 ALTER TABLE `lab_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `lab_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `firstname` varchar(30) DEFAULT NULL,
  `middlename` varchar(20) DEFAULT NULL,
  `lastname` varchar(30) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `postal` varchar(10) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `login_dt` datetime DEFAULT NULL,
  `primary_reason` varchar(1000) DEFAULT NULL,
  `notes` varchar(5000) DEFAULT NULL,
  `referred_by` varchar(100) DEFAULT NULL,
  `inches` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `signature` blob,
  `ip_address` varchar(30) DEFAULT NULL,
  `pharmacy_name` varchar(100) DEFAULT NULL,
  `pharmacy_phone` varchar(50) DEFAULT NULL,
  `pharmacy_fax` varchar(50) DEFAULT NULL,
  `verify_token` varchar(255) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`,`firstname`),
  KEY `client_id_2` (`client_id`,`lastname`),
  KEY `client_id_3` (`client_id`,`phone`),
  KEY `client_id_4` (`client_id`,`email`),
  KEY `client_id_5` (`client_id`,`created`),
  KEY `client_id_6` (`client_id`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,1,'David','M','Potter','100 Main St',NULL,'xx','CA','91214','US','1234',NULL,'david10@davidjpotter.com','$2b$10$DhD.jVx4eInrisPRt/Qlj.LCv8FdSHu70Im4dp3199hCd2hWVzmla',1,'M',NULL,'Hypothyroidism',NULL,NULL,0,0,NULL,NULL,'University Compounding Pharmacy',NULL,NULL,NULL,'2019-09-12',1,'2019-09-28',NULL),(2,2,'John','J','Doe','100 Main Street',NULL,'LA','CA','91214',NULL,'cell',NULL,'test@test.com','$2b$10$wK9xyQQc3bWebGGRuCnipuN2TI6oe17RQdqlbqF//YDgVZxn9DBNS',1,'M',NULL,'Hypothyroidism',NULL,NULL,0,0,NULL,NULL,'University Compounding Pharmacy',NULL,NULL,NULL,'2019-09-19',1,'2019-09-28',NULL);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_accounting`
--

DROP TABLE IF EXISTS `patient_accounting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_accounting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `tran_dt` date DEFAULT NULL,
  `tran_type` varchar(10) DEFAULT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  `note` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_accounting`
--

LOCK TABLES `patient_accounting` WRITE;
/*!40000 ALTER TABLE `patient_accounting` DISABLE KEYS */;
INSERT INTO `patient_accounting` VALUES (1,1,1,'2019-06-01','BILL',-100,'Initial screening','2019-09-16 22:54:05',1,NULL,NULL),(2,1,1,'2019-06-02','PMT',100,'Payment by credit card','2019-09-16 22:54:05',1,NULL,NULL),(3,1,1,'2019-06-03','BILL',-300,'Initial appointment','2019-09-16 22:54:05',1,NULL,NULL),(4,1,1,'2019-06-04','PMT',300,'Payment by credit card','2019-09-16 22:54:05',1,NULL,NULL);
/*!40000 ALTER TABLE `patient_accounting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_form`
--

DROP TABLE IF EXISTS `patient_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `form_id` int(11) DEFAULT NULL,
  `ip_address` varchar(20) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_form`
--

LOCK TABLES `patient_form` WRITE;
/*!40000 ALTER TABLE `patient_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_message`
--

DROP TABLE IF EXISTS `patient_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `user_id_from` int(11) DEFAULT NULL,
  `user_id_to` int(11) DEFAULT NULL,
  `patient_id_from` int(11) DEFAULT NULL,
  `patient_id_to` int(11) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` varchar(10000) DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `task_dt` date DEFAULT NULL,
  `completed_dt` char(1) DEFAULT NULL,
  `notified_dt` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id_from` (`patient_id_from`),
  KEY `patient_id_to` (`patient_id_to`),
  KEY `user_id_from` (`user_id_from`),
  KEY `user_id_to` (`user_id_to`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_message`
--

LOCK TABLES `patient_message` WRITE;
/*!40000 ALTER TABLE `patient_message` DISABLE KEYS */;
INSERT INTO `patient_message` VALUES (1,1,NULL,1,1,NULL,'Medication','Can you refill my medication?\nI will be out tomorrow.','I asked Chris','2019-08-01','Y',NULL,'2019-09-28 14:49:35',1,'2019-09-28 14:49:35',NULL);
/*!40000 ALTER TABLE `patient_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support`
--

DROP TABLE IF EXISTS `support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support`
--

LOCK TABLES `support` WRITE;
/*!40000 ALTER TABLE `support` DISABLE KEYS */;
INSERT INTO `support` VALUES (1,1,'O','Upload of lab gives error message file not supported','2019-09-16 22:54:05',1,'2019-09-16 22:54:05',1);
/*!40000 ALTER TABLE `support` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_message`
--

DROP TABLE IF EXISTS `support_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `support_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `notified_dt` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `support_id` (`support_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_message`
--

LOCK TABLES `support_message` WRITE;
/*!40000 ALTER TABLE `support_message` DISABLE KEYS */;
INSERT INTO `support_message` VALUES (1,1,1,'It just happened again.\nCan you help me?',NULL,'2019-09-16 00:00:00',1,'2019-09-16 22:54:05',1);
/*!40000 ALTER TABLE `support_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `name_long` varchar(255) DEFAULT NULL,
  `descr` varchar(1000) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `name_long` (`name_long`)
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'Glucose','','To diagnose diabetes, prediabetes, high blood glucose (hyperglycemia) or low blood glucose (hypoglycemia)','2019-09-16 22:54:05'),(2,'Uric Acid','','To detect high levels of uric acid in the blood, which could be a sign of the condition gout, or to monitor uric acid levels when undergoing chemotherapy or radiation treatment; to detect high levels of uric acid in the urine in order to diagnose the cause of kidney stones and to monitor those with gout who are at risk of developing such stones;','2019-09-16 22:54:05'),(3,'BUN','Blood Urea Nitrogen','Evaluates kidney health','2019-09-16 22:54:05'),(4,'Creatinine','','Evaluates kidney health','2019-09-16 22:54:05'),(5,'BUN/Creatinine Ratio','','An increased ratio may be due to a condition that causes a decrease in the flow of blood to the kidneys, such as congestive heart failure or dehydration.','2019-09-16 22:54:05'),(6,'eGFR','Estimated Glomerular Filtration Rate','Evaluates kidney health','2019-09-16 22:54:05'),(7,'eGFRAA','Estimated Glomerular Filtration Rate','Evaluates kidney health','2019-09-16 22:54:05'),(8,'Sodium','','Evaluates electrolyte balance','2019-09-16 22:54:05'),(9,'Potassium','','Evaluates electrolyte balance','2019-09-16 22:54:05'),(10,'Chloride','','Evaluates electrolyte balance and acid-base (pH) balance','2019-09-16 22:54:05'),(11,'Carbon Dioxide','','Evaluates electrolyte imbalance and acid-base (pH) imbalance','2019-09-16 22:54:05'),(12,'Anion Gap','','Evaluates electrolyte balance','2019-09-16 22:54:05'),(13,'Calcium','','High values could be caused by hyperparathyroidism, hyperthyroidism or excess vitamin D intake.  Low values could be caused by low blood protein, low vitamin D, low magnesium, or increased phosphorus.','2019-09-16 22:54:05'),(14,'Magnesium','','','2019-09-16 22:54:05'),(15,'Phosphorus','','','2019-09-16 22:54:05'),(16,'Protein Total','','','2019-09-16 22:54:05'),(17,'Albumin','','','2019-09-16 22:54:05'),(18,'Globulin','','','2019-09-16 22:54:05'),(19,'Albumin/Globulin Ratio','','','2019-09-16 22:54:05'),(20,'Bilirubin Total','','','2019-09-16 22:54:05'),(21,'ALP','Alkaline Phosphatase','Liver and bone health','2019-09-16 22:54:05'),(22,'LDH','Lactate dehydrogenase','Tissue damage','2019-09-16 22:54:05'),(23,'AST','Aspartate Aminotransferase','Liver health','2019-09-16 22:54:05'),(24,'ALT','Alanine Transaminase','Liver health','2019-09-16 22:54:05'),(25,'GGT','Gamma-glutamyl transferase','Liver health','2019-09-16 22:54:05'),(26,'Iron','','','2019-09-16 22:54:05'),(29,'Ferritin, Serum','','Elevated ferritin does not necessarily indicates iron overload.  Ferritin is also an acute phase reactant which is elevated in an inflammatory response.','2019-09-16 22:54:05'),(30,'TIBC','Total Iron Binding Capacity','Measures the capacity to bind transferrin with iron.  An inverse marker, so if iron overload than the value will be below the range.','2019-09-16 22:54:05'),(31,'UIBC','Unsaturated iron binding capacity','Measures the remaining amount of transferrin not bound to iron.  An inverse marker, so if iron overload is present than the value will be below the range.  UIBC is a more reliable marker than TIBC.  Equal to iron saturation as a predictive value for iron overload.','2019-09-16 22:54:05'),(33,'Iron Saturation','Transferrin Saturation','Measures percentage of iron that is bound to transferrin.  Transferrin is a protein that transports iron through the body and withholds iron from pathogens as iron is a source of energy for them.  Strong indicator for iron overload.','2019-09-16 22:54:05'),(34,'Osmolality','','To help evaluate the body\'s water and electrolyte balance; to investigate low sodium levels in the blood (hyponatremia) and increased or decreased urine production.','2019-09-16 22:54:05'),(35,'Mean Glucose','','','2019-09-16 22:54:05'),(36,'Fibrinogen Activity','','','2019-09-16 22:54:05'),(37,'Soluble Transferrin Receptor','','Can be used to determine if elevated ferritin is due to inflamation or iron overload.  Decreases with reduced cellular need for iron.  An inverse marker.  If low then iron overload present.','2019-09-16 22:54:05'),(100,'WBC','White Blood Cells','White blood cells are the cells of the immune system that protect the body against infectious disease and foreign organisms.   A high count could be caused by infection, inflammation, or allergic responses.  A low count could be caused by a weakened immune system, bone marrow disorders, autoimmune disorders, dietary deficiencies, or infections.','2019-09-16 22:54:05'),(101,'RBC','Red Blood Cells','Red blood cells are .....  A low count could be caused by iron deficiency, vitamin B12 or folate deficiency.  A high count could be caused by dehydration.','2019-09-16 22:54:05'),(102,'HGB','Hemoglobin','Hemoglobin is.....    Low values could be caused by iron, folate or B12 deficiency?  High values can be caused by dehydration.','2019-09-16 22:54:05'),(103,'HCT','Hematocrit','','2019-09-16 22:54:05'),(104,'MCV','Mean Corpuscular Volume','','2019-09-16 22:54:05'),(105,'MCH','Mean Corpuscular Haemoglobin','','2019-09-16 22:54:05'),(106,'MCHC','Mean Corpuscular Haemoglobin Concentration','','2019-09-16 22:54:05'),(107,'RDW','Red Cell Distribution Width','','2019-09-16 22:54:05'),(108,'Platelets','','','2019-09-16 22:54:05'),(109,'MPV','Mean Platelet Volume','','2019-09-16 22:54:05'),(110,'NRBC','Nucleated RBC','','2019-09-16 22:54:05'),(111,'Erythrocyte Sedimentation Rate','','','2019-09-16 22:54:05'),(150,'Neutrophils %','','','2019-09-16 22:54:05'),(151,'Neutrophils #','','','2019-09-16 22:54:05'),(152,'Lymphocytes %','','','2019-09-16 22:54:05'),(153,'Lymphocytes #','','','2019-09-16 22:54:05'),(154,'Monocytes %','','','2019-09-16 22:54:05'),(155,'Monocytes #','','','2019-09-16 22:54:05'),(156,'Eosinophil %','','','2019-09-16 22:54:05'),(157,'Eosinophil #','','','2019-09-16 22:54:05'),(158,'Basophil %','','','2019-09-16 22:54:05'),(159,'Basophil #','','','2019-09-16 22:54:05'),(160,'Granulocytes %','','','2019-09-16 22:54:05'),(161,'Granulocytes #','','','2019-09-16 22:54:05'),(162,'Granulocytes Immature %','','','2019-09-16 22:54:05'),(163,'Granulocytes Immature #','','','2019-09-16 22:54:05'),(200,'Cholesterol Total','','','2019-09-16 22:54:05'),(201,'HDL','HDL Cholesterol','','2019-09-16 22:54:05'),(202,'Non HDL Cholesterol','','','2019-09-16 22:54:05'),(203,'LDL','LDL Cholesterol','','2019-09-16 22:54:05'),(204,'VLDL','VLDL Cholesterol','','2019-09-16 22:54:05'),(205,'Triglycerides','','','2019-09-16 22:54:05'),(206,'Cholesterol/HDL Ratio','','','2019-09-16 22:54:05'),(207,'LDL/HDL Ratio','','','2019-09-16 22:54:05'),(208,'Cholesterol, nonfasting','','','2019-09-16 22:54:05'),(209,'HDL-P','HDL Particle Count','','2019-09-16 22:54:05'),(210,'LDL-P','LDL Particle Count','','2019-09-16 22:54:05'),(211,'Small LDL-P','Small LDL Particle Count','','2019-09-16 22:54:05'),(212,'LDL Size','','','2019-09-16 22:54:05'),(213,'LP-IR Score','Lipoprotein Insulin Resistance','A composite of six lipoprotein parameters that reflects the lipoprotein derangements of insulin resistance, which may be apparent years before the onset of hyperglycemia.','2019-09-16 22:54:05'),(300,'TSH','Thyroid Stimulating Hormone','','2019-09-16 22:54:05'),(301,'T3 Total','Total Triiodothyronine','','2019-09-16 22:54:05'),(302,'T3 Free','Free Triiodothyronine','','2019-09-16 22:54:05'),(303,'T4 Total','Total Thyroxine','','2019-09-16 22:54:05'),(304,'T4 Free','Free Thyroxine','','2019-09-16 22:54:05'),(305,'T3 Uptake','','','2019-09-16 22:54:05'),(306,'TG Ab','Thyroglobulin Ab','','2019-09-16 22:54:05'),(307,'TP Ab','Thyroid Peroxidase Ab','','2019-09-16 22:54:05'),(308,'TG','Thyroglobulin','','2019-09-16 22:54:05'),(309,'T3 Reverse','Reverse Triiodothyronine','','2019-09-16 22:54:05'),(310,'FTI','Free T4 Index (T7)','','2019-09-16 22:54:05'),(400,'A1C','Hemoglobin A1c','A1C is useful directionally but otherwise useless.  A1c depends on the fact that a red blood cell lives for 90-120 days.','2019-09-16 22:54:05'),(401,'Vitamin D 25 Hydroxy','Calcifediol','','2019-09-16 22:54:05'),(402,'C-Reactive Protein','','','2019-09-16 22:54:05'),(403,'Homocysteine','','','2019-09-16 22:54:05'),(404,'PSA','Prostate-Specific Antigen','','2019-09-16 22:54:05'),(405,'Vitamin B12','','','2019-09-16 22:54:05'),(406,'Methylmalonic Acid, Urine','','','2019-09-16 22:54:05'),(407,'Methylmalonic Acid, Urine, Normalized','','','2019-09-16 22:54:05'),(408,'Creatinine, Urine','','','2019-09-16 22:54:05'),(410,'Folate','','','2019-09-16 22:54:05'),(411,'Copper, Serum','','','2019-09-16 22:54:05'),(412,'Zinc, Plasma or Serum','','','2019-09-16 22:54:05'),(413,'Progesterone','','','2019-09-16 22:54:05'),(414,'Selenium, Serum/Plasma','','','2019-09-16 22:54:05'),(416,'DHEA Sulfate','','','2019-09-16 22:54:05'),(417,'Cortisol AM','','','2019-09-16 22:54:05'),(418,'Testosterone Total','','','2019-09-16 22:54:05'),(419,'Testosterone Free','','','2019-09-16 22:54:05'),(420,'G6PD','Glucose-6-Phosphate Dehydrogenase','','2019-09-16 22:54:05'),(421,'Methylmalonic Acid, Serum','','','2019-09-16 22:54:05'),(430,'OGTT1','Oral Glucose Tolerance Test - 1 Hour','','2019-09-16 22:54:05'),(431,'OGTT2','Oral Glucose Tolerance Test - 2 Hours','','2019-09-16 22:54:05');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_name`
--

DROP TABLE IF EXISTS `test_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_name` (
  `test_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`test_id`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_name`
--

LOCK TABLES `test_name` WRITE;
/*!40000 ALTER TABLE `test_name` DISABLE KEYS */;
INSERT INTO `test_name` VALUES (1,'Glucose fasting','2019-09-16 22:54:05',NULL,NULL,NULL),(1,'Glucose, serum','2019-09-16 22:54:05',NULL,NULL,NULL),(2,'Uric Acid, serum','2019-09-16 22:54:05',NULL,NULL,NULL),(3,'BUN (Blood Urea Nitrogen)','2019-09-16 22:54:05',NULL,NULL,NULL),(3,'Urea Nitrogen (BUN)','2019-09-16 22:54:05',NULL,NULL,NULL),(3,'Urea nitrogen (bun), serum','2019-09-16 22:54:05',NULL,NULL,NULL),(3,'Urea nitrogen bun','2019-09-16 22:54:05',NULL,NULL,NULL),(4,'Creatinine, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(5,'BUN Creatinine Ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(5,'BUN/creat ratio (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(5,'BUN/creatinine ratio (calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(6,'egfr (calc) nonafrican american','2019-09-16 22:54:05',NULL,NULL,NULL),(6,'eGFR If NonAfricn Am','2019-09-16 22:54:05',NULL,NULL,NULL),(6,'egfr non afr american','2019-09-16 22:54:05',NULL,NULL,NULL),(6,'eGFR Non-Afr. American','2019-09-16 22:54:05',NULL,NULL,NULL),(6,'eGFR-Non African American (Calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(6,'Glomerular filtration rate','2019-09-16 22:54:05',NULL,NULL,NULL),(7,'egfr (calc) african american','2019-09-16 22:54:05',NULL,NULL,NULL),(7,'eGFR African American','2019-09-16 22:54:05',NULL,NULL,NULL),(7,'eGFR If Africn Am','2019-09-16 22:54:05',NULL,NULL,NULL),(7,'eGFR-African American (Calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(8,'NA','2019-09-16 22:54:05',NULL,NULL,NULL),(8,'Sodium, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(9,'K','2019-09-16 22:54:05',NULL,NULL,NULL),(9,'Potassium, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(10,'Chloride, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(10,'CL','2019-09-16 22:54:05',NULL,NULL,NULL),(11,'Carbon Dioxide Total','2019-09-16 22:54:05',NULL,NULL,NULL),(11,'Carbon Dioxide, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(11,'Carbon Dioxide, Total','2019-09-16 22:54:05',NULL,NULL,NULL),(11,'CO2','2019-09-16 22:54:05',NULL,NULL,NULL),(11,'CO2 (Bicarbonate)','2019-09-16 22:54:05',NULL,NULL,NULL),(12,'Anion Gap (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(12,'Anion Gap (Calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(12,'Anion Gap (NA - (CL + CO2))','2019-09-16 22:54:05',NULL,NULL,NULL),(13,'CA','2019-09-16 22:54:05',NULL,NULL,NULL),(13,'Calcium, ionized (calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(13,'Calcium, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(13,'Calcium, Total','2019-09-16 22:54:05',NULL,NULL,NULL),(14,'Magnesium, serum','2019-09-16 22:54:05',NULL,NULL,NULL),(14,'MG','2019-09-16 22:54:05',NULL,NULL,NULL),(15,'Phosphorus, inorg','2019-09-16 22:54:05',NULL,NULL,NULL),(15,'Phosphorus, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(16,'Protein, total, serum','2019-09-16 22:54:05',NULL,NULL,NULL),(16,'Total Protein','2019-09-16 22:54:05',NULL,NULL,NULL),(16,'Total Protein, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(17,'Albumin, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(18,'Globulin (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(18,'Globulin (calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(18,'Globulin Total','2019-09-16 22:54:05',NULL,NULL,NULL),(18,'Globulin, Total','2019-09-16 22:54:05',NULL,NULL,NULL),(19,'A G ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(19,'A/G ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(19,'A/G ratio (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(19,'A/G ratio (calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(19,'Albumin globulin ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(20,'Bilirubin, Total','2019-09-16 22:54:05',NULL,NULL,NULL),(21,'Alk Phos','2019-09-16 22:54:05',NULL,NULL,NULL),(21,'Alk. phosphatase','2019-09-16 22:54:05',NULL,NULL,NULL),(21,'Alkaline phosphatase, s','2019-09-16 22:54:05',NULL,NULL,NULL),(22,'LD','2019-09-16 22:54:05',NULL,NULL,NULL),(22,'ldh, serum','2019-09-16 22:54:05',NULL,NULL,NULL),(23,'AST (SGOT)','2019-09-16 22:54:05',NULL,NULL,NULL),(23,'AST SGOT','2019-09-16 22:54:05',NULL,NULL,NULL),(24,'ALT (SGPT)','2019-09-16 22:54:05',NULL,NULL,NULL),(24,'ALT SGPT','2019-09-16 22:54:05',NULL,NULL,NULL),(25,'GGT, serum','2019-09-16 22:54:05',NULL,NULL,NULL),(26,'Iron Total','2019-09-16 22:54:05',NULL,NULL,NULL),(26,'Iron, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(26,'Total Iron','2019-09-16 22:54:05',NULL,NULL,NULL),(29,'Ferritin','2019-09-16 22:54:05',NULL,NULL,NULL),(30,'Iron Bind.Cap.(TIBC)','2019-09-16 22:54:05',NULL,NULL,NULL),(30,'tibc (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(34,'Osmolality (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(34,'Osmolality (calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(34,'Osmolality calc','2019-09-16 22:54:05',NULL,NULL,NULL),(34,'Osmolality calc.','2019-09-16 22:54:05',NULL,NULL,NULL),(35,'Estim. avg glu (eag)','2019-09-16 22:54:05',NULL,NULL,NULL),(35,'Estim. avg glu (eag), serum','2019-09-16 22:54:05',NULL,NULL,NULL),(35,'Mean Blood Glucose (Calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(35,'Mean Plasma Glucose','2019-09-16 22:54:05',NULL,NULL,NULL),(35,'Mean Plasma Glucose, serum','2019-09-16 22:54:05',NULL,NULL,NULL),(36,'Iron % Saturation','2019-09-16 22:54:05',NULL,NULL,NULL),(36,'Iron % Saturation (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(100,'White blood cell','2019-09-16 22:54:05',NULL,NULL,NULL),(100,'White blood cell count','2019-09-16 22:54:05',NULL,NULL,NULL),(100,'White blood cells','2019-09-16 22:54:05',NULL,NULL,NULL),(101,'Red blood cell','2019-09-16 22:54:05',NULL,NULL,NULL),(101,'Red blood cell count','2019-09-16 22:54:05',NULL,NULL,NULL),(101,'Red blood cells','2019-09-16 22:54:05',NULL,NULL,NULL),(107,'RDW-CV','2019-09-16 22:54:05',NULL,NULL,NULL),(107,'RDWCV','2019-09-16 22:54:05',NULL,NULL,NULL),(108,'Platelet','2019-09-16 22:54:05',NULL,NULL,NULL),(108,'Platelet Count','2019-09-16 22:54:05',NULL,NULL,NULL),(110,'Absolute nucleated rbc','2019-09-16 22:54:05',NULL,NULL,NULL),(110,'Nucleated rbc abs','2019-09-16 22:54:05',NULL,NULL,NULL),(111,'ESR','2019-09-16 22:54:05',NULL,NULL,NULL),(150,'Manual neut %','2019-09-16 22:54:05',NULL,NULL,NULL),(150,'Neutrophils','2019-09-16 22:54:05',NULL,NULL,NULL),(151,'Absolute Neutrophils','2019-09-16 22:54:05',NULL,NULL,NULL),(151,'Neutrophil Abs','2019-09-16 22:54:05',NULL,NULL,NULL),(151,'Neutrophils (Absolute)','2019-09-16 22:54:05',NULL,NULL,NULL),(151,'Neutrophils Abs','2019-09-16 22:54:05',NULL,NULL,NULL),(151,'Neutrophils Absolute','2019-09-16 22:54:05',NULL,NULL,NULL),(152,'Lymphocytes','2019-09-16 22:54:05',NULL,NULL,NULL),(152,'Lymphs','2019-09-16 22:54:05',NULL,NULL,NULL),(152,'Manual lymph %','2019-09-16 22:54:05',NULL,NULL,NULL),(153,'Absolute Lymphocytes','2019-09-16 22:54:05',NULL,NULL,NULL),(153,'Lymphocyte abs','2019-09-16 22:54:05',NULL,NULL,NULL),(153,'Lymphocytes abs','2019-09-16 22:54:05',NULL,NULL,NULL),(153,'Lymphocytes absolute','2019-09-16 22:54:05',NULL,NULL,NULL),(153,'Lymphs (Absolute)','2019-09-16 22:54:05',NULL,NULL,NULL),(153,'Lymphs Abs','2019-09-16 22:54:05',NULL,NULL,NULL),(153,'Lymphs Absolute','2019-09-16 22:54:05',NULL,NULL,NULL),(154,'Monocytes','2019-09-16 22:54:05',NULL,NULL,NULL),(155,'Absolute Monocytes','2019-09-16 22:54:05',NULL,NULL,NULL),(155,'Monocyte Abs','2019-09-16 22:54:05',NULL,NULL,NULL),(155,'Monocytes (Absolute)','2019-09-16 22:54:05',NULL,NULL,NULL),(155,'Monocytes Abs','2019-09-16 22:54:05',NULL,NULL,NULL),(155,'Monocytes Absolute','2019-09-16 22:54:05',NULL,NULL,NULL),(155,'Monocytes(Absolute)','2019-09-16 22:54:05',NULL,NULL,NULL),(156,'Eos','2019-09-16 22:54:05',NULL,NULL,NULL),(156,'Eosinophils','2019-09-16 22:54:05',NULL,NULL,NULL),(157,'Absolute Eosinophils','2019-09-16 22:54:05',NULL,NULL,NULL),(157,'Eos (Absolute)','2019-09-16 22:54:05',NULL,NULL,NULL),(157,'Eos Abs','2019-09-16 22:54:05',NULL,NULL,NULL),(157,'Eos Absolute','2019-09-16 22:54:05',NULL,NULL,NULL),(157,'Eosinophil Abs','2019-09-16 22:54:05',NULL,NULL,NULL),(158,'Basophil','2019-09-16 22:54:05',NULL,NULL,NULL),(158,'Basophils','2019-09-16 22:54:05',NULL,NULL,NULL),(158,'Basos','2019-09-16 22:54:05',NULL,NULL,NULL),(159,'Absolute Basophils','2019-09-16 22:54:05',NULL,NULL,NULL),(159,'Baso (Absolute)','2019-09-16 22:54:05',NULL,NULL,NULL),(159,'Baso Abs','2019-09-16 22:54:05',NULL,NULL,NULL),(159,'Baso Absolute','2019-09-16 22:54:05',NULL,NULL,NULL),(162,'Immature Granulocytes','2019-09-16 22:54:05',NULL,NULL,NULL),(163,'immature grans (abs)','2019-09-16 22:54:05',NULL,NULL,NULL),(163,'Immature Grans Abs','2019-09-16 22:54:05',NULL,NULL,NULL),(200,'Cholesterol','2019-09-16 22:54:05',NULL,NULL,NULL),(200,'Cholesterol, Total','2019-09-16 22:54:05',NULL,NULL,NULL),(200,'Total Cholesterol','2019-09-16 22:54:05',NULL,NULL,NULL),(201,'hdl, cholesterol','2019-09-16 22:54:05',NULL,NULL,NULL),(201,'HDL-C','2019-09-16 22:54:05',NULL,NULL,NULL),(201,'HDLC','2019-09-16 22:54:05',NULL,NULL,NULL),(202,'Cholesterol Non HDL','2019-09-16 22:54:05',NULL,NULL,NULL),(202,'Cholesterol, Non-HDL','2019-09-16 22:54:05',NULL,NULL,NULL),(202,'Non-HDL Chol Calc','2019-09-16 22:54:05',NULL,NULL,NULL),(202,'non-hdl cholesterol (calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(203,'LDL (Calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(203,'LDL (Calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(203,'LDL Chol Direct','2019-09-16 22:54:05',NULL,NULL,NULL),(203,'LDL Cholesterol Calc','2019-09-16 22:54:05',NULL,NULL,NULL),(203,'LDL-C','2019-09-16 22:54:05',NULL,NULL,NULL),(203,'LDLC','2019-09-16 22:54:05',NULL,NULL,NULL),(204,'vldl (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(204,'VLDL Cholesterol Cal','2019-09-16 22:54:05',NULL,NULL,NULL),(204,'VLDL, (Calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(205,'Triglyceride','2019-09-16 22:54:05',NULL,NULL,NULL),(205,'Triglyceride nonfasting','2019-09-16 22:54:05',NULL,NULL,NULL),(205,'Triglyceride, nonfasting','2019-09-16 22:54:05',NULL,NULL,NULL),(206,'Chol hdlc ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(206,'CHOL/HDL','2019-09-16 22:54:05',NULL,NULL,NULL),(206,'Chol/hdl ratio (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(206,'CHOL/HDLC Ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(206,'cholesterol/hdl cholesterol ratio (calc.)','2019-09-16 22:54:05',NULL,NULL,NULL),(206,'T Chol HDL Ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(206,'T. Chol HDL Ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(206,'T. Chol/HDL Ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(207,'LDL HDL Ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(207,'LDL/HDL','2019-09-16 22:54:05',NULL,NULL,NULL),(207,'LDL/HDL Ratio','2019-09-16 22:54:05',NULL,NULL,NULL),(209,'hdl-p (total)','2019-09-16 22:54:05',NULL,NULL,NULL),(300,'Thyrotropin','2019-09-16 22:54:05',NULL,NULL,NULL),(300,'Thyrotropin Hormone','2019-09-16 22:54:05',NULL,NULL,NULL),(300,'TSH 3rd Gen','2019-09-16 22:54:05',NULL,NULL,NULL),(300,'TSH 3rd Gen.','2019-09-16 22:54:05',NULL,NULL,NULL),(300,'TSH 3rd Generation','2019-09-16 22:54:05',NULL,NULL,NULL),(300,'TSH 3rd, Gen.','2019-09-16 22:54:05',NULL,NULL,NULL),(300,'TSH Third Gen','2019-09-16 22:54:05',NULL,NULL,NULL),(300,'TSH Third Generation','2019-09-16 22:54:05',NULL,NULL,NULL),(300,'TSH, 3rd Gen.','2019-09-16 22:54:05',NULL,NULL,NULL),(301,'T3, Total','2019-09-16 22:54:05',NULL,NULL,NULL),(301,'Total T3','2019-09-16 22:54:05',NULL,NULL,NULL),(301,'Triiodothyronine','2019-09-16 22:54:05',NULL,NULL,NULL),(301,'Triiodothyronine (T3)','2019-09-16 22:54:05',NULL,NULL,NULL),(301,'Triiodothyronine (T3), total','2019-09-16 22:54:05',NULL,NULL,NULL),(301,'Triiodothyronine T3','2019-09-16 22:54:05',NULL,NULL,NULL),(301,'Triiodothyronine Total','2019-09-16 22:54:05',NULL,NULL,NULL),(302,'Free T3','2019-09-16 22:54:05',NULL,NULL,NULL),(302,'T3, Free','2019-09-16 22:54:05',NULL,NULL,NULL),(302,'Triiodothyronine (T3), Free','2019-09-16 22:54:05',NULL,NULL,NULL),(302,'Triiodothyronine Free','2019-09-16 22:54:05',NULL,NULL,NULL),(302,'Triiodothyronine Free Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(302,'Triiodothyronine,free,serum','2019-09-16 22:54:05',NULL,NULL,NULL),(303,'T4 (thyroxine), total','2019-09-16 22:54:05',NULL,NULL,NULL),(303,'T4 Thyroxine Total','2019-09-16 22:54:05',NULL,NULL,NULL),(303,'Thyroxine','2019-09-16 22:54:05',NULL,NULL,NULL),(303,'Thyroxine (T4)','2019-09-16 22:54:05',NULL,NULL,NULL),(303,'Thyroxine (T4) Total','2019-09-16 22:54:05',NULL,NULL,NULL),(303,'Thyroxine (T4), Total','2019-09-16 22:54:05',NULL,NULL,NULL),(303,'Thyroxine T4','2019-09-16 22:54:05',NULL,NULL,NULL),(303,'Thyroxine Total','2019-09-16 22:54:05',NULL,NULL,NULL),(303,'Total T4','2019-09-16 22:54:05',NULL,NULL,NULL),(304,'Free T4','2019-09-16 22:54:05',NULL,NULL,NULL),(304,'T4 Free Direct','2019-09-16 22:54:05',NULL,NULL,NULL),(304,'T4, Free','2019-09-16 22:54:05',NULL,NULL,NULL),(304,'T4,Free(Direct)','2019-09-16 22:54:05',NULL,NULL,NULL),(304,'Thyroxine (T4) Free','2019-09-16 22:54:05',NULL,NULL,NULL),(304,'Thyroxine (T4), Free','2019-09-16 22:54:05',NULL,NULL,NULL),(304,'Thyroxine Free','2019-09-16 22:54:05',NULL,NULL,NULL),(305,'T3 Resin Uptake','2019-09-16 22:54:05',NULL,NULL,NULL),(305,'T3, Uptake','2019-09-16 22:54:05',NULL,NULL,NULL),(305,'T3RU','2019-09-16 22:54:05',NULL,NULL,NULL),(306,'Antithyroglobulin AB','2019-09-16 22:54:05',NULL,NULL,NULL),(306,'TG Antibodies','2019-09-16 22:54:05',NULL,NULL,NULL),(306,'Thyroglobulin Antibodies','2019-09-16 22:54:05',NULL,NULL,NULL),(306,'Thyroglobulin, Antibody','2019-09-16 22:54:05',NULL,NULL,NULL),(307,'Thyroid peroxidase (tpo) ab','2019-09-16 22:54:05',NULL,NULL,NULL),(307,'thyroid peroxidase ab (tpo)','2019-09-16 22:54:05',NULL,NULL,NULL),(307,'Thyroid Peroxidase Antibodies','2019-09-16 22:54:05',NULL,NULL,NULL),(309,'Reverse T3','2019-09-16 22:54:05',NULL,NULL,NULL),(309,'Reverse T3, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(309,'Triiodothyronine Reverse','2019-09-16 22:54:05',NULL,NULL,NULL),(309,'Triiodothyronine Reverse LCMS/MS','2019-09-16 22:54:05',NULL,NULL,NULL),(309,'triiodothyronine, reverse - lc-ms/ms','2019-09-16 22:54:05',NULL,NULL,NULL),(310,'Free T4 Index T7','2019-09-16 22:54:05',NULL,NULL,NULL),(310,'Free Thyroxine Index','2019-09-16 22:54:05',NULL,NULL,NULL),(310,'fti (calc)','2019-09-16 22:54:05',NULL,NULL,NULL),(400,'Glycated hemoglobin','2019-09-16 22:54:05',NULL,NULL,NULL),(400,'Glycohemoglobin w/MBG','2019-09-16 22:54:05',NULL,NULL,NULL),(400,'Hb1c','2019-09-16 22:54:05',NULL,NULL,NULL),(400,'Hba1c','2019-09-16 22:54:05',NULL,NULL,NULL),(400,'HGB A1C','2019-09-16 22:54:05',NULL,NULL,NULL),(400,'Hgba1c','2019-09-16 22:54:05',NULL,NULL,NULL),(400,'Hgba1c%','2019-09-16 22:54:05',NULL,NULL,NULL),(401,'25-Hydroxyvitamin D3','2019-09-16 22:54:05',NULL,NULL,NULL),(401,'Vitamin D, 25 Hydroxy','2019-09-16 22:54:05',NULL,NULL,NULL),(401,'Vitamin D, 25-Hydroxy','2019-09-16 22:54:05',NULL,NULL,NULL),(401,'Vitamin D, 25-OH, Total, IA','2019-09-16 22:54:05',NULL,NULL,NULL),(402,'C-Reactive Protein, Cardiac','2019-09-16 22:54:05',NULL,NULL,NULL),(402,'CRP','2019-09-16 22:54:05',NULL,NULL,NULL),(402,'CRP, highly sensitive','2019-09-16 22:54:05',NULL,NULL,NULL),(403,'Homocyst(e)ine, Plasma','2019-09-16 22:54:05',NULL,NULL,NULL),(404,'Prostate Specific Ag, Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(404,'PSA Total','2019-09-16 22:54:05',NULL,NULL,NULL),(405,'B12','2019-09-16 22:54:05',NULL,NULL,NULL),(406,'Methylmalonic Acid, U','2019-09-16 22:54:05',NULL,NULL,NULL),(407,'MMA - Normalized','2019-09-16 22:54:05',NULL,NULL,NULL),(408,'Creatinine(Crt), U','2019-09-16 22:54:05',NULL,NULL,NULL),(410,'Folate (Folic Acid), Serum','2019-09-16 22:54:05',NULL,NULL,NULL),(417,'Cortisol, A.M.','2019-09-16 22:54:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `test_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `appointments` char(1) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `schedule` varchar(255) DEFAULT NULL,
  `admin` char(1) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `signin_dt` datetime DEFAULT NULL,
  `verify_token` varchar(255) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  `last_viewed_patient_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,1,'David','Potter','President','david10@davidjpotter.com','123456','','1','0',NULL,NULL,'1','$2b$10$wwGqVjGXvWDJUlnrNRtyf.Y64bLEmEL47gmX0NX/IS4Ix1U.FQ/ua',NULL,'18a0ccb0-e152-11e9-b02c-5ff8e88a082d','2019-09-18',1,'2019-10-01',1,2),(2,1,'Test','Test2','RN','test@test.com','1234','','1','1',NULL,NULL,'0','$2b$10$I6G2Fh.676v5bURjls9LreYce8mtDn0f87x1EZy5aqB.xL2lYN3Pa',NULL,'76e31120-dd9c-11e9-b576-cd653636cffb','2019-09-19',1,'2019-09-30',1,1),(3,2,'test2','test2','President','test2@test.com','','','1','1',NULL,NULL,'1','$2b$10$wwGqVjGXvWDJUlnrNRtyf.Y64bLEmEL47gmX0NX/IS4Ix1U.FQ/ua',NULL,'6a5083a0-dda3-11e9-b1a0-59fe0d3e9181','2019-09-18',1,'2019-09-23',1,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_calendar`
--

DROP TABLE IF EXISTS `user_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_calendar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `start_event` datetime DEFAULT NULL,
  `end_event` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `user_id` (`user_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_calendar`
--

LOCK TABLES `user_calendar` WRITE;
/*!40000 ALTER TABLE `user_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_log`
--

DROP TABLE IF EXISTS `user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_log` (
  `dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `page` varchar(100) DEFAULT NULL,
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_log`
--

LOCK TABLES `user_log` WRITE;
/*!40000 ALTER TABLE `user_log` DISABLE KEYS */;
INSERT INTO `user_log` VALUES ('2019-10-01 07:42:56',1,2,1,'patient'),('2019-10-01 08:10:43',1,2,1,'patient'),('2019-10-01 17:21:46',1,1,1,'patient'),('2019-10-01 19:17:04',1,1,1,'patient');
/*!40000 ALTER TABLE `user_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login` (
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `dt` datetime DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--

LOCK TABLES `user_login` WRITE;
/*!40000 ALTER TABLE `user_login` DISABLE KEYS */;
INSERT INTO `user_login` VALUES (2,1,'2019-10-01 07:21:00','::1'),(2,1,'2019-10-01 08:10:26','::1'),(2,1,'2019-10-01 15:48:39','::1'),(1,1,'2019-10-01 16:55:42','::1');
/*!40000 ALTER TABLE `user_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_schedule`
--

DROP TABLE IF EXISTS `user_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `start_event` datetime DEFAULT NULL,
  `end_event` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `client_id` (`client_id`),
  KEY `start_event` (`start_event`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_schedule`
--

LOCK TABLES `user_schedule` WRITE;
/*!40000 ALTER TABLE `user_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_sql`
--

DROP TABLE IF EXISTS `user_sql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_sql` (
  `dt` datetime DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `statement` varchar(1000) DEFAULT NULL,
  `arg` varchar(1000) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sql`
--

LOCK TABLES `user_sql` WRITE;
/*!40000 ALTER TABLE `user_sql` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_sql` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-02 20:16:46
