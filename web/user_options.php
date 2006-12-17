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

if (isset($_POST['save_option']))
{
	if (is_numeric($_POST['del_virus_notifi']) && $_POST['del_virus_notifi']==1)
	{
		$del_virus_notifi=1;
	}
	else
	{
		$del_virus_notifi=0;
	}
	$sql=sprintf("SELECT id,conf,extra,options FROM email_options WHERE email='%s' AND conf='del_virus_notifi'",
		$db->escapeSimple($_SESSION['uid']));
	$result=&$db->query($sql);
	if ($result->numRows() == 1 ) {
		$sql=sprintf("UPDATE email_options SET options='%s' WHERE email='%s' AND conf='del_virus_notifi'",
			$db->escapeSimple($del_virus_notifi),
			$db->escapeSimple($_SESSION['uid']));
	}
	else if($del_virus_notifi==1)
	{
		$sql=sprintf("INSERT INTO email_options SET options='1', email='%s', conf='del_virus_notifi'",
			$db->escapeSimple($_SESSION['uid']));
	}
	$result=&$db->query($sql);
	update_mailfilter('del_virus_notifi',$_SESSION['uid'], $db, $del_virus_notifi);
	
}



$sql=sprintf("SELECT id,conf,extra,options FROM email_options WHERE email='%s' AND conf='del_virus_notifi'",
	$db->escapeSimple($_SESSION['uid']));
$result=&$db->query($sql);
if ($result->numRows() ==1) {
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
}
else {
	$data['options']=0;
}
$smarty->assign('del_virus_notifi', $data['options']);










$smarty->assign('email', $_SESSION['email']);
$smarty->assign('template','user_options.tpl');
$smarty->display('structure.tpl');

?>