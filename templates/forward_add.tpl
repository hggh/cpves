{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

<form action="?module=forward_add&#038;did={$did}" method="post">
<table>
<tr>
 <td>eMailadresse:</td>
 <td style="width:10px;"></td>
 <td><input type="text" class="in_1" name="from" value="{$from}"/>@{$domain}</td>
</tr>

<tr>
 <td>Leiten nach:</td>
 <td style="width:10px;"></td>
 <td><input type="text" class="in_1" name="to" value="{$to}"/></td>
</tr>
<tr>
<td></td>
<td style="width:10px;"></td>
<td><input type="submit" name="submit" value="Anlegen" /></td>
</tr>
</table>
</form>
{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}