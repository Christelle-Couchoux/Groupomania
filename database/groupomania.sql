-- MySQL dump 10.13  Distrib 8.0.12, for macos10.13 (x86_64)
--
-- Host: localhost    Database: groupomania
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Comments`
--

DROP TABLE IF EXISTS `Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Comments` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `comment_text` tinytext,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `fk_user_id` smallint(4) unsigned NOT NULL,
  `fk_post_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `fk_user_id` (`fk_user_id`),
  KEY `fk_post_id` (`fk_post_id`),
  KEY `comment_createdAt` (`createdAt`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`fk_post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comments`
--

LOCK TABLES `Comments` WRITE;
/*!40000 ALTER TABLE `Comments` DISABLE KEYS */;
INSERT INTO `Comments` VALUES (1,'Lorem ipsum dolor sit amet.','2021-08-13 14:13:53','2021-08-13 14:13:53',20,6),(2,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','2021-08-13 14:14:53','2021-08-13 14:14:53',8,6),(4,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','2021-08-13 14:17:04','2021-08-13 14:17:04',18,9),(5,'Lorem ipsum dolor sit amet, consectetur adipiscing.','2021-08-13 14:26:53','2021-08-13 14:26:53',18,6),(6,'Lorem ipsum dolor sit amet, consectetur adipiscing. Lorem ipsum dolor sit amet, consectetur adipiscing.','2021-08-13 14:27:11','2021-08-13 14:27:11',18,8),(7,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ','2021-08-13 14:54:12','2021-08-13 14:54:12',16,10),(9,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.','2021-08-13 15:48:03','2021-08-13 15:48:03',8,9),(10,'Lorem ipsum dolor sit amet, consectetur.','2021-08-13 15:51:04','2021-08-13 15:51:04',16,12),(11,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.','2021-08-13 15:51:35','2021-08-13 15:51:35',16,9),(12,'Lorem ipsum dolor sit amet.','2021-08-13 15:52:00','2021-08-13 15:52:00',16,13),(16,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.','2021-08-16 16:09:56','2021-08-16 16:09:56',6,8),(19,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ','2021-08-16 17:18:38','2021-08-16 17:18:38',16,8),(20,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','2021-08-17 09:36:45','2021-08-17 09:36:45',24,14),(22,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','2021-08-17 09:40:44','2021-08-17 09:40:44',24,9),(24,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.','2021-08-17 16:03:00','2021-08-17 16:03:00',28,14),(25,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.','2021-08-17 16:06:08','2021-08-17 16:06:08',6,14),(26,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.','2021-08-18 07:35:38','2021-08-18 07:35:38',8,34),(27,'commentaire','2021-08-18 09:46:27','2021-08-18 09:46:27',8,35),(30,'Lorem ipsum dolor sit amet.','2021-08-18 12:31:30','2021-08-18 12:31:30',24,36),(31,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit.','2021-08-18 12:33:12','2021-08-18 12:33:12',24,34),(32,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ','2021-08-18 12:33:54','2021-08-18 12:33:54',24,33),(33,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.','2021-08-18 13:21:45','2021-08-18 13:21:45',16,36),(34,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis.','2021-08-18 13:23:07','2021-08-18 13:23:07',16,34),(35,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n','2021-08-18 13:31:24','2021-08-18 13:31:24',28,37),(36,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.','2021-08-18 13:31:46','2021-08-18 13:31:46',28,34),(37,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','2021-08-18 13:32:35','2021-08-18 13:32:35',28,38),(38,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','2021-08-18 14:31:41','2021-08-18 14:31:41',22,40),(39,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.','2021-08-18 14:33:18','2021-08-18 14:33:18',22,36),(40,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.','2021-08-18 14:34:11','2021-08-18 14:34:11',22,33),(41,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim.','2021-08-18 14:36:18','2021-08-18 14:36:18',20,34),(42,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','2021-08-18 14:36:52','2021-08-18 14:36:52',20,38),(43,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','2021-08-18 14:38:19','2021-08-18 14:38:19',20,36),(44,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','2021-08-18 14:40:34','2021-08-18 14:40:34',20,26),(45,'Lorem ipsum dolor sit amet, consectetur.','2021-08-18 14:43:11','2021-08-18 14:43:11',6,42),(46,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.','2021-08-18 15:08:31','2021-08-18 15:08:31',16,47),(47,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.','2021-08-18 15:14:52','2021-08-18 15:14:52',16,45),(49,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.','2021-08-18 17:20:33','2021-08-18 17:20:33',18,31),(50,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ','2021-08-19 08:17:10','2021-08-19 08:17:10',20,55);
/*!40000 ALTER TABLE `Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Post_likes`
--

DROP TABLE IF EXISTS `Post_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Post_likes` (
  `post_like_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `fk_user_id` smallint(4) unsigned NOT NULL,
  `fk_post_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`post_like_id`),
  KEY `fk_user_id` (`fk_user_id`),
  KEY `fk_post_id` (`fk_post_id`),
  KEY `post_like_createdAt` (`createdAt`),
  CONSTRAINT `post_likes_ibfk_1` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `post_likes_ibfk_2` FOREIGN KEY (`fk_post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Post_likes`
--

LOCK TABLES `Post_likes` WRITE;
/*!40000 ALTER TABLE `Post_likes` DISABLE KEYS */;
INSERT INTO `Post_likes` VALUES (3,'2021-08-16 15:54:47','2021-08-16 15:54:47',18,14),(4,'2021-08-16 15:56:05','2021-08-16 15:56:05',6,14),(14,'2021-08-16 16:00:01','2021-08-16 16:00:01',6,13),(18,'2021-08-16 16:05:25','2021-08-16 16:05:25',6,12),(21,'2021-08-16 17:16:13','2021-08-16 17:16:13',6,8),(30,'2021-08-17 09:41:20','2021-08-17 09:41:20',24,9),(39,'2021-08-17 14:31:14','2021-08-17 14:31:14',24,31),(41,'2021-08-17 14:36:14','2021-08-17 14:36:14',24,14),(43,'2021-08-17 15:05:28','2021-08-17 15:05:28',24,13),(44,'2021-08-17 15:07:46','2021-08-17 15:07:46',24,12),(45,'2021-08-17 16:01:57','2021-08-17 16:01:57',28,31),(46,'2021-08-17 16:03:35','2021-08-17 16:03:35',28,9),(47,'2021-08-17 16:06:54','2021-08-17 16:06:54',6,6),(51,'2021-08-18 07:59:11','2021-08-18 07:59:11',8,34),(52,'2021-08-18 07:59:37','2021-08-18 07:59:37',8,31),(56,'2021-08-18 08:19:10','2021-08-18 08:19:10',8,35),(57,'2021-08-18 12:16:36','2021-08-18 12:16:36',18,35),(58,'2021-08-18 12:30:53','2021-08-18 12:30:53',24,36),(59,'2021-08-18 12:32:35','2021-08-18 12:32:35',24,8),(60,'2021-08-18 13:21:26','2021-08-18 13:21:26',16,37),(61,'2021-08-18 13:21:35','2021-08-18 13:21:35',16,36),(62,'2021-08-18 13:22:46','2021-08-18 13:22:46',16,6),(63,'2021-08-18 13:22:57','2021-08-18 13:22:57',16,34),(64,'2021-08-18 13:24:38','2021-08-18 13:24:38',16,35),(65,'2021-08-18 13:25:23','2021-08-18 13:25:23',16,33),(66,'2021-08-18 13:30:59','2021-08-18 13:30:59',28,39),(67,'2021-08-18 13:31:16','2021-08-18 13:31:16',28,37),(68,'2021-08-18 13:32:06','2021-08-18 13:32:06',28,13),(69,'2021-08-18 13:32:38','2021-08-18 13:32:38',28,38),(70,'2021-08-18 14:31:30','2021-08-18 14:31:30',22,40),(71,'2021-08-18 14:31:59','2021-08-18 14:31:59',22,14),(73,'2021-08-18 14:33:22','2021-08-18 14:33:22',22,36),(74,'2021-08-18 14:33:47','2021-08-18 14:33:47',22,38),(75,'2021-08-18 14:34:32','2021-08-18 14:34:32',22,37),(76,'2021-08-18 14:35:49','2021-08-18 14:35:49',20,43),(77,'2021-08-18 14:36:02','2021-08-18 14:36:02',20,34),(78,'2021-08-18 14:37:13','2021-08-18 14:37:13',20,33),(79,'2021-08-18 14:38:08','2021-08-18 14:38:08',20,36),(80,'2021-08-18 14:38:44','2021-08-18 14:38:44',20,42),(81,'2021-08-18 14:41:40','2021-08-18 14:41:40',6,44),(82,'2021-08-18 14:41:47','2021-08-18 14:41:47',6,42),(83,'2021-08-18 14:42:01','2021-08-18 14:42:01',6,10),(84,'2021-08-18 14:43:45','2021-08-18 14:43:45',6,43),(86,'2021-08-18 15:14:30','2021-08-18 15:14:30',16,47),(87,'2021-08-18 15:14:38','2021-08-18 15:14:38',16,41),(88,'2021-08-18 15:14:46','2021-08-18 15:14:46',16,45),(89,'2021-08-18 15:15:28','2021-08-18 15:15:28',16,44),(90,'2021-08-18 15:36:22','2021-08-18 15:36:22',6,45),(92,'2021-08-18 17:19:27','2021-08-18 17:19:27',18,46),(93,'2021-08-18 17:20:27','2021-08-18 17:20:27',18,31),(94,'2021-08-19 07:42:09','2021-08-19 07:42:09',28,35),(95,'2021-08-19 07:59:50','2021-08-19 07:59:50',22,54),(96,'2021-08-19 08:00:29','2021-08-19 08:00:29',22,47),(97,'2021-08-19 08:17:12','2021-08-19 08:17:12',20,55),(98,'2021-08-19 08:18:48','2021-08-19 08:18:48',20,52),(99,'2021-08-19 08:18:58','2021-08-19 08:18:58',20,46),(100,'2021-08-19 11:57:27','2021-08-19 11:57:27',20,56),(107,'2021-08-20 14:47:24','2021-08-20 14:47:24',16,56);
/*!40000 ALTER TABLE `Post_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Posts`
--

DROP TABLE IF EXISTS `Posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Posts` (
  `post_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_file` varchar(255) DEFAULT NULL,
  `post_text` tinytext,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `fk_user_id` smallint(4) unsigned NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `fk_user_id` (`fk_user_id`),
  KEY `post_createdAt` (`createdAt`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Posts`
--

LOCK TABLES `Posts` WRITE;
/*!40000 ALTER TABLE `Posts` DISABLE KEYS */;
INSERT INTO `Posts` VALUES (6,'http://localhost:3000/images/mesange-charbo.jpg1628863748905.jpg','Mésange charbonnière.','2021-08-13 14:09:08','2021-08-13 14:09:08',28),(8,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','2021-08-13 14:15:33','2021-08-13 14:15:33',8),(9,'http://localhost:3000/images/whale.gif1628864202572.gif','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.','2021-08-13 14:16:42','2021-08-13 14:16:42',18),(10,'','Lorem ipsum dolor sit amet, consectetur adipiscing.','2021-08-13 14:27:36','2021-08-13 14:27:36',18),(12,'http://localhost:3000/images/moineau-20200412_Jardin_455.jpg1628869562607.jpg','','2021-08-13 15:46:02','2021-08-13 15:46:02',20),(13,'http://localhost:3000/images/seal-hiccup.gif1628869654017.gif','','2021-08-13 15:47:34','2021-08-13 15:47:34',8),(14,'http://localhost:3000/images/papillon-20200427_Jardin_920.jpg1628869845101.jpg','Lorem ipsum dolor sit amet, consectetur.','2021-08-13 15:50:45','2021-08-13 15:50:45',16),(26,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ','2021-08-17 09:11:57','2021-08-17 09:11:57',24),(31,'http://localhost:3000/images/merle-20200508_Jardin_1115.jpg1629192821797.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ','2021-08-17 09:33:41','2021-08-17 09:33:41',24),(33,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod .','2021-08-17 16:02:37','2021-08-17 16:02:37',28),(34,'http://localhost:3000/images/mesangebleue-20200415_Jardin_635.jpg1629216292100.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ','2021-08-17 16:04:52','2021-08-17 16:04:52',6),(35,'http://localhost:3000/images/papillon-20200719_Jardin_2992.jpg1629272103632.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim.','2021-08-18 07:35:03','2021-08-18 07:35:03',8),(36,'http://localhost:3000/images/penguin-bubbles.gif1629288939174.gif','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.','2021-08-18 12:15:39','2021-08-18 12:15:39',18),(37,'http://localhost:3000/images/herisson-20210813_jardin_1268.jpg1629289846424.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit.','2021-08-18 12:30:46','2021-08-18 12:30:46',24),(38,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex.','2021-08-18 13:21:20','2021-08-18 13:21:20',16),(39,'http://localhost:3000/images/verdier-20200729_Jardin_3281-2.jpg1629293051536.jpg','','2021-08-18 13:24:11','2021-08-18 13:24:11',16),(40,'http://localhost:3000/images/mesangelonguequeue-20201230_Jardin_3808.jpg1629293447380.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.','2021-08-18 13:30:47','2021-08-18 13:30:47',28),(41,'http://localhost:3000/images/hamster.gif1629297039722.gif','','2021-08-18 14:30:39','2021-08-18 14:30:39',22),(42,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.','2021-08-18 14:31:18','2021-08-18 14:31:18',22),(43,'http://localhost:3000/images/bzz-20200714_Jardin_2896.jpg1629297315163.jpg','Lorem ipsum dolor sit amet, consectetur.','2021-08-18 14:35:15','2021-08-18 14:35:15',22),(44,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim.','2021-08-18 14:37:01','2021-08-18 14:37:01',20),(45,'http://localhost:3000/images/hedgehog-running.gif1629297594206.gif','Lorem ipsum dolor sit amet, consectetur adipiscing.','2021-08-18 14:39:54','2021-08-18 14:39:54',20),(46,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ','2021-08-18 14:41:16','2021-08-18 14:41:16',6),(47,'http://localhost:3000/images/rougegorge-20210207_Jardin_0304.jpg1629297761872.jpg','','2021-08-18 14:42:41','2021-08-18 14:42:41',6),(48,'http://localhost:3000/images/pigeon-20210207_Jardin_0299.jpg1629299650233.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.','2021-08-18 15:14:10','2021-08-18 15:14:10',16),(52,'http://localhost:3000/images/bzz_-20200518_Jardin_1223.jpg1629307122477.jpg','','2021-08-18 17:18:42','2021-08-18 17:18:42',18),(53,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.','2021-08-18 17:19:11','2021-08-18 17:19:11',18),(54,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.','2021-08-19 07:57:22','2021-08-19 07:57:22',28),(55,'http://localhost:3000/images/redpanda-pumpkin.gif1629359961005.gif','Lorem ipsum dolor sit amet, consectetur adipiscing.','2021-08-19 07:59:21','2021-08-19 07:59:21',22),(56,'http://localhost:3000/images/bzz-20200504_Jardin_1044.jpg1629360999637.jpg','','2021-08-19 08:16:39','2021-08-19 08:16:39',20);
/*!40000 ALTER TABLE `Posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Roles` (
  `role_id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) NOT NULL,
  `role_description` tinytext,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES (1,'super_admin','For web dev in charge of database.','2021-08-13 14:59:11','2021-08-13 14:59:11'),(2,'admin','For application admin.','2021-08-13 14:59:11','2021-08-13 14:59:11'),(3,'user','For standard user.','2021-08-13 14:59:11','2021-08-13 14:59:11');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Users` (
  `user_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(16) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_photo` varchar(255) DEFAULT 'http://127.0.0.1:3000/images/default-user-icon.jpg',
  `bio` tinytext,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `fk_user_role` varchar(20) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `pseudo` (`pseudo`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_user_role` (`fk_user_role`),
  KEY `user_createdAt` (`createdAt`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`fk_user_role`) REFERENCES `roles` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'Admin','admin@groupomania.fr','$2b$10$BGJ68jRvoWhI/jygCq0EEeluc0/gPSP4ivIEvFt5iC65odUPTfOXS','http://127.0.0.1:3000/images/default-user-icon.jpg','Le compte admin peut supprimer n\'importe quel message, commentaire ou compte utilisateur.','2021-08-13 12:59:48','2021-08-13 13:15:50','admin'),(6,'Vert menthe','vertmenthe@gmail.com','$2b$10$/XEBuvXdyr5RmItWY.l8WuoshhUQ4KOzH/karpK.hGzIpTPqJ4/Ii','http://localhost:3000/images/very_liht_green.png1628860939558.png','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.','2021-08-13 13:21:52','2021-08-13 13:22:36','user'),(8,'Bleu très clair','bleutresclair@gmail.com','$2b$10$TGqEwGZ1Gl/SRjuudmm3B.AyuEEirln0tMsJWEPsxV2SVmxOqoZGK','http://localhost:3000/images/very_light_blue.png1628861095070.png','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ','2021-08-13 13:24:24','2021-08-13 13:25:15','user'),(10,'Bleu foncé','bleufonce@gmail.com','$2b$10$ZB82ToUypdBGnmwlkfa2t.5X63m2To8rasKI2EgyPY6vtMoXTlufq','http://localhost:3000/images/dark_blue.jpeg1628861272113.jpg','Lorem ipsum dolor sit amet.','2021-08-13 13:27:21','2021-08-13 13:30:38','user'),(16,'Violet clair','violetclair@gmail.com','$2b$10$bALyQlh3gSRySWIL0N/ZEOzgr6JtbYVsqjfQMcwX6NxcRkPbEeVDu','http://localhost:3000/images/light_purple.png1629472089406.png','Lorem ipsum dolor sit amet, consectetur adipiscing elit.','2021-08-13 13:35:51','2021-08-20 15:08:09','user'),(18,'Bleu','bleu@gmail.com','$2b$10$yb3jOPKvLFf5sWZYaqztk.GjxYboIWOlyJ49zPZIQsDBmYjrq6Cae','http://localhost:3000/images/blue.png1628862336734.png','Lorem ipsum.','2021-08-13 13:45:07','2021-08-13 13:45:36','user'),(20,'Vert clair','vertclair@gmail.com','$2b$10$RhfwNj0bnoIAlR.wI.aZtend1KDlx7C8oDwGPoIOCNCJweaweucRi','http://localhost:3000/images/light_green.png1628862393020.png','Lorem ipsum dolor sit amet, consectetur adipiscing elit.','2021-08-13 13:46:08','2021-08-13 13:46:33','user'),(22,'Bleu clair','bleuclair@gmail.com','$2b$10$vpxBS.Ss.NxDTZ/jrbS1K.GkPtbt7ZNsTNXOKMvUW6fLc3vWnk6pu','http://localhost:3000/images/light_blue.png1628862439957.png',NULL,'2021-08-13 13:47:04','2021-08-13 13:47:19','user'),(24,'Vert','vert@gmail.com','$2b$10$lg5ws9OFCclF.osNXZd87.u9BsdGC3.eFbL3ikcROK8GYsjdC0iRO','http://localhost:3000/images/green.png1628862893601.png','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ','2021-08-13 13:54:22','2021-08-17 15:08:56','user'),(26,'Vert foncé','vertfonce@gmail.com','$2b$10$MOyDM163ajZXU0J5Omk5U.QYktOmd8NyfJ/jWeM1aulcDy0niWPbq','http://localhost:3000/images/dark_green.png1628862958185.png','','2021-08-13 13:55:44','2021-08-13 13:55:58','user'),(28,'Violet','violet@gmail.com','$2b$10$jNWowv/xioUeTsZK2nHRee8qlWv9s9MuiJFY8k.3YkIM6lco8vO.G','http://localhost:3000/images/dark_purple.png1628863579848.png','Lorem.','2021-08-13 14:05:54','2021-08-13 14:06:19','user');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_posts_with_comments_count`
--

DROP TABLE IF EXISTS `v_posts_with_comments_count`;
/*!50001 DROP VIEW IF EXISTS `v_posts_with_comments_count`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_posts_with_comments_count` AS SELECT 
 1 AS `post_id`,
 1 AS `post_file`,
 1 AS `post_text`,
 1 AS `post_createdAt`,
 1 AS `post_fk_user_id`,
 1 AS `comments_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_posts_with_likes_count`
--

DROP TABLE IF EXISTS `v_posts_with_likes_count`;
/*!50001 DROP VIEW IF EXISTS `v_posts_with_likes_count`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_posts_with_likes_count` AS SELECT 
 1 AS `post_id`,
 1 AS `post_file`,
 1 AS `post_text`,
 1 AS `post_createdAt`,
 1 AS `post_fk_user_id`,
 1 AS `post_likes_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'groupomania'
--
/*!50003 DROP PROCEDURE IF EXISTS `create_comment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_comment`(IN p_user_id INT(4), IN p_post_id INT, IN p_text VARCHAR(255))
BEGIN
    INSERT INTO Comments (fk_user_id, fk_post_id, post_text, createdAt, updatedAt)
    VALUES (p_user_id, p_post_id, p_text,  NOW(), NOW());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_post`(IN p_file VARCHAR(255), IN p_text VARCHAR(255), IN p_user_id INT(4))
BEGIN
    INSERT INTO Posts (post_file, post_text, fk_user_id, createdAt, updatedAt)
    VALUES (p_file, p_text, p_user_id, NOW(), NOW());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_comments_of_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_comments_of_user`(IN p_user_id INT)
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id AS post_user_id, 
        PostUsers.pseudo AS post_user_pseudo, PostUsers.user_photo AS post_user_photo, Posts.createdAt AS post_createdAt, 
        Comments.comment_id  AS comment_id, Comments.comment_text AS comment_text, Comments.fk_user_id AS comment_user_id, 
        CommentUsers.pseudo AS comment_user_pseudo, CommentUsers.user_photo AS comment_user_photo, Comments.createdAt AS comment_createdAt, 
        Comments.createdAt AS createdAt, Comments.fk_user_id AS targetedUser
    FROM Posts
    INNER JOIN Comments
    ON Comments.fk_post_id = Posts.post_id
    INNER JOIN Users AS CommentUsers
    ON Comments.fk_user_id = CommentUsers.user_id
    INNER JOIN Users AS PostUsers
    ON Posts.fk_user_id = PostUsers.user_id
    HAVING targetedUser = p_user_id
    
    ORDER BY createdAt DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_likes_of_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_likes_of_user`(IN p_user_id INT)
BEGIN
    SELECT  Posts.post_id,
            Posts.post_file,
            Posts.post_text,
            Posts.createdAt AS post_createdAt,
            Posts.fk_user_id AS post_user_id, 
            PostUsers.pseudo AS post_user_pseudo, 
            PostUsers.user_photo AS post_user_photo, 
            Post_likes.post_like_id  AS post_like_id, 
            Post_likes.fk_user_id AS post_like_user_id,
            Post_likes.createdAt AS post_like_createdAt, 
            Post_likes.fk_user_id AS targetedUser,
            LikeUsers.pseudo AS post_like_user_pseudo, 
            LikeUsers.user_photo AS post_like_user_photo 
    FROM Posts
    INNER JOIN Post_likes
    ON Post_likes.fk_post_id = Posts.post_id
    INNER JOIN Users AS LikeUsers
    ON Post_likes.fk_user_id = LikeUsers.user_id
    INNER JOIN Users AS PostUsers
    ON Posts.fk_user_id = PostUsers.user_id
    HAVING targetedUser = p_user_id
    
    ORDER BY post_like_createdAt DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_posts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_posts`()
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, Users.pseudo, Users.user_photo, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id
    ORDER BY Posts.createdAt DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_posts_of_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_posts_of_user`(IN p_user_id INT)
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, 
        Users.pseudo, Users.user_photo, Users.bio, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id
    WHERE Posts.fk_user_id = p_user_id

    ORDER BY Posts.createdAt DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_comments_count_of_one_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_comments_count_of_one_post`(IN p_post_id INT)
BEGIN
    SELECT  View.post_id,  
            View.comments_count
    FROM V_posts_with_comments_count AS View
    WHERE View.post_id = p_post_id

    ORDER BY View.post_createdAt DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_comments_of_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_comments_of_post`(IN p_post_id INT)
BEGIN
    SELECT Comments.comment_id, Comments.comment_text, Comments.fk_post_id, Posts.post_id, Users.pseudo, Users.user_photo, Users.user_id, Comments.createdAt
    FROM Comments
    INNER JOIN Posts 
    ON Comments.fk_post_id = Posts.post_id
    INNER JOIN Users
    ON Comments.fk_user_id = Users.user_id
    WHERE Posts.post_id = p_post_id
    ORDER BY Comments.createdAt DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_likes_count_of_one_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_likes_count_of_one_post`(IN p_post_id INT)
BEGIN
    SELECT  View.post_id,  
            View.post_likes_count
    FROM V_posts_with_likes_count AS View
    WHERE View.post_id = p_post_id

    ORDER BY View.post_createdAt DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_one_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_one_post`(IN p_post_id INT)
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, posts.createdAt, Users.user_id, Users.pseudo, Users.user_photo
    FROM Posts
    INNER JOIN Users
    ON Posts.fk_user_id = Users.user_id
    WHERE Posts.post_id = p_post_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_info`(IN p_user_id INT)
BEGIN
    SELECT Users.pseudo, Users.user_photo, Users.bio, Users.user_id
    FROM Users
    WHERE Users.user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_posts_with_comments_count`
--

/*!50001 DROP VIEW IF EXISTS `v_posts_with_comments_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_posts_with_comments_count` (`post_id`,`post_file`,`post_text`,`post_createdAt`,`post_fk_user_id`,`comments_count`) AS select `posts`.`post_id` AS `post_id`,`posts`.`post_file` AS `post_file`,`posts`.`post_text` AS `post_text`,`posts`.`createdAt` AS `createdAt`,`posts`.`fk_user_id` AS `fk_user_id`,count(`comments`.`comment_id`) AS `COUNT(Comments.comment_id)` from (`posts` left join `comments` on((`posts`.`post_id` = `comments`.`fk_post_id`))) group by `posts`.`post_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_posts_with_likes_count`
--

/*!50001 DROP VIEW IF EXISTS `v_posts_with_likes_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_posts_with_likes_count` (`post_id`,`post_file`,`post_text`,`post_createdAt`,`post_fk_user_id`,`post_likes_count`) AS select `posts`.`post_id` AS `post_id`,`posts`.`post_file` AS `post_file`,`posts`.`post_text` AS `post_text`,`posts`.`createdAt` AS `createdAt`,`posts`.`fk_user_id` AS `fk_user_id`,count(`post_likes`.`post_like_id`) AS `COUNT(Post_likes.post_like_id)` from (`posts` left join `post_likes` on((`posts`.`post_id` = `post_likes`.`fk_post_id`))) group by `posts`.`post_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-21 15:25:41
