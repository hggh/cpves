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


//update DB:
if (isset($_POST['submit']) && !empty($_POST['forwardaddress']))
{
	// first delete all entries
	$sql=sprintf("DELETE FROM mailfilter WHERE email='%d' AND type LIKE 'forward%%'",
		$db->escapeSimple($_SESSION['uid']));
	$res=&$db->query($sql);
	
	if ($_POST['save_local']=="1") 
	{
		$type="forward_cc";
	}
	else
	{
		$type="forward_to";
	}
	$sql=sprintf("INSERT INTO mailfilter SET type='%s', filter='%s',prio='15', email='%d'",
		$db->escapeSimple($type),
		$db->escapeSimple($_POST['forwardaddress']),
		$db->escapeSimple($_SESSION['uid']));
	$res=&$db->query($sql);
	if ($res)
	{
		$smarty->assign('reload_page', 'y');
	}
	// activate System-Script
	if( $config['service_enabled'] == 'y' ) {
		$socket = @socket_create (AF_INET, SOCK_STREAM, 0);
		$result = @socket_connect ($socket, '127.0.0.1', $config['service_port']);
		@socket_close ($socket);
	}
}
if (isset($_POST['submit']) && isset($_POST['delete_forward']) && $_POST['delete_forward']=="on" )
{
	$sql=sprintf("UPDATE mailfilter SET active='0'  WHERE email='%d' AND type LIKE 'forward%%'",
		$db->escapeSimple($_SESSION['uid']));
	$res=&$db->query($sql);
	$smarty->assign('reload_page', 'y');
	// activate System-Script
	if( $config['service_enabled'] == 'y' ) {
		$socket = @socket_create (AF_INET, SOCK_STREAM, 0);
		$result = @socket_connect ($socket, '127.0.0.1', $config['service_port']);
		@socket_close ($socket);
	}
}




//SELECT *  FROM `mailfilter` WHERE `type` LIKE 'forward%'
$sql=sprintf("SELECT type,filter FROM mailfilter WHERE email='%d' AND active!=0 AND type LIKE 'forward%%'",
	$db->escapeSimple($_SESSION['uid']));
$result=&$db->query($sql);
if ($result->numRows()==1)
{
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	if ($data['type']=="forward_cc") // mit kopie ans lokale postfach
	{
		$smarty->assign('if_forward_cc', '1');
	}
	else // ohne kopie weiterleiten
	{
	}
	$smarty->assign('forwardaddress', $data['filter']);
}


$smarty->assign('email', $_SESSION['email']);
$smarty->assign('template','user_forward.tpl');
$smarty->display('structure.tpl');
$db->disconnect();

?>
