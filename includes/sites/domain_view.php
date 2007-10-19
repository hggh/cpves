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
if ( (isset($_SESSION['superadmin']) &&
	isset($_GET['did']) &&
	is_numeric($_GET['did']) &&
	$_SESSION['superadmin']=='1') || (
	isset($_SESSION['admin']) &&
	$_SESSION['admin']=='1' &&
	isset($_GET['did']) &&
	is_numeric($_GET['did']) &&
	$access_domain ) )
{
//Enable or Disable EMAIL BEGIN
if (isset($_GET['eid']) && is_numeric($_GET['eid']) && isset($_GET['state']) && isset($_GET['type']) )
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
		$sql=sprintf("UPDATE %s SET ACCESS='0' WHERE id='%s'",
			$table,
			$db->escapeSimple($_GET['eid']));
	}
	else if ($_GET['state']=='enable')
	{
		$sql=sprintf("UPDATE %s SET ACCESS='1' WHERE id='%s'",
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

//Whitelist add:
if (isset($_POST['sa_whitelist_data_add_submit']) && ($_SESSION['spamassassin']==1||$_SESSION['superadmin']== '1') ) {
	if (!isset($_POST['sa_whitelist_data_add']) || empty($_POST['sa_whitelist_data_add'])) {
		$smarty->assign('error_msg', 'y');
		$smarty->assign('sa_whitelist_data_add_empty', 'y');
		
	}
	elseif (check_whitelist_addr($_POST['sa_whitelist_data_add'])== 0) {
		$smarty->assign('error_msg', 'y');
		$smarty->assign('sa_whitelist_data_add_wrong', 'y');
	}
	else {
		$addr=trim(strtolower($_POST['sa_whitelist_data_add']));
		$sql=sprintf("INSERT INTO sa_wb_listing SET domainid='%s',email='0',sa_from='%s',type='1'",
			$db->escapeSimple($_GET['did']),
			$db->escapeSimple($addr));
		$result=&$db->query($sql);

	}
}
//Whitelist add (END)

//Whitelist del:
if (isset($_POST['sa_whitelist_data_del']) && !empty($_POST['sa_whitelist_data'])) {
	
	foreach($_POST['sa_whitelist_data'] as $key) {
		$sql=sprintf("DELETE FROM sa_wb_listing WHERE domainid='%d' AND id='%d'",
			$db->escapeSimple($_GET['did']),
			$db->escapeSimple($key));
		$db->query($sql);
		unset($sql);
	}
}
//Whitelist del (END)

if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='1') {
	//change MAX_forwards in database:
	if (isset($_POST['max_forwards']) && is_numeric($_POST['max_forwards']) ) {
		$sql=sprintf("UPDATE domains SET max_forward='%d' WHERE id='%d'",
			$db->escapeSimple($_POST['max_forwards']),
			$db->escapeSimple($_GET['did']));
		$db->query($sql);
	}

	//change MAX_emailss in database:
	if (isset($_POST['max_emails']) && is_numeric($_POST['max_emails']) ) {
		$sql=sprintf("UPDATE domains SET max_email='%d' WHERE id='%d'",
			$db->escapeSimple($_POST['max_emails']),
			$db->escapeSimple($_GET['did']));
		$db->query($sql);
	}
	
	//Domain Notiz aendern:
	if (isset($_POST['dnote'])) {
		$sql=sprintf("UPDATE domains SET dnote='%s' WHERE id='%d'",
			$db->escapeSimple(clean_input(substr($_POST['dnote'],0,30))),
			$db->escapeSimple($_GET['did']));
		$db->query($sql);
	}
} // superadmin END

//Domain features veraendern ANFANG
if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='1' && isset($_GET['fstate'])&& isset($_GET['f']))
{
	if ($_GET['f']=='spamassassin' && $_GET['f']==0) {
		change_domain_feature($_GET['did'],'bogofilter','0');
		change_domain_feature($_GET['did'],'spam_del','0');
		change_domain_feature($_GET['did'],'sa_wb_listing','0');
		change_domain_feature($_GET['did'],'sa_learn','0');
	}
	if ($_GET['f']=='bogofilter' 
	   && !check_domain_feature($_GET['did'], 'p_spamassassin')) {
	   $smarty->assign('error_msg', 'y');
	   $smarty->assign('if_error_sa_disabled_enable_bogofilter','y');
	}
	elseif ($_GET['f']=='spam_del' 
	   && !check_domain_feature($_GET['did'], 'p_spamassassin')) {
		$smarty->assign('error_msg', 'y');
		$smarty->assign('if_error_sa_disable_enable_spam_del', 'y');
	}
	elseif ($_GET['f']=='sa_wb_listing' 
	   && !check_domain_feature($_GET['did'], 'p_spamassassin')) {
		$smarty->assign('error_msg', 'y');
		$smarty->assign('if_error_sa_disable_enable_sa_wb_listing', 'y');
	}
	elseif($_GET['f']=='sa_learn' 
	   && !check_domain_feature($_GET['did'], 'p_spamassassin')) {
		$smarty->assign('error_msg', 'y');
		$smarty->assign('if_error_sa_disable_enable_sa_learn', 'y');
	}
	else {
		if ($_GET['f'] == 'check_polw' && $config['recipient_classes_polw']==0) {
		}
		elseif($_GET['f'] == 'check_grey' && $config['recipient_classes_grey']==0) {
		}
		else {
		change_domain_feature($_GET['did'],$_GET['f'],$_GET['fstate']);
		}
	}

}
// Domain feature veraendern ENDE


	$sql=sprintf("SELECT * FROM domains WHERE id='%s' LIMIT 1",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('dnsname', $data['dnsname']);
	$smarty->assign('domain', $data);
	$smarty->assign('max_emails', $data['max_email']);
	$smarty->assign('max_fwd', $data['max_forward']);

$smarty->assign('emails', get_forem_domain($_GET['did'],'users', $db));
$smarty->assign('forwardings', get_forem_domain($_GET['did'],'forwardings', $db));


//FIXME: deleted email addresses!!!
$sql=sprintf("SELECT email,id,access,mb_size FROM users WHERE domainid='%s' AND enew!='0' ORDER BY email",
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
	'mb_size' => mailbox_size_human($data['mb_size']),
	'autoresponder' => $autoresponder) );
} //ENDE WHILE eMails

$sql=sprintf("SELECT * FROM forwardings WHERE domainid='%s' ORDER BY efrom",
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
	'access' =>$data['access']));
	}
} //ENDE WHILE forward


if ($config['mailinglists'] == '1') { //Run ML-Code only ==1

$sql = sprintf("SELECT id,COUNT(*) as num FROM list_recp GROUP BY id",
	$db->escapeSimple($_GET['did']));
$res = &$db->query($sql);
$list_recps = array();
while( $row = $res->fetchrow(DB_FETCHMODE_ASSOC) ) {
 $list_recps[$row['id']] = $row['num'];
}

$sql = sprintf("SELECT * FROM lists WHERE domainid = %d ORDER BY address",
	$db->escapeSimple($_GET['did']));
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

} //Run ML-Code only == 1

//look at catchall  `efrom` REGEXP '^@'
$sql=sprintf("SELECT eto,id,access FROM forwardings WHERE domainid='%d' AND efrom REGEXP '^@'",
	$db->escapeSimple($_GET['did']));
$result=&$db->query($sql);
if ($result->numRows()==1) {
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('if_catchall' , 'y');
	$smarty->assign('catchall_to',$data['eto'] );
	$smarty->assign('catchall_id',$data['id'] );
	$smarty->assign('catchall_access',$data['access'] );
}
else {
	$smarty->assign('if_catchall' , 'n');
}


//get Spamfilter whitelist
if ($_SESSION['spamassassin']==1 ||$_SESSION['superadmin'] == '1') {
	$sql=sprintf("SELECT id,sa_from FROM sa_wb_listing WHERE domainid='%s' ORDER BY sa_from",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$table_sa_whitelist=array();
	while($row=$result->fetchrow(DB_FETCHMODE_ASSOC)) {
		array_push($table_sa_whitelist,array(
			'id' => $row['id'],
			'sa_from' => $row['sa_from']));
	}
	$smarty->assign('table_sa_whitelist',$table_sa_whitelist);
}
//get Spamfilter whitelist END


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
?>