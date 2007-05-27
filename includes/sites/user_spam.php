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

//Save Options to database:
if (isset($_POST['save_option']) && $_SESSION['spamassassin']==1)
{
	if (isset($_POST['spamassassin_active']) && is_numeric($_POST['spamassassin_active']))
	{
		update_email_options($_SESSION['uid'],"spamassassin",$_POST['spamassassin_active'],0);
		update_email_options($_SESSION['uid'],"bogofilter",$_POST['bogofilter_active'],0);
		//FIXME: in mailfilter ein und austragen!
		if ($_POST['spamassassin_active']=='1')
		{
			//INSERT INTO
			$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%d' AND type='spamassassin'",
				$db->escapeSimple($_SESSION['uid']));
			$result=&$db->query($sql);
			$sql=sprintf("INSERT INTO mailfilter SET email='%d', active='1',prio='5', type='spamassassin'",
				$db->escapeSimple($_SESSION['uid']));
			$result=&$db->query($sql);
		}
		else if($_POST['spamassassin_active']=='0')
		{
			//reset filter
			$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%d' AND type='spamassassin'",
				$db->escapeSimple($_SESSION['uid']));
			$result=&$db->query($sql);
		}
	}
	if (isset($_POST['rewrite_subject']) && is_numeric($_POST['rewrite_subject']))
	{
		if (strlen($_POST['rewrite_subject_header'])>15)
		{
			$smarty->assign('error_msg', 'y');
			$smarty->assign('if_wrong_sa_subjecttag','y');
		}
		else
		{
			if ($_POST['rewrite_subject']==0)
			{
				$rewrite_subject='';
			}
			elseif ($_POST['rewrite_subject']==1)
			{
				$rewrite_subject=$_POST['rewrite_subject_header'];
			
			}
			update_spamassassin_value($_SESSION['email'],"rewrite_header subject",$rewrite_subject );
			
		}
	}
	if (isset($_POST['threshold']) && !empty($_POST['threshold']))
	{
		if (ereg("^[0-9]{1,2}\.[0-9]$",$_POST['threshold'])==0)
		{
			$smarty->assign('error_msg', 'y');
			$smarty->assign('if_wrong_sa_threshold', 'y');
		}
		else
		{
			update_spamassassin_value($_SESSION['email'],"required_score",$_POST['threshold']);
		}
	}
	//save move_spam 
	if ($_POST['move_spam']==0) {
		$sql=sprintf("UPDATE users SET move_spam=NULL WHERE id='%d'",
			$db->escapeSimple($_SESSION['uid']));
		$result=&$db->query($sql);
		//reset filter
		$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%d' AND type='move_spam'",
			$db->escapeSimple($_SESSION['uid']));
		$result=&$db->query($sql);
	}
	elseif ($_POST['move_spam']==1) {
		//reset filter
		$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%d' AND type='move_spam'",
			$db->escapeSimple($_SESSION['uid']));
		$result=&$db->query($sql);
		
		$sql=sprintf("UPDATE users SET move_spam='%s' WHERE id='%d'",
			$db->escapeSimple($_POST['spam_folder']),
			$db->escapeSimple($_SESSION['uid']));
		$result=&$db->query($sql);
		//INSERT INTO
		$sql=sprintf("INSERT INTO mailfilter SET email='%d', active='1',prio='20', type='move_spam',filter='%s'",
			$db->escapeSimple($_SESSION['uid']),
			$db->escapeSimple($_POST['spam_folder']));
		$result=&$db->query($sql);
		
	}
	//save the del_known_spam option
	if (is_numeric($_POST['del_known_spam']) && $_POST['del_known_spam']== 1) {
		if (ereg("^[0-9]{1,2}\.[0-9]$",$_POST['del_known_spam_value'])==0)
		{
			$smarty->assign('error_msg', 'y');
			$smarty->assign('if_wrong_del_known_spam_value', 'y');
		}
		elseif (get_spamassassin_value($_SESSION['email'], "required_score", "5.0") >= $_POST['del_known_spam_value'] ) {
			$smarty->assign('error_msg', 'y');
			$smarty->assign('if_wrong_del_known_spam_value_lower', 'y');
		}
		else
		{
			update_email_options($_SESSION['uid'],'del_known_spam_value',$_POST['del_known_spam_value'],0);
			update_email_options($_SESSION['uid'],'del_known_spam','1',0);
		}
	}
	else {
		update_email_options($_SESSION['uid'],'del_known_spam','0',0);
	}


	// activate System-Script
	run_systemscripts();
	
}
// SAVE new whitelist
if (isset($_POST['white_add']) && isset($_POST['white_add_email']) && !empty($_POST['white_add_email']))
{
	 if (ereg("^(.*)@(.*)$",$_POST['white_add_email'])==1)
	 {
	 	$sql=sprintf("SELECT value FROM spamassassin WHERE username='%s' AND preference='whitelist_from'",
			$db->escapeSimple($_SESSION['email']));
		$result=&$db->query($sql);
		unset($sql);
		if ($result->numRows()==0)
		{
			$sql=sprintf("INSERT INTO spamassassin SET username='%s', preference='whitelist_from', value='%s'",
				$db->escapeSimple($_SESSION['email']),
				$db->escapeSimple($_POST['white_add_email']));
		}
		else
		{
			$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
			if (empty($data['value']))
			{
				$data['value']=$_POST['white_add_email'];
			}
			else
			{
				$data['value'].=" ".$_POST['white_add_email'];
			}
			$sql=sprintf("UPDATE spamassassin SET value='%s' WHERE username='%s' AND preference='whitelist_from'",
				$db->escapeSimple($data['value']),
				$db->escapeSimple($_SESSION['email']));
		}
		if (!empty($sql))
		{
			$result=&$db->query($sql);
		}
	 }

}

$spamassassin=get_email_options($_SESSION['uid'],"spamassassin", 0);
$bogofilter=get_email_options($_SESSION['uid'],"bogofilter",0);
$del_known_spam=get_email_options($_SESSION['uid'],"del_known_spam",0);
$del_known_spam_value=get_email_options($_SESSION['uid'],"del_known_spam_value",10);
$smarty->assign('bogofilter_active', $bogofilter);
$smarty->assign('spamassassin_active', $spamassassin);
$smarty->assign('email', $_SESSION['email']);
$smarty->assign('del_known_spam', $del_known_spam);
$smarty->assign('del_known_spam_value', $del_known_spam_value);

// Database output rewrite_header subject
$sa_header = get_spamassassin_value($_SESSION['email'], "rewrite_header subject", false);
if ($sa_header==false) {
	$smarty->assign('rewrite_subject', '0');
	$smarty->assign('rewrite_subject_header', "*** SPAM ***");
}
else {
	$smarty->assign('rewrite_subject', '1');
	$smarty->assign('rewrite_subject_header', $sa_header);
}

//get IMAP Folders
$folders =list_imap_folders($config['imap_server'],$_SESSION['email'],decrypt_passwd($_SESSION['cpasswd']));
if ($folders== false ) {
	$smarty->assign('imap_folder_exits', 0);
}
else {
	$smarty->assign('imap_folder_exits', 1);
	$smarty->assign('available_folders',$folders);
}


//move spam feature:
$sql=sprintf("SELECT move_spam FROM users WHERE id='%s'",
	$db->escapeSimple($_SESSION['uid']));
$result=&$db->query($sql);
$move_spam=$result->fetchrow(DB_FETCHMODE_ASSOC);
if ($move_spam['move_spam']==NULL)
{
	$smarty->assign('move_spam','0');
}
else
{
	$smarty->assign('move_spam', '1');
	$smarty->assign('move_spam_folder',$move_spam['move_spam'] );
}

// Database output required_score
$sa_threshold = get_spamassassin_value($_SESSION['email'], "required_score", "5.0");
$smarty->assign('threshold', $sa_threshold);


//Database output whitelist_from
$sql=sprintf("SELECT value FROM spamassassin WHERE username='%s' AND preference='whitelist_from'",
	$db->escapeSimple($_SESSION['email']));
$result=&$db->query($sql);
if ($result->numRows()>0)
{
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$value_array=array();
	$whitelist=array();
	$value_array=split(' ', $data['value']);
	foreach ($value_array as $key)
	{
		array_push($whitelist, array(
			'email' => $key));
	}
	$smarty->assign('whitelist', $whitelist);
}



if ($_SESSION['spamassassin'] != 1) {
	header("Location: index.php");
	exit();
}
?>