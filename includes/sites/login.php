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
$login=0;
$_SESSION['superadmin']='0';
$_SESSION['admin']='0';
$_SESSION['manager']='0';
$_SESSION['ad_user']='n';
$_SESSION['spamassassin']='0';
$_SESSION['forwarding']='0';
$_SESSION['p_mailarchive']='0';
$_SESSION['p_bogofilter']='0';
$_SESSION['p_mailfilter']='0';
$_SESSION['p_spam_del']='0';
$_SESSION['p_sa_learn']='0';
$_SESSION['p_fetchmail']='0';

if (isset($_POST['email']) && isset($_POST['password']) && isset($_POST['login']) )
{

if ( ereg("@",$_POST['email']) ) // check admin or user benutzername
{
	$sql=sprintf("SELECT a.* FROM users AS a LEFT JOIN domains AS b ON b.id = a.domainid WHERE a.email='%s' AND a.access='1' AND b.access='1' AND a.p_webinterface='1' AND b.p_webinterface='1'",
		$db->escapeSimple($_POST['email']) );
	$result=&$db->query($sql);
	if (!$result)
	{
		$login=0;
	}
	else if ($result->numRows() ==1)
	{
		
		$daten=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if (check_password($daten['cpasswd'],$_POST['password']) == 1) 
		{
			$login=1;
			$_SESSION['uid']=$daten['id'];
			$_SESSION['email']=$daten['email'];
			$_SESSION['cpasswd']=encrypt_passwd($_POST['password']);
			
			$_SESSION['full_name']=$daten['full_name'];
			$sql=sprintf("SELECT id FROM admin_access WHERE email='%s'",
				$db->escapeSimple($daten['id']));
			$res=&$db->query($sql);
			if ($res->numRows() > 0 )
			{
				$_SESSION['admin']='1';
			}
			// checke ob domain aktiv ist:
			$sql=sprintf("SELECT p_spamassassin,p_mailarchive,p_bogofilter,p_mailfilter,p_fetchmail FROM domains where id=%s",
				$db->escapeSimple($daten['domainid']));
			$res_domain=&$db->query($sql);
			
			$data_domain=$res_domain->fetchrow(DB_FETCHMODE_ASSOC);

			$smarty->assign('if_login_ok', 'yes');
			logging($_SESSION['email']);
			$_SESSION['spamassassin']=check_du_fetaure($_SESSION['uid'],$daten['domainid'],'p_spamassassin');
			$_SESSION['p_mailarchive']=check_du_fetaure($_SESSION['uid'],$daten['domainid'],'p_mailarchive');
			$_SESSION['p_bogofilter']=check_du_fetaure($_SESSION['uid'],$daten['domainid'],'p_bogofilter');
			$_SESSION['p_spam_del']=check_du_fetaure($_SESSION['uid'],$daten['domainid'],'p_spam_del');
			$_SESSION['p_sa_learn']=check_du_fetaure($_SESSION['uid'],$daten['domainid'],'p_sa_learn');
			$_SESSION['p_fetchmail']=check_du_fetaure($_SESSION['uid'],$daten['domainid'],'p_fetchmail');
			$_SESSION['forwarding']=$daten['p_forwarding'];
			$_SESSION['p_mailfilter']=$data_domain['p_mailfilter'];
			
				
		
		}
		
		

	}
}
else // wird ein admin username sein, also checke adm_users table
{
	$sql=sprintf("SELECT * FROM adm_users WHERE username='%s' AND access='1'",
		$db->escapeSimple($_POST['email']));
	$result = &$db->query($sql);
	if ($result->numRows() ==1)
	{
		$daten=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if (check_password($daten['cpasswd'],$_POST['password']) == 1)
		{
			$login=1;
			$_SESSION['email']=$daten['username'];
			$_SESSION['cpasswd']=encrypt_passwd($_POST['password']);
			$_SESSION['superadmin']='1';
			$_SESSION['manager']=$daten['manager'];
			
			$smarty->assign('if_login_ok', 'yes');
			logging($_SESSION['email']);
		}
	}
}


}

if ($login == 0)
{
	$smarty->assign('error_msg','y');
	$smarty->assign('if_error_login_failed', 'y');
}
else if ($login==1)
{
	header("Location: index.php?module=main");
}
$smarty->assign('if_login' , 'y');
?>