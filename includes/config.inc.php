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
$smarty->compile_check = true;
$smarty->caching = false;
$smarty->template_dir = $root . '/templates';
$smarty->compile_dir = '/tmp/';
$smarty->config_overwrite = false;

//Server IP
$config['server_ip'] = "127.0.0.1";


//Postmaster and Serveradmin:
$config['postmaster'] = "postmaster@localhost";

//DES Key for de/encrypt users passwd in session:
//It have to be 24 chars long!!
$config['des_key']="hs#+ska81k!%&Y>FJMJflDT";

//set to false if no logging!
$config['write_login_log']=false;


//Save cleartext password in the database
//NOT RECOMMENDED!!!! secuity hole
$config['cleartext_passwd']="0";

//set max password lenth:
$config['max_passwd_len']=15;

//IMAP Server:
$config['imap_server'] = "localhost";

//Company Name:
$config['company_title'] = "Some Company";

$ar_spam=array("cbl.abuseat.org","multi.surbl.org","sbl-xbl.spamhaus.org");

//Mailinglistenfeature: 
$config['mailinglisten'] = 'y'; //Development, please don't use!
//Run Systemscript via xinetd Service 
$config['service_enabled'] = 'n'; // Development, please don't use!
$config['service_port'] = 7928; // Development, please don't use!

$options = array(
    'debug'       => 2,
    'portability' => DB_PORTABILITY_ALL,
);
$dsn = array(
    'phptype'  => 'mysql',
    'username' => 'root',
    'password' => '',
    'hostspec' => 'localhost',
    'database' => 'mail_system',
);

require_once(ROOT . '/includes/func.inc.php');
?>