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

if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='y'
    && isset($_SESSION['manager'])
    && $_SESSION['manager'] =='y')
{
	if ($_GET['state']=='disable')
	{
		$sql=sprintf("UPDATE adm_users SET access='n' WHERE id='%s'",
			$db->escapeSimple($_GET['id']));
	}
	else if ($_GET['state']=='enable')
	{
		$sql=sprintf("UPDATE adm_users SET access='y' WHERE id='%s'",
			$db->escapeSimple($_GET['id']));
	}
	else if ($_GET['state']=="delete")
	{
		$sql=sprintf("DELETE FROM adm_users WHERE id='%s'",
			$db->escapeSimple($_GET['id']));
	}
	$result=&$db->query($sql);
	
	$result=&$db->query("SELECT * FROM adm_users ORDER BY username");
	$table_data=array();
	while($data=$result->fetchrow(DB_FETCHMODE_ASSOC))
	{
		array_push($table_data, array(
			'username' => $data['username'],
			'id' => $data['id'],
			'access' => $data['access'],
			'full_name' => $data['full_name']
		));
	}
$smarty->assign('table_data', $table_data);
}
$smarty->assign('template','sadmin_view.tpl');
$smarty->display('structure.tpl');
?>
