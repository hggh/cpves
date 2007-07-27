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
include( ROOT . "/includes/localization/de_DE/labels.inc.php");
include( ROOT . "/includes/localization/de_DE/headline.inc.php");
$smarty->assign('labels', $labels);
$smarty->assign('headline', $headline);
if (!isset($_POST['login'])  ) {
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
	case 'domain_del':
		$site="domain_del";
		break;
	case 'list_add':
		$site="list_add";
		break;
	case 'list_del':
		$site="list_del";
		break;
	case 'list_view':
		$site="list_view";
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
	case 'sadmin_options':
		$site="sadmin_options";
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
	case 'user_archivemail':
		$site="user_archivemail";
		break;
	case 'user_mailfilter':
		$site="user_mailfilter";
		break;
	case 'user_salearn':
		$site="user_salearn";
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

// Build Menu Structure
if (ereg("_", $site) && isset($_GET['did']) && is_numeric($_GET['did'])) {
	list($siteB, $siteA) = split("_", $site);
	if ($siteB == "email" || $siteB == "forward" ||
	$siteB == "domain" ||$siteB == "list") {
	    //Build up Menu
	    $smarty->assign('if_domain_view', 'y');
	    $smarty->assign('did',$_GET['did']);
	    
	    $access_domain=check_access_to_domain($_GET['did'], $db);
	    $smarty->assign('access_domain', $access_domain);
	}
}
// Normal user fix for viewing correct menu:
if ((ereg("_", $site) && substr($site,0, strpos($site, '_'))== 'user')) {
	$sql=sprintf("SELECT email FROM users WHERE id='%s'",
		$db->escapeSimple($_SESSION['uid']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('email', $data['email']);

	if (isset($_GET['user'])
	    && $_GET['user']=='y' || $_SESSION['ad_user']=='y') {
		$smarty->assign('if_ad_user','y');
		$_SESSION['ad_user']='y';
	}
	if (isset($_GET['user']) && $_GET['user']=='n') {
		$smarty->assign('if_ad_user','n');
		$_SESSION['ad_user']='n';
	}

}

// Fetch Domainname from $_GET['did']
if (isset($_GET['did']) && is_numeric($_GET['did'])) {
	$sql=sprintf("SELECT dnsname,p_spamassassin FROM domains WHERE id='%s'",
		$db->escapeSimple($_GET['did']) );
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('dnsname', $data['dnsname']);
	$smarty->assign('did',$_GET['did']);
}

if (! check_access_to_site($site)) {
	$site="main";
}

require_once(ROOT . "/includes/sites/" . $site . ".php");
$smarty->assign('template', $site . ".tpl");

$smarty->display('structure.tpl');
$db->disconnect();
?>