{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

{if $if_max_list eq 'y'}
<div style="text-align:center;color:red;">Maximale Anzahl an Mailinglisten erreicht, es k&ouml;nnen keine weiteren MAilinglisten angelegt werden!<br/> - Bitte wenden sie sich an Ihren Administrator! -<br/><br/></div>
{/if}
{if $if_email_saved eq "y" }
<div style="text-align:center;color:blue;">Mailingliste angelegt!<br/><br/></div>

{/if}

<form action="list_add.php?id={$id}" method="post">
<table>
<tr>
 <td>Mailingliste:</td>
 <td style="width:10px;"></td>
 <td><input type="text" class="in_1" name="address" value="{$address}"/>@{$domain}</td>
</tr>
<tr>
 <td>Status:</td>
 <td style="width:10px;"></td>
 <td><input type="radio" class="in_1" name="public" value="y"/>&Ouml;ffentlich<input type="radio" class="in_1" name="public" value="n"/>Privat</td>
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