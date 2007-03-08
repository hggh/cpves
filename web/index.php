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
require_once("../root.php");
require_once( ROOT . "/includes/config.inc.php");
if (!isset($_POST['login'])) {
	include(ROOT . "/includes/check_access.php");
}

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



$site="";
switch($_GET['module']) {
	case 'login':
		$site="login";
		break;
	case 'domain_view':
		$site="domain_view";
		break;
	case 'domain_add':
		$site="domain_add";
		break;
	case 'email_add':
		$site="email_add";
		break;
	case 'email_del':
		$site="email_del";
		break;
	case 'email_view':
		$site="email_view";
		break;
	case 'forward_add':
		$site="forward_add";
		break;
	case 'forward_del':
		$site="forward_del";
		break;
	case 'forward_view':
		$site="forward_view";
		break;
	case 'forward_catchall':
		$site="forward_catchall";
		break;
	case 'sadmin_edit':
		$site="sadmin_edit";
		break;
	case 'sadmin_add':
		$site="sadmin_add";
		break;
	case 'sadmin_passwd':
		$site="sadmin_passwd";
		break;
	case 'sadmin_view':
		$site="sadmin_view";
		break;
	case 'user_autores':
		$site="user_autores";
		break;
	case 'user_spam':
		$site="user_spam";
		break;
	case 'user_forward':
		$site="user_forward";
		break;
	case 'user_options':
		$site="user_options";
		break;
	case 'logout':
		$_SESSION = array();
		session_destroy();
		$smarty->assign('if_login' , 'y');
		$site="login";
		break;
	default:
		$site="main";
	
}


require_once(ROOT . "/includes/sites/" . $site . ".php");
$smarty->assign('template', $site . ".tpl");
$smarty->display('structure.tpl');
$db->disconnect();
?>