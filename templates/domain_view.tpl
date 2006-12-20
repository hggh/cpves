

{if $if_superadmin eq 'y' or $if_admin eq 'y' and $access_domain eq 'true' }



<br/>
{if $if_postmaster eq 'y' }
<div style="text-align:center;color:red;">Postmaster Weiterleitung kann nicht deaktiviert werden!</div>
<br/>
{/if}
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
 <td style="width:580px;" colspan="3" ><h3>eMailadressen</h3></td>
 <td style="width:090px;vertical-align:bottom;font-size:9px;" >[<a id="mailsl" href="javascript:fade('mails');">Ausblenden</a>]</td>
</tr>
</table>
<table id="mailst" border="0">
{foreach from=$table_email item=row }
<tr style="background-color:{cycle values=#rcolor#}">
 <td style="width:300px;">{if $row.autoresponder eq "1"}<img src="img/icons/autoresponder.png"   title="Autoresponder aktiv." />{/if}
 <a href="email_view.php?id={$row.id}&amp;did={$row.domain}">{$row.email}</a></td>
 <td style="width:300px;">&#160;</td>
 <td style="text-align:right;vertical-align:middle;">
 {if $row.access eq 'y' }
 <a href="domain_view.php?id={$row.domain}&#038;type=email&#038;state=disable&#038;eid={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;" title="eMailadresse deaktivieren."/></a>
 {else}
 <a  href="domain_view.php?id={$row.domain}&#038;type=email&#038;state=enable&#038;eid={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;" title="eMailadresse aktivieren."/></a>
 {/if}</td>
  <td style="text-align:right;vertical-align:middle;">
  <a href="email_del.php?domainid={$row.domain}&#038;id={$row.id}"><img src="img/icons/delete.png" style="border:0px;" title="eMailadresse l&ouml;schen" />
  </a>
</td>
</tr>
{/foreach}
{if $if_no_email eq 'y'}
<tr>
 <td colspan="4">Keine eMailadresse unter dieser Domain vorhanden!</td>
</tr>
{/if}
</table>

<table border="0" class="domain_view">
<tr>
 <td style="width:580px;" colspan="3"><h3>Weiterleitungen</h3></td>
 <td style="width:090px;vertical-align:bottom;font-size:9px;">[<a id="forwardl" href="javascript:fade('forward');">Ausblenden</a>]</td>
</tr>
</table>
<table id="forwardt" border="0">
{foreach from=$table_forward item=row}
<tr style="background-color:{cycle values=#rcolor#}">
 <td style="width:300px;"><a href="forward_view.php?id={$row.id}&amp;did={$row.domain}">{$row.from}</a></td>
 <td style="width:300px;">{if $row.if_multif eq 'y' }<img src="img/icons/multi_fwd.png"  style="border:0px;" title="Weiterleitung an mehrere Adressen." /> {/if }{$row.to}</td>
 <td style="text-align:right;vertical-align:middle;">
 {if $row.access eq 'y'}
  <a href="domain_view.php?id={$row.domain}&#038;type=forward&#038;state=disable&#038;eid={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;" title="Weiterleitung deaktivieren."/></a>
 
 {else}
 <a href="domain_view.php?id={$row.domain}&#038;type=forward&#038;state=enable&#038;eid={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;" title="Weiterleitung aktivieren."/></a>
 {/if}</td>
  <td style="text-align:right;vertical-align:middle;">
  <a href="forward_del.php?domainid={$row.domain}&#38;id={$row.id}" ><img src="img/icons/delete.png" style="border:0px;" title="Weiterleitung l&ouml;schen"/></a>
  </td>
</tr>
{/foreach}
</table>

{if $if_listings == 'y' }
<table border="0" class="domain_view">
<tr>
 <td style="width:580px;" colspan="3"><h3>Mailinglisten</h3></td>
 <td style="width:090px;vertical-align:bottom;font-size:9px;">[<a id="listsl" href="javascript:fade('lists');">Ausblenden</a>]</td>
</tr>
</table>
<table id="listst" border="0">
{foreach from=$table_list item=row}
<tr style="background-color:{cycle values=#rcolor#}">
 <td style="width:300px;"><a href="list_view.php?id={$row.id}&amp;did={$row.domain}">{$row.address}</a></td>
 <td style="width:300px;">&#160;</td>
 <td style="text-align:right;vertical-align:middle;">
 {if $row.active eq 'y' }
 <a href="domain_view.php?id={$row.domain}&#038;type=list&#038;state=disable&#038;eid={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;" title="Mailingliste deaktivieren."/></a>
 {else}
 <a  href="domain_view.php?id={$row.domain}&#038;type=list&#038;state=enable&#038;eid={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;" title="Mailingliste aktivieren."/></a>
 {/if}</td>
 <td style="text-align:right;vertical-align:middle;">
  <a href="list_del.php?domainid={$row.domain}&#38;id={$row.id}" ><img src="img/icons/delete.png" style="border:0px;" title="Mailingliste l&ouml;schen"/></a>
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
  <td colspan="4"  style="width:670px;">Kein CatchAll f&uuml;r {$dnsname} konfiguiert.<br/><a href="forward_catchall.php?id={$id}&#038;new=yes">Hier klicken um einen Einzurichten.</a></td>
  {else}
  <td style="width:670px;"><a href="forward_catchall.php?id={$id}">@{$dnsname}</a></td>
  <td>{$catchall_to}</td>
  <td style="text-align:right;vertical-align:middle;">
  
  {if $catchall_access eq 'y'}
  <a href="domain_view.php?id={$id}&#038;state=disable&#038;type=forward&#038;eid={$catchall_id}"><img src="img/icons/button_ok.png" title="CatchAll Eintrag deaktivieren." style="border:0px;" /></a>  
  
  {else}
  <a href="domain_view.php?id={$id}&#038;state=enable&#038;type=forward&#038;eid={$catchall_id}"><img src="img/icons/button_cancel.png" title="CatchAll Eintrag aktivieren." style="border:0px;" /></a>
  {/if}</form></td>
  <td style="text-align:right;vertical-align:middle;">
  <a href="domain_view.php?id={$id}&#038;type=catchall&#038;state=delete&#038;eid={$catchall_id}" title="Catchall Eintrag l&ouml;schen."><img src="img/icons/delete.png" style="border:0px;" /></a>
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
 {if $if_imap eq '1' }
 <a href="domain_view.php?id={$id}&#038;fstate=enableimap">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="IMAP aktivieren." /></a>
 {else}
 <a href="domain_view.php?id={$id}&#038;fstate=disableimap">
 <img src="img/icons/button_ok.png" style="border:0px;" title="IMAP deaktivieren." /></a>
 {/if}</td>
</tr>
<tr>
 <td>POP3:</td>
 <td></td>
 <td style="text-align:right;">
 {if $if_pop3 eq '1' }
  <a href="domain_view.php?id={$id}&#038;fstate=enablepop3">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="POP3 aktivieren." /></a>
 {else}
  <a href="domain_view.php?id={$id}&#038;fstate=disablepop3">
 <img src="img/icons/button_ok.png" style="border:0px;" title="POP3 deaktivieren." /></a>
 {/if}</td>
</tr>
<tr>
 <td>WebMail:</td>
 <td></td>
 <td style="text-align:right;">
 {if $if_webmail eq '1' }
   <a href="domain_view.php?id={$id}&#038;fstate=enablewebmail">
 <img src="img/icons/button_cancel.png" style="border:0px;" title="Webmail aktivieren." /></a>
 {else}
   <a href="domain_view.php?id={$id}&#038;fstate=disablewebmail">
 <img src="img/icons/button_ok.png" style="border:0px;" title="Webmail deaktivieren." /></a>
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
 <td>eMailadressen</td>
 {if $if_superadmin != 'y' }
 <td></td>
 {/if}
 <td style="text-align:right;"  colspan="2">{$emails}/{if $max_emails eq "0" }unbegrenzt{else}{$max_emails}{/if}</td>
{if $if_superadmin eq 'y' }
 <td style="text-align:right;"><form action="domain_view.php?id={$id}" method="post"><input type="text" title="0 = Unbegrenzt" name="max_emails" class="in_1" style="width:40px;" /></form></td>
{else}
 <td></td>
{/if} 
</tr>
<tr>
 <td>Weiterleitungen</td>
 {if $if_superadmin != 'y' }
 <td></td>
 {/if}
 <td style="text-align:right;"  colspan="2">{$forwardings}/{if $max_fwd eq "0"}unbegrenzt{else}{$max_fwd}{/if}</td>
{if $if_superadmin eq 'y' }
 <td style="text-align:right;"><form action="domain_view.php?id={$id}" method="post"><input type="text" title="0 = Unbegrenzt" name="max_forwards" class="in_1" style="width:40px;" /></form></td>
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
 <form action="domain_view.php?id={$id}" method="post">
 <input name="dnote" class="in_1" maxlength="30" value="{$dnote}" type="text"/></form>
 </td>
</tr>
{/if}

</table>

{else}
<meta http-equiv="refresh" content="1; URL=index.php">
{/if}
