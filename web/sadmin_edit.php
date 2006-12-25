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
    && isset($_GET['id'])
    && isset($_SESSION['manager'])
    && $_SESSION['manager'] =='y')
{
	$sql=sprintf("SELECT * FROM adm_users WHERE id='%s'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('id', $data['id']);
	$smarty->assign('full_name', $data['full_name']);
	$smarty->assign('username', $data['username']);
	$smarty->assign('access', $data['access']);
	$smarty->assign('manager', $data['manager']);
	$_POST['username']=$data['username'];
	if (empty($_POST['passwd']))
	{
		$passwd=$data['passwd'];
		$cpasswd=$data['cpasswd'];
	}
	else
	{
		$passwd=$_POST['passwd'];
		$cpasswd=crypt($_POST['passwd']);
	}
	
	if (isset($_POST['submit']))
	{
		$wrong=0;
		if(!empty($_POST['passwd']) && (strlen($passwd) > $max_passwd_len || strlen($passwd) < 3) )
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_password_long','y');
			$wrong=1;
		}
		elseif(adm_user_exits($_POST['username'],$_GET['id'],$db))
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_sadmim_exits','y');
			$wrong=1;
		}
		else
		{
			if ($_POST['access']=="enable") {
				$access='y'; }
			else {
				$access='n'; }
			if ($_POST['manager']=="enable") {
				$manager='y'; }
			else {
				$manager='n'; }
			
			$sql=sprintf("DELETE FROM adm_users WHERE id='%s'",
				$db->escapeSimple($_GET['id']));
			$res=&$db->query($sql);
			
			if ($config['cleartext_passwd']==1) {
				$cleartext=$passwd;
			}
			else
			{
				$cleartext="";
			}
			
			
			
			$sql=sprintf("INSERT INTO adm_users SET username='%s', passwd='%s', full_name='%s', access='%s', manager='%s', id='%d', cpasswd='%s'",
			$db->escapeSimple($data['username']),
			$db->escapeSimple($cleartext),
			$db->escapeSimple($_POST['full_name']),
			$db->escapeSimple($access),
			$db->escapeSimple($manager),
			$db->escapeSimple($_GET['id']),
			$db->escapeSimple($cpasswd));
			$res=&$db->query($sql);
			if (!PEAR::isError($res)) {
				$smarty->assign('if_changed','y');
			}
		}
	}

	
	
}

$smarty->assign('template','sadmin_edit.tpl');
$smarty->display('structure.tpl');
?>
