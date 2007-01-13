{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

<form action="forward_catchall.php?id={$id}" method="post">
{if $if_edit eq 'y' }
<input type="hidden" name="eid" value="{$eid}"/>
{/if}
<table>
<tr>
 <td>Domain: </td>
 <td>@{$dnsname}</td>
</tr>
<tr>
 <td>Weiterleiten:</td>
 <td><input name="eto" value="{$eto}" class="in_1" /></td>
</tr>
<tr>
 <td colspan="2" style="text-align:center;">
 <input type="submit" name="add" value="Speichern" class="in_1" /></td>
</tr> 
</table>
</form>
{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}