-- phpMyAdmin SQL Dump
-- version 2.8.2.4
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Dec 09, 2006 at 02:32 PM
-- Server version: 5.0.27
-- PHP Version: 5.1.6
-- 
-- Database: `ipexchange-mail`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `adm_users`
-- 

DROP TABLE IF EXISTS `adm_users`;
CREATE TABLE IF NOT EXISTS `adm_users` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `passwd` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `access` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  `manager` enum('n','y') collate utf8_unicode_ci NOT NULL default 'n',
  `full_name` varchar(255) collate utf8_unicode_ci default NULL,
  `cpasswd` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `admin_access`
-- 

DROP TABLE IF EXISTS `admin_access`;
CREATE TABLE IF NOT EXISTS `admin_access` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `domain` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `autoresponder`
-- 

DROP TABLE IF EXISTS `autoresponder`;
CREATE TABLE IF NOT EXISTS `autoresponder` (
  `id` int(11) NOT NULL auto_increment,
  `esubject` varchar(100) collate utf8_unicode_ci NOT NULL default '',
  `msg` text collate utf8_unicode_ci NOT NULL,
  `active` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  `email` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `autoresponder_send`
-- 

DROP TABLE IF EXISTS `autoresponder_send`;
CREATE TABLE IF NOT EXISTS `autoresponder_send` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `efromto` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `efromto` (`efromto`),
  KEY `in2` (`email`,`efromto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `domains`
-- 

DROP TABLE IF EXISTS `domains`;
CREATE TABLE IF NOT EXISTS `domains` (
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `email_options`
-- 

DROP TABLE IF EXISTS `email_options`;
CREATE TABLE IF NOT EXISTS `email_options` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL,
  `conf` varchar(100) default NULL,
  `options` varchar(100) default NULL,
  `extra` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `conf` (`conf`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `forwardings`
-- 

DROP TABLE IF EXISTS `forwardings`;
CREATE TABLE IF NOT EXISTS `forwardings` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL default '0',
  `efrom` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `eto` text collate utf8_unicode_ci NOT NULL,
  `access` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `efrom` (`efrom`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `mailfilter`
-- 

DROP TABLE IF EXISTS `mailfilter`;
CREATE TABLE IF NOT EXISTS `mailfilter` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `active` int(11) NOT NULL default '1',
  `type` varchar(30) default NULL,
  `filter` varchar(255) default NULL,
  `prio` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `spamassassin`
-- 

DROP TABLE IF EXISTS `spamassassin`;
CREATE TABLE IF NOT EXISTS `spamassassin` (
  `username` varchar(100) NOT NULL default '',
  `preference` varchar(30) NOT NULL default '',
  `value` varchar(100) NOT NULL default '',
  `prefid` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`prefid`),
  KEY `username` (`username`),
  KEY `preference` (`preference`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;
