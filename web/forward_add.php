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
$access_domain=check_access_to_domain($_GET['id'],$db);
$smarty->assign('access_domain', $access_domain);

if (isset($_SESSION['superadmin']) &&
	isset($_GET['id']) &&
	$_SESSION['superadmin']=='y'||
	$_SESSION['admin']=='y' &&
	isset($_GET['id']) &&
	$access_domain )
{
	$sql=sprintf("SELECT id,dnsname,max_forward FROM domains WHERE id='%s'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('id', $_GET['id']);
	$smarty->assign('domain',$data['dnsname']);
	$dnsname=$data['dnsname'];
	$domain_id=$_GET['id'];
	
	if (get_forem_domain($data['id'],'forwardings', $db)>=$data['max_forward'] && $data['max_forward']!=0)
	{
		$smarty->assign('if_max_fwd', 'y');
	}

	
	if (isset($_POST['submit']))
	{
		if (! empty($_POST['from']) && ! empty($_POST['to']))
		{
			$full_email=$_POST['from']."@".$data['dnsname'];
			if (!email_valid($_POST['from']))
			{
			$smarty->assign('if_valid', 'n');
			$smarty->assign('from',$_POST['from'] );
			$smarty->assign('to',$_POST['to'] );
			}
			else if (get_forem_domain($data['id'],'forwardings', $db)>=$data['max_forward'] && $data['max_forward']!=0)
			{
				$smarty->assign('if_max_fwd', 'y');
			}
			else if (email_exist($full_email,$db,0,0))
			{
			$smarty->assign('if_exists', 'y');
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
				$smarty->assign('if_email_saved', 'y');
			}
		}
		else
		{
			$smarty->assign('if_missing', 'y');
			$smarty->assign('from',$_POST['from'] );
			$smarty->assign('to',$_POST['to'] );
		}
	}
}

// Menuansicht
$smarty->assign('id',$_GET['id']);
$smarty->assign('if_domain_view', 'y');
$smarty->assign('domain_id',$domain_id);
$smarty->assign('dnsname', $dnsname);

$smarty->assign('template','forward_add.tpl');
$smarty->display('structure.tpl');
?>