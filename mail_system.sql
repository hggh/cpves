-- MySQL dump 10.10
--
-- Host: localhost    Database: mail_system
-- ------------------------------------------------------
-- Server version	5.0.30-Debian_1-log

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
  `cpasswd` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
-- Table structure for table `email_options`
--

DROP TABLE IF EXISTS `email_options`;
CREATE TABLE `email_options` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL,
  `conf` varchar(100) collate utf8_unicode_ci default NULL,
  `options` varchar(100) collate utf8_unicode_ci default NULL,
  `extra` varchar(100) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `conf` (`conf`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
-- Table structure for table `list_recp`
--

DROP TABLE IF EXISTS `list_recp`;
CREATE TABLE `list_recp` (
  `id` int(11) NOT NULL auto_increment,
  `recp` varchar(100) default NULL,
  KEY `listID` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `lists`
--

DROP TABLE IF EXISTS `lists`;
CREATE TABLE `lists` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL,
  `address` varchar(80) NOT NULL,
  `access` enum('y','n') NOT NULL default 'y',
  `public` enum('y','n') NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `second` (`address`,`access`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!50003 SET @OLD_SQL_MODE=@@SQL_MODE*/;
DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`root`@`localhost` */ /*!50003 TRIGGER `listDelete` AFTER DELETE ON `lists` FOR EACH ROW begin delete from list_recp where listID = OLD.listID; end */;;

DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;

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
-- Table structure for table `tmp`
--

DROP TABLE IF EXISTS `tmp`;
CREATE TABLE `tmp` (
  `id` int(11) NOT NULL default '0',
  `passwd` varchar(200) character set utf8 collate utf8_unicode_ci NOT NULL default ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
  `cpasswd` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2006-12-21 14:58:08
