{assign var="color1"  value="#ffffee"}
{assign var="color2"  value="#b0b0b0"}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>:: CpVES :: {$company_title} ::</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<meta name="author" content="Jonas Genannt / Original design by Andreas Viklund - http://andreasviklund.com" />
<link rel="stylesheet" href="css/main.css" type="text/css" media="screen" />
</head>
<body{include file="focus_input.tpl"}>
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
	<span class="text">Weiterleitung:{if $if_weiterleitung == 'y'}aktiv{else}nicht aktiv{/if}</span> |{/if}
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
</body{include>
</html>