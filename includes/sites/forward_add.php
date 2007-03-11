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
$access_domain=check_access_to_domain($_GET['did'],$db);
$smarty->assign('access_domain', $access_domain);

if (isset($_SESSION['superadmin']) &&
	isset($_GET['did']) &&
	$_SESSION['superadmin']=='y'||
	$_SESSION['admin']=='y' &&
	isset($_GET['did']) &&
	$access_domain )
{
	$sql=sprintf("SELECT id,dnsname,max_forward FROM domains WHERE id='%s'",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('id', $_GET['id']);
	$smarty->assign('domain',$data['dnsname']);
	$dnsname=$data['dnsname'];
	$domain_id=$_GET['did'];
	
	if (get_forem_domain($data['did'],'forwardings', $db)>=$data['max_forward'] && $data['max_forward']!=0)
	{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_forwds_max_reached','y');
	}

	
	if (isset($_POST['submit']))
	{
		if (! empty($_POST['from']) && ! empty($_POST['to']))
		{
			$full_email=$_POST['from']."@".$data['dnsname'];
			if (!email_valid($_POST['from']))
			{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_email_valid', 'y');
			$smarty->assign('from',$_POST['from'] );
			$smarty->assign('to',$_POST['to'] );
			}
			else if (get_forem_domain($data['id'],'forwardings', $db)>=$data['max_forward'] && $data['max_forward']!=0)
			{
				$smarty->assign('error_msg','y');
				$smarty->assign('if_error_forwds_max_reached','y');
			}
			else if (email_exist($full_email,$db,0,0))
			{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_email_exits', 'y');
			$smarty->assign('full_email', 'y');
			$smarty->assign('from',$_POST['from'] );
			$smarty->assign('to',$_POST['to'] );
			}
			else
			{
				$sql=sprintf("INSERT INTO forwardings SET efrom='%s', eto='%s', domainid='%s', access='y'",
				$db->escapeSimple(strtolower($full_email)),
				$db->escapeSimple($_POST['to']),
				$db->escapeSimple($_GET['id']));
				$result=&$db->query($sql);
				$smarty->assign('success_msg', 'y');
				$smarty->assign('if_forward_saved', 'y');
			}
		}
		else
		{
			$smarty->assign('if_missing', 'y');
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_missing_input', 'y');
			$smarty->assign('from',$_POST['from'] );
			$smarty->assign('to',$_POST['to'] );
		}
	}
}
?>