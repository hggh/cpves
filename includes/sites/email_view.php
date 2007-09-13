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
	isset($_GET['id']) &&
	isset($_GET['did']) &&
	$_SESSION['superadmin']=='1'||
	$_SESSION['admin']=='1' &&
	isset($_GET['id']) &&
	isset($_GET['did']) &&
	$access_domain )
{
	$sql=sprintf("SELECT * FROM domains WHERE id='%s'",
		$db->escapeSimple($_GET['did']));
	$result=&$db->query($sql);
	$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
	$dnsname=$data['dnsname'];
	$domain_id=$_GET['did'];
	
	
	$smarty->assign('domain',$data['dnsname']);
	$dnsname=$data['dnsname']; // dnsname 
	$smarty->assign('if_imap', $data['p_imap']);
	$smarty->assign('if_pop3', $data['p_pop3']);
	$smarty->assign('if_webmail', $data['p_webmail']);
	$smarty->assign('if_spamassassin', $data['p_spamassassin']);
	$smarty->assign('if_mailarchive', $data['p_mailarchive']);
	$smarty->assign('if_bogofilter', $data['p_bogofilter']);
	$smarty->assign('if_spam_del', $data['p_spam_del']);
	$smarty->assign('if_sa_learn', $data['p_sa_learn']);
	$smarty->assign('if_fetchmail', $data['p_fetchmail']);
	$smarty->assign('if_webinterface', $data['p_webinterface']);
	$smarty->assign('if_autores_xheader', $data['p_autores_xheader']);
	$smarty->assign('if_check_polw', $data['p_check_polw']);
	$smarty->assign('if_check_grey', $data['p_check_grey']);
	$sql=sprintf("SELECT passwd,cpasswd,email FROM users WHERE id='%s'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$edata=$result->fetchrow(DB_FETCHMODE_ASSOC);
	
	
	/* save spamassassin begin */
	if (isset($_POST['save_option']))
{
	if (isset($_POST['spamassasin_active']) && is_numeric($_POST['spamassasin_active']))
	{
		update_email_options($_GET['id'],"spamassassin",$_POST['spamassasin_active'],0);
		update_email_options($_GET['id'],"bogofilter",$_POST['bogofilter_active'],0);
		//FIXME: in mailfilter ein und austragen!
		if ($_POST['spamassasin_active']=='1')
		{
			//INSERT INTO
			$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%d' AND type='spamassassin'",
				$db->escapeSimple($_GET['id']));
			$result=&$db->query($sql);
			$sql=sprintf("INSERT INTO mailfilter SET email='%d', active='1',prio='5', type='spamassassin'",
				$db->escapeSimple($_GET['id']));
			$result=&$db->query($sql);
		}
		else if($_POST['spamassasin_active']=='0')
		{
			//reset filter
			$sql=sprintf("UPDATE mailfilter SET active='0' WHERE email='%d' AND type='spamassassin'",
				$db->escapeSimple($_GET['id']));
			$result=&$db->query($sql);
		}
	}
	if (isset($_POST['rewrite_subject']) && is_numeric($_POST['rewrite_subject']))
	{
		if (strlen($_POST['rewrite_subject_header'])>15)
		{
			$smarty->assign('error_msg', 'y');
			$smarty->assign('if_wrong_sa_subjecttag','y');
		}
		else
		{
			if ($_POST['rewrite_subject']==0)
			{
				$rewrite_subject='';
			}
			elseif ($_POST['rewrite_subject']==1)
			{
				$rewrite_subject=$_POST['rewrite_subject_header'];
			
			}
			update_spamassassin_value($edata['email'],"rewrite_header subject",$rewrite_subject,$_GET['id'] );
			
		}
	}
	if (isset($_POST['threshold']) && !empty($_POST['threshold']))
	{
		if (ereg("^[0-9]{1,2}\.[0-9]$",$_POST['threshold'])==0)
		{
			$smarty->assign('error_msg', 'y');
			$smarty->assign('if_wrong_sa_threshold', 'y');
		}
		else
		{
			update_spamassassin_value($edata['email'],"required_score",$_POST['threshold'],$_GET['id']);
		}
	}
	//save the del_known_spam option
	if (is_numeric($_POST['del_known_spam']) && $_POST['del_known_spam']== 1) {
		if (ereg("^[0-9]{1,2}\.[0-9]$",$_POST['del_known_spam_value'])==0)
		{
			$smarty->assign('error_msg', 'y');
			$smarty->assign('if_wrong_del_known_spam_value', 'y');
		}
		elseif (get_spamassassin_value($edata['email'], "required_score", "5.0") >= $_POST['del_known_spam_value'] ) {
			$smarty->assign('error_msg', 'y');
			$smarty->assign('if_wrong_del_known_spam_value_lower', 'y');
		}
		else
		{
			update_email_options($_GET['id'],'del_known_spam_value',$_POST['del_known_spam_value'],0);
			update_email_options($_GET['id'],'del_known_spam','1',0);
		}
	}
	else {
		update_email_options($_GET['id'],'del_known_spam','0',0);
	}
	}
	/* save spamassassin end */

	//xheader disable feature
	if (isset($_GET['xheader']) && is_numeric($_GET['xheader']) && isset($_GET['do']) && $_GET['do']=='del') {
		$sql=sprintf("DELETE FROM autoresponder_xheader WHERE email='%d' AND id='%d'",
			$db->escapeSimple($_GET['id']),
			$db->escapeSimple($_GET['xheader']));
		$db->query($sql);
	}
	if (isset($_POST['xheader_submit'])) {
		if (!empty($_POST['xheader_name']) && !empty($_POST['xheader_value'])) {
			$sql=sprintf("INSERT INTO autoresponder_xheader SET email='%d',xheader='%s',value='%s'",
				$db->escapeSimple($_GET['id']),
				$db->escapeSimple($_POST['xheader_name']),
				$db->escapeSimple($_POST['xheader_value']));
			$db->query($sql);
		}
		else {
			$smarty->assign('error_msg','y');
			$smarty->assign('if_xheader_empty', 'y');
		}
	}

	/* Save autoresponder begin */
	if (isset($_POST['autores_submit'])) {
		$error=false;
		if (empty($_POST['autores_subject']) && $_POST['autores_active'] == 'y')
		{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_subject_empty', 'y');
		$error=true;
		}
		else if (empty($_POST['autores_msg']) && $_POST['autores_active'] == 'y')
		{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_msg_empty', 'y');
		$error=true;
		}
		else if(strlen($_POST['autores_subject']) > 50 && $_POST['autores_active'] == 'y')
		{
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_subject_to_long', 'y');
		$error=true;
		}
		else
		{
		save_autoresponder($_GET['id'],
			$_POST['autores_active'],
			$_POST['autores_subject'],
			$_POST['autores_msg'],$_POST['autores_sendback_times']);
		run_systemscripts();
		}
	
	}
	
	
	if (isset($_POST['val_tos_active'])&& is_numeric($_POST['val_tos_active'])) {
		update_email_options($_GET['id'],"auto_val_tos_active",$_POST['val_tos_active'], 0);
	}
	if(isset($_POST['val_tos_del'])) {
		val_tos_del($_GET['id'],$_POST['val_tos']);
	}
	
	if(isset($_POST['val_tos_add'])) {
		if (val_tos_add($_GET['id'], $_POST['val_tos_da'])== 1) {
			$smarty->assign('error_msg','y');
			$smarty->assign('if_submit_email_wrong', 'y');
		}
	}
	
	//automatic disable autoresponder:
	//save automatic autoresponder disable feaure
	if (isset($_POST['autores_datedisable_submit'])) {
	if ($_POST['autores_datedisable_active'] == 0) {
		$sql=sprintf("UPDATE autoresponder_disable SET active='0' WHERE email='%d'",
			$db->escapeSimple($_GET['id']));
		$result=&$db->query($sql);
	}
	elseif (! preg_match('/^([0-9]{2}).([0-9]{2}).([0-9]{4})$/', $_POST['autores_datedisable_date'])) {
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_date_wrong', 'y');
	}
	elseif (! preg_match('/^([0-9]{2}):([0-9]{2}):([0-9]{2})$/', $_POST['autores_datedisable_time'])) {
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_time_wrong', 'y');
	}
	elseif (! check_autores_date_disable($_POST['autores_datedisable_date'],$_POST['autores_datedisable_time'])) {
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_autores_disable_in_past', 'y');
	}
	else {
		$unix_time=autores_date_format($_POST['autores_datedisable_date'],$_POST['autores_datedisable_time']);
		$sql=sprintf("SELECT id FROM autoresponder_disable WHERE email='%d'",
			$db->escapeSimple($_GET['id']));
		$result=&$db->query($sql);
		if ($result->numRows() == 1) {
			$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
			$sql=sprintf("UPDATE autoresponder_disable SET a_date=FROM_UNIXTIME('%s'), active='1' WHERE email='%d'",
				$db->escapeSimple($unix_time),
				$db->escapeSimple($_GET['id']));
		}
		else {
			$sql=sprintf("INSERT INTO autoresponder_disable SET a_date=FROM_UNIXTIME('%s'),email='%d',active='1'",
				$db->escapeSimple($unix_time),
				$db->escapeSimple($_GET['id']));
		}
		$result=&$db->query($sql);
	}
	}
	
	
	/* Save autoresponder end */
	
	
	/*  Autoresponder begin */
	$sql=sprintf("SELECT id,email,active,msg,esubject,times FROM autoresponder WHERE email='%d'",
	$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	if ($result->numRows()==1)
	{
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		$active=$data['active'];
		$msg=$data['msg'];
		$esubject=$data['esubject'];
		$id=$data['id'];
		$times=$data['times'];
	}
	elseif($error)
	{
		$active=$_POST['autores_active'];
		$msg=$_POST['autores_msg'];
		$esubject=$_POST['autores_subject'];
		$times=$_POST['autores_sendback_times'];
	}
	else
	{
		$active='n';
		$msg=$config_autores_msg;
		$esubject=$config_autores_subject;
	}
	$smarty->assign('autores_subject', $esubject);
	$smarty->assign('autores_active', $active);
	$smarty->assign('autores_sendback_times_value', $times);
	$smarty->assign('id', $id);
	$smarty->assign('autores_msg', $msg);
	$smarty->assign('email', $_SESSION['email']);
	//output autoresponder disabled feature
	$autores_disable=get_autores_disable($_GET['id']);
	$smarty->assign('autores_disable', $autores_disable);
	/*  Autoresponder end */
	
	/* foward option save begin */
	if (isset($_POST['fwdmail_submit'])) {

	if (!empty($_POST['forwardaddress']) &&  Validate::email($_POST['forwardaddress']) !=1 ) {
		$smarty->assign('error_msg','y');
		$smarty->assign('if_error_forwardaddr_valid', 'y');
	}
	else {
		update_mailfilter('mail_forward',
			$_GET['id'],$_POST['forwardaddress'],
			$_POST['delete_forward'],
			$_POST['save_local']);
		run_systemscripts();
	}
	}
	/* foward option save begin */
	
	/* options save begin */
	if (isset($_POST['submit_mailoptions'])) {
		update_email_options($_GET['id'],"del_dups_mails",$_POST['del_dups_mails'], 0);
		update_email_options($_GET['id'],"del_virus_notifi",$_POST['del_virus_notifi'], 0);
		update_mailfilter('del_virus_notifi',$_GET['id'], $_POST['del_virus_notifi'],0,0);
		update_mailfilter('del_dups_mails',$_GET['id'], $_POST['del_dups_mails'],0,0);
		
	// activate System-Script
	run_systemscripts();
	
	}
	$del_virus_notifi = get_email_options($_GET['id'],"del_virus_notifi", 0);
	$smarty->assign('del_virus_notifi',$del_virus_notifi );

	$del_dups_mails = get_email_options($_GET['id'],"del_dups_mails", 0);
	$smarty->assign('del_dups_mails',$del_dups_mails );
	/* option save ENDE */
	
	
	/* forward option begin */
	$sql=sprintf("SELECT type,filter FROM mailfilter WHERE email='%d' AND active!=0 AND type LIKE 'forward%%'",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	if ($result->numRows()==1) {
		$data=$result->fetchrow(DB_FETCHMODE_ASSOC);
		if ($data['type']=="forward_cc") { // mit kopie ans lokale postfach
			$smarty->assign('if_forward_cc', '1');
		}
		$smarty->assign('forwardaddress', $data['filter']);
	}
	/* forward option end */
	
	
	

	
	//adde domainadmin:
	if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='1'
		&& isset($_POST['adddns']) && is_numeric($_POST['add_domain']) )
	{
		$sql=sprintf("SELECT id FROM admin_access WHERE email='%d' AND domain='%d'",
			$db->escapeSimple($_GET['id']),
			$db->escapeSimple($_POST['add_domain']));
		$res=&$db->query($sql);
		if ($res->numRows() == 0)
		{
			$sql=sprintf("INSERT INTO admin_access SET email='%d', domain='%d'",
				$db->escapeSimple($_GET['id']),
				$db->escapeSimple($_POST['add_domain']));
			$res=&$db->query($sql);
		}
	}
	
	//remove domainadmin: 
	if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='1' 
		&& isset($_GET['del']) && is_numeric($_GET['del']))
	{
		$sql=sprintf("DELETE FROM admin_access WHERE id='%d'",
			$db->escapeSimple($_GET['del']));
		$res=&$db->query($sql);
	}
	
	
	// Liste AdminDomains
	if (isset($_SESSION['superadmin']) && $_SESSION['superadmin']=='1' )
	{
		$sql=sprintf("SELECT b.dnsname,a.id FROM admin_access AS a LEFT JOIN domains as b ON b.id=a.domain WHERE a.email='%s'",
			$db->escapeSimple($_GET['id']));
		$res_admin=&$db->query($sql);
		$table_admins= array();
		$smarty->assign('ava_ad_domains',$res_admin->numRows());
		while($data=$res_admin->fetchrow(DB_FETCHMODE_ASSOC))
		{
			array_push($table_admins, array(
				'dnsname' => $data['dnsname'],
				'del_id' => $data['id'])
			);
		} //ENDE WHILE 
		$smarty->assign('table_admins', $table_admins);
		
		$sql=sprintf("SELECT a.dnsname,b.email,a.id FROM domains AS a LEFT JOIN admin_access AS b ON b.domain = a.id ORDER BY a.dnsname");
		$res_dns=&$db->query($sql);
		$table_adddns= array();
		while($data=$res_dns->fetchrow(DB_FETCHMODE_ASSOC))
		{
			if ($data['email'] != $_GET['id'])
			{
				array_push($table_adddns, array(
				'dnsname' => $data['dnsname'],
				'dnsid' => $data['id'])
				);
			}
		}
		if (count($table_adddns)==0) {
			$smarty->assign('if_nodomains_found', 'y');
		}
		$smarty->assign('table_adddns', $table_adddns);
		
	}//ende Liste adminDomains
	
	// wenn submit dann aendere daten:
	if (isset($_POST['submit']))
	{
			if (isset($_POST['imap']) && 
			  $_POST['imap'] == "enable" &&
			check_domain_feature($_GET['did'],'p_imap'))
			{
				$imap="1";
			}
			else
			{
				$imap="0";
			}
			if (isset($_POST['pop3']) && 
			  $_POST['pop3'] == "enable" &&
			  check_domain_feature($_GET['did'],'p_pop3'))
			{
				$pop3="1";
			}
			else
			{
				$pop3="0";
			}
			if (isset($_POST['webmail']) && 
			  $_POST['webmail'] == "enable" &&
			  check_domain_feature($_GET['did'],'p_webmail'))
			{
				$webmail="1";
			}
			else
			{
				$webmail="0";
			}
			if (isset($_POST['spamassassin']) && $_POST['spamassassin']=='enable' &&
			    check_domain_feature($_GET['did'], 'p_spamassassin'))
			{
				$spamassassin=1;
				
			}
			else 
			{
				$spamassassin=0;
			}
			if (isset($_POST['mailachrive']) && $_POST['mailachrive'] =="enable" && check_domain_feature($_GET['did'],'p_mailarchive')) {
				$mailarchive=1;
			}
			else
			{
				$mailarchive=0;
			}
			if (isset($_POST['bogofilter']) &&  $_POST['bogofilter'] =="enable" && check_domain_feature($_GET['did'],'p_bogofilter')) {
				$bogofilter=1;
			}
			else
			{
				$bogofilter=0;
			}
			if (isset($_POST['spam_del']) && $_POST['spam_del'] =="enable" && check_domain_feature($_GET['did'],'p_spam_del')) {
				$spam_del=1;
			}
			else
			{
				$spam_del=0;
			}
			if (isset($_POST['sa_learn']) && $_POST['sa_learn'] =="enable" && check_domain_feature($_GET['did'],'p_sa_learn')) {
				$sa_learn=1;
			}
			else
			{
				$sa_learn=0;
			}
			if (isset($_POST['fetchmail']) && $_POST['fetchmail'] == "enable" && check_domain_feature($_GET['did'], 'p_fetchmail')) {
				$fetchmail=1;
			}
			else {
				$fetchmail=0;
			}
			if (isset($_POST['webinterface']) && $_POST['webinterface'] == "enable" && check_domain_feature($_GET['did'], 'p_webinterface')) {
				$webinterface=1;
			}
			else {
				$webinterface=0;
			}
			if (isset($_POST['autores_xheader']) && $_POST['autores_xheader'] == "enable" && check_domain_feature($_GET['did'], 'p_autores_xheader')) {
				$autores_xheader=1;
			}
			else {
				$autores_xheader=0;
			}
			if (isset($_POST['check_polw']) && $_POST['check_polw'] == "enable" && check_domain_feature($_GET['did'], 'p_check_polw')) {
				$check_polw=1;
			}
			else {
				$check_polw=0;
			}
			if (isset($_POST['check_grey']) && $_POST['check_grey'] == "enable" && check_domain_feature($_GET['did'], 'p_check_grey')) {
				$check_grey=1;
			}
			else {
				$check_grey=0;
			}
			if (isset($_POST['forwarding']) && $_POST['forwarding'] == "enable" ) {
				$forward_vis=1;
			}
			else
			{
				$forward_vis=0;
			}
			if (isset($_POST['npassword']) && !empty($_POST['npassword']))
			{
				if (check_passwd_length($_POST['npassword'])==false)
				{
					$smarty->assign('error_msg', 'y');
					$smarty->assign('if_error_password_long','y');
					
					$smarty->assign('full_name',$_POST['full_name'] );
					$error=true;
				}
				else
				{
					$password=$_POST['npassword'];
					$cpasswd=crypt($_POST['npassword']);
				}
			} 
			else
			{
				$password=$edata['passwd'];
				$cpasswd=$edata['cpasswd'];
			}
			if ($config['cleartext_passwd']==1) {
				$cleartext=$password;
			}
			else
			{
				$cleartext="";
			}
			if (!$error)
			{
				$sql=sprintf("UPDATE users SET passwd='%s', full_name='%s',p_imap='%d', p_pop3='%d',p_webmail='%d',	cpasswd='%s', p_forwarding='%s',p_spamassassin='%s',p_mailarchive='%d',p_bogofilter='%d',p_spam_del='%d',p_sa_learn='%d',p_fetchmail='%d',p_webinterface='%d',p_autores_xheader='%d',p_check_polw='%d',p_check_grey='%d' WHERE id='%d' ",
					$db->escapeSimple($cleartext),
					$db->escapeSimple($_POST['full_name']),
					$db->escapeSimple($imap),
					$db->escapeSimple($pop3),
					$db->escapeSimple($webmail),
					$db->escapeSimple($cpasswd),
					$db->escapeSimple($forward_vis),
					$db->escapeSimple($spamassassin),
					$db->escapeSimple($mailarchive),
					$db->escapeSimple($bogofilter),
					$db->escapeSimple($spam_del),
					$db->escapeSimple($sa_learn),
					$db->escapeSimple($fetchmail),
					$db->escapeSimple($webinterface),
					$db->escapeSimple($autores_xheader),
					$db->escapeSimple($check_polw),
					$db->escapeSimple($check_grey),
					$db->escapeSimple($_GET['id'])) ;
				$result=&$db->query($sql);
				$smarty->assign('success_msg', 'y');
				$smarty->assign('if_email_data_saved', 'y');
			}
	}//ende update DB

	
	
	// OK OK OK OK OK OK OK OK OK OK OK OUTPUT after INSERT!!
	//get email 
	$sql=sprintf("SELECT * FROM users WHERE id='%s'",
		$db->escapeSimple($_GET['id']));
	$edata=&$db->getRow($sql,array(),DB_FETCHMODE_ASSOC);
	$full_email=$edata['email'];
	$smarty->assign('full_email', $full_email);
	$smarty->assign('full_name', $edata['full_name']);
	$smarty->assign('if_imap_value', $edata['p_imap']);
	$smarty->assign('if_pop3_value', $edata['p_pop3']);
	$smarty->assign('if_webmail_value', $edata['p_webmail']);
	$smarty->assign('if_webinterface_value',$edata['p_webinterface']);
	$smarty->assign('if_forwarding_value', $edata['p_forwarding']);
	$smarty->assign('if_spamassassin_value', $edata['p_spamassassin']);
	$smarty->assign('if_mailarchive_value', $edata['p_mailarchive']);
	$smarty->assign('if_bogofilter_value', $edata['p_bogofilter']);
	$smarty->assign('if_spam_del_value', $edata['p_spam_del']);
	$smarty->assign('if_sa_learn_value', $edata['p_sa_learn']);
	$smarty->assign('if_fetchmail_value',$edata['p_fetchmail']);
	$smarty->assign('if_autores_xheader_value',$edata['p_autores_xheader']);
	$smarty->assign('if_check_polw_value',$edata['p_check_polw']);
	$smarty->assign('if_check_grey_value',$edata['p_check_grey']);
	if ( !empty($edata['move_spam']) && $edata['move_spam']!=NULL) {
		$smarty->assign('sa_move_spam',$edata['move_spam'] );
	}
	else {
		$smarty->assign('sa_move_spam','0');
	}
	
	// outout val_tos
	$sql=sprintf("SELECT recip,id FROM autoresponder_recipient WHERE email='%d'",
	$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$table_val_tos = array();
	while($data=$result->fetchrow(DB_FETCHMODE_ASSOC)) {
		array_push($table_val_tos,array(
		'recip' => $data['recip'],
		'id'    => $data['id'])); 
	}
	$smarty->assign('table_val_tos', $table_val_tos);
	//output val_tos_active
	$val_tos_active = get_email_options($_GET['id'],"auto_val_tos_active", 0);
	$smarty->assign('val_tos_active', $val_tos_active);
	
	// output spamassassin
	$spamassassin=get_email_options($_GET['id'],"spamassassin", 0);
	$bogofilter=get_email_options($_GET['id'],"bogofilter", 0);
	$del_known_spam=get_email_options($_GET['id'],"del_known_spam",0);
	$del_known_spam_value=get_email_options($_GET['id'],"del_known_spam_value",'10.0');
	
	$smarty->assign('spamassassin_active', $spamassassin);
	$smarty->assign('bogofilter_active', $bogofilter);
	$smarty->assign('del_known_spam', $del_known_spam);
	$smarty->assign('del_known_spam_value', $del_known_spam_value);
	// Database output rewrite_header subject
	$sa_header = get_spamassassin_value($full_email, "rewrite_header subject", false);
	if ($sa_header==false) {
		$smarty->assign('rewrite_subject', '0');
		$smarty->assign('rewrite_subject_header', "*** SPAM ***");
	}
	else {
		$smarty->assign('rewrite_subject', '1');
		$smarty->assign('rewrite_subject_header', $sa_header);
	}
	// Database output required_score
	$sa_threshold = get_spamassassin_value($full_email, "required_score", "5.0");
	$smarty->assign('threshold', $sa_threshold);
	
	//output xheader feature
	if ($edata['p_autores_xheader'] == 1) {
	$sql=sprintf("SELECT * FROM autoresponder_xheader WHERE email='%d' ORDER BY xheader",
		$db->escapeSimple($_GET['id']));
	$result=&$db->query($sql);
	$table_xheader=array();
	while($data=$result->fetchrow(DB_FETCHMODE_ASSOC)) {
		array_push($table_xheader,array(
			'id' => $data['id'],
			'xheader' => $data['xheader'],
			'value' => $data['value']));
	}
	$smarty->assign('table_xheader',$table_xheader);
	}


} // ENDE ACCESS OK


$smarty->assign('id',$_GET['id']);
$smarty->assign('domainid',$_GET['did']);
?>
