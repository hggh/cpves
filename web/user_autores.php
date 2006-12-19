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

if (isset($_POST['u_submit']))
{
	if (empty($_POST['esubject']))
	{
		$smarty->assign('if_subject_empty', 'y');
		$error=true;
	}
	else if (empty($_POST['msg']))
	{
		$smarty->assign('if_msg_empty','y');
		$error=true;
	}
	else if(strlen($_POST['esubject']) > 50)
	{
		$smarty->assign('if_subject_tolong','y');
		$error=true;
	}
	else
	{
		if (isset($_POST['id']) && is_numeric($_POST['id']))
		{
			$sql=sprintf("UPDATE autoresponder SET esubject='%s',msg='%s',active='%s' WHERE id='%d' AND email='%d'",
				$db->escapeSimple($_POST['esubject']),
				$db->escapeSimple($_POST['msg']),
				$db->escapeSimple($_POST['active']),
				$db->escapeSimple($_POST['id']),
				$db->escapeSimple($_SESSION['uid']) );
			
		}
		else
		{
			$sql=sprintf("INSERT INTO autoresponder SET esubject='%s',msg='%s',active='%s',email='%d'",
				$db->escapeSimple($_POST['esubject']),
				$db->escapeSimple($_POST['msg']),
				$db->escapeSimple($_POST['active']),
				$db->escapeSimple($_SESSION['uid']));
		}
		$result=&$db->query($sql);
		if ($_POST['active']== 'n')
		{
			$sql=sprintf("DELETE FROM autoresponder_send WHERE email='%d'",
				$db->escapeSimple($_SESSION['uid']));
			$result=&$db->query($sql);
			
			$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%d' AND type='autoresponder'",
				$db->escapeSimple($_SESSION['uid']));
			$result=&$db->query($sql);
		
		}
		elseif ($_POST['active']== 'y')
		{
			$sql=sprintf("INSERT INTO mailfilter SET email='%d', active='1',prio='10', type='autoresponder'",
				$db->escapeSimple($_SESSION['uid']));
			$result=&$db->query($sql);
		}
		$smarty->assign('if_query_ok','y');
		
	}
	// activate System-Script
	if( $config['service_enabled'] == 'y' ) {
		$socket = @socket_create (AF_INET, SOCK_STREAM, 0);
		$result = @socket_connect ($socket, '127.0.0.1', $config['service_port']);
		@socket_close ($socket);
	}
}


$sql=sprintf("SELECT id,email,active,msg,esubject FROM autoresponder WHERE email='%d'",
	$db->escapeSimple($_SESSION['uid']));
$result=&$db->query($sql);
if ($result->numRows()==1)
{
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$active=$data['active'];
	$msg=$data['msg'];
	$esubject=$data['esubject'];
	$id=$data['id'];
	
}
elseif($error)
{
	$active=$_POST['active'];
	$msg=$_POST['msg'];
	$esubject=$_POST['esubject'];
	
}
else
{
	$active='n';
	$msg=$config_autores_msg;
	$esubject=$config_autores_subject;
}

$smarty->assign('esubject', $esubject);
$smarty->assign('active', $active);
$smarty->assign('id', $id);
$smarty->assign('msg', $msg);
$smarty->assign('email', $_SESSION['email']);

$smarty->assign('template','user_autores.tpl');
$smarty->display('structure.tpl');
$db->disconnect();

?>
