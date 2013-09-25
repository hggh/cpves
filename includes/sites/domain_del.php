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
if (isset($_SESSION['superadmin']) && 
    $_SESSION['superadmin']=='1'&& 
    is_numeric($_GET['did']) || is_numeric($_POST['did'])  && 
    isset($_POST['state']) &&
    $_POST['state']=='delete' )
{
if (! isset($_POST['del_ok']))
{

	$sql=sprintf("SELECT dnsname,id FROM domains WHERE id='%s'",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	
	$table_data = array();
	$sql=sprintf("SELECT email FROM users WHERE domainid='%s'",
		$db->escapeSimple($_GET['did']));
	$res =&$db->query($sql);
	$i=0;
	if ($res->numRows()==0)
	{
		$smarty->assign('if_no_data','y');
	} else {
        $smarty->assign('if_no_data','n');
    }
	while($row=$res->fetchrow(DB_FETCHMODE_ASSOC))
	{
		array_push($table_data, array(
		'email'=>$row['email']
		));
		$i++;
	}
	$smarty->assign('if_del_ok', 'n');
}
else if (isset($_POST['del_ok']) && $_POST['del_ok']== 'y' ) 
{
	$sql=sprintf("SELECT id,email FROM users WHERE domainid='%d'",
		$db->escapeSimple($_POST['did']));
	$result=&$db->query($sql);
	while($row=$result->fetchrow(DB_FETCHMODE_ASSOC))
	{
		delete_emailaddress($row['id'],$row['email']);
	}
	
	$sql=sprintf("SELECT dnsname,id FROM domains WHERE id='%s'",
		$db->escapeSimple($_POST['did']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	
	$sql=sprintf("DELETE FROM users WHERE domainid='%d'",
		$db->escapeSimple($_POST['did']));
	$db->query($sql);
	$sql=sprintf("SELECT id FROM lists WHERE domainid='%d'",
		$db->escapeSimple($_POST['did']));
	$result= &$db->query($sql);
	while ($row=$result->fetchrow(DB_FETCHMODE_ASSOC)) {
		$sql=sprintf("DELETE FROM list_recp WHERE id='%d'",
			$db->escapeSimple($row['id']));
		$db->query($sql);
	}
	$sql=sprintf("DELETE FROM lists WHERE domainid='%d'",
		$db->escapeSimple($_POST['did']));
	$db->query($sql);

	$sql=sprintf("DELETE FROM sa_wb_listing WHERE domainid='%d'",
		$db->escapeSimple($_POST['did']));
	$db->query($sql);

	$sql=sprintf("DELETE FROM forwardings WHERE domainid='%d'",
		$db->escapeSimple($_POST['did']));
	$db->query($sql);
	
	$sql=sprintf("DELETE FROM admin_access WHERE domain=%s",
		$db->escapeSimple($_POST['did']));
	$db->query($sql);

	// Update enew to 0 for the script that moves the complete datadir to vmail_safe:
	$sql=sprintf("UPDATE domains SET enew='0' WHERE id='%s'",
		$db->escapeSimple($_POST['did']));
	$db->query($sql);
	

	header("Location: index.php" );
}



}// ende superadmin
$smarty->assign('did', $data['id']);
$smarty->assign('domain', $data['dnsname']);
$smarty->assign('table_data', $table_data);
?>