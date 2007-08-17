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
		$sql=sprintf("UPDATE domains SET ACCESS='n' WHERE id=%s",
			$db->escapeSimple($_GET['did']));
	}
	else if ($_GET['state']=='enable')
	{
		$sql=sprintf("UPDATE domains SET ACCESS='y' WHERE id=%s",
			$db->escapeSimple($_GET['did']));
	}
	$result=&$db->query($sql);
	if (!$result)
	{
		echo "ERROR! Something went wrong!";
	}
}
//ENABLE or DISABLE DOMAIN


if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='1' || isset($_SESSION['admin']) && $_SESSION['admin']=='y' && $_SESSION['ad_user']!='y')
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
	array_push($table_data, array(
         'dnsname' => $row['dnsname'],
         'access' => $row['access'],
	 'count_forward' => get_forem_domain($row['id'],'forwardings',$db), 
	 'count_email' => get_forem_domain($row['id'],'users',$db),
	 'id' => $row['id'],
	 'access' => $row['access'],
	 'dnote' => $row['dnote']
         )
      );
      //$i++; 
} 
}
//check for spam:
$test='n';
if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='y'&& $test=='y')
{

require_once 'Net/DNSBL.php';
$dnsbl = new Net_DNSBL();

$table_spam=array();
while (list($key, $value) = each($ar_spam))
//foreach($ar_spam as $value)
{
	$dnsbl->setBlacklists($value);
	if ($dnsbl->isListed($config['server_ip']))
	{
		$smarty->assign('if_blacklist_listet', 'y');
		array_push($table_spam, array('spam' => $value));
	}
	
}

$smarty->assign('ipaddr',$config['server_ip'] ); 
$smarty->assign('table_spam', $table_spam);

} // SPAM CHECK ENDE


//email user part:
if ($_SESSION['superadmin']==0 && $_SESSION['admin']=='n' | $_SESSION['ad_user'] == 'y' && $_SESSION['manager']=='0')
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
	if (isset($_POST['u_submit']))
	{
		if (!isset($_POST['new_passwd1']) || empty($_POST['new_passwd1']) ||
		    !isset($_POST['new_passwd2']) || empty($_POST['new_passwd2']))
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_password_empty','y');
		}
		else if (check_passwd_length($_POST['new_passwd2']) ==false)
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_password_long', 'y');

		}
		else if($_POST['new_passwd1'] !=$_POST['new_passwd2'] )
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_new_passwd_not_same', 'y');
		}
		else if(decrypt_passwd($_SESSION['cpasswd']) != $_POST['old_passwd'])
		{
			$smarty->assign('error_msg','y');
			$smarty->assign('if_error_password_old_wrong','y');
		}
		else
		{
			if ($config['cleartext_passwd']==1) {
				$cleartext=$_POST['new_passwd1'];
			}
			else
			{
				$cleartext="";
			}
			$sql=sprintf("UPDATE users SET passwd='%s',cpasswd='%s' WHERE id='%d'",
				$db->escapeSimple($cleartext),
				$db->escapeSimple(crypt($_POST['new_passwd1'])),
				$db->escapeSimple($_SESSION['uid']));
			$res=&$db->query($sql);
			
			$smarty->assign('passwd_changed', 'y');
			$smarty->assign('success_msg','y');
			$smarty->assign('if_password_changed', 'y');
			$_SESSION['cpasswd']=encrypt_passwd($_POST['new_passwd1']);
		}
	}
}
$smarty->assign('table_data', $table_data);
?>