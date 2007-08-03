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
$smarty->assign('email', $_SESSION['email']);

//save option BEGIN
if (isset($_POST['armail_save'])) {
	$index = $_POST['armail_id'];
	if (empty($_POST['armail_time' . $index]) || !is_numeric($_POST['armail_time' . $index]) ||
        $_POST['armail_time' . $index] == "0") {
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_artime', 'y');
	}
	else {
		$mailarchive['adays']=$_POST['armail_time' . $index];
		$mailarchive['mailsread']=$_POST['armail_read' . $index];
		$mailarchive['fname_month']=$_POST['armail_folder_month' . $index];
		$mailarchive['fname_year']=$_POST['armail_folder_year' . $index];
		$mailarchive['active']=$_POST['armail_active'];
		$mailarchive['folder']=$_POST['armail_folder'];
		insert_mailarchive($_SESSION['uid'], $mailarchive);
		$smarty->assign('success_msg', 'y');
		$smarty->assign('if_mailarchive_saved' , 'y');
	}
}
//save option END



//get IMAP Folders
$folders =list_imap_folders($config['imap_server'],$_SESSION['email'],decrypt_passwd($_SESSION['cpasswd']),0);
if ($folders== false ) {
	$smarty->assign('imap_folder_exits', 0);
}
else {
	$sql=sprintf("SELECT * FROM mailarchive WHERE email='%s'",
		$db->escapeSimple($_SESSION['uid']));
	$result=&$db->query($sql);
	if ($result->numRows() > 0 ) {
		$archive=array();
		while($data=$result->fetchrow(DB_FETCHMODE_ASSOC)) {
			foreach ($folders  as $key => $value) {
					if ($value['name']== $data['folder']) {
						$folders[$key]['adays']=$data['adays'];
						$folders[$key]['mailsread']=$data['mailsread'];
						$folders[$key]['fname_month']=$data['fname_month'];
						$folders[$key]['fname_year']=$data['fname_year'];
						$folders[$key]['active']=$data['active'];
						continue;
					}
			}
		}
	}
	$smarty->assign('imap_folder_exits', 1);
	$smarty->assign('available_folders',$folders);
}
?>