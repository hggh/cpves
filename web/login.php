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
include("config.inc.php");
session_start();
$no_login=0;
$_SESSION['superadmin']='n';
$_SESSION['admin']='n';
$_SESSION['manager']='n';
$_SESSION['ad_user']='n';

if (isset($_POST['email']) && isset($_POST['password']) && isset($_POST['login']) )
{

if ( (strpos($_POST['email'], '@')) !== false) // check admin oder user benutzername
{
	$sql=sprintf("SELECT * FROM users WHERE email='%s' AND access='y'",
		$db->escapeSimple($_POST['email']) );
	$result=&$db->query($sql);
	if (!$result)
	{
		$no_login=1;
	}
	else if ($result->numRows() ==1)
	{
		
		$daten=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if (check_password($daten['cpasswd'],$_POST['password']) == 1) 
		{
			$_SESSION['uid']=$daten['id'];
			$_SESSION['email']=$daten['email'];
			$_SESSION['cpasswd']=encrypt_passwd($_POST['password']);
			//$_SESSION['passwd']=$daten['passwd'];
			
			$_SESSION['full_name']=$daten['full_name'];
			$sql=sprintf("SELECT id FROM admin_access WHERE email='%s'",
				$db->escapeSimple($daten['id']));
			$res=&$db->query($sql);
			
			if ($res->numRows() > 0 )
			{
				$_SESSION['admin']='y';
			}
			// checke ob domain aktiv ist:
			$sql=sprintf("SELECT access FROM domains where id=%s",
				$db->escapeSimple($daten['domainid']));
			$res_domain=&$db->query($sql);
			
			$data_domain=$res_domain->fetchrow(DB_FETCHMODE_ASSOC);
			if ($data_domain['access']=='n')
			{
				$no_login=1;
			}
			else
			{
				$smarty->assign('if_login_ok', 'yes');
				logging($_SESSION['email']);
			}
		}
		else
		{
			$no_login=1;
		}
		
		

	}
	else
	{
		$no_login=1;
	}

}
else // wird ein admin username sein, also checke adm_users table
{
	$sql=sprintf("SELECT * FROM adm_users WHERE username='%s' AND access='y'",
		$db->escapeSimple($_POST['email']));
	$result = &$db->query($sql);
	if ($result->numRows() ==1)
	{
		$daten=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if (check_password($daten['cpasswd'],$_POST['password']) == 1)
		{
			$_SESSION['email']=$daten['username'];
			//$_SESSION['passwd']=$daten['passwd'];
			$_SESSION['cpasswd']=encrypt_passwd($_POST['password']);
			$_SESSION['superadmin']='y';
			$_SESSION['manager']=$daten['manager'];
			
			$smarty->assign('if_login_ok', 'yes');
			logging($_SESSION['email']);
		}
		else
		{
			$no_login=1;
		}

	}
	else
	{
		$no_login=1;
	}

}


}
else
{
	$no_login=1;
}
if ($no_login !=0)
{
	$smarty->assign('if_no_passwd', 'y');
}
if ($no_login==0)
{
	header("Location: index.php");
}
//$smarty->display('login.tpl');
$smarty->assign('if_login' , 'y');
$smarty->assign('template', 'login.tpl');
$smarty->display('structure.tpl');
?>