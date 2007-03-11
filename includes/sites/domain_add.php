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
if (isset($_POST['submit']) &&
    isset($_SESSION['superadmin']) && 
    $_SESSION['superadmin']=='y')
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
			//insert domain
			if ($_POST['imap']=="enable")
			{
				$imap="";
			}
			else
			{
				$imap="1";
			}
			if ($_POST['pop3']=="enable")
			{
				$pop3="";
			}
			else
			{
				$pop3="1";
			}
			if ($_POST['webmail']=="enable")
			{
				$webmail="";
			}
			else
			{
				$webmail="1";
			}
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
			$dnsname=trim(strtolower($_POST['dnsname']));
			$sql=sprintf("INSERT INTO domains SET dnsname='%s', access='y', disableimap='%s', disablepop3='%s', disablewebmail='%s',max_email='%d', max_forward='%d', dnote='%s',spamassassin='%s'",
				$db->escapeSimple($dnsname),
				$db->escapeSimple($imap),
				$db->escapeSimple($pop3),
				$db->escapeSimple($webmail),
				$db->escapeSimple($max_email),
				$db->escapeSimple($max_forward),
				$db->escapeSimple(substr($_POST['dnote'],0,30)),
				$db->escapeSimple($_POST['spamassassin']));
			$res=&$db->query($sql);
	
			$sql=sprintf("SELECT id FROM domains WHERE dnsname='%s'",
				$db->escapeSimple($dnsname));
			$res=&$db->query($sql);
			$data=$res->fetchrow(DB_FETCHMODE_ASSOC);
			$to='postmaster@'.$dnsname;
			$sql=sprintf("INSERT INTO forwardings SET domainid='%s', efrom='%s', eto='%s', access='y'",
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
					if ($value['ipaddr']==$config['server_ip'])
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