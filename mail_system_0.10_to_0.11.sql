DROP VIEW IF EXISTS smtpd_recipient_classes;
CREATE VIEW smtpd_recipient_classes AS  SELECT email,if(p_check_polw=1,'check_polw','') AS polw,if(p_check_grey=1,'check_grey','') AS grey FROM users WHERE access=1 AND p_check_polw!=0 AND p_check_polw!=0 UNION SELECT efrom,if(p_check_polw=1,'check_polw','') AS polw,if(p_check_grey=1,'check_grey','') AS grey FROM forwardings WHERE access=1 AND p_check_polw!=0 AND p_check_polw!=0 AND efrom NOT REGEXP '^@';

CREATE TABLE `domains_forward` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`fr_domain` INT NOT NULL ,
`to_domain` INT NOT NULL ,
INDEX ( `fr_domain` )
) ENGINE = MYISAM ;
ALTER TABLE `domains` ADD `p_autores` TINYINT( 1 ) NOT NULL DEFAULT '1';

