ALTER TABLE `domains` ADD `p_mailfilter` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `domains` ADD `p_spam_del` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `users` ADD `p_spam_del` TINYINT( 1 ) NOT NULL DEFAULT '0';
CREATE TABLE `mailarchive` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`email` INT NOT NULL ,
`folder` VARCHAR( 250 ) NOT NULL ,
`adays` INT NOT NULL ,
`fname_month` TINYINT( 1 ) NOT NULL ,
`fname_year` TINYINT( 1 ) NOT NULL ,
`active` TINYINT( 1 ) NOT NULL ,
INDEX ( `email` , `active` )
) ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci;
ALTER TABLE `mailarchive` ADD `mailsread` TINYINT( 1 ) NOT NULL ;
ALTER TABLE `autoresponder` ADD `times` CHAR( 1 ) NOT NULL DEFAULT '1';
ALTER TABLE `domains` ADD `enew` TINYINT( 1 ) NOT NULL DEFAULT '1';

ALTER TABLE `domains` ADD `p_sa_learn` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `users` ADD `p_sa_learn` TINYINT( 1 ) NOT NULL DEFAULT '0';

CREATE TABLE `spamassassin_learn` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`email` INT NOT NULL ,
`folder` VARCHAR( 255 ) NOT NULL ,
`active` TINYINT( 1 ) NOT NULL DEFAULT '0',
`type` ENUM( 'spam', 'ham' ) NOT NULL
) ENGINE = MYISAM ;
ALTER TABLE `domains` ADD `p_fetchmail` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `users` ADD `p_fetchmail` TINYINT( 1 ) NOT NULL DEFAULT '0';
CREATE TABLE `fetchmail` (
  `id` int(11) NOT NULL auto_increment,
  `email` int(11) NOT NULL default '0',
  `server` varchar(255) NOT NULL default '',
  `proto` tinyint(1) NOT NULL default '0',
  `conn_type` tinyint(1) NOT NULL default '0',
  `username` varchar(255) NOT NULL default '',
  `password` varchar(255) NOT NULL default '',
  `keep_mails` tinyint(1) NOT NULL default '0',
  `active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `email` (`email`),
  KEY `active` (`active`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
ALTER TABLE `adm_users` CHANGE `access` `access` VARCHAR( 2 ) NOT NULL DEFAULT 'y';
update adm_users SET access='1' WHERE access='y';
update adm_users SET access='0' WHERE access='n';
ALTER TABLE `adm_users` CHANGE `access` `access` TINYINT( 1 ) NOT NULL DEFAULT '1';
ALTER TABLE `adm_users` CHANGE `manager` `manager` VARCHAR( 2 ) NOT NULL DEFAULT 'y';
update adm_users SET manager='1' WHERE manager='y';
update adm_users SET manager='0' WHERE manager='n';
ALTER TABLE `adm_users` CHANGE `manager` `manager` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `users` DROP `admin` ;
ALTER TABLE `users` CHANGE `access` `access` VARCHAR( 2 ) NOT NULL DEFAULT 'y';
update users SET access='1' WHERE access='y';
update users SET access='0' WHERE access='n';
ALTER TABLE `users` CHANGE `access` `access` TINYINT( 1 ) NOT NULL DEFAULT '1';
ALTER TABLE `domains` CHANGE `access` `access` VARCHAR( 2 ) NOT NULL DEFAULT 'y';
update domains SET access='1' WHERE access='y';
update domains SET access='0' WHERE access='n';
ALTER TABLE `domains` CHANGE `access` `access` TINYINT( 1 ) NOT NULL DEFAULT '1';
ALTER TABLE `forwardings` CHANGE `access` `access` VARCHAR( 2 ) NOT NULL DEFAULT 'y';
update forwardings SET access='1' WHERE access='y';
update forwardings SET access='0' WHERE access='n';
ALTER TABLE `forwardings` CHANGE `access` `access` TINYINT( 1 ) NOT NULL DEFAULT '1';
ALTER TABLE `spamassassin` ADD `email` INT NOT NULL FIRST;
ALTER TABLE `domains` ADD `p_webinterface` TINYINT( 1 ) DEFAULT '1' NOT NULL;
ALTER TABLE `users` ADD `p_webinterface` TINYINT( 1 ) DEFAULT '1' NOT NULL;