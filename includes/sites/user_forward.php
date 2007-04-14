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

/* foward option save begin */
if (isset($_POST['submit']) && $_SESSION['forwarding'] == 1) {
	update_mailfilter('mail_forward',
		$_SESSION['uid'],$_POST['forwardaddress'],
		$_POST['delete_forward'],
		$_POST['save_local']);
	run_systemscripts();
}
/* foward option save begin */



//SELECT *  FROM `mailfilter` WHERE `type` LIKE 'forward%'
$sql=sprintf("SELECT type,filter FROM mailfilter WHERE email='%d' AND active!=0 AND type LIKE 'forward%%'",
	$db->escapeSimple($_SESSION['uid']));
$result=&$db->query($sql);
if ($result->numRows()==1)
{
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	if ($data['type']=="forward_cc") // mit kopie ans lokale postfach
	{
		$smarty->assign('if_forward_cc', '1');
	}
	else // ohne kopie weiterleiten
	{
	}
	$smarty->assign('forwardaddress', $data['filter']);
}

if ($_SESSION['forwarding'] != 1) {
	header("Location: index.php");
	exit();
}

$smarty->assign('email', $_SESSION['email']);
?>