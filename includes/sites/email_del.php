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
if (isset($_SESSION['superadmin']) &&
	isset($_GET['id']) &&
	is_numeric($_GET['did']) &&
	$_SESSION['superadmin']=='1'||
	$_SESSION['admin']=='1' &&
	isset($_GET['id']) &&
	is_numeric($_GET['did']) &&
	$access_domain )
{
	$sql=sprintf("SELECT email FROM users WHERE id='%s'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$edata=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('email', $edata['email']);
	
	if (isset($_POST['del_ok']) && $_POST['del_ok'] == "true")
	{

		$smarty->assign('if_del_ok', 'y');

		
		$sql=sprintf("UPDATE users SET enew='0' WHERE id='%d'",
			$db->escapeSimple($_GET['id']));
		$db->query($sql);
		
		$sql=sprintf("DELETE FROM admin_access WHERE email='%d'",
			$db->escapeSimple($_GET['id']));
		$db->query($sql);
		$sql=sprintf("DELETE FROM mailfilter WHERE email='%d'",
			$db->escapeSimple($_GET['id']));
		$db->query($sql);
		
		$sql=sprintf("DELETE FROM autoresponder WHERE email='%d'",
			$db->escapeSimple($_GET['id']));
		$db->query($sql);
		
		$sql=sprintf("DELETE FROM autoresponder_send WHERE email='%d'",
			$db->escapeSimple($_GET['id']));
		$db->query($sql);
		
		$sql=sprintf("DELETE FROM email_options WHERE email='%d'",
			$db->escapeSimple($_GET['id']));
		$db->query($sql);
		
		$sql=sprintf("DELETE FROM spamassassin WHERE username='%s'",
			$db->escapeSimple($edata['email']));
		$db->query($sql);
		
		header("Location: ?module=domain_view&did=".$_GET['did'] );
		
		
	}

} // ENDE ACCESS OK

// Menuansicht
$smarty->assign('if_domain_view', 'y');
$smarty->assign('domain_id',$_GET['did']);


$smarty->assign('id',$_GET['id']);
$smarty->assign('did',$_GET['did']);
?>