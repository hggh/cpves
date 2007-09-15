<?php
//Enable or Disable Domain BEGIN
if (isset($_SESSION['superadmin']) && 
	$_SESSION['superadmin']=='1'&& 
	isset($_GET['did']) &&
	is_numeric($_GET['did']) &&
	isset($_GET['state']) )
{
	if ($_GET['state']=='disable')
	{
		$sql=sprintf("UPDATE domains SET ACCESS='0' WHERE id=%s",
			$db->escapeSimple($_GET['did']));
	}
	else if ($_GET['state']=='enable')
	{
		$sql=sprintf("UPDATE domains SET ACCESS='1' WHERE id=%s",
			$db->escapeSimple($_GET['did']));
	}
	$result=&$db->query($sql);
	if (!$result)
	{
		echo "ERROR! Something went wrong!";
	}
}
//ENABLE or DISABLE DOMAIN


if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='1' || isset($_SESSION['admin']) && $_SESSION['admin']=='1' && $_SESSION['ad_user']!='y')
{

if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']==1 )
{
	$sql="SELECT * FROM domains WHERE enew!=0 ORDER BY dnsname";
}
else
{
	$sql=sprintf("SELECT * FROM admin_access WHERE email=%s",
		$db->escapeSimple($_SESSION['uid']));
	$result=&$db->query($sql);
	$sql="SELECT * FROM domains WHERE id=";
	$e=0;
	while($daten=$result->fetchrow(DB_FETCHMODE_ASSOC))
	{
		if ($e==0)
		{
			$sql.="'".$daten['domain']. "' AND enew!=0 ";
		}
		else
		{
			$sql.=" OR id='".$daten['domain']. "' AND enew!=0 ";
		}
		$e++;
		
	}
	$sql.=" ORDER BY dnsname";
}

$table_data = array();
$result = $db->query($sql);
while($row = $result->fetchrow(DB_FETCHMODE_ASSOC))
{
	$sql=sprintf("SELECT a.email FROM users AS a LEFT JOIN autoresponder AS b ON b.email = a.id WHERE a.domainid='%d' AND b.active = 'y'",
		$db->escapeSimple($row['id']));
	$res_vacation = $db->query($sql);
	if ($res_vacation->numRows() > 0 ) {
		$vaction=1;
		$vaction_infos="";
		while($row_vac = $res_vacation->fetchrow(DB_FETCHMODE_ASSOC)) {
			$vaction_infos .= $row_vac['email'] . " ";
		}
	}
	else {
		$vaction=0;
	}
	array_push($table_data, array(
         'dnsname' => $row['dnsname'],
         'access' => $row['access'],
	 'count_forward' => get_forem_domain($row['id'],'forwardings',$db), 
	 'count_email' => get_forem_domain($row['id'],'users',$db),
	 'id' => $row['id'],
	 'access' => $row['access'],
	 'dnote' => $row['dnote'],
	 'vacation' => $vaction,
	 'vacation_infos' => $vaction_infos
         )
      );
      //$i++; 
} 
}

//email user part:
if ($_SESSION['superadmin']==0 && $_SESSION['admin']=='0' | $_SESSION['ad_user'] == 'y' && $_SESSION['manager']=='0')
{
	$folders =list_imap_folders($config['imap_server'],$_SESSION['email'],decrypt_passwd($_SESSION['cpasswd']), 1);
	if ($folders== false ) {
	$smarty->assign('imap_folder_exits', 0);
	}
	else {
		$smarty->assign('imap_folder_exits', 1);
		$smarty->assign('available_folders',$folders);
	}
	$smarty->assign('if_user_index','y');
	$smarty->assign('full_name', $_SESSION['full_name']);
	$smarty->assign('email', $_SESSION['email']);
	
	if ($config['display_mb_size'] == 1) {
	$sql=sprintf("SELECT mb_size FROM users WHERE id='%d'",
		$db->escapeSimple($_SESSION['uid']));
	$result=& $db->query($sql);
	$row = $result->fetchrow(DB_FETCHMODE_ASSOC);
	$smarty->assign('mb_size', $row['mb_size']);
	}
	
}
$smarty->assign('table_data', $table_data);
?>