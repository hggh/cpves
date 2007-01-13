{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }
<form action="email_add.php?id={$id}" method="post">
<table>
<tr>
 <td style="width:190px;">eMailadresse:</td>
 <td style="width:300px;"><input type="text" class="in_1" name="emailaddr" value="{$eMail}"/>@{$domain}</td>
</tr>
<tr>
 <td>Voller Name:</td>
 <td><input type="text" class="in_1" name="full_name" value="{$full_name}"/></td>
</tr>
<tr>
 <td>Passwort:</td>
 <td><input type="password" class="in_1" name="password" maxlength="{$max_passwd_len}" value=""/></td>
</tr>
{if $if_imap != '1' }
<tr>
 <td>IMAP-Verbindung:</td>
 <td><select name="imap" class="in_1">
     <option value="enable">Ja</option>
     <option value="disable">Nein</option></select></td>
</tr>
{/if}
{if $if_pop3 != '1' }
<tr>
 <td>POP3-Verbindung:</td>
 <td><select name="pop3" class="in_1">
     <option value="enable">Ja</option>
     <option value="disable">Nein</option></select></td>
</tr>
{/if}
{if $if_webmail != '1' }
<tr>
 <td>Webmail moeglich:</td>
 <td><select name="webmail" class="in_1">
     <option value="enable">Ja</option>
     <option value="disable">Nein</option></select></td>
</tr>
{/if}
<tr>
<td></td>
<td><input type="submit" name="submit" value="Anlegen" /></td>
</tr>
</table>
</form>
{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}