{if $if_superadmin == '1' or $if_admin == '1' and $access_domain }

<form action="?module=forward_view&#038;id={$id}&#038;did={$domainid}" method="post">
<table>
<tr>
 <td>{t}forward{/t}: </td>
 <td>{$forward}</td>
</tr>
<tr>
 <td valign="top">{t}to{/t}:</td>
 <td>
 <select style="min-width:250px;" name="etos[]" size="8" multiple="true" >
 {section name=row loop=$forwards}
 <option value="{$forwards[row].etosingle}">{$forwards[row].etosingle}</option>
 {/section}
 </select>
 </td>
</tr>
<tr>
 <td colspan="2" class="domain_view"><h3>{t}delete selected addresses{/t}:</h3></td>
</tr>
<tr>
 <td colspan="2"  style="text-align:right"><input name="del_addr" value="{t}delete{/t}" type="submit" /></td>
</tr>
</form>
<tr>
 <td colspan="2" class="domain_view"><h3>{t}add new address{/t}:</h3></td>
</tr>
<tr>
 <td valign="top">{t}emailaddress{/t}:</td>
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
{if $if_check_polw == 1 && $config.recipient_classes_polw == 1 or $if_check_grey == 1 && $config.recipient_classes_grey == 1}

{if $if_check_polw == 1 && $config.recipient_classes_polw == 1}
<form action="?module=forward_view&#038;id={$id}&#038;did={$did}" method="post">
<tr>
	<td colspan="2" class="domain_view"><h3>{t 1=$forward}options of %1{/t}</h3></td>
</tr>
<tr>
 <td>{t}policyd-weight available{/t}:</td>
 <td><select name="check_polw" >
     <option value="enable">{t}yes{/t}</option>
     {if $if_check_polw_value == 0 }
     <option value="disable" selected="selected" >{t}no{/t}</option>
     {else}
     <option value="disable" >{t}no{/t}</option>
     {/if}
     </select></td>
</tr>
{/if}
{if $if_check_grey == 1 && $config.recipient_classes_grey }
<tr>
 <td>{t}greylisting available{/t}:</td>
 <td ><select name="check_grey">
     <option value="enable">{t}yes{/t}</option>
     {if $if_check_grey_value == 0 }
     <option value="disable" selected="selected" >{t}no{/t}</option>
     {else}
     <option value="disable" >{t}no{/t}</option>
     {/if}
     </select></td>
</tr>
{/if}
<tr>
	<td></td>
	<td><input type="submit" name="forwarding_options" value="{t}save{/t}"/></td>
</tr>
</form>

{/if}




</table>

{else}
<meta http-equiv="refresh" content="1; URL=index.php">
{/if}
