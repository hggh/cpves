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
$access_domain=check_access_to_domain($_GET['id'], $db);
$smarty->assign('access_domain', $access_domain);

if (isset($_SESSION['superadmin']) &&
	isset($_GET['id']) &&
	$_SESSION['superadmin']=='y'||
	$_SESSION['admin']=='y' &&
	isset($_GET['id']) &&
	$access_domain )
{
	$sql=sprintf("SELECT dnsname FROM domains WHERE id='%d'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	
	$smarty->assign('dnsname', $data['dnsname']);
	
	//neue Catchall speichern und weiterleiten....
	if (isset($_POST['add']) && !empty($_POST['eto']))
	{
		if (isset($_POST['eid']) && is_numeric($_POST['eid']))
		{
		$sql=sprintf("SELECT id FROM forwardings WHERE domainid='%d' AND efrom REGEXP '^@' AND id!='%d'",
			$db->escapeSimple($_GET['id']),
			$db->escapeSimple($_POST['eid']));
		}
		else
		{
		$sql=sprintf("SELECT id FROM forwardings WHERE domainid='%d' AND efrom REGEXP '^@'",
			$db->escapeSimple($_GET['id']));
		}
		$result=&$db->query($sql);
		if ($result->numRows()==0)
		{
			if (isset($_POST['eid']))
			{
			$sql=sprintf("UPDATE forwardings SET eto='%s' WHERE id='%d'",
				$db->escapeSimple($_POST['eto']),
				$db->escapeSimple($_POST['eid']));
			}
			else
			{
			$sql=sprintf("INSERT INTO forwardings SET efrom='%s', eto='%s', access='y',domainid='%d'",
				$db->escapeSimple('@'.$data['dnsname']),
				$db->escapeSimple($_POST['eto']),
				$db->escapeSimple($_GET['id']));
			}
			$result=&$db->query($sql);
			
			$smarty->assign('success_msg', 'y');
			$smarty->assign('if_catchall_saved', 'y');
		}
	}
	//neue Catchall speichern und weiterleiten.... ENDE CODE
	
	$sql=sprintf("SELECT eto,id FROM forwardings WHERE domainid='%d' AND efrom REGEXP '^@'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	if ($result->numRows()==1)
	{
		$smarty->assign('if_edit','y');
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$smarty->assign('eto', $data['eto']);
		$smarty->assign('eid', $data['id']);
	}






} // ENDE ACCESS OK
$smarty->assign('id',$_GET['id']);

// Menuansicht
$smarty->assign('if_domain_view', 'y');
$smarty->assign('domain_id',$_GET['id']);


$smarty->assign('template','forward_catchall.tpl');
$smarty->display('structure.tpl');
?>