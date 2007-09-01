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
if (isset($_SESSION['superadmin']))    $smarty->assign('if_superadmin', $_SESSION['superadmin']);
if (isset($_SESSION['admin']))         $smarty->assign('if_admin', $_SESSION['admin']);
if (isset($_SESSION['manager']))       $smarty->assign('if_manager',$_SESSION['manager']);
if (isset($_SESSION['email']))         $smarty->assign('username', $_SESSION['email']);
if (isset($_SESSION['spamassassin']))  $smarty->assign('if_spamassassin', $_SESSION['spamassassin']);
if (isset($_SESSION['forwarding']))    $smarty->assign('if_forwarding', $_SESSION['forwarding']);
if (isset($_SESSION['p_mailarchive'])) $smarty->assign('p_mailarchive', $_SESSION['p_mailarchive']);
if (isset($_SESSION['p_bogofilter']))  $smarty->assign('p_bogofilter', $_SESSION['p_bogofilter']);
if (isset($_SESSION['p_mailfilter']))  $smarty->assign('p_mailfilter', $_SESSION['p_mailfilter']);
if (isset($_SESSION['p_spam_del']))    $smarty->assign('p_spam_del', $_SESSION['p_spam_del']);
if (isset($_SESSION['p_sa_learn']))    $smarty->assign('p_sa_learn', $_SESSION['p_sa_learn']);
if (isset($_SESSION['p_fetchmail']))   $smarty->assign('p_fetchmail',$_SESSION['p_fetchmail']);
if (isset($_SESSION['p_autores_xheader']))   $smarty->assign('p_autores_xheader',$_SESSION['p_autores_xheader']);


$no_login=0;
if (isset($_SESSION['superadmin']) &&
	 $_SESSION['superadmin']=='1' && 
	 isset($_SESSION['email']))
{
	$sql=sprintf("SELECT cpasswd FROM adm_users WHERE username='%s' AND access='1'",
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
	$sql=sprintf("SELECT cpasswd FROM users WHERE email='%s' AND access='1'",
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


if (isset($_SESSION['menu_user_open']) && $_SESSION['menu_user_open']== 'y')
{
	$smarty->assign('menu_user_open', 'y');
}
elseif (isset($_GET['user']) && $_GET['user'] == 'y')
{
	$smarty->assign('menu_user_open', 'y');
	$_SESSION['menu_user_open']='y';
}

if (isset($_GET['user']) && $_GET['user']== 'n')
{
	$smarty->assign('menu_user_open', 'n');
	$_SESSION['menu_user_open']='n';
}
?>