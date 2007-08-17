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
	is_numeric($_GET['did']) &&
	$_SESSION['superadmin']=='1'||
	$_SESSION['admin']=='1' &&
	isset($_GET['id']) &&
	is_numeric($_GET['did']) &&
	$access_domain )
{
	$sql=sprintf("SELECT efrom,eto FROM forwardings WHERE id='%s'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$edata=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('efrom', $edata['efrom']);
	//$smarty->assign('eto' , get_first_forward($edata['eto']));
	$forwards=array();
	if ( check_multi_forward($edata['eto'])=='y') //multipli
	{
		$eto_array=array();
		$eto_array=split(',',$edata['eto']);
		foreach($eto_array as $key)
		{
			array_push($forwards, array(
			'etosingle' => $key)
			);
		}
	}
	else
	{	
			array_push($forwards, array(
			'etosingle' => $edata['eto'])
			);

	}
	$smarty->assign('forwards',$forwards);
	
	if (isset($_POST['del_ok']) && $_POST['del_ok'] == "true")
	{
		$smarty->assign('if_del_ok', 'y');
		$pos=strpos($edata['efrom'], '@');
		$forward=substr($edata['efrom'],0,$pos);
		if ($forward=="postmaster")
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_postmaster', 'y');
		}
		else
		{
			$sql=sprintf("DELETE FROM forwardings WHERE id='%s'",
				$db->escapeSimple($_GET['id']));
			$db->query($sql);
		}
	}

} // ENDE ACCESS OK

$smarty->assign('id',$_GET['id']);
?>