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
if (isset($_POST['submit']))
{
	if (!empty($_POST['dnsname']))
	{
		if (domain_exist($_POST['dnsname'],$db))
		{
			
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_domain_exits', 'y');
			$smarty->assign('dnsname', $_POST['dnsname']);
		}
		else
		{
			if (isset($_POST['max_email']) && is_numeric($_POST['max_email']))
			{
				$max_email=$_POST['max_email'];
			}
			else
			{
				$max_email=0;
			}
			if (isset($_POST['max_forward']) && is_numeric($_POST['max_forward']))
			{
				$max_forward=$_POST['max_forward'];
			}
			else
			{
				$max_forward=0;
			}
			if ($_POST['p_spamassassin']!= 1) {
				$bogofilter=0;
			}
			else {
				$bogofilter=$_POST['p_bogofilter'];
			}
			if ($_POST['p_spamassassin']!=1) {
				$sa_wb_listing=0;
			}
			else {
				$sa_wb_listing=$_POST['p_sa_wb_listing'];
			}
			
			$dnsname=trim(strtolower($_POST['dnsname']));
			$sql=sprintf("INSERT INTO domains SET dnsname='%s', access='1', p_imap='%s', p_pop3='%s', p_webmail='%s',max_email='%d', max_forward='%d', dnote='%s',p_spamassassin='%s',p_bogofilter='%s',p_mailarchive='%s',p_sa_wb_listing='%s'",
				$db->escapeSimple($dnsname),
				$db->escapeSimple($_POST['p_imap']),
				$db->escapeSimple($_POST['p_pop3']),
				$db->escapeSimple($_POST['p_webmail']),
				$db->escapeSimple($max_email),
				$db->escapeSimple($max_forward),
				$db->escapeSimple(substr($_POST['dnote'],0,30)),
				$db->escapeSimple($_POST['p_spamassassin']),
				$db->escapeSimple($bogofilter),
				$db->escapeSimple($_POST['p_mailarchive']),
				$db->escapeSimple($sa_wb_listing));
			$res=&$db->query($sql);
	
			$sql=sprintf("SELECT id FROM domains WHERE dnsname='%s'",
				$db->escapeSimple($dnsname));
			$res=&$db->query($sql);
			$data=$res->fetchrow(DB_FETCHMODE_ASSOC);
			$to='postmaster@'.$dnsname;
			$sql=sprintf("INSERT INTO forwardings SET domainid='%s', efrom='%s', eto='%s', access='1'",
				$db->escapeSimple($data['id']),
				$db->escapeSimple($to),
				$db->escapeSimple($config['postmaster']));
			$res=&$db->query($sql);
			
			$smarty->assign('new_dnsname', $dnsname);
			$smarty->assign('if_dns_added', 'y');
			$smarty->assign('did', $data['id']);
			
			$res_array=array();
			$points='n';
			if (get_mx($dnsname))
			{
				$mx_entry=array();
				foreach($res_array as $value)
				{
					if (in_array($value['ipaddr'], $config['server_ip']))
					{
						$this_server=true;
						$points='y';
					}
					else
					{
						$this_server=false;
					}
					array_push($mx_entry, array(
						'prio' => $value['prio'],
						'mx_name' => $value['dnsname'],
						'ipaddr' => $value['ipaddr'],
						'iptype' => $value['iptype'],
						'this_server' => $this_server 
					));
				}
				$smarty->assign('if_mx' , 'y');
				$smarty->assign('mx_entry',$mx_entry );
				$smarty->assign('points', $points);
			}
			else
			{
				
				$smarty->assign('if_dns_not_found' ,'y');
			}
		}
	}
	else
	{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_missing_input', 'y');
	}
}
?>