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
$access_domain=check_access_to_domain($_GET['domainid'], $db);
$smarty->assign('access_domain', $access_domain);

if (isset($_SESSION['superadmin']) &&
	isset($_GET['id']) &&
	is_numeric($_GET['domainid']) &&
	$_SESSION['superadmin']=='y'||
	$_SESSION['admin']=='y' &&
	isset($_GET['id']) &&
	is_numeric($_GET['domainid']) &&
	$access_domain )
{
	$sql = sprintf("SELECT address FROM lists WHERE id = %d",
		$db->escapeSimple($_GET['id']));
	$res = &$db->query($sql);
	$row = $res->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('address', $row['address']);

	$sql = sprintf("SELECT recp FROM list_recp WHERE id = %d",
		$db->escapeSimple($_GET['id']));
	$res = &$db->query($sql);
	$recps = array();
	while($row = $res->fetchrow(DB_FETCHMODE_ASSOC)) {
		$recps[] = $row['recp'];
	}


	$smarty->assign('recps',$recps);
	
	if (isset($_POST['del_ok']) && $_POST['del_ok'] == "true")
	{
		$smarty->assign('if_del_ok', 'y');
		$sql=sprintf("DELETE FROM lists WHERE id = %d",
			$db->escapeSimple($_GET['id']));
		$db->query($sql);
	}

} // ENDE ACCESS OK
// Menuansicht
$smarty->assign('if_domain_view', 'y');
$smarty->assign('domain_id',$_GET['domainid']);

$smarty->assign('id',$_GET['id']);
$smarty->assign('domainid',$_GET['domainid']);
$smarty->assign('template','list_del.tpl');
$smarty->display('structure.tpl');
?>
