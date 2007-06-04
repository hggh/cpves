{if $if_superadmin eq 'y' or $if_admin eq 'y' and $access_domain eq 'true' }
{literal}
<script type="text/javascript">
 function fade(name) {
  if( document.getElementById(name + 't').style.display == "none" ) {
   document.getElementById(name + 't').style.display = "block";
   document.getElementById(name + 'l').innerHTML = "Ausblenden";
  } else {
   document.getElementById(name + 't').style.display = "none";
   document.getElementById(name + 'l').innerHTML = "Einblenden";
  }
 }
</script>
{/literal}
<table border="0" class="domain_view">
<tr>
 <td style="width:580px;" colspan="3" ><h3>E-Mailadressen</h3></td>
 <td style="width:090px;vertical-align:bottom;font-size:9px;" >[<a id="mailsl" href="javascript:fade('mails');">{$labels.hide}</a>]</td>
</tr>
</table>
<table id="mailst" border="0">
{foreach from=$table_email item=row }
<tr bgcolor="{cycle values="$color1,$color2"}">
 <td style="width:300px;">{if $row.autoresponder eq "1"}<img src="img/icons/autoresponder.png"   title="Autoresponder aktiv." />{/if}
 <a href="?module=email_view&#038;id={$row.id}&amp;did={$did}">{$row.email}</a></td>
 <td style="width:300px;"> </td>
 <td style="text-align:right;vertical-align:middle;">
 {if $row.access eq 'y' }
 <a href="?module=domain_view&#038;did={$did}&#038;type=email&#038;state=disable&#038;eid={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;" title="E-Mailadresse deaktivieren."/></a>
 {else}
 <a  href="?module=domain_view&#038;did={$did}&#038;type=email&#038;state=enable&#038;eid={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;" title="E-Mailadresse aktivieren."/></a>
 {/if}</td>
  <td style="text-align:right;vertical-align:middle;">
  <a href="?module=email_del&#038;did={$row.did}&#038;id={$row.id}"><img src="img/icons/delete.png" style="border:0px;" title="eMailadresse l&ouml;schen" />
  </a>
</td>
</tr>
{foreachelse}
<tr>
 <td colspan="4">Keine E-Mailadressen vorhanden!</td>
</tr>
{/foreach}

</table>

<table border="0" class="domain_view">
<tr>
 <td style="width:580px;" colspan="3"><h3>Weiterleitungen</h3></td>
 <td style="width:090px;vertical-align:bottom;font-size:9px;">[<a id="forwardl" href="javascript:fade('forward');">{$labels.hide}</a>]</td>
</tr>
</table>
<table id="forwardt" border="0">
{foreach from=$table_forward item=row}
<tr bgcolor="{cycle values="$color1,$color2"}">
 <td style="width:300px;"><a href="?module=forward_view&#038;id={$row.id}&amp;did={$did}">{$row.from}</a></td>
 <td style="width:300px;">{if $row.if_multif eq 'y' }<img src="img/icons/multi_fwd.png"  style="border:0px;" title="Weiterleitung an mehrere Adressen." /> {/if }{$row.to}</td>
 <td style="text-align:right;vertical-align:middle;">
 {if $row.access eq 'y'}
  <a href="?module=domain_view&#038;did={$did}&#038;type=forward&#038;state=disable&#038;eid={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;" title="Weiterleitung deaktivieren."/></a>
 
 {else}
 <a href="?module=domain_view&#038;did={$did}&#038;type=forward&#038;state=enable&#038;eid={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;" title="Weiterleitung aktivieren."/></a>
 {/if}</td>
  <td style="text-align:right;vertical-align:middle;">
  <a href="?module=forward_del&#038;did={$did}&#38;id={$row.id}" ><img src="img/icons/delete.png" style="border:0px;" title="Weiterleitung l&ouml;schen"/></a>
  </td>
</tr>
{/foreach}
</table>

{if $if_listings == 'y' }
<table border="0" class="domain_view">
<tr>
 <td style="width:580px;" colspan="3"><h3>Mailinglisten</h3></td>
 <td style="width:090px;vertical-align:bottom;font-size:9px;">[<a id="listsl" href="javascript:fade('lists');">{$labels.hide}</a>]</td>
</tr>
</table>
<table id="listst" border="0">
{foreach from=$table_list item=row}
<tr bgcolor="{cycle values="$color1,$color2"}">
 <td style="width:300px;"><a href="?module=list_view&#038;id={$row.id}&amp;did={$did}">{$row.address}</a></td>
 <td style="width:200px;">Empf&auml;nger: {$row.recps}</td>
 <td style="width:100px;">{if $row.public eq 'y'}&Ouml;ffentlich{else}Privat{/if}</td>
 <td style="text-align:right;vertical-align:middle;">
 {if $row.access eq 'y' }
 <a href="?module=domain_view&#038;did={$did}&#038;type=list&#038;state=disable&#038;eid={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;" title="Mailingliste deaktivieren."/></a>
 {else}
 <a  href="?module=domain_view&#038;did={$did}&#038;type=list&#038;state=enable&#038;eid={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;" title="Mailingliste aktivieren."/></a>
 {/if}</td>
 <td style="text-align:right;vertical-align:middle;">
  <a href="?module=list_del&#038;did={$did}&#38;id={$row.id}" ><img src="img/icons/delete.png" style="border:0px;" title="Mailingliste l&ouml;schen"/></a>
 </td>
</tr> 
{foreachelse}
<tr>
 <td colspan="4">Keine Mailingliste unter dieser Domain vorhanden!</td>
</tr>
{/foreach}
</table>
{/if}

<table border="0" class="domain_view">
<tr>
 <td style="width:670px;" colspan="4"><h3>Catchall</h3></td>
</tr>
</table>
<table id="catcht" border="0">
<tr>
  {if $if_catchall eq 'n' }
  <td colspan="4"  style="width:670px;">Kein CatchAll f&uuml;r {$dnsname} konfiguiert.<br/><a href="?module=forward_catchall&#038;did={$did}&#038;new=yes">Hier klicken um einen Einzurichten.</a></td>
  {else}
  <td style="width:300px;"><a href="?module=forward_catchall&#038;did={$did}">@{$dnsname}</a></td>
  <td style="width:300px;">{$catchall_to}</td>
  <td style="text-align:right;vertical-align:middle;">
  
  {if $catchall_access eq 'y'}
  <a href="?module=domain_view&#038;did={$did}&#038;state=disable&#038;type=forward&#038;eid={$catchall_id}"><img src="img/icons/button_ok.png" title="CatchAll Eintrag deaktivieren." style="border:0px;" /></a>  
  
  {else}
  <a href="?module=domain_view&#038;did={$did}&#038;state=enable&#038;type=forward&#038;eid={$catchall_id}"><img src="img/icons/button_cancel.png" title="CatchAll Eintrag aktivieren." style="border:0px;" /></a>
  {/if}</form></td>
  <td style="text-align:right;vertical-align:middle;">
  <a href="?module=domain_view&#038;did={$did}&#038;type=catchall&#038;state=delete&#038;eid={$catchall_id}" title="Catchall Eintrag l&ouml;schen."><img src="img/icons/delete.png" style="border:0px;" /></a>
 </td>
  {/if}
</tr>

{if $if_superadmin eq 'y' }
<tr>
 <td colspan="4" class="domain_view"><h3>Eigenschaften von {$dnsname}</h3></td>
</tr>
<tr>
 <td>IMAP:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_imap == 0  }
 <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=imap">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="IMAP aktivieren." /></a>
 {else}
 <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=imap">
 <img src="img/icons/button_ok.png" style="border:0px;" title="IMAP deaktivieren." /></a>
 {/if}</td>
</tr>
<tr>
 <td>POP3:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_pop3 == 0 }
  <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=pop3">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="POP3 aktivieren." /></a>
 {else}
  <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=pop3">
 <img src="img/icons/button_ok.png" style="border:0px;" title="POP3 deaktivieren." /></a>
 {/if}</td>
</tr>
<tr>
 <td>WebMail:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_webmail ==  0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=webmail">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="Webmail aktivieren." /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=webmail">
 <img src="img/icons/button_ok.png" style="border:0px;" title="Webmail deaktivieren." /></a>
 {/if}</td>
</tr>
<tr>
 <td>Spamassassin:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_spamassassin == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=spamassassin">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="Spamassassin aktivieren." /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=spamassassin">
 <img src="img/icons/button_ok.png" style="border:0px;" title="Spamassassin deaktivieren." /></a>
 {/if}</td> 
</tr>

<tr>
 <td>Spam l&ouml;schbar:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_spam_del == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=spam_del">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="Spam löschen aktivieren." /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=spam_del">
 <img src="img/icons/button_ok.png" style="border:0px;" title="Spam löschen deaktivieren." /></a>
 {/if}</td> 
</tr>

<tr>
 <td>Bogofilter:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_bogofilter == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=bogofilter">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="Bogofilter aktivieren." /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=bogofilter">
 <img src="img/icons/button_ok.png" style="border:0px;" title="Bogofilter deaktivieren." /></a>
 {/if}</td> 
</tr>

<tr>
 <td>Mailarchiv:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_mailarchive == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=mailarchive">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="Mailarchiv aktivieren." /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=mailarchive">
 <img src="img/icons/button_ok.png" style="border:0px;" title="Mailarchiv deaktivieren." /></a>
 {/if}</td> 
</tr>
<tr>
 <td>Spamfilter Whitelisting:</td>
 <td></td>
 <td style="text-align:right;">
 {if $p_sa_wb_listing == 0 }
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=1&#038;f=sa_wb_listing">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="Spamfilter Whitelisting aktivieren." /></a>
 {else}
   <a href="?module=domain_view&#038;did={$did}&#038;fstate=0&#038;f=sa_wb_listing">
 <img src="img/icons/button_ok.png" style="border:0px;" title="Spamfilter Whitelisting deaktivieren." /></a>
 {/if}</td> 
</tr>


{/if}
{if $if_superadmin eq 'y' or $if_admin eq 'y' }

<tr>
 <td class="domain_view" colspan="4"><h3 style="margin-bottom:0px;">Adressenanzahl</h3>
 <span style="float:right;">
Verbraucht/M&ouml;glich
 {if $if_superadmin eq 'y' }
 &Auml;ndern
 {/if}</span></td>
</tr>
<tr>
 <td>E-Mailadressen:</td>
 {if $if_superadmin != 'y' }
 <td></td>
 {/if}
 <td style="text-align:right;"  colspan="2">{$emails}/{if $max_emails eq "0" }unbegrenzt{else}{$max_emails}{/if}</td>
{if $if_superadmin eq 'y' }
 <td style="text-align:right;"><form action="?module=domain_view&#038;did={$did}" method="post"><input type="text" title="0 = Unbegrenzt" name="max_emails" style="width:40px;" /></form></td>
{else}
 <td></td>
{/if} 
</tr>
<tr>
 <td>Weiterleitungen:</td>
 {if $if_superadmin != 'y' }
 <td></td>
 {/if}
 <td style="text-align:right;"  colspan="2">{$forwardings}/{if $max_fwd eq "0"}unbegrenzt{else}{$max_fwd}{/if}</td>
{if $if_superadmin eq 'y' }
 <td style="text-align:right;"><form action="?module=domain_view&#038;did={$did}" method="post"><input type="text" title="0 = Unbegrenzt" name="max_forwards" style="width:40px;" /></form></td>
{else}
 <td></td>
{/if} 
</tr>
{/if}

 {if $if_superadmin == 'y' }
<tr>
<td colspan="4" class="domain_view"><h3>Notiz zu {$dnsname}</h3></td>
</tr>
<tr>
 <td colspan="4">
 <form action="?module=domain_view&#038;did={$did}" method="post">
 <input name="dnote" maxlength="30" value="{$dnote}" type="text"/></form>
 </td>
</tr>
{/if}

{if ($if_spamassassin == 1 || ( $if_superadmin == 'y' && $p_spamassassin == 1)) && $p_sa_wb_listing == 1 }
<tr>
	<td colspan="4" class="domain_view"><h3>Spamfilter - Whitelist</h3></td>
</tr>
<tr>
	<td valign="top">Whitelist:</td>
	<td colspan="3"><form action="?module=domain_view&#038;did={$did}" method="post">
	<select style="min-width:250px;" name="sa_whitelist_data[]" size="10" multiple="true">
	{foreach from=$table_sa_whitelist item=row}
	<option value="{$row.id}">{$row.sa_from}</option>
	{/foreach}
	</select><br/>
	<input type="submit" name="sa_whitelist_data_del" value="Markierte L&ouml;schen"/>
	</form></td>
</tr>
<tr>
	<td colspan="4" style="height:10px;"></td>
</tr>
<tr>
	<td>{$labels.add}:</td>
	<td colspan="3"><form action="?module=domain_view&#038;did={$did}" method="post">
	<input type="text" size="30" name="sa_whitelist_data_add"/><br/>
	<input type="submit" name="sa_whitelist_data_add_submit" value="Speichern"/></form></td>
</tr>
{/if}

</table>

{else}
<meta http-equiv="refresh" content="1; URL=index.php">
{/if}
