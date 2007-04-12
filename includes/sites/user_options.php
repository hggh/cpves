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
	
	update_email_options($_SESSION['uid'],"del_virus_notifi",$_POST['del_virus_notifi'], 0);
	
	update_mailfilter('del_virus_notifi',$_SESSION['uid'], $del_virus_notifi,0,0);
	// activate System-Script
	run_systemscripts();
}


$del_virus_notifi = get_email_options($_SESSION['uid'],"del_virus_notifi", 0);
$smarty->assign('del_virus_notifi',$del_virus_notifi );


$smarty->assign('email', $_SESSION['email']);
?>