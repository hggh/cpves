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

$smarty->assign('if_superadmin', $_SESSION['superadmin']);
$smarty->assign('if_admin', $_SESSION['admin']);
$smarty->assign('if_manager',$_SESSION['manager']);
$smarty->assign('username', $_SESSION['email']);
$smarty->assign('if_spamassassin', $_SESSION['spamassassin']);
$smarty->assign('if_forwarding', $_SESSION['forwarding']);
$smarty->assign('p_mailarchive', $_SESSION['p_mailarchive']);
$smarty->assign('p_bogofilter', $_SESSION['p_bogofilter']);
$smarty->assign('p_mailfilter', $_SESSION['p_mailfilter']);
$no_login=0;
if (isset($_SESSION['superadmin']) &&
	 $_SESSION['superadmin']=='y' && 
	 isset($_SESSION['email']))
{
	$sql=sprintf("SELECT cpasswd FROM adm_users WHERE username='%s' AND access='y'",
		$db->escapeSimple($_SESSION['email']));
	$result=&$db->query($sql);
	if ($result->numRows() ==1)
	{
		$daten=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if (check_password($daten['cpasswd'],decrypt_passwd($_SESSION['cpasswd']))==1)
		{
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
else if (isset($_SESSION['email']) && isset($_SESSION['cpasswd']))
{
	$sql=sprintf("SELECT cpasswd FROM users WHERE email='%s' AND access='y'",
		$db->escapeSimple($_SESSION['email']));

	$result=&$db->query($sql);
	if ($result->numRows() ==1)
	{
		$daten=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if (check_password($daten['cpasswd'],decrypt_passwd($_SESSION['cpasswd']))==1)
		{
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
else
{
	$no_login=1;


}

if ($no_login==1)
{
	//$smarty->display('login.tpl');
	$smarty->assign('if_login' , 'y');
	$smarty->assign('template', 'login.tpl');
	$smarty->display('structure.tpl');
	exit();
}


if ($_SESSION['menu_user_open']== 'y')
{
	$smarty->assign('menu_user_open', 'y');
}
elseif ($_GET['user'] == 'y')
{
	$smarty->assign('menu_user_open', 'y');
	$_SESSION['menu_user_open']='y';
}

if ($_GET['user']== 'n')
{
	$smarty->assign('menu_user_open', 'n');
	$_SESSION['menu_user_open']='n';
}

// wenn nicht superadmin check autoresponder status und zeige ihn in der infobox an!
if ($_SESSION['superadmin'] != 'y' ) 
{
	$sql=sprintf("SELECT active FROM autoresponder WHERE email='%d'",
		$db->escapeSimple($_SESSION['uid']));
	$result=&$db->query($sql);
	if ($result->numRows() ==1)
	{
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$smarty->assign('if_autoresponder',$data['active']);
	}
	else
	{
		$smarty->assign('if_autoresponder','n');
	}
	$sql=sprintf("SELECT type,filter FROM mailfilter WHERE email='%d' AND active!=0 AND type LIKE 'forward%%'",
		$db->escapeSimple($_SESSION['uid']));
	$result=&$db->query($sql);
	if ($result->numRows()==1)
	{
		$smarty->assign('if_weiterleitung','y');
	}
	else
	{
		$smarty->assign('if_weiterleitung','n');
	}

}

?>