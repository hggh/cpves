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
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_subject_empty', 'y');
		$error=true;
	}
	else if (empty($_POST['msg']))
	{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_msg_empty', 'y');
		$error=true;
	}
	else if(strlen($_POST['esubject']) > 50)
	{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_subject_to_long', 'y');
		$error=true;
	}
	else
	{
		save_autoresponder($_SESSION['uid'],
			$_POST['active'],
			$_POST['esubject'],
			$_POST['msg']);
		// activate System-Script
		run_systemscripts();
		$smarty->assign('if_query_ok','y');
		
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