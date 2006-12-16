

{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

{if $if_max_fwd eq 'y'}
<div style="text-align:center;color:red;">Maximale Anzahl an Weiterleitungen erreicht, es k&ouml;nnen keine weiteren Weiterleitungen angelegt werden!<br/> - Bitte wenden sie sich an Ihren Administrator! -<br/><br/></div>
{/if}
{if $if_valid eq 'n'}
<div style="text-align:center;color:red;">eMailadresse ist nicht konform. Bitte korigieren!<br/><br/></div>
{/if}
{if $if_exists eq 'y' }
<div style="text-align:center;color:red;">eMailadresse ist bereits vorhanden! Bitte korigieren!<br/><br/></div>
{/if}
{if $if_missing eq 'y' }
<div style="text-align:center;color:red;">Fehlerhafte eingabe! Bitte korigieren!<br/><br/></div>
{/if}
{if $if_email_saved eq "y" }
<div style="text-align:center;color:blue;">Forward angelegt!<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$id}">
{/if}

<form action="forward_add.php?id={$id}" method="post">
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