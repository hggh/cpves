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
	isset($_GET['id']) &&
	isset($_GET['did']) &&
	$_SESSION['superadmin']=='y'||
	$_SESSION['admin']=='y' &&
	isset($_GET['id']) &&
	isset($_GET['did']) &&
	$access_domain )
{
	//del adresses:
	if (isset($_POST['del_addr']) && isset($_POST['etos']))
	{
		$sql=sprintf("SELECT eto FROM forwardings WHERE id='%d'",
			$db->escapeSimple($_GET['id']));
		$result=&$db->query($sql);
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$etos=$data['eto'];
		//print_r ($_POST['etos']);
		foreach ($_POST['etos'] as $key)
		{
			$etos=str_replace($key.",","",$etos);
			$etos=str_replace($key,"",$etos);
		
		}
		if ("," == substr($etos,-1,1))
		{
			$etos=substr($etos, 0, strlen($etos)-1);
		}
		if ($etos=="")
		{
			$smarty->assign('if_del', 'y');
		}
		else
		{
			$sql=sprintf("UPDATE forwardings SET eto='%s' WHERE id='%d'",
				$db->escapeSimple($etos),
				$db->escapeSimple($_GET['id']));
			$result=&$db->query($sql);
			$smarty->assign('if_update_of' , 'y');
		}
	}
	//del adresses ENDE

	//hinzufugen:
	if (isset($_POST['submit_fwd']) && ! empty($_POST['add_fwd']))
	{
		$sql=sprintf("SELECT eto FROM forwardings WHERE id='%d'",
			$db->escapeSimple($_GET['id']));
		$result=&$db->query($sql);
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$new_fwd=$data['eto'].",".$_POST['add_fwd'];
		$sql=sprintf("UPDATE forwardings SET eto='%s' WHERE id='%d'",
			$db->escapeSimple($new_fwd),
			$db->escapeSimple($_GET['id']));
		$result=&$db->query($sql);
		
	}
	//END hinzufugen
	$sql=sprintf("SELECT * FROM forwardings WHERE id='%d'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('forward', $data['efrom']);
	$forwards=array();
	if ( check_multi_forward($data['eto'])=='y') //multipli
	{
		$eto_array=array();
		$eto_array=split(',',$data['eto']);
		foreach($eto_array as $key)
		{
			array_push($forwards, array(
			'etosingle' => $key));
		}
	}
	else
	{	
			array_push($forwards, array(
			'etosingle' => $data['eto'])
			);

	}
	sort($forwards);
	
	$sql=sprintf("SELECT dnsname,id FROM domains WHERE id='%s'",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$dnsname=$data['dnsname'];
	$domain_id=$data['id'];
	
	
	$smarty->assign('forwards',$forwards);
	$sql=sprintf("SELECT id,email FROM users WHERE domainid='%d' AND access='y' ORDER BY email",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$emailfwd=array();
	while($data=$result->fetchrow(DB_FETCHMODE_ASSOC))
	{
		array_push($emailfwd, array(
			'email' => $data['email'],
			'emailid' => $data['id']));
	}
	if (count($emailfwd)==0) {
		$smarty->assign('if_noemail_found' ,'y');
	}
	$smarty->assign('table_addemail',$emailfwd);
	
} // ENDE ACCESS OK



$smarty->assign('dnsname', $dnsname);
$smarty->assign('id',$_GET['id']);
$smarty->assign('domainid',$_GET['did']);
?>
