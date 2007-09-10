{if $if_superadmin == '1' or $if_admin == '1' and $access_domain }

<form action="?module=forward_add&#038;did={$did}" method="post">
<table>
<tr>
 <td>{t}emailaddress{/t}:</td>
 <td style="width:10px;"></td>
 <td><input type="text" name="from" value="{$from}"/>@{$domain}</td>
</tr>

<tr>
 <td valign="top">{t}forward to{/t}:</td>
 <td style="width:10px;"></td>
 <td><textarea cols="40" rows="10" name="to" value="{$to}"></textarea>

 {if $table_email != false }<input type="button" name="add" value="<"  onclick="forwardadd_fillform()" />
 <select name="mail">
 {foreach from=$table_email item=row}
 <option>{$row.mail}</option>
 {/foreach}
 </select>{/if}
 
 </td>
</tr>
<tr>
<td></td>
<td style="width:10px;"></td>
<td><input type="submit" name="submit" value="{t}create new forward{/t}" /> <input type="reset" value="{t}reset form{/t}"</td>
</tr>
</table>
</form>
{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}