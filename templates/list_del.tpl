

{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

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
 <td colspan="2"><form action="list_del.php?domainid={$domainid}&#38;id={$id}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" class="in_1" name="submit" value="L&ouml;schen" />
</form></td>
</tr>
</table>

<br/>
{else}
<div style="color:blue;">Mailingliste wurde gel&ouml;scht!<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$domainid}">
{/if}
<br/>

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}


