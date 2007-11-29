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
	isset($_GET['did']) &&
	$_SESSION['superadmin']=='1')
{
	if (isset($_POST['domains_forward_save'])&& isset($_POST['to_domain']) && is_numeric($_POST['to_domain'])) {
		$sql=sprintf("SELECT id FROM domains WHERE id='%s'", $db->escapeSimple($_POST['to_domain']));
		$result=&$db->query($sql);
		$sql=sprintf("SELECT id FROM domains_forward WHERE fr_domain='%s'",
			$db->escapeSimple($_GET['did']));
		$result2=&$db->query($sql);
		$sql=sprintf("SELECT id FROM domains_forward WHERE to_domain='%s'",
			$db->escapeSimple($_GET['did']));
		$result3=$db->query($sql);
		if($result->numRows()!=1) {
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_to_domain_not_exists', 'y');
		}
		elseif($result2->numRows()!=0) {
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_domain_forwarded_already','y');
		}
		elseif ($result3->numRows()!=0) {
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_other_domains_points_to_me','y');
		}
		else {
			$sql=sprintf("INSERT INTO domains_forward SET fr_domain='%s', to_domain='%s'",
				$db->escapeSimple($_GET['did']),
				$db->escapeSimple($_POST['to_domain']));
			$db->query($sql);
			$smarty->assign('success_msg', 'y');
			$smarty->assign('domain_forward_saved', 'y');
		}
		
	}
	
	// get domainlist
	$sql=sprintf("SELECT id,dnsname FROM domains WHERE id!='%s' AND (SELECT COUNT(id) FROM domains_forward WHERE domains_forward.fr_domain =domains.id  )!=1 ORDER BY dnsname",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	if ($result->numRows() > 0) {
		$smarty->assign('no_domains_found',0);
		$domains_display=array();
		while($data=$result->fetchrow(DB_FETCHMODE_ASSOC)) {
			array_push($domains_display, array(
				'dnsname' => $data['dnsname'],
				'id'      => $data['id']));
		}
		$smarty->assign('domains_display', $domains_display);
	}
	else {
		$smarty->assign('no_domains_found',1);
	}
}
?>