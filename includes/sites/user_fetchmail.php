<?php
/******************************************************************************
* Copyright (C) 2007 Jonas Genannt <jonas.genannt@brachium-system.net>
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

if (isset($_GET['enable']) && is_numeric($_GET['enable'])) {
	$sql=sprintf("UPDATE fetchmail SET active=1 WHERE email='%d' AND id='%d'",
		$db->escapeSimple($_SESSION['uid']),
		$db->escapeSimple($_GET['enable']));
	$db->query($sql);
}
if (isset($_GET['disable']) && is_numeric($_GET['disable'])) {
	$sql=sprintf("UPDATE fetchmail SET active=0 WHERE email='%d' AND id='%d'",
		$db->escapeSimple($_SESSION['uid']),
		$db->escapeSimple($_GET['disable']));
	$db->query($sql);
}
if (isset($_GET['delete']) && is_numeric($_GET['delete'])) {
	$sql=sprintf("DELETE FROM fetchmail WHERE email='%d' AND id='%d'",
		$db->escapeSimple($_SESSION['uid']),
		$db->escapeSimple($_GET['delete']));
	$db->query($sql);
}

//SAVE NEW DATA TO TABLE - BEGIN
if (isset($_POST['fm_submit'])) {

if (empty($_POST['fm_server']) ||
	empty($_POST['fm_username']) ||
	empty($_POST['fm_password'])) {
	
	$smarty->assign('error_msg', 'y');
	$smarty->assign('fm_missing_error' ,'y');
}
else {
	//FIXME: INPUT CHECKS!!
	$sql=sprintf("INSERT INTO fetchmail SET email='%d', server='%s',proto='%d',conn_type='%d',username='%s',password='%s', keep_mails='%d',active='1'",
		$db->escapeSimple($_SESSION['uid']),
		$db->escapeSimple($_POST['fm_server']),
		$db->escapeSimple($_POST['fm_proto']),
		$db->escapeSimple($_POST['fm_conn_type']),
		$db->escapeSimple($_POST['fm_username']),
		$db->escapeSimple($_POST['fm_password']),
		$db->escapeSimple($_POST['fm_keep_mails']));
	$db->query($sql);
}


}
//SAVE NEW DATA TO TABLE - END


$sql=sprintf("SELECT * FROM fetchmail WHERE email='%d' ORDER BY server",
	$db->escapeSimple($_SESSION['uid']));
$result=$db->query($sql);

$table_fetchmail=array();
while($data = $result->fetchrow(DB_FETCHMODE_ASSOC)) {
	array_push($table_fetchmail,array(
		'id' => $data['id'],
		'active' => $data['active'],
		'server' => $data['server'],
		'username' => $data['username'],
		'proto' => $data['proto']));
}
$smarty->assign('table_fetchmail', $table_fetchmail);
?>