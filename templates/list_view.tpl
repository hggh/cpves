{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

{if $email_added eq 'y'}
{else}
 {if $email_there eq 'y'}
<div style="text-align:center;color:blue;">Adresse ist schon eingetragen!</div>
 {/if}
{/if}
<form action="list_view.php?id={$id}&#038;did={$domainid}" method="post">
<table>
<tr>
 <td>Liste: </td>
 <td>{$address}</td>
</tr>
<tr>
 <td valign="top">Empf&auml;nger: </td>
 <td>
 <select name="addresses[]" size="8" multiple="true"  class="in_1">
 {foreach item=row from=$recps}
 <option value="{$row}">{$row}</option>
 {/foreach}
 </select>
 </td>
</tr>
<tr>
 <td colspan="2" class="domain_view"><h3>Selektierte Adresse l&ouml;schen:</h3></td>
</tr>
<tr>
 <td colspan="2"  style="text-align:right"><input name="del_addr" class="in_1" value="L&ouml;schen" type="submit" /></td>
</tr>
</form>
<tr>
 <td colspan="2" class="domain_view"><h3>Adresse hinzuf&uuml;gen:</h3></td>
</tr>
<tr>
 <td valign="top">eMailadresse:</td>
 <td style="text-align:right"><form action="list_view.php?id={$id}&#038;did={$domainid}" method="post"><input class="in_1" type="text" name="add_address" /><br/><input  type="submit" value="Hinzuf&uuml;gen" name="submit_add" /></form><br/>
 </td>
</tr>
</table>
<div>Die Liste ist {if $public eq 'y'}&ouml;ffentlich{else}privat{/if} - [<a href="./list_view.php?id={$id}&#038;did={$domainid}&#038;cmd={if $public eq 'y'}priv{else}pub{/if}">&Auml;ndern</a>]</div>


{else}
<meta http-equiv="refresh" content="1; URL=index.php">
{/if}
