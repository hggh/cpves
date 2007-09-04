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

if (isset($_POST['save_option']))
{
	
	update_email_options($_SESSION['uid'],"del_virus_notifi",$_POST['del_virus_notifi'], 0);
	update_email_options($_SESSION['uid'],"del_dups_mails",$_POST['del_dups_mails'], 0);

	update_mailfilter('del_virus_notifi',$_SESSION['uid'], $_POST['del_virus_notifi'],0,0);
	update_mailfilter('del_dups_mails',$_SESSION['uid'], $_POST['del_dups_mails'],0,0);
	// activate System-Script
	run_systemscripts();
	if (is_dir(ROOT . "/includes/localization/" .$_POST['web_lang'] ) || $_POST['web_lang']="en_US") {
		update_email_options($_SESSION['uid'], 'web_lang', $_POST['web_lang'],0);
		$_SESSION['lang']=$_POST['web_lang'];
	}
}

$del_virus_notifi = get_email_options($_SESSION['uid'],"del_virus_notifi", 0);
$smarty->assign('del_virus_notifi',$del_virus_notifi );

$del_dups_mails = get_email_options($_SESSION['uid'],"del_dups_mails", 0);
$smarty->assign('del_dups_mails',$del_dups_mails );
$smarty->assign('table_lang', get_all_langs());
$smarty->assign('web_lang', $_SESSION['lang']);

$smarty->assign('email', $_SESSION['email']);
?>