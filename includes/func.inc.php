<?php
/******************************************************************************
* Copyright (C) 2006 Jonas Genannt <jonas.genannt@brachium-system.net>
* 
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public License
* as published by the Free Software Foundation; either version 2
* of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
******************************************************************************/
$smarty->assign('company_title', $config['company_title']);
$smarty->assign('max_passwd_len', $config['max_passwd_len']);
$smarty->assign('webmail_link',$config['webmail_link']);
$smarty->assign('mailgraph_link',$config['mailgraph_link']);
$smarty->assign('display_mb_size',$config['display_mb_size']);
$smarty->assign('cpves_version', $config['cpves_version']);
$smarty->assign('config', $config);
/*
mailfilter prios:
del_dups_mails		- 2
mailinglists		- 3
del virusnotifications	- 4
Spamassassin		- 5
autoresponder		- 10
foward			- 15
move_spam		- 20
*/


$db=&DB::connect($dsn, $options);
if (PEAR::isError($db)) {
    die($db->getMessage());
}
function check_whitelist_addr($addr) {
	if (preg_match('/^@/', $addr)) { //addr is an domain
		if (preg_match('/^([0-9a-zA-Z_.\-@]+)$/',$addr)) {
			return 1;
		}
	}
	else {
		if (Validate::email($addr)== 1) {
			return 1;
		}
	}
	return 0;
}

function get_all_langs() {
$table_lang = array();
if (is_dir(ROOT . "/includes/localization/")) {
	$lc_dir = opendir(ROOT . "/includes/localization/");
	while (($lc_file = readdir($lc_dir)) !== false) {
		if (filetype(ROOT . "/includes/localization/" . $lc_file)== "dir" &&
			  $lc_file!="." && $lc_file!=".." && $lc_file!= ".svn") {
				if (is_file(ROOT . "/includes/localization/".$lc_file. "/LC_MESSAGES/cpves.mo")) {
					array_push($table_lang, array(
						'name' => $lc_file));
				}
		}
	}
}
	return $table_lang;
}

function insert_mailarchive($uid,$options) {
	global $db;
	$sql=sprintf("SELECT id FROM mailarchive WHERE email='%s' AND folder='%s'",
		$db->escapeSimple($uid),
		$db->escapeSimple($options['folder']));
	$result=&$db->query($sql);
	if ($result->numRows() == 1) {
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$sql=sprintf("UPDATE mailarchive SET folder='%s',adays='%d',fname_month='%d',fname_year='%d',active='%d',mailsread='%d' WHERE email='%d' AND id='%d'",
			$db->escapeSimple($options['folder']),
			$db->escapeSimple($options['adays']),
			$db->escapeSimple($options['fname_month']),
			$db->escapeSimple($options['fname_year']),
			$db->escapeSimple($options['active']),
			$db->escapeSimple($options['mailsread']),
			$db->escapeSimple($uid),
			$db->escapeSimple($data['id']));
		$res=&$db->query($sql);
	}
	else {
		$sql=sprintf("INSERT INTO mailarchive SET email='%d',folder='%s',adays='%d',fname_month='%d',fname_year='%d',active='%d',mailsread='%d'",
			$db->escapeSimple($uid),
			$db->escapeSimple($options['folder']),
			$db->escapeSimple($options['adays']),
			$db->escapeSimple($options['fname_month']),
			$db->escapeSimple($options['fname_year']),
			$db->escapeSimple($options['active']),
			$db->escapeSimple($options['mailsread']));
		$res=&$db->query($sql);
	}
}

function insert_sa_learn($uid,$options) {
	global $db;
	$sql=sprintf("SELECT id FROM spamassassin_learn WHERE email='%s' AND folder='%s'",
		$db->escapeSimple($uid),
		$db->escapeSimple($options['folder']));
	$result=&$db->query($sql);
	if ($result->numRows() == 1) {
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if ($options['satype']== "0") {
			$sql=sprintf("DELETE FROM spamassassin_learn WHERE email='%d' AND id='%d'",
				$db->escapeSimple($uid),
				$db->escapeSimple($data['id']));
		}
		else {		
			$sql=sprintf("UPDATE spamassassin_learn SET folder='%s',active='1',type='%s' WHERE email='%d' AND id='%d'",
				$db->escapeSimple($options['folder']),
				$db->escapeSimple($options['satype']),
				$db->escapeSimple($uid),
				$db->escapeSimple($data['id']));
		}
		$res=&$db->query($sql);
	}
	else {
		$sql=sprintf("INSERT INTO spamassassin_learn SET email='%d', folder='%s',active='1',type='%s'",
			$db->escapeSimple($uid),
			$db->escapeSimple($options['folder']),
			$db->escapeSimple($options['satype']));
		$res=&$db->query($sql);
	}
}

function get_autores_disable($uid) {
	global $db;
	$sql=sprintf("SELECT active,DATE_FORMAT(a_date, '%%d.%%m.%%Y') AS a_date,DATE_FORMAT(a_date, '%%H:%%i:%%s') AS a_time FROM autoresponder_disable WHERE email='%s'",
		$db->escapeSimple($uid));
	$res=&$db->query($sql);
	if ($res->numRows() == 1) {
		$data=$res->fetchrow(DB_FETCHMODE_ASSOC);
		return $data;
	}
	return array('active '=> 0);
}

function check_autores_date_disable($a_date,$a_time) {
	list($hour,$minute,$second)=split(':',$a_time,3);
	list($day,$month,$year)=split("[.]",$a_date);
	$date_user=mktime($hour,$minute,$second,$month,$day,$year);
	if (time()<$date_user) {
		return true;
	}
	return false;
}

function autores_date_format($a_date,$a_time) {
	list($hour,$minute,$second)=split(':',$a_time,3);
	list($day,$month,$year)=split("[.]",$a_date);
	return mktime($hour,$minute,$second,$month,$day,$year);
}

function change_domain_feature($did,$feature,$state) {
	global $db;
	if (!is_numeric($state)) return false;
	switch ($feature) {
		case 'imap':
			$do='p_imap';
			break;
		case 'pop3':
			$do='p_pop3';
			break;
		case 'webmail':
			$do='p_webmail';
			break;
		case 'spamassassin':
			$do='p_spamassassin';
			break;
		case 'mailarchive':
			$do='p_mailarchive';
			break;
		case 'bogofilter':
			$do='p_bogofilter';
			break;
		case 'sa_wb_listing':
			$do='p_sa_wb_listing';
			break;
		case 'spam_del':
			$do='p_spam_del';
			break;
		case 'sa_learn':
			$do='p_sa_learn';
			break;
		case 'webinterface':
			$do='p_webinterface';
			break;
		case 'fetchmail':
			$do="p_fetchmail";
			break;
		case 'autores_xheader':
			$do="p_autores_xheader";
			break;
		case 'check_polw':
			$do="p_check_polw";
			break;
		case 'check_grey':
			$do="p_check_grey";
			break;
		case 'mlists':
			$do="p_mlists";
			break;
		default:
			return false;
	}
	$sql=sprintf("UPDATE domains SET %s='%s' WHERE id='%s'",
		$do,
		$db->escapeSimple($state),
		$db->escapeSimple($did));
	$result=&$db->query($sql);
	if ($result) {
		
		if (preg_match("/p_check_/", $do) ==1) {
			$sql=sprintf("UPDATE users SET %s='%s' WHERE domainid='%s'",
				$do,
				$db->escapeSimple($state),
				$db->escapeSimple($did));
			$result=&$db->query($sql);
			$sql=sprintf("UPDATE forwardings SET %s='%s' WHERE domainid='%s'",
				$do,
				$db->escapeSimple($state),
				$db->escapeSimple($did));
			$result=&$db->query($sql);
		}
		return true;
	}
	return false;
}

function check_du_fetaure($uid,$did,$typ) {
	global $db;
	$sql=sprintf("SELECT %s FROM domains WHERE id='%s'",
		$db->escapeSimple($typ),
		$db->escapeSimple($did));
	$domain=&$db->getRow($sql,array(),DB_FETCHMODE_ORDERED);
	if ($domain[0] == 1) {
		$sql=sprintf("SELECT %s FROM users WHERE id='%s'",
			$db->escapeSimple($typ),
			$db->escapeSimple($uid));
		$user=&$db->getRow($sql,array(),DB_FETCHMODE_ORDERED);
		if ($user[0] == 1) {
			return 1;
		}
	}
	return 0;
}

function list_imap_folders($imap_server, $email,$password, $stati) {
	if (!function_exists('imap_open')) {
		die("CpVES needs PHP IMAP Support. Please install php-imap!");
	}
	$mbox=@imap_open("{".$imap_server.":143/imap/notls}",$email,$password);
	if (! $mbox) {
		return false;
	}
	$list = imap_getmailboxes($mbox, "{ffo}", "*");
	if (is_array($list)) {
		$imap_folders=array();
		sort($list);
		foreach($list as $key => $val) {
			$trenner = $val->delimiter;
			$name = ereg_replace("{ffo}", "", $val->name);
			$folder = ereg_replace("{ffo}", "", $val->name);
			$name = ereg_replace("INBOX$trenner", "", $name);
			$name_display=mb_convert_encoding($name, "UTF-8", "UTF7-IMAP");
			$name_display=str_replace($trenner, "/", $name_display);
			if (!preg_match('/^drafts$/i', $name ) &&
			   !preg_match("/^Trash$trenner/i", $name)) {

				if ($stati==1) {
				$status = imap_status($mbox, "{".$imap_server."}". $folder, SA_ALL );
				if ($status) {
					$messages=$status->messages;
					$unseen  =$status->unseen;
				}
				else {
					$messages=0;
					$unseen  =0;
				}
				}

				if (preg_match('/SPAM/i',$name) || preg_match('/JUNK/i',$name)) {
					$type="spam";
				}
				else if (preg_match('/^INBOX$/i', $name))  {
					$type="inbox";
				}
				else {
					$type="normal";
				}
				array_push($imap_folders,array(
					'name_display' => $name_display,
					'name' => $name,
					'type' => $type,
					'messages' => $messages,
					'unseen' => $unseen));
			}
			$type="";
		}
		if (count($imap_folders) > 0 ) {
			return $imap_folders;
		}
		else {
			return false;
		}
	}
	else {
		return false;
	}
}


//$_SESSION['uid'],"auto_val_tos_active",$_POST['val_tos_active'], 0
function update_email_options($uid,$conf,$options,$extra) {
	global $db;
	$sql=sprintf("SELECT id FROM email_options WHERE email='%s' AND conf='%s'",
		$db->escapeSimple($uid),
		$db->escapeSimple($conf) );
	$result=&$db->query($sql);
	if ($result->numRows() == 1 ) {
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$sql=sprintf("UPDATE email_options SET options='%s' WHERE id='%s'",
			$db->escapeSimple($options),
			$db->escapeSimple($data['id']) );
	}
	else {
		$sql=sprintf("INSERT INTO email_options SET conf='%s',email='%s',options='%s'",
			$db->escapeSimple($conf),
			$db->escapeSimple($uid),
			$db->escapeSimple($options));
	}
	$result=&$db->query($sql);

}

function update_spamassassin_value($email,$preference,$value,$uid) {
	global $db;
	$sql=sprintf("SELECT prefid FROM spamassassin WHERE username='%s' AND preference='%s'",
		$db->escapeSimple($email),
		$db->escapeSimple($preference));
	$result=&$db->query($sql);
	if ($result->numRows() == 1) {
		$sql=sprintf("UPDATE spamassassin SET value='%s',email='%d' WHERE username='%s' AND preference='%s'",
			$db->escapeSimple($value),
			$db->escapeSimple($uid),
			$db->escapeSimple($email),
			$db->escapeSimple($preference));
	}
	else {
		$sql=sprintf("INSERT INTO spamassassin SET value='%s',username='%s',preference='%s',email='%d'",
			$db->escapeSimple($value),
			$db->escapeSimple($email),
			$db->escapeSimple($preference),
			$db->escapeSimple($uid));
	}
	$result=&$db->query($sql);
	return true;
}

function get_spamassassin_value($email,$conf,$default) {
	global $db;
	$sql=sprintf("SELECT value FROM spamassassin WHERE username='%s' AND preference='%s'",
		$db->escapeSimple($email),
		$db->escapeSimple($conf));
	$result=&$db->query($sql);
	if ($result->numRows() == 1) {
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if (empty($data['value'])) {
			return $default;
		}
		return $data['value'];
	}
	else {
		return $default;
	}
	
	
}

//$_SESSION['uid'],"auto_val_tos_active", 0
function get_email_options($uid,$conf,$default) {
	global $db;
	$sql=sprintf("SELECT options FROM email_options WHERE email='%s' AND conf='%s'",
		$db->escapeSimple($uid),
		$db->escapeSimple($conf) );
	$result=&$db->query($sql);
	if ($result->numRows() == 1 ) {
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		return $data['options'];
	}
	else {
		return $default;
	}
}

function val_tos_del($uid,$val_tos_del) {
	global $db;
	foreach($val_tos_del as $key) {
		$sql=sprintf("DELETE FROM autoresponder_recipient WHERE email='%d' AND id='%d'",
			$db->escapeSimple($uid),
			$db->escapeSimple($key));
		$db->query($sql);
		unset($sql);
	}
}

function val_tos_add($uid, $val_tos_add) {
	global $db;
	if (Validate::email($val_tos_add) == false) {
		return 1;
	}
	else {
		$sql=sprintf("INSERT INTO autoresponder_recipient SET email='%d', recip='%s'",
			$db->escapeSimple($uid),
			$db->escapeSimple(strtolower($val_tos_add)));
		$db->query($sql);
		unset($sql);
		return 0;
	}
	
}
function run_systemscripts() {
	global $config;
	if( $config['service_enabled'] == 'y' ) {
		$socket = @socket_create (AF_INET, SOCK_STREAM, 0);
		$result = @socket_connect ($socket, '127.0.0.1', 
			$config['service_port']);
		@socket_close ($socket);
	}
}

function check_passwd_length($passwd) {
	global $config;
	$passwdlen=strlen($passwd);
	if ($passwdlen < 3 || $passwdlen > $config['max_passwd_len'])
	{
		return false;
	}
	else
	{
		return true;
	}
}

function logging($username)
{
        global $config;
        if ($config['write_login_log']!=false && 
	    is_file($config['write_login_log']) &&
            is_writeable($config['write_login_log']))
        {
                $f_handle=fopen($config['write_login_log'], "a+");
                if ($f_handle)
                {
                        $line=sprintf("%s - %s - %s\n",
                                date("d.m.Y - H:i:s"),
                                $_SERVER['REMOTE_ADDR'],
                                $username);
                        fwrite($f_handle, $line);
                        fclose($f_handle);
                }
                unset($line);

        }
}


function get_first_forward($forward)
{
	if ((strpos($forward, ',')) !== false) // , kommt vor
	{
		$pos=strpos($forward,',');
		return substr($forward,0, $pos);
	}
	else
	{
		return $forward;
	}
}

function check_multi_forward($forward)
{
	if ((strpos($forward, ',')) !== false)
	{
		return 'y';
	}
	return 'n';
}

function check_access_to_domain($domainid,$db)
{
	if (! isset($_SESSION['uid'])) return false;
	$sql=sprintf("SELECT a.id FROM admin_access AS a LEFT JOIN domains AS b ON b.id=a.domain WHERE a.email='%s' AND a.domain='%s' AND b.access='1'",
		$db->escapeSimple($_SESSION['uid']),
		$db->escapeSimple($domainid));
	$result=&$db->query($sql);
	if ($result->numRows() == 1)
	{
		return true;
	}
	return false;
}

function get_forem_domain($id,$type,$db)
{
	if ($type=="forwardings")
	{
	$sql=sprintf("SELECT COUNT(*) AS anzahl FROM forwardings WHERE domainid='%d' AND `efrom` NOT REGEXP '^@'",
		$db->escapeSimple($id));	
	}
	else
	{
	
	$sql=sprintf("SELECT COUNT(*) AS anzahl FROM users WHERE domainid='%d' AND enew!='0'",
		$db->escapeSimple($id));
	}
	$res=&$db->query($sql);
	$row = $res->fetchrow(DB_FETCHMODE_ASSOC);
	return $row['anzahl'];
	
}

function email_valid($mail)
{
	if (ereg("^([a-zA-Z0-9._-]+)$", $mail))
	{
		return true;
	}
	return false;
}
function adm_user_exits($user,$id,$db)
{
	if ($id!=0)
	{
		$sql=sprintf("SELECT id FROM adm_users WHERE username='%s' AND id!='%d'",
			$db->escapeSimple($user),
			$db->escapeSimple($id));
	}
	else
	{
		$sql=sprintf("SELECT id FROM adm_users WHERE username='%s'",
			$db->escapeSimple($user));
	}
	$res=&$db->query($sql);
	if ($res->numRows() == 1)
	{
		return true;
	}
	return false;
}
function email_exist($mail,$db,$eid,$fid)
{
	if ($eid!=0)
	{
		$sql=sprintf("SELECT id FROM users WHERE email='%s' AND id!='%d'",
			$db->escapeSimple($mail),
			$db->escapeSimple($eid));
	}
	else
	{
		$sql=sprintf("SELECT id FROM users WHERE email='%s'",
			$db->escapeSimple($mail));
	}
	$res=&$db->query($sql);
	if ($res->numRows() == 1)
	{
		return true;
	}
	else
	{
		if ($fid!=0)
		{
			$sql=sprintf("SELECT id FROM forwardings WHERE efrom='%s' AND id!='%s'",
				$db->escapeSimple($mail),
				$db->escapeSimple($fid));
		}
		else
		{
			$sql=sprintf("SELECT id FROM forwardings WHERE efrom='%s'",
				$db->escapeSimple($mail));
		}
		$res=&$db->query($sql);
		if ($res->numRows() == 1)
		{
			return true;
		}
		else
		{
			return false;
		}

		if ($fid != 0)
		{
			$sql=sprintf("SELECT id FROM lists WHERE address = '%s' AND id! = '%s'",
				$db->escapeSimple($mail),
				$db->escapeSimple($fid));
		}
		else
		{
			$sql=sprintf("SELECT id FROM lists WHERE address = '%s'",
				$db->escapeSimple($mail));
		}
		$res=&$db->query($sql);
		if ($res->numRows() == 1)
		{
			return true;
		}
		else
		{
			return false;
		}

	}
	
}
function domain_exist($domain,$db)
{
	$sql=sprintf("SELECT id FROM domains WHERE dnsname='%s'",
		$db->escapeSimple($domain));
	$result=&$db->query($sql);
	if ($result->numRows() ==1)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function check_domain_feature($id,$type)
{
	global $db;
	$sql=sprintf("SELECT %s FROM domains WHERE id='%s'",
		$type,
		$db->escapeSimple($id));
	$result=&$db->query($sql);
	$data=$result->fetchRow(DB_FETCHMODE_ASSOC);
	if ($data[$type] == '1')
	{
		return true;
	}
	return false;
}

function get_ip_for_a($arecord)
{
	$resolver = new Net_DNS_Resolver();
	$response = $resolver->query($arecord);
	if ($response)
	{
		foreach($response->answer as $rr)
		{
			return $rr->address;
		}
	}
	
	
}

function get_mx($dnsname) {
$resolver = new Net_DNS_Resolver();
$response = $resolver->query($dnsname, 'MX');
global $res_array;
if ($response)
{
	foreach ($response->answer as $rr) 
	{
		$ipaddr="";
		$ip_type="";

		$ipaddr = get_ip_for_a($rr->exchange);
		if (Net_CheckIP::check_ip($ipaddr)) $ip_type="ipv4";
		if (Net_IPv6::checkIPv6($ipaddr)) $ip_type="ipv6";
		array_push($res_array, array(
			'prio' => $rr->preference,
			'dnsname' => $rr->exchange,
			'ipaddr' => $ipaddr,
			'iptype' => $ip_type));
	}
	asort($res_array);
	return true;
}
else
{
	return false;
}

} // get_mx ENDE


function check_password($cpasswd, $passwd) {
	if (crypt($passwd,$cpasswd) == $cpasswd)
	{
		return 1;
	}
	return 0;
}



// encrypt password using DES encryption
function encrypt_passwd($pass) {
	global $config;
	$cypher = des($config['des_key'], $pass, 1, 0, NULL);
	return base64_encode($cypher);
}

// decrypt password using DES encryption
function decrypt_passwd($cypher)  {
	global $config;
	$pass = des($config['des_key'], base64_decode($cypher), 0, 0, NULL);
	return preg_replace('/\x00/', '', $pass);
}



function update_mailfilter($type,$uid,$opt_1,$opt_2,$opt_3) {
global $db;
if ($type=='del_virus_notifi') {
	$sql=sprintf("SELECT id FROM mailfilter WHERE type='del_virus_notifi' AND email='%d'",$db->escapeSimple($uid));
	$result=&$db->query($sql);
	if ($result->numRows() ==1 )
	{
		if ($opt_1==1) {
			$sql=sprintf("UPDATE mailfilter SET active='1' WHERE email='%s' AND type='del_virus_notifi'",
			$db->escapeSimple($uid));
		}
		else {
			$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%s' AND type='del_virus_notifi'",
			$db->escapeSimple($uid));
		}
	}
	elseif ($opt_1 == 1) {
		$sql_del=sprintf("DELETE FROM mailfilter WHERE type='del_virus_notifi' AND email='%s'",
			$db->escapeSimple($uid));
		$result=&$db->query($sql_del);
		
		$sql=sprintf("INSERT INTO mailfilter SET active='1',type='del_virus_notifi',filter='1',email='%s',prio='4'",
			$db->escapeSimple($uid));
		
	}
	
	$result=&$db->query($sql);
} //ENDE: del_virus_notifi
if ($type=='del_dups_mails') {
	$sql=sprintf("SELECT id FROM mailfilter WHERE type='del_dups_mails' AND email='%d'",$db->escapeSimple($uid));
	$result=&$db->query($sql);
	if ($result->numRows() ==1 )
	{
		if ($opt_1==1) {
			$sql=sprintf("UPDATE mailfilter SET active='1' WHERE email='%s' AND type='del_dups_mails'",
			$db->escapeSimple($uid));
		}
		else {
			$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%s' AND type='del_dups_mails'",
			$db->escapeSimple($uid));
		}
	}
	elseif ($opt_1 == 1) {
		$sql_del=sprintf("DELETE FROM mailfilter WHERE type='del_dups_mails' AND email='%s'",
			$db->escapeSimple($uid));
		$result=&$db->query($sql_del);
		
		$sql=sprintf("INSERT INTO mailfilter SET active='1',type='del_dups_mails',filter='1',email='%s',prio='2'",
			$db->escapeSimple($uid));
		
	}
	
	$result=&$db->query($sql);
} //ENDE: del_dups_mails
if ($type == 'mail_forward') {
	$fwdmailaddr=$opt_1;
	$delete=$opt_2;
	$fwdoption=$opt_3;
		
	if ((isset($delete) && $delete == 'on') || empty($fwdmailaddr)) {
		$sql=sprintf("UPDATE mailfilter SET active='0'  WHERE email='%d' AND type LIKE 'forward%%'",
			$db->escapeSimple($uid));
		$res=&$db->query($sql);
		
	}
	else {
		// first delete all entries
		$sql=sprintf("DELETE FROM mailfilter WHERE email='%d' AND type LIKE 'forward%%'",
			$db->escapeSimple($uid));
		$res=&$db->query($sql);
		
		if ($fwdoption=="1") {
			$fwdtype="forward_cc";
		}
		else {
			$fwdtype="forward_to";
		}
		
		$sql=sprintf("INSERT INTO mailfilter SET type='%s', filter='%s',prio='15', email='%d'",
			$db->escapeSimple($fwdtype),
			$db->escapeSimple($fwdmailaddr),
			$db->escapeSimple($uid));
		$res=&$db->query($sql);
		
	}
} //END: mail_forward



}


function save_autoresponder($uid,$active,$esubject,$msg,$send_times) {
	global $db;
	$sql=sprintf("SELECT id FROM autoresponder WHERE email='%d'",
		$db->escapeSimple($uid));
	$result=&$db->query($sql);
	// strip fucking magic quotes if enabled
	if (get_magic_quotes_gpc()) {
		$esubject=stripslashes($esubject);
		$msg=stripslashes($msg);
	}
	if ($result->numRows()==1) 
	{
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if ($active == 'n' ) {
			$sql=sprintf("UPDATE autoresponder SET active='%s' WHERE id='%d' AND email='%d' ",
				$db->escapeSimple($active),
				$db->escapeSimple($data['id']),
				$db->escapeSimple($uid) );
		}
		else {
			$sql=sprintf("UPDATE autoresponder SET esubject='%s',msg='%s',active='%s',times='%s' WHERE id='%d' AND email='%d'",
				$db->escapeSimple($esubject),
				$db->escapeSimple($msg),
				$db->escapeSimple($active),
				$db->escapeSimple($send_times),
				$db->escapeSimple($data['id']),
				$db->escapeSimple($uid) );
		}
	}
	else
	{
		$sql=sprintf("INSERT INTO autoresponder SET esubject='%s',msg='%s',active='%s',email='%d',times='%s'",
				$db->escapeSimple($esubject),
				$db->escapeSimple($msg),
				$db->escapeSimple($active),
				$db->escapeSimple($uid),
				$db->escapeSimple($send_times) );
	}
	$result=&$db->query($sql);
	
	$sql=sprintf("DELETE FROM autoresponder_send WHERE email='%d'",
				$db->escapeSimple($uid));
	$result=&$db->query($sql);
	
	$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%d' AND type='autoresponder'",
		$db->escapeSimple($uid));
	$result=&$db->query($sql);
	
	if ($active == 'y' )
	{
		$sql=sprintf("INSERT INTO mailfilter SET email='%d', active='1',prio='10', type='autoresponder'",
			$db->escapeSimple($uid));
		$result=&$db->query($sql);
	}
	
	if ($active!='y') {
		$sql=sprintf("UPDATE autoresponder_disable SET active='0' WHERE email='%d'",
			$db->escapeSimple($uid));
		$result=&$db->query($sql);
	}
	
}

function check_access_to_site($site) {
	$usersite = substr($site,0, strpos($site, '_'));
	if (ereg("_", $site) && ($usersite == 'user' || $usersite == 'sadmin')) {
		$sites = array(
			'user_archivemail' => 'p_mailarchive',
			'user_mailfilter'  => 'p_mailfilter',
			'user_spam'        => 'spamassassin',
			'user_forward'     => 'forwarding',
			'user_salearn'     => 'p_sa_learn',
			'user_fetchmail'   => 'p_fetchmail',
			'sadmin_view'      => 'manager',
			'sadmin_add'       => 'manager',
			'sadmin_edit'      => 'manager',
			'sadmin_options'   => 'manager',
			'sadmin_passwd'    => 'superadmin',
			'domain_add'       => 'superadmin');
		if (array_key_exists($site,$sites)) {
			if ($_SESSION[$sites[$site]] == '0' ) {
				return 0;
			}
			if ($_SESSION[$sites[$site]] == 'n' ) {
				return 0;
			}
		}
	}
	return 1;
}

function delete_emailaddress($id,$emailaddress) {
	global $config;
	global $db;
	$sql=sprintf("UPDATE users SET enew='0' WHERE id='%d'",
			$db->escapeSimple($id));
	$db->query($sql);
		
	foreach ($config['user_tables']  as $table) {
		if ($table == "spamassassin" ) {
			$email=$emailaddress;
			$where="username";
		}
		else {
			$email=$id;
			$where="email";
		}
		$sql=sprintf("DELETE FROM `%s` WHERE %s='%s'",
			$table,
			$where,
			$db->escapeSimple($email));
		$db->query($sql);
	}
} 

$smarty->assign('autores_sendback_times_selects', 
		array( '1' => 'Nur bei der ersten Mail',
		'2' => 'Bis zur zweiten Mail',
		'3' => 'Bis zur dritten Mail',
		'4' => 'Bis zur vierten Mail',
		'5' => 'Bis zur f&uuml;nften Mail',
		'n' => 'Bei jeder Mail'));
?>