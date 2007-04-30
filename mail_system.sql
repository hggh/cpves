-- 
-- Database: `mail_system`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `adm_users`
-- 

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `admin_access`
-- 

CREATE TABLE `admin_access` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `domain` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `autoresponder`
-- 

CREATE TABLE `autoresponder` (
  `id` int(11) NOT NULL auto_increment,
  `esubject` varchar(100) collate utf8_unicode_ci NOT NULL default '',
  `msg` text collate utf8_unicode_ci NOT NULL,
  `active` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  `email` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `autoresponder_disable`
-- 

CREATE TABLE `autoresponder_disable` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `active` tinyint(1) NOT NULL default '1',
  `a_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `autoresponder_recipient`
-- 

CREATE TABLE `autoresponder_recipient` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `recip` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `autoresponder_send`
-- 

CREATE TABLE `autoresponder_send` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `efromto` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `efromto` (`efromto`),
  KEY `in2` (`email`,`efromto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `domains`
-- 

CREATE TABLE `domains` (
  `id` int(11) NOT NULL auto_increment,
  `dnsname` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `access` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  `p_imap` tinyint(1) default '1',
  `p_pop3` tinyint(1) default '1',
  `p_webmail` tinyint(1) default '1',
  `max_email` int(11) NOT NULL default '0',
  `max_forward` int(11) NOT NULL default '0',
  `dnote` varchar(30) collate utf8_unicode_ci default NULL,
  `p_spamassassin` tinyint(1) default '0',
  `p_mailarchive` tinyint(1) default '0',
  `p_bogofilter` tinyint(1) NOT NULL default '0',
  `p_sa_wb_listing` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `dnsname_2` (`dnsname`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `email_options`
-- 

CREATE TABLE `email_options` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `conf` varchar(100) default NULL,
  `options` varchar(100) default NULL,
  `extra` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `conf` (`conf`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `forwardings`
-- 

CREATE TABLE `forwardings` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL default '0',
  `efrom` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `eto` text collate utf8_unicode_ci NOT NULL,
  `access` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `efrom` (`efrom`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `list_recp`
-- 

CREATE TABLE `list_recp` (
  `id` int(11) NOT NULL auto_increment,
  `recp` varchar(100) default NULL,
  KEY `listID` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `lists`
-- 

CREATE TABLE `lists` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL default '0',
  `address` varchar(80) NOT NULL default '',
  `access` enum('y','n') NOT NULL default 'y',
  `public` enum('y','n') NOT NULL default 'y',
  PRIMARY KEY  (`id`),
  KEY `second` (`address`,`access`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `mailfilter`
-- 

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

-- --------------------------------------------------------

-- 
-- Table structure for table `sa_wb_listing`
-- 

CREATE TABLE `sa_wb_listing` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL default '0',
  `email` int(11) NOT NULL default '0',
  `sa_from` varchar(250) NOT NULL default '',
  `type` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `domainid` (`domainid`),
  KEY `type` (`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `spamassassin`
-- 

CREATE TABLE `spamassassin` (
  `username` varchar(100) NOT NULL default '',
  `preference` varchar(30) NOT NULL default '',
  `value` varchar(100) NOT NULL default '',
  `prefid` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`prefid`),
  KEY `username` (`username`),
  KEY `preference` (`preference`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL default '0',
  `email` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `passwd` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `full_name` text collate utf8_unicode_ci NOT NULL,
  `access` enum('y','n') collate utf8_unicode_ci NOT NULL default 'y',
  `enew` tinyint(4) NOT NULL default '1',
  `admin` enum('n','y') collate utf8_unicode_ci NOT NULL default 'n',
  `p_imap` tinyint(1) default '1',
  `p_pop3` tinyint(1) default '1',
  `p_webmail` tinyint(1) default '1',
  `p_spamassassin` tinyint(1) default '0',
  `move_spam` varchar(100) collate utf8_unicode_ci default NULL,
  `cpasswd` varchar(255) character set utf8 NOT NULL default '',
  `p_forwarding` tinyint(1) default '1',
  `p_mailarchive` tinyint(1) default '0',
  `p_bogofilter` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `adm_users` VALUES (1, 'admin', '', 'y', 'y', 'Superadmin', '$1$Ekjbn5PV$lTKL1k2IkDKzpneppf6Wx0');
