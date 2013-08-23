ALTER TABLE `domains` ADD `p_spam_fwd` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `users` ADD `p_spam_fwd` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `adm_users` CHANGE `web_lang` `web_lang` VARCHAR( 14 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL

Version 0.10 to 0.11
DROP VIEW IF EXISTS smtpd_recipient_classes;
CREATE VIEW smtpd_recipient_classes AS  SELECT email,if(p_check_polw=1,'check_polw','') AS polw,if(p_check_grey=1,'check_grey','') AS grey FROM users WHERE access=1 AND p_check_polw!=0 AND p_check_polw!=0 UNION SELECT efrom,if(p_check_polw=1,'check_polw','') AS polw,if(p_check_grey=1,'check_grey','') AS grey FROM forwardings WHERE access=1 AND p_check_polw!=0 AND p_check_polw!=0 AND efrom NOT REGEXP '^@';

CREATE TABLE `domains_forward` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`fr_domain` INT NOT NULL ,
`to_domain` INT NOT NULL ,
INDEX ( `fr_domain` )
) ENGINE = MYISAM ;
ALTER TABLE `domains` ADD `p_autores` TINYINT( 1 ) NOT NULL DEFAULT '1';