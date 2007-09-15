<?php
require_once 'DB.php';
require_once(ROOT . '/includes/des.inc.php');
require_once 'Net/DNS.php';
require_once 'Net/CheckIP.php';
require_once 'Net/IPv6.php';
require_once "Validate.php";
define('SMARTY_DIR', $root .'/smarty/libs/');
require(SMARTY_DIR .'Smarty.class.php');
$smarty = new Smarty;
$smarty->use_sub_dirs = false; 
$smarty->compile_check = true;
$smarty->caching = false;
$smarty->template_dir = $root . '/templates';
$smarty->compile_dir = "/tmp/";
$smarty->config_overwrite = false;

//Server IP: add more ips: array("127.0.0.1", "123.123.123.123")
$config['server_ip'] = array("127.0.0.1");


//Postmaster and Serveradmin:
$config['postmaster'] = "postmaster@localhost";

//DES Key for de/encrypt users passwd in session:
//It have to be 24 chars long!!
$config['des_key']="hs#+ska81k!%&Y>FJMJflDT";

//set to false if no logging!
$config['write_login_log']=false;

//webmail
//$config['webmail_link']="http://your-mailserver.com/webmail/";
$config['webmail_link']=false;

//Mailgraph statistics (only visible for the admin and superadmin):
//$config['mailgraph_link']="http://your-mailserver.com/cgi-bin/mailgraph.cgi";
$config['mailgraph_link']=false;

//Save cleartext password in the database
//NOT RECOMMENDED!!!! secuity hole
$config['cleartext_passwd']="0";

//set max password lenth:
$config['max_passwd_len']=15;

//display the size of the mailboxes
$config['display_mb_size']=1;

//IMAP Server:
$config['imap_server'] = "swetlana.brachium-system.net";

//Company Name:
$config['company_title'] = "Some Company";

// use the postfix per recipient classes with policyd-weight
$config['recipient_classes_polw']=0;

// use the postfix per recipient classes with greylisting
$config['recipient_classes_grey']=0;

$ar_spam=array("cbl.abuseat.org","multi.surbl.org","sbl-xbl.spamhaus.org");

// use CpVES mailinglist feature 
$config['mailinglists'] = '1';

//Run Systemscript via xinetd Service 
$config['service_enabled'] = 'n'; // Development, please don't use!
$config['service_port'] = 7928; // Development, please don't use!

$options = array(
    'debug'       => 2,
    'portability' => DB_PORTABILITY_ALL,
);
$dsn = array(
    'phptype'  => 'mysql',
    'username' => 'mail_web',
    'password' => '',
    'hostspec' => 'localhost',
    'database' => 'mail_system',
    );

$config['user_tables']=array("admin_access", "autoresponder",
	 "autoresponder_disable","autoresponder_recipient",
	 "autoresponder_send", "email_options","fetchmail",
	 "mailarchive","mailfilter","spamassassin","spamassassin_learn","autoresponder_xheader");
$config['cpves_version']="0.09-SVN";
require_once(ROOT . '/includes/func.inc.php');
?>