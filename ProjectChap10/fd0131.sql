-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: fboard
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `freeboard`
--

DROP TABLE IF EXISTS `freeboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `freeboard` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `password` varchar(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `subject` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `inputdate` varchar(20) NOT NULL,
  `masterid` int(11) DEFAULT '0',
  `readcount` int(11) DEFAULT '0',
  `replynum` int(11) DEFAULT '0',
  `step` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `freeboard`
--

LOCK TABLES `freeboard` WRITE;
/*!40000 ALTER TABLE `freeboard` DISABLE KEYS */;
INSERT INTO `freeboard` VALUES (1,'신정희','1234','test@gmail.com','10단원 테스트','10단원 테스트\r\n10단원 테스트\r\n10단원 테스트\r\n10단원 테스트','17-01-25 10:13 오전',0,3,0,0),(2,'김길동','1234','king@naver.com','홍길동아류','홍길동아류홍길동아류\r\n홍길동아류\r\n홍길동아류\r\n홍길동아류','17-01-25 10:15 오전',0,1,0,0),(3,'세종대왕','1234','you@naver.com','훈민정음','훈민정음\r\n훈민정음\r\n훈민정음\r\n훈민정음\r\n훈민정음','17-01-25 10:34 오전',0,0,0,0),(4,'심청이','1234','sim@gmail.com','효녀심청이','옛날 옛날에 심봉사가 살았어요~\r\n','17-01-25 10:49 오전',0,4,0,0),(5,'앤써북','1234','book@gmail.com','JSP 웹프로그래밍','JSP 웹프로그래밍\r\n입문 + 활용','17-01-25 11:37 오전',0,5,0,0),(6,'북스홀릭','1234','holic@daum.net','기초입문 마스터','를 위한 JSP 웹프로그래밍','17-01-25 11:37 오전',0,0,0,0),(7,'남궁성','1234','nam@naver.com','자바의 정석','자바의 자바의 정석\r\n\\자바의 정석\r\n자바의 정석\r\n자바의 정석정석자바의 정석자바의 정석자바의 정석','17-01-25 11:38 오전',0,2,0,0),(8,'전자정부','1234','frame@gmail.co','출석부','전자정부 프레임 직권입력 관리대장','17-01-25 11:38 오전',0,1,0,0),(9,'오라클','1234','ora@naver.com','오라클 프로그래밍','오라클 프로그래밍 11g','17-01-25 11:39 오전',0,2,0,0),(10,'안드로이드','1234','ahn@daum.net','안드로이드','자바와 아드로이드를 다루는 기술','17-01-25 11:40 오전',0,5,0,0),(11,'김자바','1234','kim@gmail.cpm','HTMl5 + CSS','웹표준화 기술','17-01-25 11:42 오전',0,6,0,0),(12,'test','1234','sets','tsetset','seteste','17-01-26 10:24 오전',0,24,0,0),(13,'구정','1234','newyear@naver.com','까치까치 설날은','1','17-01-31 10:11 오전',0,3,0,0),(14,'강감찬','1234','kang@gmail.com','장군','장군\r\n장군\r\n장군\r\n장군\r\n','17-01-31 11:12 오전',0,7,0,0);
/*!40000 ALTER TABLE `freeboard` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-31 12:06:20
