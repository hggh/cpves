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
$access_domain=check_access_to_domain($_GET['did'], $db);
$smarty->assign('access_domain', $access_domain);

if (isset($_SESSION['superadmin']) &&
	isset($_GET['id']) &&
	isset($_GET['did']) &&
	$_SESSION['superadmin']=='y'||
	$_SESSION['admin']=='y' &&
	isset($_GET['id']) &&
	isset($_GET['did']) &&
	$access_domain )
{
	$sql=sprintf("SELECT * FROM domains WHERE id='%s'",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$dnsname=$data['dnsname'];
	$domain_id=$_GET['did'];
	
	
	$smarty->assign('domain',$data['dnsname']);
	$dnsname=$data['dnsname']; // dnsname 
	$smarty->assign('if_imap', $data['disableimap']);
	$smarty->assign('if_pop3', $data['disablepop3']);
	$smarty->assign('if_webmail', $data['disablewebmail']);
	$sql=sprintf("SELECT * FROM users WHERE id='%s'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$edata=$result->fetchrow(DB_FETCHMODE_ASSOC);
	
	
	
	$full_email=$edata['email'];
	$smarty->assign('full_email', $full_email);
	$smarty->assign('full_name', $edata['full_name']);
	$smarty->assign('if_imapdisable', $edata['disableimap']);
	$smarty->assign('if_pop3disable', $edata['disablepop3']);
	$smarty->assign('if_webmaildisable', $edata['disablewebmail']);

	
	//adde domainadmin:
	if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='y'
		&& isset($_POST['adddns']) && is_numeric($_POST['add_domain']) )
	{
		$sql=sprintf("SELECT id FROM admin_access WHERE email='%d' AND domain='%d'",
			$db->escapeSimple($_GET['id']),
			$db->escapeSimple($_POST['add_domain']));
		$res=&$db->query($sql);
		if ($res->numRows() == 0)
		{
			$sql=sprintf("INSERT INTO admin_access SET email='%d', domain='%d'",
				$db->escapeSimple($_GET['id']),
				$db->escapeSimple($_POST['add_domain']));
			$res=&$db->query($sql);
		}
	}
	
	//remove domainadmin: 
	if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='y' 
		&& isset($_GET['del']) && is_numeric($_GET['del']))
	{
		$sql=sprintf("DELETE FROM admin_access WHERE id='%d'",
			$db->escapeSimple($_GET['del']));
		$res=&$db->query($sql);
	}
	
	
	// Liste AdminDomains
	if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='y' )
	{
		$sql=sprintf("SELECT b.dnsname,a.id FROM admin_access AS a LEFT JOIN domains as b ON b.id=a.domain WHERE a.email='%s'",
			$db->escapeSimple($_GET['id']));
		$res_admin=&$db->query($sql);
		$table_admins= array();
		$smarty->assign('ava_ad_domains',$res_admin->numRows());
		while($data=$res_admin->fetchrow(DB_FETCHMODE_ASSOC))
		{
			array_push($table_admins, array(
				'dnsname' => $data['dnsname'],
				'del_id' => $data['id'])
			);
		} //ENDE WHILE 
		$smarty->assign('table_admins', $table_admins);
		
		$sql=sprintf("SELECT a.dnsname,b.email,a.id FROM domains AS a LEFT JOIN admin_access AS b ON b.domain = a.id");
		$res_dns=&$db->query($sql);
		$table_adddns= array();
		while($data=$res_dns->fetchrow(DB_FETCHMODE_ASSOC))
		{
			if ($data['email'] != $_GET['id'])
			{
				array_push($table_adddns, array(
				'dnsname' => $data['dnsname'],
				'dnsid' => $data['id'])
				);
			}
		}
		if (count($table_adddns)==0) {
			$smarty->assign('if_nodomains_found', 'y');
		}
		$smarty->assign('table_adddns', $table_adddns);
		
	}//ende Liste adminDomains
	
	// wenn submit dann aendere daten:
	if (isset($_POST['submit']))
	{
			if (isset($_POST['imap']) && 
			  $_POST['imap'] == "enable" &&
			check_domain_feature($_GET['id'],'imap',$db))
			{
				$imap="0";
			}
			else
			{
				$imap="1";
			}
			if (isset($_POST['pop3']) && 
			  $_POST['pop3'] == "enable" &&
			  check_domain_feature($_GET['id'],'pop3',$db))
			{
				$pop3="0";
			}
			else
			{
				$pop3="1";
			}
			if (isset($_POST['webmail']) && 
			  $_POST['webmail'] == "enable" &&
			  check_domain_feature($_GET['id'],'webmail',$db))
			{
				$webmail="0";
			}
			else
			{
				$webmail="1";
			}
			if (isset($_POST['password']) && !empty($_POST['password']))
			{
				if (strlen($_POST['password']) > $max_passwd_len || strlen($_POST['password']) < 3)
				{
					$smarty->assign('if_passwd_len', 'y');
					$smarty->assign('full_name',$_POST['full_name'] );
					$error=true;
				}
				else
				{
					$password=$_POST['password'];
					$cpasswd=crypt($_POST['password']);
				}
			} 
			else
			{
				$password=$edata['passwd'];
				$cpasswd=$edata['cpasswd'];
			}
			if ($config['cleartext_passwd']==1) {
				$cleartext=$password;
			}
			else
			{
				$cleartext="";
			}
			if (!$error)
			{
				$sql=sprintf("UPDATE users SET passwd='%s', full_name='%s', disableimap='%d', disablepop3='%d',disablewebmail='%d',
				cpasswd='%s' WHERE id='%d' ",
					$db->escapeSimple($cleartext),
					$db->escapeSimple($_POST['full_name']),
					$db->escapeSimple($imap),
						$db->escapeSimple($pop3),
					$db->escapeSimple($webmail),
					$db->escapeSimple($cpasswd),
					$db->escapeSimple($_GET['id'])) ;
				$result=&$db->query($sql);
				$smarty->assign('if_email_saved', 'y');
			}
	}//ende update DB

} // ENDE ACCESS OK


// Menuansicht
$smarty->assign('if_domain_view', 'y');
$smarty->assign('domain_id',$domain_id);
$smarty->assign('dnsname', $dnsname);


$smarty->assign('id',$_GET['id']);
$smarty->assign('domainid',$_GET['did']);
$smarty->assign('template','email_view.tpl');
$smarty->display('structure.tpl');
?>
