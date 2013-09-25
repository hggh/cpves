ALTER TABLE `domains` ADD `spamassassin` TINYINT(1) DEFAULT '1' NOT NULL;

ALTER TABLE `domains` CHANGE `disableimap` `p_imap` TINYINT( 1 ) NULL DEFAULT '1';
ALTER TABLE `domains` CHANGE `disablepop3` `p_pop3` TINYINT( 1 ) NULL DEFAULT '1';
ALTER TABLE `domains` CHANGE `disablewebmail` `p_webmail` TINYINT( 1 ) NULL DEFAULT '1';
ALTER TABLE `domains` CHANGE `spamassassin` `p_spamassassin` TINYINT( 1 ) NULL DEFAULT '1';

ALTER TABLE `users` CHANGE `disableimap` `p_imap` TINYINT( 1 ) NULL DEFAULT '1';
ALTER TABLE `users` CHANGE `disablepop3` `p_pop3` TINYINT( 1 ) NULL DEFAULT '1';
ALTER TABLE `users` CHANGE `disablewebmail` `p_webmail` TINYINT( 1 ) NULL DEFAULT '1';
ALTER TABLE `users` CHANGE `spamassassin` `p_spamassassin` TINYINT( 1 ) NULL DEFAULT '1';
ALTER TABLE `users` ADD `p_forwarding` TINYINT( 1 ) NULL DEFAULT '1';

CREATE TABLE `autoresponder_recipient` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `recip` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

ALTER TABLE `domains` ADD `p_mailarchive` TINYINT( 1 ) DEFAULT '0';
ALTER TABLE `users` ADD `p_mailarchive` TINYINT( 1 ) DEFAULT '0';

ALTER TABLE `domains` ADD `p_bogofilter` TINYINT( 1 ) DEFAULT '0' NOT NULL ;
ALTER TABLE `users` ADD `p_bogofilter` TINYINT( 1 ) DEFAULT '0' NOT NULL ;

CREATE TABLE `autoresponder_disable` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `active` tinyint(1) NOT NULL default '1',
  `a_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `sa_wb_listing` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL default '0',
  `email` int(11) NOT NULL default '0',
  `sa_from` varchar(250) NOT NULL default '',
  `type` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `domainid` (`domainid`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

ALTER TABLE `domains` ADD `p_sa_wb_listing` TINYINT( 1 ) DEFAULT '0' NOT NULL ;
