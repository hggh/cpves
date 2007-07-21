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
if (isset($_POST['autores_submit']))
{
	if (empty($_POST['autores_subject']) && $_POST['autores_active'] == 'y')
	{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_subject_empty', 'y');
		$error=true;
	}
	else if (empty($_POST['autores_msg'])  && $_POST['autores_active'] == 'y')
	{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_msg_empty', 'y');
		$error=true;
	}
	else if(strlen($_POST['autores_subject']) > 50  && $_POST['autores_active'] == 'y')
	{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_subject_to_long', 'y');
		$error=true;
	}
	else if ( $_POST['autores_sendback_times'] != "n" && ($_POST['autores_sendback_times'] < 1 && $_POST['autores_sendback_times'] > 5 ))
	{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_send_times', 'y');
		$error=true;
	}
	else
	{
		save_autoresponder($_SESSION['uid'],
			$_POST['autores_active'],
			$_POST['autores_subject'],
			$_POST['autores_msg'], $_POST['autores_sendback_times']);
		// activate System-Script
		run_systemscripts();
	}
	
	
	
}

if (isset($_POST['val_tos_active'])&& is_numeric($_POST['val_tos_active'])) {
	update_email_options($_SESSION['uid'],"auto_val_tos_active",$_POST['val_tos_active'], 0);

}


if(isset($_POST['val_tos_del'])) {
	val_tos_del($_SESSION['uid'],$_POST['val_tos']);

}
if(isset($_POST['val_tos_add'])) {
	if (val_tos_add($_SESSION['uid'], $_POST['val_tos_da'])== 1) {
		$smarty->assign('error_msg','y');
		$smarty->assign('if_submit_email_wrong', 'y');
	}
}

//save automatic autoresponder disable feaure
if (isset($_POST['autores_datedisable_submit'])) {
	if ($_POST['autores_datedisable_active'] == 0) {
		$sql=sprintf("UPDATE autoresponder_disable SET active='0' WHERE email='%d'",
			$db->escapeSimple($_SESSION['uid']));
		$result=&$db->query($sql);
	}
	elseif (! preg_match('/^([0-9]{2}).([0-9]{2}).([0-9]{4})$/', $_POST['autores_datedisable_date'])) {
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_date_wrong', 'y');
	}
	elseif (! preg_match('/^([0-9]{2}):([0-9]{2}):([0-9]{2})$/', $_POST['autores_datedisable_time'])) {
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_time_wrong', 'y');
	}
	elseif (! check_autores_date_disable($_POST['autores_datedisable_date'],$_POST['autores_datedisable_time'])) {
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_disable_in_past', 'y');
	}
	else {
		$unix_time=autores_date_format($_POST['autores_datedisable_date'],$_POST['autores_datedisable_time']);
		$sql=sprintf("SELECT id FROM autoresponder_disable WHERE email='%d'",
			$db->escapeSimple($_SESSION['uid']));
		$result=&$db->query($sql);
		if ($result->numRows() == 1) {
			$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
			$sql=sprintf("UPDATE autoresponder_disable SET a_date=FROM_UNIXTIME('%s'), active='1' WHERE email='%d'",
				$db->escapeSimple($unix_time),
				$db->escapeSimple($_SESSION['uid']));
		}
		else {
			$sql=sprintf("INSERT INTO autoresponder_disable SET a_date=FROM_UNIXTIME('%s'),email='%d',active='1'",
				$db->escapeSimple($unix_time),
				$db->escapeSimple($_SESSION['uid']));
		}
		$result=&$db->query($sql);
	}
}

$sql=sprintf("SELECT id,email,active,msg,esubject,times FROM autoresponder WHERE email='%d'",
	$db->escapeSimple($_SESSION['uid']));
$result=&$db->query($sql);
if ($result->numRows()==1)
{
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$active=$data['active'];
	$msg=$data['msg'];
	$esubject=$data['esubject'];
	$id=$data['id'];
	$times=$data['times'];
}
elseif($error)
{
	$active=$_POST['autores_active'];
	$msg=$_POST['autores_msg'];
	$esubject=$_POST['autores_subject'];
	$times=$_POST['autores_sendback_times'];
	
}
else
{
	$active='n';
}

// outout val_tos
$sql=sprintf("SELECT recip,id FROM autoresponder_recipient WHERE email='%d'",
	$db->escapeSimple($_SESSION['uid']));
$result=&$db->query($sql);
$table_val_tos = array();
while($data=$result->fetchrow(DB_FETCHMODE_ASSOC)) {
	array_push($table_val_tos,array(
		'recip' => $data['recip'],
		'id'    => $data['id'])); 
}

//output val_tos_active
$val_tos_active = get_email_options($_SESSION['uid'],"auto_val_tos_active", 0);
$smarty->assign('val_tos_active', $val_tos_active);


//output autoresponder disabled feature
$autores_disable=get_autores_disable($_SESSION['uid']);

$smarty->assign('autores_disable', $autores_disable);
$smarty->assign('table_val_tos', $table_val_tos);
$smarty->assign('autores_subject', $esubject);
$smarty->assign('autores_active', $active);

$smarty->assign('autores_sendback_times_value', $times);
$smarty->assign('id', $id);
$smarty->assign('autores_msg', $msg);
$smarty->assign('email', $_SESSION['email']);
?>