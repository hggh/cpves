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
$smarty->compile_dir = '/tmp';
$smarty->config_overwrite = false;


$server_ip="127.0.0.1";


//Postmaster and Serveradmin:
$config['postmaster']="postmaster@localhost";

//DES Key for de/encrypt users passwd in session:
//It have to be 24 chars long!!
$des_key="hs§#+ska81k!%&Y>FJMJflDT";

//set to false if no logging!
$write_login_log="false";

//set max password lenth:
$max_passwd_len=10;
$smarty->assign('max_passwd_len', $max_passwd_len);

//IMAP Server:
$config['imap_server']="localhost";

//Company Name:
$config['company_title']="Some Company";
//Mailinglistenfeature: 
$config['mailinglisten']='n'; //Development, please don't use!
$ar_spam=array("cbl.abuseat.org","multi.surbl.org","sbl-xbl.spamhaus.org");
$config_autores_subject="";
$config_autores_msg="";

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

require_once 'functions.inc';
?>