{if $if_superadmin == '1' or $if_admin == '1' and $access_domain }

<form action="?module=forward_view&#038;id={$id}&#038;did={$domainid}" method="post">
<table>
<tr>
 <td>{t}forward:{/t} </td>
 <td>{$forward}</td>
</tr>
<tr>
 <td valign="top">{t}to:{/t}</td>
 <td>
 <select style="min-width:250px;" name="etos[]" size="8" multiple="true" >
 {section name=row loop=$forwards}
 <option value="{$forwards[row].etosingle}">{$forwards[row].etosingle}</option>
 {/section}
 </select>
 </td>
</tr>
<tr>
 <td colspan="2" class="domain_view"><h3>{t}delete selected addresses:{/t}</h3></td>
</tr>
<tr>
 <td colspan="2"  style="text-align:right"><input name="del_addr" value="{t}delete{/t}" type="submit" /></td>
</tr>
</form>
<tr>
 <td colspan="2" class="domain_view"><h3>{t}add new address:{/t}</h3></td>
</tr>
<tr>
 <td valign="top">{t}emailaddress:{/t}</td>
 <td style="text-align:right"><form action="?module=forward_view&#038;id={$id}&#038;did={$did}" method="post"><input type="text" name="add_fwd" /><br/><input  type="submit" value="{t}add{/t}" name="submit_fwd" /></form><br/>
 
 {if $if_noemail_found != "y" }
 <form action="?module=forward_view&#038;id={$id}&#038;did={$domainid}" method="post">
 <select name="add_fwd">
 {section name=row loop=$table_addemail}
 <option value="{$table_addemail[row].email}">{$table_addemail[row].email}</option>
 {/section}</select><input type="submit" value="{t}add{/t}" name="submit_fwd" />
 </form> 
 {/if}
 </td>
</tr>
</table>

{else}
<meta http-equiv="refresh" content="1; URL=index.php">
{/if}
