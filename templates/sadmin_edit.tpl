

{if $if_superadmin eq 'y' and $if_manager eq 'y' }
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
{if $if_changed eq 'y' }
<div style="text-align:center;color:blue;">
&Auml;nderung erfolgreicht gespeichert.<br/>
Sie werden in kuerze Weitergeleitet...
<meta http-equiv="refresh" content="1; URL=?module=sadmin_view">
</div>
<br/>
{/if}

<form accept-charset="?module=sadmin&#038;id={$id}" method="post">
<table>
<tr>
 <td>Benutzername: </td>
 <td>{$username}</td>
</tr>
<tr>
 <td>Name: </td>
 <td><input name="full_name" value="{$full_name}" type="text"/></td>
</tr>
<tr>
 <td>Passwort:</td>
 <td><input name="passwd" value="" type="password" maxlength="{$max_passwd_len}" /></td>
</tr>

<tr>
 <td>Zugriff:</td>
 <td><select name="access">
     <option value="enable">Ja</option>
     {if $access eq 'n'}
     <option value="disable" selected="selected">Nein</option>
     {else}
     <option value="disable">Nein</option>
     {/if}
     </select></td>
     
</tr>
<tr>
 <td>Manager:</td>
 <td><select name="manager">
     <option value="enable">Ja</option>
     {if $manager eq 'n'}
     <option value="disable" selected="selected">Nein</option>
     {else}
     <option value="disable">Nein</option>
     {/if}
     </select></td>
     
</tr>

<tr>
 <td colspan="2" style="text-align:center;"><input type="submit" name="submit" value="Speichern" /></td>
</tr>
</table>
</form>
{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}


