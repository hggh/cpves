{if $if_superadmin == 1 or $if_admin == '1' and $access_domain eq 'true'}

{if $if_max_list eq 'y'}
<div style="text-align:center;color:red;">Maximale Anzahl an Mailinglisten erreicht, es k&ouml;nnen keine weiteren MAilinglisten angelegt werden!<br/> - Bitte wenden sie sich an Ihren Administrator! -<br/><br/></div>
{/if}

<form action="?module=list_add&#038;did={$did}" method="post">
<table>
<tr>
 <td>Mailingliste:</td>
 <td style="width:10px;"></td>
 <td><input type="text" name="address" value="{$address}"/>@{$domain}</td>
</tr>
<tr>
 <td>Status:</td>
 <td style="width:10px;"></td>
 <td><input type="radio" name="public" value="y"/>&Ouml;ffentlich<input type="radio" checked="checked" name="public" value="n"/>Privat</td>
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
