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

if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='y')
{
	$smarty->assign('username',$_SESSION['email']);
	if (isset($_POST['s_submit']))
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
			$smarty->assign('error_msg','y');
			$smarty->assign('if_new_passwd_not_same', 'y');
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
			$sql=sprintf("UPDATE adm_users SET passwd='%s',cpasswd='%s' WHERE username='%s'",
				$db->escapeSimple($cleartext),
				$db->escapeSimple(crypt($_POST['new_passwd1'])),
				$db->escapeSimple($_SESSION['email']));
			$res=&$db->query($sql);
			
			$smarty->assign('success_msg','y');
			$smarty->assign('if_password_changed', 'y');
			$_SESSION['cpasswd']=encrypt_passwd($_POST['new_passwd1']);
			
		}
	}

}
$smarty->assign('template','sadmin_passwd.tpl');
$smarty->display('structure.tpl');
?>