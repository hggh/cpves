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
$smarty->assign('if_listings', $config['mailinglisten']);
$smarty->assign('company_title', $config['company_title']);
$smarty->assign('max_passwd_len', $config['max_passwd_len']);
/*
mailfilter prios:

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
	$sql=sprintf("SELECT id FROM admin_access WHERE email='%s' AND domain='%s'",
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
if ($type == 'mail_forward') {
	$fwdmailaddr=$opt_1;
	$delete=$opt_2;
	$fwdoption=$opt_3;
		
	if (isset($delete) && $delete == 'on') {
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



function save_autoresponder($uid,$active,$esubject,$msg) {
	global $db;
	$sql=sprintf("SELECT id FROM autoresponder WHERE email='%d'",
		$db->escapeSimple($uid));
	$result=&$db->query($sql);
	if ($result->numRows()==1) 
	{
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$sql=sprintf("UPDATE autoresponder SET esubject='%s',msg='%s',active='%s' WHERE id='%d' AND email='%d'",
				$db->escapeSimple($esubject),
				$db->escapeSimple($msg),
				$db->escapeSimple($active),
				$db->escapeSimple($data['id']),
				$db->escapeSimple($uid) );
	}
	else
	{
		$sql=sprintf("INSERT INTO autoresponder SET esubject='%s',msg='%s',active='%s',email='%d'",
				$db->escapeSimple($esubject),
				$db->escapeSimple($msg),
				$db->escapeSimple($active),
				$db->escapeSimple($uid) );
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
	
}
?>