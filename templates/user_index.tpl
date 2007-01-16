<h2>Willkommen, {$full_name}</h2>
<br/>
<form action="index.php" method="post">
<table>
<tr>
 <td><p>eMailadresse:</p></td>
 <td><p>{$email}</p></td>
</tr>
<tr>
 <td><p>Altes Passwort:</p></td>
 <td><input type="password" name="old_passwd" class="in_1" /></td>
</tr>
<tr>
 <td><p>Neues Passwort:</p></td>
 <td><input name="new_passwd1" maxlength="{$max_passwd_len}" type="password" class="in_1" /></td>
</tr>
<tr>
 <td><p>Wiederholen:</p></td>
 <td><input name="new_passwd2" maxlength="{$max_passwd_len}" type="password" class="in_1" /></td>
</tr>
<tr>
 <td colspan="2" style="text-align:center;">
 <input name="u_submit" class="in_1" value="&Auml;ndern" type="submit" /></td>
</tr>
</table>
</form>