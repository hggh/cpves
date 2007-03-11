{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

{if $if_del eq 'y'}
<div style="text-align:center;color:red;">
Es wurden alle Adressen der Weiterleitung zum L&ouml;schen markiert.<br/>Dieser Vorgang l&ouml;scht nun den kompletten Eintrag!<br/>
 <form action="?module=forward_del&#038;id={$id}&#038;did={$domainid}" method="post">
  <input type="submit" name="del_fwd" class="in_1" value="Loeschen"/>
  <input type="hidden" name="id" value="{$id}" />
  <input type="hidden" name="domainid" value="{$domainid}" />
  </form>
</div>
{/if}


<form action="?module=forward_view&#038;id={$id}&#038;did={$domainid}" method="post">
<table>
<tr>
 <td>Von: </td>
 <td>{$forward}</td>
</tr>
<tr>
 <td valign="top">An: </td>
 <td>
 <select name="etos[]" size="8" multiple="true"  class="in_1">
 {section name=row loop=$forwards}
 <option value="{$forwards[row].etosingle}">{$forwards[row].etosingle}</option>
 {/section}
 </select>
 </td>
</tr>
<tr>
 <td colspan="2" class="domain_view"><h3>Selektierte Adresse l&ouml;schen:</h3></td>
</tr>
<tr>
 <td colspan="2"  style="text-align:right"><input name="del_addr" value="L&ouml;schen" type="submit" /></td>
</tr>
</form>
<tr>
 <td colspan="2" class="domain_view"><h3>Adresse hinzuf&uuml;gen:</h3></td>
</tr>
<tr>
 <td valign="top">eMailadresse:</td>
 <td style="text-align:right"><form action="?module=forward_view&#038;id={$id}&#038;did={$did}" method="post"><input class="in_1" type="text" name="add_fwd" /><br/><input  type="submit" value="Hinzuf&uuml;gen" name="submit_fwd" /></form><br/>
 
 {if $if_noemail_found != "y" }
 <form action="?module=forward_view&#038;id={$id}&#038;did={$domainid}" method="post">
 <select name="add_fwd">
 {section name=row loop=$table_addemail}
 <option value="{$table_addemail[row].email}">{$table_addemail[row].email}</option>
 {/section}</select><input class="in_1" type="submit" value="Hinzuf&uuml;gen" name="submit_fwd" />
 </form> 
 {/if}
 
 
 </td>
</tr>
</table>



{else}
<meta http-equiv="refresh" content="1; URL=index.php">
{/if}
