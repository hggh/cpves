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
echo $access_domain;
if (isset($_SESSION['superadmin']) &&
	isset($_GET['did']) &&
	is_numeric($_GET['did']) &&
	$_SESSION['superadmin']=='y'||
	$_SESSION['admin']=='y' &&
	isset($_GET['did']) &&
	is_numeric($_GET['did']) &&
	$access_domain )
{
//Enable or Disable EMAIL BEGIN
if (is_numeric($_GET['eid']) && isset($_GET['state']) && isset($_GET['type']) )
{
	if ($_GET['type'] == "catchall" && $_GET['state'] == "delete")
	{ // loesche den catchall
		$sql=sprintf("DELETE FROM forwardings WHERE id='%s' AND efrom REGEXP '^@'",
			$db->escapeSimple($_GET['eid']));
		$result=&$db->query($sql);
	}
	if ($_GET['type'] == "email")
	{
		$table="users";
		$sql=sprintf("SELECT email FROM users WHERE id='%s'",
			$db->escapeSimple($_GET['eid']));
		$result=&$db->query($sql);
		$mail=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$email=$mail['email'];
	}
	elseif ($_GET['type'] == "forward")
	{
		$table="forwardings";
		$sql=sprintf("SELECT * FROM forwardings WHERE id='%s'",
			$db->escapeSimple($_GET['eid']));
		$result=&$db->query($sql);
		$mail=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$email=$mail['efrom'];
	}
	elseif ($_GET['type'] == 'list')
	{
		$table = 'lists';
		$sql = sprintf("SELECT address FROM lists WHERE id = %d",
				$db->escapeSimple($_GET['eid']));
		$res = &$db->query($sql);
		$row = $res->fetchrow(DB_FETCHMODE_ASSOC);
		$email = $row['address'];
	}

	if ($_GET['state']=='disable')
	{
		$sql=sprintf("UPDATE %s SET ACCESS='n' WHERE id='%s'",
			$table,
			$db->escapeSimple($_GET['eid']));
	}
	else if ($_GET['state']=='enable')
	{
		$sql=sprintf("UPDATE %s SET ACCESS='y' WHERE id='%s'",
			$table,
			$db->escapeSimple($_GET['eid']));
	}
	if ( (strpos($email, 'postmaster')) === false)
	{
		$result=&$db->query($sql);
		if (!$result)
		{
			echo "ERROR! Something went wrong!";
		}
	}
	else
	{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_postmaster' , 'y');
	}
}
//ENABLE or DISABLE EMAIL


//change MAX_forwards in database:
if (isset($_POST['max_forwards']) && is_numeric($_POST['max_forwards']) && $_SESSION['superadmin'] && $_SESSION['superadmin']=='y')
{
	$sql=sprintf("UPDATE domains SET max_forward='%d' WHERE id='%d'",
		$db->escapeSimple($_POST['max_forwards']),
		$db->escapeSimple($_GET['did']));
	$db->query($sql);
}

//change MAX_emailss in database:
if (isset($_POST['max_emails']) && is_numeric($_POST['max_emails']) && $_SESSION['superadmin'] && $_SESSION['superadmin']=='y')
{
	$sql=sprintf("UPDATE domains SET max_email='%d' WHERE id='%d'",
		$db->escapeSimple($_POST['max_emails']),
		$db->escapeSimple($_GET['did']));
	$db->query($sql);
}


//Domain Notiz aendern:
if ($_SESSION['superadmin'] && $_SESSION['superadmin']=='y' && isset($_POST['dnote']))
{
	$sql=sprintf("UPDATE domains SET dnote='%s' WHERE id='%d'",
		$db->escapeSimple($_POST['dnote']),
		$db->escapeSimple($_GET['did']));
	$db->query($sql);

}




//Domain features veraendern ANFANG
if ($_SESSION['superadmin'] && $_SESSION['superadmin']=='y' && isset($_GET['fstate']))
{
	$sql="";
	$sql2="";
	if ($_GET['fstate'] =='disableimap')
	{
		$sql=sprintf("UPDATE domains SET disableimap='1' WHERE id='%s'",
			$db->escapeSimple($_GET['did']));
		$sql2=sprintf("UPDATE users SET disableimap='1' WHERE domainid='%s'",
			$db->escapeSimple($_GET['did']));
	}
	if ($_GET['fstate'] =='enableimap')
	{
		$sql=sprintf("UPDATE domains SET disableimap='' WHERE id='%s'",
			$db->escapeSimple($_GET['did']));
	}
	if ($_GET['fstate'] == "disablespamassassin")
	{
		$sql=sprintf("UPDATE domains SET spamassassin='0' WHERE id='%s'",
			$db->escapeSimple($_GET['did']));
	}
	if ($_GET['fstate'] == "enablespamassassin")
	{
		$sql=sprintf("UPDATE domains SET  spamassassin='1' WHERE id='%s'",
			$db->escapeSimple($_GET['did']));
	}
	if ($_GET['fstate'] =='disablepop3')
	{
		$sql=sprintf("UPDATE domains SET disablepop3='1' WHERE id='%s'",
			$db->escapeSimple($_GET['did']));
		$sql2=sprintf("UPDATE users SET disablepop3='1' WHERE domainid='%s'",
			$db->escapeSimple($_GET['did']));
	}
	if ($_GET['fstate'] =='enablepop3')
	{
		$sql=sprintf("UPDATE domains SET disablepop3='' WHERE id='%s'",
			$db->escapeSimple($_GET['did']));
	}
	
	if ($_GET['fstate'] =='disablewebmail')
	{
		$sql=sprintf("UPDATE domains SET disablewebmail='1' WHERE id='%s'",
			$db->escapeSimple($_GET['did']));
		$sql2=sprintf("UPDATE users SET disablewebmail='1' WHERE domainid='%s'",
			$db->escapeSimple($_GET['did']));
	}
	if ($_GET['fstate'] =='enablewebmail')
	{
		$sql=sprintf("UPDATE domains SET disablewebmail='' WHERE id='%s'",
			$db->escapeSimple($_GET['did']));
	}
	$db->query($sql);
	if (isset($sql2))
	{
		$db->query($sql2);
	}
}
// Domain feature veraendern ENDE


	$sql=sprintf("SELECT * FROM domains WHERE id='%s' LIMIT 1",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	
	$smarty->assign('dnsname', $data['dnsname']);
	$smarty->assign('if_imap', $data['disableimap']);
	$smarty->assign('if_pop3', $data['disablepop3']);
	$smarty->assign('if_webmail', $data['disablewebmail']);
	
	$smarty->assign('max_emails', $data['max_email']);
	$smarty->assign('max_fwd', $data['max_forward']);
	$smarty->assign('dnote', $data['dnote']);
	$smarty->assign('if_spamassassin', $data['spamassassin']);
	
	
	
$smarty->assign('emails', get_forem_domain($_GET['did'],'users', $db));
$smarty->assign('forwardings', get_forem_domain($_GET['did'],'forwardings', $db));


//FIXME: deleted email addresses!!!
$sql=sprintf("SELECT email,id,access FROM users WHERE domainid='%s' AND enew!='0' ORDER BY email",
	$db->escapeSimple($_GET['did']));
$result=&$db->query($sql);
$table_email = array();
while($data=$result->fetchrow(DB_FETCHMODE_ASSOC))
{
	$autoresponder=0;
	$sql=sprintf("SELECT id FROM autoresponder WHERE email='%d' AND active='y'",
		$db->escapeSimple($data['id']));
	$res=&$db->query($sql);
	if ($res->numRows()== 1)
	{
		$autoresponder=1;
	}
	array_push($table_email, array(
	'id' => $data['id'],
	'did' => $_GET['did'],
	'email' =>$data['email'],
	'access' =>$data['access'],
	'autoresponder' => $autoresponder)
	);


} //ENDE WHILE eMails

$sql=sprintf("SELECT * FROM forwardings WHERE domainid=%s ORDER BY efrom",
	$db->escapeSimple($_GET['did']));
$result=&$db->query($sql);
echo mysql_error();
$table_forward = array();
while($data=$result->fetchrow(DB_FETCHMODE_ASSOC))
{
	if (!ereg('^@',$data['efrom'])) //show no @catchall
	{
	array_push($table_forward, array(
	'id' => $data['id'],
	'did' => $_GET['did'],
	'from' =>$data['efrom'],
	'to' => get_first_forward($data['eto']),
	'if_multif' => check_multi_forward($data['eto']),
	'access' =>$data['access'])
	);
	}
} //ENDE WHILE forward


if ($config['mailinglisten'] != 'n') { //Run ML-Code only ==y

$sql = sprintf("SELECT id,COUNT(*) as num FROM list_recp GROUP BY id",
	$db->escapeSimple($_GET['id']));
$res = &$db->query($sql);
$list_recps = array();
while( $row = $res->fetchrow(DB_FETCHMODE_ASSOC) ) {
 $list_recps[$row['id']] = $row['num'];
}

$sql = sprintf("SELECT * FROM lists WHERE domainid = %d ORDER BY address",
	$db->escapeSimple($_GET['id']));
$res = &$db->query($sql);
$table_list = array();
while( $row = $res->fetchrow(DB_FETCHMODE_ASSOC) ) {
 if( isset($list_recps[$row['id']]) ) $recps = $list_recps[$row['id']]; else $recps = 0;
 array_push($table_list, array(
			'id' => $row['id'],
			'domain'=> $row['domainid'],
			'address' => $row['address'],
			'access' => $row['access'],
			'public' => $row['public'],
			'recps' => $recps
			)
	);
}

} //Run ML-Code only ==y


//look at catchall  `efrom` REGEXP '^@'
$sql=sprintf("SELECT eto,id,access FROM forwardings WHERE domainid='%d' AND efrom REGEXP '^@'",
	$db->escapeSimple($_GET['id']));
$result=&$db->query($sql);
if ($result->numRows()==1)
{
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('if_catchall' , 'y');
	$smarty->assign('catchall_to',$data['eto'] );
	$smarty->assign('catchall_id',$data['id'] );
	$smarty->assign('catchall_access',$data['access'] );
	
}
else
{
	$smarty->assign('if_catchall' , 'n');
}


}//Access OK
else
{
	$access_domain=false;
}

$smarty->assign('access_domain', $access_domain);
$smarty->assign('did',$_GET['did']);
$smarty->assign('table_email', $table_email);
$smarty->assign('table_list', $table_list);
$smarty->assign('table_forward', $table_forward);
$smarty->assign('template','domain_view.tpl');
//$smarty->display('structure.tpl');
?>