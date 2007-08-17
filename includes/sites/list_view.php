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
	isset($_GET['did']) &&
	$_SESSION['superadmin']=='1'||
	$_SESSION['admin']=='1' &&
	isset($_GET['id']) &&
	isset($_GET['did']) &&
	$access_domain )
{

	// Change list state
	if( isset($_GET['cmd']) ) {
	 if( $_GET['cmd'] == 'priv' ) {
		$sql = sprintf("UPDATE lists SET public = 'n' WHERE id = %d",
			$db->escapeSimple($_GET['id']));
	 } elseif( $_GET['cmd'] == 'pub' ) {
		$sql = sprintf("UPDATE lists SET public = 'y' WHERE id = %d",
			$db->escapeSimple($_GET['id']));
	 }
	 $res = &$db->query($sql);
	}

	//del adresses:
	if (isset($_POST['del_addr']) && isset($_POST['addresses']))
	{
		foreach ($_POST['addresses'] as $key)
		{
			$sql = sprintf("DELETE FROM list_recp WHERE id = %d AND recp = '%s' LIMIT 1",
				$db->escapeSimple($_GET['id']),
				$db->escapeSimple($key));
			$res = &$db->query($sql);
		}
	}
	//del adresses ENDE

	//hinzufugen:
	if (isset($_POST['submit_add']) && ! empty($_POST['add_address']))
	{
		$sql = sprintf("SELECT COUNT(*) AS num FROM list_recp WHERE id = %d AND recp = '%s'",
			$db->escapeSimple($_GET['id']),
			$db->escapeSimple($_POST['add_address']));
		$res = &$db->query($sql);
		$row = $res->fetchrow(DB_FETCHMODE_ASSOC);
		if( 0 == $row['num'] ) {
		 $sql = sprintf("INSERT INTO list_recp SET id = %d, recp = '%s'",
		 	$db->escapeSimple($_GET['id']),
			$db->escapeSimple($_POST['add_address']));
			$res = &$db->query($sql);
			$smarty->assign('email_added', 'y');
		} else {
			$smarty->assign('email_added', 'n');
			$smarty->assign('email_there', 'y');
		}
	} //END hinzufugen
	$sql = sprintf("SELECT id,address,public FROM lists WHERE id = %d",
		$db->escapeSimple($_GET['id']));
	$result = &$db->query($sql);
	$data = $result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('address', $data['address']);
	$smarty->assign('public', $data['public']);

	$sql = sprintf("SELECT * FROM list_recp WHERE id = %d ORDER by recp",
		$db->escapeSimple($_GET['id']));
	$res = &$db->query($sql);
	$recps = array();
	while( $row = $res->fetchrow(DB_FETCHMODE_ASSOC) ) {
		$recps[] = $row['recp'];
	}
	
	$sql = sprintf("SELECT dnsname,id FROM domains WHERE id = %d",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$dnsname = $data['dnsname'];
	$domain_id = $data['id'];
	
	
	$smarty->assign('recps',$recps);
	
} // ENDE ACCESS OK
$smarty->assign('id',$_GET['id']);
$smarty->assign('domainid',$_GET['did']);
?>