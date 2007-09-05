{if $if_superadmin == 1 or $if_admin == '1' and $access_domain eq 'true'}

{if $if_del_ok != "y" }
<table>
<tr>
 <td>Liste:</td>
 <td style="text-align:right;">{$address}</td>
</tr>
<tr>
 <td valign="top">Empf&auml;nger:</td>
 <td style="text-align:right;">
 {foreach item=row from=$recps}
 {$row}<br/>
 {foreachelse}
 Keine Empf&auml;nger
 {/foreach}
 </td>
</tr>
<tr>
 <td colspan="2" style="color:red;">Soll diese Mailingliste gel&ouml;scht werden?</td>
</tr>
<tr>
 <td colspan="2"><form action="?module=list_del&#038;did={$did}&#38;id={$id}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" name="submit" value="L&ouml;schen" />
</form></td>
</tr>
</table>

<br/>
{else}
<div style="color:blue;">Mailingliste wurde gel&ouml;scht!<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{/if}
<br/>

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}
