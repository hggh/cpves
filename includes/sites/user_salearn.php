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

if (isset($_POST['sa_learn_submit'])) {
	if (isset($_POST['sa_learn_type']) && 
           ($_POST['sa_learn_type']=='spam' || $_POST['sa_learn_type']=='ham')) {
		$sa_learn['satype']=$_POST['sa_learn_type'];
		$sa_learn['active']=$_POST['sa_learn_active'];
		$sa_learn['folder']=$_POST['sa_learn_folder'];
		insert_sa_learn($_SESSION['uid'], $sa_learn);
		$smarty->assign('success_msg', 'y');
		$smarty->assign('if_salearn_saved' , 'y');
	}
}

//get IMAP Folders
$folders =list_imap_folders($config['imap_server'],$_SESSION['email'],decrypt_passwd($_SESSION['cpasswd']));
if ($folders== false ) {
	$smarty->assign('imap_folder_exits', 0);
}
else {
	$sql=sprintf("SELECT * FROM spamassassin_learn WHERE email='%s'",
		$db->escapeSimple($_SESSION['uid']));
	$result=&$db->query($sql);
	if ($result->numRows() > 0 ) {
		$archive=array();
		while($data=$result->fetchrow(DB_FETCHMODE_ASSOC)) {
			foreach ($folders  as $key => $value) {
					if ($value['name']== $data['folder']) {
						$folders[$key]['satype']=$data['type'];
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