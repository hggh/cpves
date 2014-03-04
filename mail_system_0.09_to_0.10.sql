ALTER TABLE `domains` ADD `p_spam_fwd` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `users` ADD `p_spam_fwd` TINYINT( 1 ) NOT NULL DEFAULT '0';
ALTER TABLE `adm_users` CHANGE `web_lang` `web_lang` VARCHAR( 14 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL

