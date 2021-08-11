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
-- Table structure for table `Comment_likes`
--

DROP TABLE IF EXISTS `Comment_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Comment_likes` (
  `comment_like_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `fk_user_id` int(4) NOT NULL,
  `fk_comment_id` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`comment_like_id`),
  KEY `comment_like_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comment_likes`
--

LOCK TABLES `Comment_likes` WRITE;
/*!40000 ALTER TABLE `Comment_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `Comment_likes` ENABLE KEYS */;
UNLOCK TABLES;
--
-- WARNING: old server version. The following dump may be incomplete.
--
DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `after_insert_comment_likes` AFTER INSERT ON `Comment_likes` FOR EACH ROW BEGIN
    INSERT INTO Notifications (type, fk_recipient_id, fk_sender_id, original_text, createdAt)
    SELECT ('comment_like', Comments.fk_user_id, Comment_likes.fk_user_id, Comments.comment_text, Comment_likes.createdAt )
    FROM Comment_likes
    INNER JOIN Comment ON Comments.comment_id = Comment_likes.fk_comment_id;
END */;;
DELIMITER ;

--
-- Table structure for table `Comments`
--

DROP TABLE IF EXISTS `Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_text` varchar(255) DEFAULT NULL,
  `fk_user_id` int(4) NOT NULL,
  `fk_post_id` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_createdAt` (`createdAt`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comments`
--

LOCK TABLES `Comments` WRITE;
/*!40000 ALTER TABLE `Comments` DISABLE KEYS */;
INSERT INTO `Comments` VALUES (1,'commentaire',13,26,'2021-08-10 12:47:39','2021-08-10 12:47:39'),(2,'commentaire commentaire',11,26,'2021-08-10 12:48:13','2021-08-10 12:48:13'),(3,'nouveau commentaire',11,26,'2021-08-10 13:33:24','2021-08-10 13:33:24'),(4,'commentaire commentaire\ncommentaire',11,30,'2021-08-10 18:14:29','2021-08-10 18:14:29'),(5,'uij oije  poe` i 28eup \'ou',13,36,'2021-08-11 12:35:04','2021-08-11 12:35:04'),(6,'hg podouf i1je foi2',13,34,'2021-08-11 12:36:23','2021-08-11 12:36:23'),(7,'j;lj ;',13,52,'2021-08-11 12:41:14','2021-08-11 12:41:14');
/*!40000 ALTER TABLE `Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notifications`
--

DROP TABLE IF EXISTS `Notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(12) DEFAULT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `fk_recipient_id` int(4) NOT NULL,
  `fk_sender_id` int(4) NOT NULL,
  `original_text` varchar(255) DEFAULT NULL,
  `original_file` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `notification_created_at` (`created_at`),
  KEY `notification_createdAt` (`createdAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notifications`
--

LOCK TABLES `Notifications` WRITE;
/*!40000 ALTER TABLE `Notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `Notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Post_likes`
--

DROP TABLE IF EXISTS `Post_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Post_likes` (
  `post_like_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `fk_user_id` int(4) NOT NULL,
  `fk_post_id` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`post_like_id`),
  KEY `post_like_created_at` (`created_at`),
  KEY `post_like_createdAt` (`createdAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Post_likes`
--

LOCK TABLES `Post_likes` WRITE;
/*!40000 ALTER TABLE `Post_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `Post_likes` ENABLE KEYS */;
UNLOCK TABLES;
--
-- WARNING: old server version. The following dump may be incomplete.
--
DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `after_insert_post_likes` AFTER INSERT ON `Post_likes` FOR EACH ROW BEGIN
    INSERT INTO Notifications (type, fk_recipient_id, fk_sender_id, original_text, createdAt)
    SELECT ('post_like', Posts.fk_user_id, Post_likes.fk_user_id, Posts.post_text, Post_likes.createdAt)
    FROM Post_likes
    INNER JOIN Posts ON Posts.post_id = Post_likes.fk_post_id;
END */;;
DELIMITER ;

--
-- Table structure for table `Posts`
--

DROP TABLE IF EXISTS `Posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Posts` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_file` varchar(50) DEFAULT NULL,
  `post_text` varchar(255) DEFAULT NULL,
  `fk_user_id` int(4) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `post_createdAt` (`createdAt`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Posts`
--

LOCK TABLES `Posts` WRITE;
/*!40000 ALTER TABLE `Posts` DISABLE KEYS */;
INSERT INTO `Posts` VALUES (4,NULL,'test test test',13,'2021-08-08 15:52:08','2021-08-08 15:52:08'),(5,NULL,'test test test',13,'2021-08-08 15:52:46','2021-08-08 15:52:46'),(6,'','is it working?',13,'2021-08-08 15:54:39','2021-08-08 15:54:39'),(7,'','what about now?',13,'2021-08-08 15:55:13','2021-08-08 15:55:13'),(8,'','and now?',13,'2021-08-08 18:02:23','2021-08-08 18:02:23'),(9,'','new message',2,'2021-08-09 09:50:11','2021-08-09 09:50:11'),(10,'','new message',4,'2021-08-09 09:50:31','2021-08-09 09:50:31'),(11,'','Hello !',13,'2021-08-09 11:25:56','2021-08-09 11:25:56'),(12,'','hello hello',13,'2021-08-09 11:30:31','2021-08-09 11:30:31'),(15,'','message sans photo',13,'2021-08-09 11:53:24','2021-08-09 11:53:24'),(16,'','message',13,'2021-08-09 11:53:50','2021-08-09 11:53:50'),(17,'','bla bla bla',2,'2021-08-09 11:58:28','2021-08-09 11:58:28'),(18,'','wqefwefwf',2,'2021-08-09 12:17:18','2021-08-09 12:17:18'),(19,'','dbcpid ijpo ',2,'2021-08-09 12:18:49','2021-08-09 12:18:49'),(20,'','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',2,'2021-08-09 14:45:14','2021-08-09 14:45:14'),(23,'','HAAAAAAAAAAAAAAAAAAAAAAAAAA',1,'2021-08-09 15:22:35','2021-08-09 15:22:35'),(24,'','efwefwfd',4,'2021-08-10 07:59:55','2021-08-10 07:59:55'),(25,'','wefv diuyr iwudpxoi oihdiufx  oi pije i  oijog',19,'2021-08-10 09:27:36','2021-08-10 09:27:36'),(26,'','test',21,'2021-08-10 09:42:47','2021-08-10 09:42:47'),(27,'','test test test',23,'2021-08-10 09:46:07','2021-08-10 09:46:07'),(30,'','message',11,'2021-08-10 13:51:22','2021-08-10 13:51:22'),(31,'','message message',11,'2021-08-10 13:51:30','2021-08-10 13:51:30'),(32,'','message sans photo',11,'2021-08-10 17:53:21','2021-08-10 17:53:21'),(33,'','why aren\'t images fucking working?!',25,'2021-08-11 07:51:50','2021-08-11 07:51:50'),(34,'','sdc iojo ijn ijfug \n\nwefjbp o',27,'2021-08-11 08:38:25','2021-08-11 08:38:25'),(35,'','message sans photo',25,'2021-08-11 08:39:45','2021-08-11 08:39:45'),(36,'','message sans photo ygi pok[pl,',25,'2021-08-11 08:40:56','2021-08-11 08:40:56'),(37,'','message avec photo par Postman',25,'2021-08-11 08:42:41','2021-08-11 08:42:41'),(38,'','message avec photo par Postman',25,'2021-08-11 08:46:44','2021-08-11 08:46:44'),(41,'','time should be 12:01pm',13,'2021-08-11 10:01:07','2021-08-11 10:01:07'),(42,'','12:02',13,'2021-08-11 10:02:41','2021-08-11 10:02:41'),(44,'','arghhhhhhhhhhhhhhhhhhhhhhhhhhh',13,'2021-08-11 11:10:49','2021-08-11 11:10:49'),(51,'','ytf upo op[o ',13,'2021-08-11 11:45:42','2021-08-11 11:45:42'),(56,'','test',13,'2021-08-11 12:52:26','2021-08-11 12:52:26'),(59,'','pourquoi seulement le texte marche?????????',13,'2021-08-11 13:02:29','2021-08-11 13:02:29');
/*!40000 ALTER TABLE `Posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Roles` (
  `role_id` int(1) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) DEFAULT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES (1,'super_admin','For web dev in charge of database.','2021-08-06 14:50:57','2021-08-06 14:50:57'),(2,'admin','For application admin.','2021-08-06 14:50:57','2021-08-06 14:50:57'),(3,'user','For standard user.','2021-08-06 14:50:57','2021-08-06 14:50:57');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Users` (
  `user_id` int(4) NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_photo` varchar(255) NOT NULL DEFAULT 'http://127.0.0.1:3000/images/default-user-icon.jpg',
  `bio` varchar(255) DEFAULT NULL,
  `fk_user_role` varchar(20) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `pseudo` (`pseudo`),
  UNIQUE KEY `email` (`email`),
  KEY `user_first_name` (`first_name`),
  KEY `user_last_name` (`last_name`),
  KEY `user_createdAt` (`createdAt`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'Admin',NULL,NULL,'admin@groupomania.fr','$2b$10$mtSnQs6gwJk5V6mV6t16burmPDX9nv42P87Ad70OsRSvRMrOZt0/q','http://127.0.0.1:3000/images/default-user-icon.jpg','Peut supprimer des utilisateurs et des messages.','admin','2021-08-06 13:27:11','2021-08-06 13:27:11'),(11,'Chris 3',NULL,NULL,'chris3@gmail.com','$2b$10$ob7UcruBbJq.A5JhvHMzLuixeL8RRQSi1wNIMYCxp8jonXagAEbl.','http://127.0.0.1:3000/images/default-user-icon.jpg','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.','user','2021-08-07 11:56:00','2021-08-07 11:56:00'),(13,'Christelle',NULL,NULL,'christelle.couchoux@gmail.com','$2b$10$ZXGiREXrcffUFCd7CGjavutPdxyvrvb3hOyBtHstAx4XUffEc3Eye','http://127.0.0.1:3000/images/default-user-icon.jpg','bio bio bio bio ','user','2021-08-08 12:25:36','2021-08-10 17:54:09'),(21,'Test 2',NULL,NULL,'test2@gmail.com','$2b$10$KWjUngFb2/6knk9SQPqcUuecFEojR28x2HcMXqRcx3K5an08Lru0W','http://127.0.0.1:3000/images/default-user-icon.jpg',NULL,'user','2021-08-10 09:41:12','2021-08-10 09:41:12'),(25,'Chris 2',NULL,NULL,'chris2@gmail.com','$2b$10$kt3vgVYzECRVNOPDCDM07O3ZpWnOLuC.URmehDnIeTiuDckJkfLTK','http://127.0.0.1:3000/images/default-user-icon.jpg',NULL,'user','2021-08-11 07:50:07','2021-08-11 07:50:07'),(27,'Chris',NULL,NULL,'chris@gmail.com','$2b$10$DIr.XyKyhrGWtt0Mn9Edn.if9.zHRNxDwbwERnvuCb26hb5nvKTNm','http://127.0.0.1:3000/images/default-user-icon.jpg','','user','2021-08-11 07:55:10','2021-08-11 08:15:11');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_notifications`
--

DROP TABLE IF EXISTS `v_notifications`;
/*!50001 DROP VIEW IF EXISTS `v_notifications`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `v_notifications` AS SELECT 
 1 AS `notification_id`,
 1 AS `type`,
 1 AS `seen`,
 1 AS `recipient_id`,
 1 AS `sender_name`,
 1 AS `notification_text`,
 1 AS `createdAt`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'groupomania'
--
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
/*!50003 DROP PROCEDURE IF EXISTS `delete_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_post`(IN p_post_id INT)
BEGIN
    DELETE FROM Posts
    WHERE Posts.post_id = p_post_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user`(IN p_user_id INT)
BEGIN
    DELETE FROM Users
    WHERE Users.user_id = p_user_id;
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
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id, Users.pseudo, Users.user_photo, Users.bio, Posts.createdAt
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
/*!50003 DROP PROCEDURE IF EXISTS `get_all_posts_with_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_posts_with_user`()
BEGIN
    SELECT Posts.post_id, Posts.post_file, Posts.post_text, Users.user_id, Users.pseudo, Users.user_photo, Posts.createdAt
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id;
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
/*!50003 DROP PROCEDURE IF EXISTS `get_posts_and_comments_of_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_posts_and_comments_of_user`(IN p_user_id INT)
BEGIN
    SELECT 'post', Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id AS post_user_id, 
        Users.pseudo AS post_user_pseudo, Users.user_photo AS post_user_photo, Posts.createdAt AS post_createdAt, 
        null AS comment_id, null AS comment_text, null AS comment_user_id,
        null AS comment_user_pseudo, null AS comment_user_photo, null AS comment_createdAt, 
        Posts.createdAt AS createdAt, Posts.fk_user_id AS targetedUser
    FROM Posts
    INNER JOIN Users 
    ON Posts.fk_user_id = Users.user_id
    HAVING targetedUser = p_user_id

    UNION

    SELECT 'comment', Posts.post_id, Posts.post_file, Posts.post_text, Posts.fk_user_id AS post_user_id, 
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
-- Final view structure for view `v_notifications`
--

/*!50001 DROP VIEW IF EXISTS `v_notifications`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_notifications` (`notification_id`,`type`,`seen`,`recipient_id`,`sender_name`,`notification_text`,`createdAt`) AS select `notifications`.`notification_id` AS `notification_id`,`notifications`.`type` AS `type`,`notifications`.`seen` AS `seen`,`notifications`.`fk_recipient_id` AS `fk_recipient_id`,`Senders`.`pseudo` AS `pseudo`,`notifications`.`original_text` AS `original_text`,`notifications`.`createdAt` AS `createdAt` from (`notifications` join `users` `Senders` on((`notifications`.`fk_sender_id` = `Senders`.`user_id`))) */;
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

-- Dump completed on 2021-08-11 16:14:44
