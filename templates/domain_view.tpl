{if $if_superadmin == 1 or $if_admin == '1' and $access_domain eq 'true' }


<script type="text/javascript">
 function fade(name) {ldelim}
  if( document.getElementById(name + 't').style.display == "none" ) {ldelim}
   document.getElementById(name + 't').style.display = "block";
   document.getElementById(name + 'l').innerHTML = "{t}hide{/t}";
  {rdelim} else {ldelim}
   document.getElementById(name + 't').style.display = "none";
   document.getElementById(name + 'l').innerHTML = "{t}show{/t}";
  {rdelim}
 {rdelim}
</script>

<table border="0" class="domain_view">
<tr>
 <td style="width:580px;" colspan="3" ><h3>{t}emailaddresses{/t}:</h3></td>
 <td style="width:090px;vertical-align:bottom;font-size:9px;" >[<a id="mailsl" href="javascript:fade('mails');">{t}hide{/t}</a>]</td>
</tr>
</table>
<table id="mailst" border="0">
{foreach from=$table_email item=row }
<tr bgcolor="{cycle values="$color1,$color2"}">
 <td style="width:300px;">{if $row.autoresponder eq "1"}<img src="img/icons/autoresponder.png" title="{t}vacation active!{/t}" />{/if}
 <a href="?module=email_view&#038;id={$row.id}&amp;did={$did}">{$row.email}</a></td>

{if $display_mb_size == 1}
<td style="width:250px;"> </td>
<td style="text-align:left;width:50px;">{$row.mb_size} M</td>
{else}
 <td style="width:300px;"> </td>
{/if}
 <td style="text-align:right;vertical-align:middle;">
 {if $row.access == '1' }
 <a href="?module=domain_view&#038;did={$did}&#038;type=email&#038;state=disable&#038;eid={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate emailaddress{/t}"/></a>
 {else}
 <a  href="?module=domain_view&#038;did={$did}&#038;type=email&#038;state=enable&#038;eid={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate emailaddress{/t}"/></a>
 {/if}</td>
  <td style="text-align:right;vertical-align:middle;">
  <a href="?module=email_del&#038;did={$row.did}&#038;id={$row.id}"><img src="img/icons/delete.png" style="border:0px;" title="{t}delete emailaddress{/t}" />
  </a>
</td>
</tr>
{foreachelse}
<tr>
 <td colspan="4">{t}no emailaddress exists!{/t}</td>
</tr>
{/foreach}

</table>

<table border="0" class="domain_view">
<tr>
 <td style="width:580px;" colspan="3"><h3>{t}forwardings{/t}:</h3></td>
 <td style="width:090px;vertical-align:bottom;font-size:9px;">[<a id="forwardl" href="javascript:fade('forward');">{t}hide{/t}</a>]</td>
</tr>
</table>
<table id="forwardt" border="0">
{foreach from=$table_forward item=row}
<tr bgcolor="{cycle values="$color1,$color2"}">
 <td style="width:300px;"><a href="?module=forward_view&#038;id={$row.id}&amp;did={$did}">{$row.from}</a></td>
 <td style="width:300px;">{if $row.if_multif eq 'y' }<img src="img/icons/multi_fwd.png"  style="border:0px;" title="{t}forwarding to more addresses.{/t}" /> {/if }{$row.to}</td>
 <td style="text-align:right;vertical-align:middle;">
 {if $row.access == '1'}
  <a href="?module=domain_view&#038;did={$did}&#038;type=forward&#038;state=disable&#038;eid={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate forwarding.{/t}"/></a>
 
 {else}
 <a href="?module=domain_view&#038;did={$did}&#038;type=forward&#038;state=enable&#038;eid={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate forwarding.{/t}"/></a>
 {/if}</td>
  <td style="text-align:right;vertical-align:middle;">
  <a href="?module=forward_del&#038;did={$did}&#38;id={$row.id}" ><img src="img/icons/delete.png" style="border:0px;" title="{t}delete forwarding.{/t}"/></a>
  </td>
</tr>
{/foreach}
</table>

{if $config.mailinglists == '1' && $access_domain_mlists == 1 }
<table border="0" class="domain_view">
<tr>
 <td style="width:580px;" colspan="3"><h3>{t}mailinglists{/t}:</h3></td>
 <td style="width:090px;vertical-align:bottom;font-size:9px;">[<a id="listsl" href="javascript:fade('lists');">{t}hide{/t}</a>]</td>
</tr>
</table>
<table id="listst" border="0">
{foreach from=$table_list item=row}
<tr bgcolor="{cycle values="$color1,$color2"}">
 <td style="width:300px;"><a href="?module=list_view&#038;id={$row.id}&amp;did={$did}">{$row.address}</a></td>
 <td style="width:200px;">{t}recipients{/t}: {$row.recps}</td>
 <td style="width:100px;">{if $row.public eq 'y'}{t}public{/t}{else}{t}private{/t}{/if}</td>
 <td style="text-align:right;vertical-align:middle;">
 {if $row.access == '1' }
 <a href="?module=domain_view&#038;did={$did}&#038;type=list&#038;state=disable&#038;eid={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate mailinglist.{/t}"/></a>
 {else}
 <a  href="?module=domain_view&#038;did={$did}&#038;type=list&#038;state=enable&#038;eid={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate mailinglist.{/t}"/></a>
 {/if}</td>
 <td style="text-align:right;vertical-align:middle;">
  <a href="?module=list_del&#038;did={$did}&#38;id={$row.id}" ><img src="img/icons/delete.png" style="border:0px;" title="{t}delete mailinglist.{/t}"/></a>
 </td>
</tr> 
{foreachelse}
<tr>
 <td colspan="4">{t}no mailinglists exists.{/t}</td>
</tr>
{/foreach}
</table>
{/if}

<table border="0" class="domain_view">
<tr>
 <td style="width:670px;" colspan="4"><h3>{t}catchall{/t}:</h3></td>
</tr>
</table>
<table id="catcht" border="0">
<tr>
  {if $if_catchall eq 'n' }
  <td colspan="4"  style="width:670px;">{t 1=$dnsname}no catchall for %1 configured.{/t}<br/><a href="?module=forward_catchall&#038;did={$did}&#038;new=yes">{t}click here to configure an catchall.{/t}</a></td>
  {else}
  <td style="width:300px;"><a href="?module=forward_catchall&#038;did={$did}">@{$dnsname}</a></td>
  <td style="width:300px;">{$catchall_to}</td>
  <td style="text-align:right;vertical-align:middle;">
  
  {if $catchall_access == '1'}
  <a href="?module=domain_view&#038;did={$did}&#038;state=disable&#038;type=forward&#038;eid={$catchall_id}"><img src="img/icons/button_ok.png" title="{t}deactivate catchall entry.{/t}" style="border:0px;" /></a>  
  
  {else}
  <a href="?module=domain_view&#038;did={$did}&#038;state=enable&#038;type=forward&#038;eid={$catchall_id}"><img src="img/icons/button_cancel.png" title="{t}activate catchall entry.{/t}" style="border:0px;" /></a>
  {/if}</form></td>
  <td style="text-align:right;vertical-align:middle;">
  <a href="?module=domain_view&#038;did={$did}&#038;type=catchall&#038;state=delete&#038;eid={$catchall_id}" title="{t}delete catchall entry.{/t}"><img src="img/icons/delete.png" style="border:0px;" /></a>
 </td>
  {/if}
</tr>

{if $if_superadmin == 1 }
<tr>
 <td colspan="4" class="domain_view"><h3>{t 1=$dnsname}properties  of %1{/t}:</h3></td>
</tr>
<tr>
 <td>{t}IMAP{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_imap == 0  }
 <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=imap">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate IMAP.{/t}" /></a>
 {else}
 <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=imap">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate IMAP.{/t}" /></a>
 {/if}</td>
</tr>
<tr>
 <td>{t}POP3{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_pop3 == 0 }
  <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=pop3">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate POP3.{/t}" /></a>
 {else}
  <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=pop3">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate POP3.{/t}" /></a>
 {/if}</td>
</tr>
<tr>
 <td>{t}Webmail{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_webmail ==  0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=webmail">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate webmail.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=webmail">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate webmail.{/t}" /></a>
 {/if}</td>
</tr>
{if $config.mailinglists == '1'}
<tr>
 <td>{t}Mailinglist feature{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_mlists ==  0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=mlists">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate mailinglists.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=mlists">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate mailinglists.{/t}" /></a>
 {/if}</td>
</tr>
{/if}
{if $config.recipient_classes_polw == 1}
<tr>
 <td>{t}Policyd-Weight{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_check_polw ==  0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=check_polw">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate policyd-weight.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=check_polw">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate policyd-weight.{/t}" /></a>
 {/if}</td>
</tr>
{/if}
{if $config.recipient_classes_grey == 1}
<tr>
 <td>{t}Greylisting{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_check_grey ==  0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=check_grey">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate greylisting.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=check_grey">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate greylisting.{/t}" /></a>
 {/if}</td>
</tr>
{/if}
<tr>
 <td>{t}access to CpVES webinterface{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_webinterface == 0  }
 <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=webinterface">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate CpVES webinterface.{/t}" /></a>
 {else}
 <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=webinterface">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate CpVES webinterface.{/t}" /></a>
 {/if}</td>
</tr>
<tr>
 <td>{t}vacation X-Header disable feature{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_autores_xheader == 0  }
 <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=autores_xheader">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate vacation X-Header feature.{/t}" /></a>
 {else}
 <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=autores_xheader">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate vacation X-Header feature.{/t}" /></a>
 {/if}</td>
</tr>
<tr>
 <td>{t}fetchmail{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_fetchmail ==  0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=fetchmail">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate fetchmail{/t}:" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=fetchmail">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate fetchmail.{/t}" /></a>
 {/if}</td>
</tr>
<tr>
 <td>{t}spamassassin{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_spamassassin == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=spamassassin">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate spamassassin.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=spamassassin">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate spamassassin.{/t}" /></a>
 {/if}</td> 
</tr>
<tr>
 <td>{t}ham/spam learning{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_sa_learn == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=sa_learn">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate ham/spam learning.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=sa_learn">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate ham/spam learning.{/t}" /></a>
 {/if}</td> 
</tr>

<tr>
 <td>{t}delete spam{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_spam_del == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=spam_del">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate delete spam.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=spam_del">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate delete spam.{/t}" /></a>
 {/if}</td> 
</tr>

<tr>
 <td>{t}bogofilter{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_bogofilter == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=bogofilter">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate bogofilter.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=bogofilter">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate bogofilter.{/t}" /></a>
 {/if}</td> 
</tr>

<tr>
 <td>{t}archivemail{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_mailarchive == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=mailarchive">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate archivemail.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=mailarchive">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate archivemail.{/t}" /></a>
 {/if}</td> 
</tr>
<tr>
 <td>{t}spamfilter - whitelisting{/t}:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_sa_wb_listing == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=sa_wb_listing">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="{t}activate whitelisting.{/t}" /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=sa_wb_listing">
 <img src="img/icons/button_ok.png" style="border:0px;" title="{t}deactivate whitelisting.{/t}" /></a>
 {/if}</td> 
</tr>


{/if}
{if $if_superadmin == '1' or $if_admin == '1' }

<tr>
 <td class="domain_view" colspan="4"><h3 style="margin-bottom:0px;">{t}number of addresses{/t}:</h3>
 <span style="float:right;">
{t}used/available{/t}
 {if $if_superadmin == '1' }
{t}change{/t}
 {/if}</span></td>
</tr>
<tr>
 <td>{t}emailaddresses{/t}:</td>
 {if $if_superadmin != '1' }
 <td></td>
 {/if}
 <td style="text-align:right;"  colspan="2">{$emails}/{if $max_emails eq "0" }{t}no limit{/t}{else}{$max_emails}{/if}</td>
{if $if_superadmin == '1' }
 <td style="text-align:right;"><form action="?module=domain_view&#038;did={$did}" method="post"><input type="text" title="0 = {t}no limit{/t}" name="max_emails" style="width:40px;" /></form></td>
{else}
 <td></td>
{/if} 
</tr>
<tr>
 <td>{t}forwardings{/t}:</td>
 {if $if_superadmin != '1' }
 <td></td>
 {/if}
 <td style="text-align:right;"  colspan="2">{$forwardings}/{if $max_fwd eq "0"}{t}no limit{/t}{else}{$max_fwd}{/if}</td>
{if $if_superadmin == '1' }
 <td style="text-align:right;"><form action="?module=domain_view&#038;did={$did}" method="post"><input type="text" title="0 = {t}no limit{/t}" name="max_forwards" style="width:40px;" /></form></td>
{else}
 <td></td>
{/if} 
</tr>
{/if}

 {if $if_superadmin == '1' }
<tr>
<td colspan="4" class="domain_view"><h3>{t 1=$dnsname}note %1{/t}</h3></td>
</tr>
<tr>
 <td colspan="4">
 <form action="?module=domain_view&#038;did={$did}" method="post">
 <input name="dnote" maxlength="30" value="{$dnote}" type="text"/></form>
 </td>
</tr>
{/if}

{if ($if_spamassassin == 1 || ( $if_superadmin == '1' && $p_spamassassin == 1)) && $p_sa_wb_listing == 1 }
<tr>
	<td colspan="4" class="domain_view"><h3>{t}spamfilter - whitelisting{/t}:</h3></td>
</tr>
<tr>
	<td valign="top">{t}whitelist{/t}:</td>
	<td colspan="3"><form action="?module=domain_view&#038;did={$did}" method="post">
	<select style="min-width:250px;" name="sa_whitelist_data[]" size="10" multiple="true">
	{foreach from=$table_sa_whitelist item=row}
	<option value="{$row.id}">{$row.sa_from}</option>
	{/foreach}
	</select><br/>
	<input type="submit" name="sa_whitelist_data_del" value="{t}delete selected{/t}"/>
	</form></td>
</tr>
<tr>
	<td colspan="4" style="height:10px;"></td>
</tr>
<tr>
	<td>{t}add to whitelist{/t}:</td>
	<td colspan="3"><form action="?module=domain_view&#038;did={$did}" method="post">
	<input type="text" size="30" name="sa_whitelist_data_add"/><br/>
	<input type="submit" name="sa_whitelist_data_add_submit" value="{t}add{/t}"/></form></td>
</tr>
{/if}

</table>

{else}
<meta http-equiv="refresh" content="1; URL=index.php">
{/if}
