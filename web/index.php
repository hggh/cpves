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

if (isset($_GET['user']) && $_GET['user']=='y' || $_SESSION['ad_user']=='y')
{
	$smarty->assign('if_ad_user','y');
	$_SESSION['ad_user']='y';
}
if (isset($_GET['user']) && $_GET['user']=='n')
{
	$smarty->assign('if_ad_user','n');
	$_SESSION['ad_user']='n';
}


//Enable or Disable Domain BEGIN
if (isset($_SESSION['superadmin']) && 
	$_SESSION['superadmin']=='y'&& 
	is_numeric($_POST['id']) &&
	isset($_POST['state']) )
{
	if ($_POST['state']=='disable')
	{
		$sql=sprintf("UPDATE domains SET ACCESS='n' WHERE id=%s",
			$db->escapeSimple($_POST['id']));
	}
	else if ($_POST['state']=='enable')
	{
		$sql=sprintf("UPDATE domains SET ACCESS='y' WHERE id=%s",
			$db->escapeSimple($_POST['id']));
	}
	$result=&$db->query($sql);
	if (!$result)
	{
		echo "ERROR! Something went wrong!";
	}
}
//ENABLE or DISABLE DOMAIN


if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='y' || isset($_SESSION['admin']) && $_SESSION['admin']=='y' && $_SESSION['ad_user']!='y')
{

if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='y' )
{
	$sql="SELECT * FROM domains ORDER BY dnsname";
}
else
{
	$sql=sprintf("SELECT * FROM admin_access WHERE email=%s",
		$db->escapeSimple($_SESSION['uid']));
	$result=&$db->query($sql);
	$sql="SELECT * FROM domains WHERE id=";
	$e=0;
	while($daten=$result->fetchrow(DB_FETCHMODE_ASSOC))
	{
		if ($e==0)
		{
			$sql.="'".$daten['domain']. "'";
		}
		else
		{
			$sql.=" OR id='".$daten['domain']. "'";
		}
		$e++;
		
	}
	$sql.=" ORDER BY dnsname";
}

$table_data = array();
$result = $db->query($sql);
while($row = $result->fetchrow(DB_FETCHMODE_ASSOC))
{
	array_push($table_data, array(
         'dnsname' => $row['dnsname'],
         'access' => $row['access'],
	 'count_forward' => get_forem_domain($row['id'],'forwardings',$db), 
	 'count_email' => get_forem_domain($row['id'],'users',$db),
	 'id' => $row['id'],
	 'access' => $row['access'],
	 'dnote' => $row['dnote']
         )
      );
      $i++; 
} 
}
//check for spam:
$test='n';
if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='y'&& $test=='y')
{

require_once 'Net/DNSBL.php';
$dnsbl = new Net_DNSBL();

$table_spam=array();
while (list($key, $value) = each($ar_spam))
//foreach($ar_spam as $value)
{
	$dnsbl->setBlacklists($value);
	if ($dnsbl->isListed($server_ip))
	{
		$smarty->assign('if_blacklist_listet', 'y');
		array_push($table_spam, array('spam' => $value));
	}
	
}

$smarty->assign('ipaddr',$server_ip ); 
$smarty->assign('table_spam', $table_spam);

} // SPAM CHECK ENDE


//email user part:
if ($_SESSION['superadmin']=='n' && $_SESSION['admin']=='n' | $_SESSION['ad_user'] == 'y' && $_SESSION['manager']=='n')
{
	$smarty->assign('if_user_index','y');
	$smarty->assign('full_name', $_SESSION['full_name']);
	$smarty->assign('email', $_SESSION['email']);
	if (isset($_POST['u_submit']))
	{
		if (!isset($_POST['new_passwd1']) || empty($_POST['new_passwd1']) ||
		    !isset($_POST['new_passwd2']) || empty($_POST['new_passwd2']))
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_password_empty','y');
		}
		else if (strlen($_POST['new_passwd2']) > $max_passwd_len ||
			 strlen($_POST['new_passwd2']) < 3)
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_password_long', 'y');

		}
		else if($_POST['new_passwd1'] !=$_POST['new_passwd2'] )
		{
			$smarty->assign('passwd_not_true', 'y');
		}
		else if(decrypt_passwd($_SESSION['cpasswd']) != $_POST['old_passwd'])
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_password_old_wrong','y');
		}
		else
		{
			if ($config['cleartext_passwd']==1) {
				$cleartext=$_POST['new_passwd1'];
			}
			else
			{
				$cleartext="";
			}
			$sql=sprintf("UPDATE users SET passwd='%s',cpasswd='%s' WHERE id='%d'",
				$db->escapeSimple($cleartext),
				$db->escapeSimple(crypt($_POST['new_passwd1'])),
				$db->escapeSimple($_SESSION['uid']));
			$res=&$db->query($sql);
			
			$smarty->assign('passwd_changed', 'y');
		}
	}
}



$smarty->assign('table_data', $table_data);
$smarty->assign('template','index.tpl');
$smarty->display('structure.tpl');
$db->disconnect();
?>