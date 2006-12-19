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
session_start();
include("config.inc.php");
include("check_access.php");
$access_domain=check_access_to_domain($_GET['id'],$db);
$smarty->assign('access_domain', $access_domain);

if (isset($_SESSION['superadmin']) &&
	isset($_GET['id']) &&
	$_SESSION['superadmin']=='y'||
	$_SESSION['admin']=='y' &&
	isset($_GET['id']) &&
	$access_domain )
{
	$sql=sprintf("SELECT * FROM domains WHERE id='%s'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('id', $_GET['id']);
	$smarty->assign('if_imap', $data['disableimap']);
	$smarty->assign('if_pop3', $data['disablepop3']);
	$smarty->assign('if_webmail', $data['disablewebmail']);
	$domain_id=$_GET['id'];
	
	$smarty->assign('domain',$data['dnsname']);
	$smarty->assign('dnsname',$data['dnsname']);
	
	if (get_forem_domain($data['id'],'users', $db)>=$data['max_email'] && $data['max_email']!=0 )
	{
		$smarty->assign('if_max_emails', 'y');
	}
	
	
	if (isset($_POST['submit']))
	{
	if (!empty($_POST['emailaddr']) && !empty($_POST['password']))
	{
		$full_email=$_POST['emailaddr']."@".$data['dnsname'];
		if (get_forem_domain($data['id'],'users', $db)>=$data['max_email'] && $data['max_email']!=0 )
		{
			$smarty->assign('if_max_emails', 'y');
		}
		else if (!email_valid($_POST['emailaddr']))
		{
			$smarty->assign('if_valid', 'n');
			$smarty->assign('eMail',$_POST['emailaddr'] );
			$smarty->assign('full_name',$_POST['full_name'] );
		}
		else if (email_exist($full_email,$db,0,0))
		{
			$smarty->assign('if_exists', 'y');
			$smarty->assign('full_email', 'y');
			$smarty->assign('eMail',$_POST['emailaddr'] );
			$smarty->assign('full_name',$_POST['full_name'] );
		}
		else if (strlen($_POST['password']) > $max_passwd_len || strlen($_POST['password']) < 3)
		{
			$smarty->assign('if_passwd_len', 'y');
			$smarty->assign('eMail',$_POST['emailaddr'] );
			$smarty->assign('full_name',$_POST['full_name'] );
		}
		else
		{
			if (isset($_POST['imap']) && 
			  $_POST['imap'] == "enable" &&
			check_domain_feature($_GET['id'],'imap',$db))
			{
				$imap="";
			}
			else
			{
				$imap="1";
			}
			if (isset($_POST['pop3']) && 
			  $_POST['pop3'] == "enable" &&
			check_domain_feature($_GET['id'],'pop3',$db))
			{
				$pop3="";
			}
			else
			{
				$pop3="1";
			}
			if (isset($_POST['webmail']) && 
			  $_POST['webmail'] == "enable" &&
			check_domain_feature($_GET['id'],'webmail',$db))
			{
				$webmail="";
			}
			else
			{
				$webmail="1";
			} 
			if ($config['cleartext_passwd']==1) {
				$cleartext=$_POST['password'];
			}
			else
			{
				$cleartext="";
			}
			$sql=sprintf("INSERT INTO users SET email='%s',domainid='%s',passwd='%s', full_name='%s',access='y',enew='1',disableimap='%s', disablepop3='%s',disablewebmail='%s',cpasswd='%s' ",
				$db->escapeSimple(strtolower($full_email)),
				$db->escapeSimple($_GET['id']),
				$db->escapeSimple($cleartext),
				$db->escapeSimple($_POST['full_name']),
				$db->escapeSimple($imap),
				$db->escapeSimple($pop3),
				$db->escapeSimple($webmail),
				$db->escapeSimple(crypt($_POST['password']))) ;
			$result=&$db->query($sql);
			$smarty->assign('if_email_saved', 'y');
			// activate System-Script
			if( $config['service_enabled'] == 'y' ) {
				$socket = @socket_create (AF_INET, SOCK_STREAM, 0);
				$result = @socket_connect ($socket, '127.0.0.1', $config['service_port']);
				@socket_close ($socket);
			}
		}
	}
	else
	{
		$smarty->assign('if_missing', 'y');
		$smarty->assign('eMail',$_POST['emailaddr'] );
		$smarty->assign('full_name',$_POST['full_name'] );
	}
	}// submit abgesendet
	

}
// Menuansicht
$smarty->assign('if_domain_view', 'y');
$smarty->assign('domain_id',$domain_id);

$smarty->assign('id',$_GET['id']);
$smarty->assign('template','email_add.tpl');
$smarty->display('structure.tpl');
?>
