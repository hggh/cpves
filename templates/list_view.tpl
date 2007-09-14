{if $if_superadmin == 1 or $if_admin == '1' and $access_domain eq 'true'}

{if $email_added eq 'y'}
{else}

{/if}
<form action="?module=list_view&#038;id={$id}&#038;did={$did}" method="post">
<table style="width: 400px;">
<tr>
 <td>{t}list{/t}: </td>
 <td>{$address}</td>
</tr>
<tr>
 <td valign="top">{t}recipient{/t}: </td>
 <td>
 <select name="addresses[]" size="8" multiple="true" >
 {foreach item=row from=$recps}
 <option value="{$row}">{$row}</option>
 {/foreach}
 </select>
 </td>
</tr>
<tr>
 <td colspan="2" class="domain_view"><h3>{t}delete selected addresses{/t}:</h3></td>
</tr>
<tr>
 <td colspan="2"  style="text-align:right"><input name="del_addr" value="{t}delete{/t}" type="submit" /></td>
</tr>
</table>
</form>
<table style="width: 400px;">
<tr>
 <td colspan="2" class="domain_view"><h3>{t}add address to list{/t}:</h3></td>
</tr>
<tr>
 <td valign="top">{t}emailaddress{/t}:</td>
 <td style="text-align:right"><form action="?module=list_view&#038;id={$id}&#038;did={$did}" method="post"><input type="text" name="add_address" /><br/><input  type="submit" value="{t}add{/t}" name="submit_add" /></form><br/>
 </td>
</tr>
</table>
<div>{t}list is{/t} {if $public eq 'y'}{t}public{/t}{else}{t}private{/t}{/if} - [<a href="?module=list_view&#038;id={$id}&#038;did={$did}&#038;cmd={if $public eq 'y'}priv{else}pub{/if}">{t}change{/t}</a>]</div>


{else}
<meta http-equiv="refresh" content="1; URL=index.php">
{/if}
