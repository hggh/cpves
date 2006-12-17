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
			$smarty->assign('passwd_empty', 'y');
		}
		else if (strlen($_POST['new_passwd2']) > $max_passwd_len ||
			 strlen($_POST['new_passwd2']) < 3)
		{
			$smarty->assign('passwd_len', 'y');
		}
		else if($_POST['new_passwd1'] !=$_POST['new_passwd2'] )
		{
			$smarty->assign('passwd_not_true', 'y');
		}
		else if(decrypt_passwd($_SESSION['cpasswd']) != $_POST['old_passwd'])
		{
			$smarty->assign('old_passwd_wrong', 'y');
		}
		else
		{
			$sql=sprintf("UPDATE adm_users SET passwd='%s',cpasswd='%s' WHERE username='%s'",
				$db->escapeSimple($_POST['new_passwd1']),
				$db->escapeSimple(crypt($_POST['new_passwd1'])),
				$db->escapeSimple($_SESSION['email']));
			$res=&$db->query($sql);
			
			$smarty->assign('passwd_changed', 'y');
		}
	}

}
$smarty->assign('template','sadmin_passwd.tpl');
$smarty->display('structure.tpl');
?>