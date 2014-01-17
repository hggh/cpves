CREATE TABLE `autoresponder_xheader` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL,
  `xheader` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
ALTER TABLE `domains` ADD `p_autores_xheader` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `users` ADD `p_autores_xheader` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `users` ADD `mb_size` INT NOT NULL DEFAULT '0';
ALTER TABLE `adm_users` ADD `web_lang` VARCHAR( 8 ) NOT NULL ;

Version 0.07 to 0.08
ALTER TABLE `users` ADD `p_check_polw` TINYINT( 1 ) DEFAULT '1' NOT NULL ;
ALTER TABLE `users` ADD `p_check_grey` TINYINT( 1 ) DEFAULT '0' NOT NULL ;

ALTER TABLE `forwardings` ADD `p_check_polw` TINYINT( 1 ) DEFAULT '1' NOT NULL ;
ALTER TABLE `forwardings` ADD `p_check_grey` TINYINT( 1 ) DEFAULT '0' NOT NULL ;

ALTER TABLE `domains` ADD `p_check_polw` TINYINT( 1 ) DEFAULT '1' NOT NULL ;
ALTER TABLE `domains` ADD `p_check_grey` TINYINT( 1 ) DEFAULT '0' NOT NULL ;

DROP VIEW IF EXISTS smtpd_recipient_classes;
CREATE VIEW smtpd_recipient_classes AS  SELECT email,if(p_check_polw=1,'check_polw','') AS polw,if(p_check_grey=1,'check_grey','') AS grey FROM users WHERE access=1 AND p_check_polw!=0 AND p_check_polw!=0 UNION SELECT efrom,if(p_check_polw=1,'check_polw','') AS polw,if(p_check_grey=1,'check_grey','') AS grey FROM forwardings WHERE access=1 AND p_check_polw!=0 AND p_check_polw!=0;

CREATE TABLE `lists` (
  `id` int(11) NOT NULL auto_increment,
  `domainid` int(11) NOT NULL,
  `address` varchar(80) NOT NULL,
  `access` tinyint(1) default '1',
  `public` enum('y','n') NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `second` (`address`,`access`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `list_recp` (
  `id` int(11) NOT NULL auto_increment,
  `recp` varchar(100) default NULL,
  KEY `listID` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

ALTER TABLE `domains` ADD `p_mlists` TINYINT NOT NULL DEFAULT '0';