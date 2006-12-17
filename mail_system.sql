-- MySQL dump 10.9
--
-- Host: localhost    Database: mail_system
-- ------------------------------------------------------
-- Server version	4.1.11-Debian_4sarge2-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adm_users`
--

DROP TABLE IF EXISTS `adm_users`;
CREATE TABLE `adm_users` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `passwd` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `access` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  `manager` enum('n','y') collate utf8_unicode_ci NOT NULL default 'n',
  `full_name` varchar(255) collate utf8_unicode_ci default NULL,
  `cpasswd` varchar(255) character set utf8 NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `adm_users`
--


/*!40000 ALTER TABLE `adm_users` DISABLE KEYS */;
LOCK TABLES `adm_users` WRITE;
INSERT INTO `adm_users` VALUES (1,'admin','','y','y','Superadmin','$1$Ekjbn5PV$lTKL1k2IkDKzpneppf6Wx0');
UNLOCK TABLES;
/*!40000 ALTER TABLE `adm_users` ENABLE KEYS */;

--
-- Table structure for table `admin_access`
--

DROP TABLE IF EXISTS `admin_access`;
CREATE TABLE `admin_access` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `domain` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `admin_access`
--


/*!40000 ALTER TABLE `admin_access` DISABLE KEYS */;
LOCK TABLES `admin_access` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `admin_access` ENABLE KEYS */;

--
-- Table structure for table `autoresponder`
--

DROP TABLE IF EXISTS `autoresponder`;
CREATE TABLE `autoresponder` (
  `id` int(11) NOT NULL auto_increment,
  `esubject` varchar(100) collate utf8_unicode_ci NOT NULL default '',
  `msg` text collate utf8_unicode_ci NOT NULL,
  `active` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  `email` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `autoresponder`
--


/*!40000 ALTER TABLE `autoresponder` DISABLE KEYS */;
LOCK TABLES `autoresponder` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `autoresponder` ENABLE KEYS */;

--
-- Table structure for table `autoresponder_send`
--

DROP TABLE IF EXISTS `autoresponder_send`;
CREATE TABLE `autoresponder_send` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `efromto` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `efromto` (`efromto`),
  KEY `in2` (`email`,`efromto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `autoresponder_send`
--


/*!40000 ALTER TABLE `autoresponder_send` DISABLE KEYS */;
LOCK TABLES `autoresponder_send` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `autoresponder_send` ENABLE KEYS */;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
CREATE TABLE `domains` (
  `id` int(11) NOT NULL auto_increment,
  `dnsname` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `access` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  `disableimap` tinyint(1) default '1',
  `disablepop3` tinyint(1) default '1',
  `disablewebmail` tinyint(1) default '1',
  `max_email` int(11) NOT NULL default '0',
  `max_forward` int(11) NOT NULL default '0',
  `dnote` varchar(30) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `dnsname_2` (`dnsname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `domains`
--


/*!40000 ALTER TABLE `domains` DISABLE KEYS */;
LOCK TABLES `domains` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `domains` ENABLE KEYS */;

--
-- Table structure for table `email_options`
--

DROP TABLE IF EXISTS `email_options`;
CREATE TABLE `email_options` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `conf` varchar(100) default NULL,
  `options` varchar(100) default NULL,
  `extra` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `conf` (`conf`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `email_options`
--


/*!40000 ALTER TABLE `email_options` DISABLE KEYS */;
LOCK TABLES `email_options` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `email_options` ENABLE KEYS */;

--
-- Table structure for table `forwardings`
--

DROP TABLE IF EXISTS `forwardings`;
CREATE TABLE `forwardings` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL default '0',
  `efrom` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `eto` text collate utf8_unicode_ci NOT NULL,
  `access` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `efrom` (`efrom`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `forwardings`
--


/*!40000 ALTER TABLE `forwardings` DISABLE KEYS */;
LOCK TABLES `forwardings` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `forwardings` ENABLE KEYS */;

--
-- Table structure for table `mailfilter`
--

DROP TABLE IF EXISTS `mailfilter`;
CREATE TABLE `mailfilter` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `active` int(11) NOT NULL default '1',
  `type` varchar(30) default NULL,
  `filter` varchar(255) default NULL,
  `prio` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mailfilter`
--


/*!40000 ALTER TABLE `mailfilter` DISABLE KEYS */;
LOCK TABLES `mailfilter` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `mailfilter` ENABLE KEYS */;

--
-- Table structure for table `spamassassin`
--

DROP TABLE IF EXISTS `spamassassin`;
CREATE TABLE `spamassassin` (
  `username` varchar(100) NOT NULL default '',
  `preference` varchar(30) NOT NULL default '',
  `value` varchar(100) NOT NULL default '',
  `prefid` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`prefid`),
  KEY `username` (`username`),
  KEY `preference` (`preference`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `spamassassin`
--


/*!40000 ALTER TABLE `spamassassin` DISABLE KEYS */;
LOCK TABLES `spamassassin` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `spamassassin` ENABLE KEYS */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL default '0',
  `email` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `passwd` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `full_name` text collate utf8_unicode_ci NOT NULL,
  `access` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  `enew` tinyint(4) NOT NULL default '1',
  `admin` enum('n','y') collate utf8_unicode_ci NOT NULL default 'n',
  `disableimap` tinyint(1) default '1',
  `disablepop3` tinyint(1) default '1',
  `disablewebmail` tinyint(1) default '1',
  `spamassassin` tinyint(1) NOT NULL default '0',
  `move_spam` varchar(100) collate utf8_unicode_ci default NULL,
  `cpasswd` varchar(255) character set utf8 NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--


/*!40000 ALTER TABLE `users` DISABLE KEYS */;
LOCK TABLES `users` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

