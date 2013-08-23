{assign var="color1"  value="#ffffee"}
{assign var="color2"  value="#b0b0b0"}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>:: CpVES :: {$config.company_title} ::</title>
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
<script type="text/javascript" src="js/cpves.js"></script>
{/literal}
</head>
<body {include file="focus_input.tpl"}>
<!--
#################################################################################
                         CpVES Version: {$config.cpves_version}
#################################################################################

#################################################################################
# Copyright (C) 2006-2012 Jonas Genannt <jonas.genannt@brachium-system.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#################################################################################
-->
{if $error_msg|default:'n' == 'y' && $if_logout != 'y'}
<div style="background-color:#EF9398;border:1px solid#DC5757;float:right;width:450px;text-align:left;">
<div style="float:left;margin:6px;"><img src="img/icons/stop.png" /></div>
<div style="text-align:left;float:left;margin-top:7px;">
{include file="error_messages.tpl"}
</div></div>
{/if}
{if $success_msg|default:'n' == 'y'}
<div style="background-color:#A6EF7B;border:1px solid#76C83F;float:right;width:450px;text-align:left;">
<div style="float:left;margin:6px;"><img src="img/icons/success.png" /></div>
<div style="text-align:left;float:left;margin-top:7px;">
{include file="success_messages.tpl"}</div>
</div>
{/if}

<div id="container">
<div id="sitename">
<h1>CpVES</h1>
<h2>{$config.company_title}</h2>
</div>

<div id="mainmenu">
{if $username|default:"" != ""}| 
<span class="text">{t}username{/t}: {$username}</span> |{else}&nbsp;{/if}
{if $if_superadmin|default:'0' != '1' && $if_login != 'y'}
	<span class="text">{t}vacation{/t}: {if $if_autoresponder == 'y'}{t}active{/t}{else}{t}not active{/t}{/if}</span>  | 
	{if $if_forwarding == 1}
	<span class="text">{t}forwarding{/t}: {if $if_weiterleitung == 'y'}{t}active{/t}{else}{t}not active{/t}{/if}</span> |{/if}
	{/if}
{if $if_superadmin|default:'0' == '1' && $if_manager|default:'0' == '1'}
<span class="text"> {t}permissions: superadmin manager{/t}</span> |
{elseif $if_superadmin|default:'0' == '1' && $if_manager|default:'0' != '1'} 
<span class="text"> {t}permissions: superadmin{/t}</span> |{/if}
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
