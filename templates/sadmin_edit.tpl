<br/>
{if $if_username_empty eq 'y' }
<div style="text-align:center;color:red;">
Benutzername leer!
</div>
<br/>
{/if}
{if $if_username_wrong eq 'y' }
<div style="text-align:center;color:red;">
Benutzername enthaelt ung&uuml;ltige Zeichen!
Benutzername darf nur Buchstaben und Zahlen enthalten!
Benutzername darf nicht l&auml;nger als 8 Zeichen sein!
</div>
<br/>
{/if}

<form accept-charset="?module=sadmin&#038;id={$id}" method="post">
<table>
<tr>
 <td>{t}username{/t}:</td>
 <td>{$username}</td>
</tr>
<tr>
 <td>{t}full name{/t}:</td>
 <td><input name="full_name" value="{$full_name}" type="text"/></td>
</tr>
<tr>
 <td>{t}password{/t}:</td>
 <td><input name="passwd" value="" type="password" maxlength="{$max_passwd_len}" /></td>
</tr>

<tr>
 <td>{t}access{/t}:</td>
 <td><select name="access">
     <option value="1">{t}yes{/t}</option>
     {if $access eq '0'}
     <option value="0" selected="selected">{t}no{/t}</option>
     {else}
     <option value="0">{t}no{/t}</option>
     {/if}
     </select></td>
     
</tr>
<tr>
 <td>{t}superadmin manager{/t}:</td>
 <td><select name="manager">
     <option value="1">{t}yes{/t}</option>
     {if $manager eq '0'}
     <option value="0" selected="selected">{t}no{/t}</option>
     {else}
     <option value="0">{t}no{/t}</option>
     {/if}
     </select></td>
     
</tr>

<tr>
 <td colspan="2" style="text-align:right;"><input type="submit" name="submit" value="{t}save{/t}" /></td>
</tr>
</table>
</form>