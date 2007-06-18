{assign var="color1"  value="#ffffee"}
{assign var="color2"  value="#b0b0b0"}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>:: CpVES :: {$company_title} ::</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="author" content="Jonas Genannt / Original design by Andreas Viklund - http://andreasviklund.com" />
<link rel="stylesheet" href="css/thickbox.css" type="text/css" media="screen" />
<link rel="stylesheet" href="css/main.css" type="text/css" media="screen" />
{literal}
<script type="text/javascript" >
	var cpves_check_state=1;
</script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/thickbox.js"></script>
<script type="text/javascript">
function forwardadd_fillform() {
	var fwd = document.forms[0].to.value;
	if ( fwd == "" ) {
		document.forms[0].to.value=document.forms[0].mail.value;
	}
	if (fwd.search('@') >= 1) {
		reg = new RegExp(',$');
		if (reg.test(fwd)) {
			document.forms[0].to.value=fwd + document.forms[0].mail.value;
		}
		else {
			document.forms[0].to.value=fwd +',\n'+document.forms[0].mail.value;
		}
	}
}

function armail_check_both(a) {
	var c = document.getElementById('checkboth' +a).checked;
	document.getElementById('armail_folder_month'+a).checked=c;
	document.getElementById('armail_folder_year' +a).checked=c;
}
function cpves_autores_field(c) {
	document.getElementById('autores_subject').disabled=c;
	document.getElementById('autores_msg').disabled=c;
	document.getElementById('autores_datedisable_active').disabled=c;
	document.getElementById('autores_datedisable_date').disabled=c;
	document.getElementById('autores_datedisable_time').disabled=c;
	document.getElementById('autores_datedisable_submit').disabled=c;
	document.getElementById('autores_valtos_active_off').disabled=c;
	document.getElementById('autores_valtos_active_on').disabled=c;
	document.getElementById('autores_valtos_data').disabled=c;
	document.getElementById('autores_valtos_del').disabled=c;
	document.getElementById('autores_valtos_add_data').disabled=c;
	document.getElementById('autores_valtos_add_submit').disabled=c;
}
function cpves_autores_datedisable(c) {
	document.getElementById('autores_datedisable_date').disabled=c;
	document.getElementById('autores_datedisable_time').disabled=c;
}
function cpves_autores_valtos(c) {
	document.getElementById('autores_valtos_data').disabled=c;
	document.getElementById('autores_valtos_del').disabled=c;
	document.getElementById('autores_valtos_add_data').disabled=c;
	document.getElementById('autores_valtos_add_submit').disabled=c;
}
function cpves_sa_active(a) { 
	if (a == 1 ) {
		document.getElementById('spamassassin_threshold').disabled='';
		document.getElementById('spamassassin_subject_header').disabled='';
		document.getElementById('del_known_spam').disabled='';
		document.getElementById('del_known_spam_value').disabled='';
		document.getElementById('bogofilter_active').disabled='';
	}
	else {
		document.getElementById('spamassassin_threshold').disabled=true;
		document.getElementById('spamassassin_subject_header').disabled=true;
		document.getElementById('del_known_spam').disabled=true;
		document.getElementById('del_known_spam_value').disabled=true;
		document.getElementById('bogofilter_active').disabled=true;
	}
}
function cpves_sa_del_knowndisable(a) {
	if (a == 1) {
		document.getElementById('del_known_spam_value').disabled='';
	}
	else {
		document.getElementById('del_known_spam_value').disabled=true;
	}
}
function cpves_sa_warning_ok() {
                document.getElementById('sa_form').submit();
		tb_remove();
}
function cpves_mf_rebuild_ok() {
		document.getElementById('mf_rebuild').value="1";
		document.getElementById('sadmin_mf_rebuild').submit();
		tb_remove();
}
function cpves_update_sa_warning() {
	var neu=document.getElementById('spamassassin_threshold').value;
	document.getElementById('sa_thresshold_value').innerHTML=neu;
	neu=document.getElementById('del_known_spam_value').value;
	document.getElementById('sa_del_known_spam').innerHTML=neu;
}
function cpves_sa_check_warning() {
	if (document.getElementById('del_known_spam').value == 0 || document.getElementById('spamassassin_active').value == 0 ) {
		cpves_check_state=0;
		document.getElementById('sa_form').submit();
	}
	cpves_update_sa_warning();
	}
	</script>
</script>{/literal}
</head>
<body {include file="focus_input.tpl"}>
{if $error_msg == 'y'}
<div style="background-color:#EF9398;border:1px solid#DC5757;float:right;width:450px;text-align:left;">
<div style="float:left;margin:6px;"><img src="img/icons/stop.png" /></div>
<div style="text-align:left;float:left;margin-top:7px;">
{include file="error_messages.tpl"}
</div></div>
{/if}
{if $success_msg == 'y'}
<div style="background-color:#A6EF7B;border:1px solid#76C83F;float:right;width:450px;text-align:left;">
<div style="float:left;margin:6px;"><img src="img/icons/success.png" /></div>
<div style="text-align:left;float:left;margin-top:7px;">
{include file="success_messages.tpl"}</div>
</div>
{/if}

<div id="container">
<div id="sitename">
<h1>CpVES</h1>
<h2>{$company_title}</h2>
</div>

<div id="mainmenu">| 
<span class="text">Benutzer: {$username}</span> | 
{if $if_superadmin != 'y' && $if_login != 'y'}
	<span class="text">Autoresponder: {if $if_autoresponder == 'y'}aktiv{else}nicht aktiv{/if}</span>  | 
	{if $if_forwarding == 1}
	<span class="text">Weiterleitung: {if $if_weiterleitung == 'y'}aktiv{else}nicht aktiv{/if}</span> |{/if}
	{/if}
{if $if_superadmin == 'y' && $if_manager == 'y'}
<span class="text"> Rechte: Superadmin Manager</span> |
{elseif $if_superadmin == 'y'&& $if_manager != 'y'} 
<span class="text"> Rechte: Superadmin</span> |{/if}
</div>

<div id="wrap">
{include file="navigation.tpl"}
<div id="content">
<h1>{include file="cont_headline.tpl"}</h1>

{include file=$template}

</div>
<div class="clearingdiv">&nbsp;</div>
</div>
</div>
<div id="footer"></div>
</body>
</html>