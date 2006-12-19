<?php
require_once '../root.php';
require_once 'DB.php';
require_once 'des.inc';
require_once 'Net/DNS.php';
require_once 'Net/CheckIP.php';
require_once 'Net/IPv6.php';
define('SMARTY_DIR', $root .'/smarty/libs/');
require(SMARTY_DIR .'Smarty.class.php');
$smarty = new Smarty;
$smarty->compile_check = true;
$smarty->caching = false;
$smarty->template_dir = $root . '/templates';
$smarty->compile_dir = $root . '/cmp/';
$smarty->config_overwrite = false;


$server_ip = "";


//Postmaster and Serveradmin:
$config['postmaster'] = "";

//DES Key for de/encrypt users passwd in session:
//It have to be 24 chars long!!
$des_key="hs§#+ska81k!%&Y>FJMJflDT";

//set to false if no logging!
$write_login_log="false";


//Save cleartext password in the database
//NOT RECOMMENDED!!!! secuity hole
$config['cleartext_passwd']="0";

//set max password lenth:
$max_passwd_len=10;
$smarty->assign('max_passwd_len', $max_passwd_len);

//IMAP Server:
$config['imap_server'] = "";

//Company Name:
$config['company_title'] = "";
//Mailinglistenfeature: 
$config['mailinglisten'] = 'n'; //Development, please don't use!
$ar_spam=array("cbl.abuseat.org","multi.surbl.org","sbl-xbl.spamhaus.org");
// Run Systemscript via xinetd Service 
$config['service_enabled'] = 'n'; // Development, please don't use!
$config['service_port'] = 7928; // Development, please don't use!

$config_autores_subject="";
$config_autores_msg="";

$options = array(
    'debug'       => 2,
    'portability' => DB_PORTABILITY_ALL,
);
$dsn = array(
    'phptype'  => 'mysql',
    'username' => 'mail',
    'password' => '',
    'hostspec' => 'localhost',
    'database' => 'mail_system',
);

require_once 'functions.inc';
?>
