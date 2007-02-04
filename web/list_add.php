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
require_once('config.inc.php');
require_once('check_access.php');
$access_domain = check_access_to_domain($_GET['id'], $db);
$smarty->assign('access_domain', $access_domain);

if (isset($_SESSION['superadmin']) &&
	isset($_GET['id']) &&
	$_SESSION['superadmin']=='y'||
	$_SESSION['admin']=='y' &&
	isset($_GET['id']) &&
	$access_domain )
{
	$sql = sprintf("SELECT id,dnsname FROM domains WHERE id = %d",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$data = $result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('id', $_GET['id']);
	$smarty->assign('domain', $data['dnsname']);
	$dnsname = $data['dnsname'];
	$domain_id = $_GET['id'];
	
	
	if (isset($_POST['submit']))
	{
		if (! empty($_POST['address']) )
		{
			$full_list = $_POST['address'] . "@" . $data['dnsname'];
			if( isset($_POST['public']) ) {
			 $public = $_POST['public'];
			} else {
			 $public = 'n';
			}
			if (!email_valid($_POST['address']))
			{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_email_valid','y');
			$smarty->assign('address',$_POST['address'] );
			}
			else if( email_exist($full_list, $db, 0, 0) )
			{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_email_exits', 'y');
			$smarty->assign('full_email', 'y');
			$smarty->assign('address',$_POST['address'] );
			}
			else
			{
				$sql=sprintf("INSERT INTO lists SET address = '%s', domainid = '%s', public = '%s'",
				$db->escapeSimple(strtolower($full_list)),
				$db->escapeSimple($_GET['id']),
				$db->escapeSimple($public));
				$result = &$db->query($sql);
				$smarty->assign('success_msg','y');
				$smarty->assign('if_list_created', 'y');
			}
		}
		else
		{
			$smarty->assign('error_msg', 'y');
			$smarty->assign('if_error_missing_input', 'y');
			$smarty->assign('address',$_POST['address'] );
		}
	}
}

// Menuansicht
$smarty->assign('id',$_GET['id']);
$smarty->assign('if_domain_view', 'y');
$smarty->assign('domain_id',$domain_id);
$smarty->assign('dnsname', $dnsname);

$smarty->assign('template','list_add.tpl');
$smarty->display('structure.tpl');
?>