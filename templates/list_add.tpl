{if $if_superadmin == 1 or $if_admin == '1' and $access_domain eq 'true'}
<form action="?module=list_add&#038;did={$did}" method="post">
<table>
<tr>
 <td>{t}mailinglist{/t}:</td>
 <td style="width:10px;"></td>
 <td><input type="text" name="address" value="{$address}"/>@{$domain}</td>
</tr>
<tr>
 <td>{t}state{/t}:</td>
 <td style="width:10px;"></td>
 <td><input type="radio" name="public" value="y"/>{t}public{/t}<input type="radio" checked="checked" name="public" value="n"/>{t}private{/t}</td>
</tr>
<tr>
<td></td>
<td style="width:10px;"></td>
<td><input type="submit" name="submit" value="{t}create{/t}" /></td>
</tr>
</table>
</form>
{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}
