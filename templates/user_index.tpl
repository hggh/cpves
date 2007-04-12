<h2>Willkommen, {$full_name}</h2>
<br/>
<form action="index.php" method="post">
<table>
<tr>
 <td>E-Mailadresse:</td>
 <td>{$email}</td>
</tr>
<tr>
 <td>Altes Passwort:</td>
 <td><input type="password" name="old_passwd" /></td>
</tr>
<tr>
 <td>Neues Passwort:</td>
 <td><input name="new_passwd1" maxlength="{$max_passwd_len}" type="password" /></td>
</tr>
<tr>
 <td>Wiederholen:</td>
 <td><input name="new_passwd2" maxlength="{$max_passwd_len}" type="password" /></td>
</tr>
<tr>
 <td colspan="2" style="text-align:center;">
 <input name="u_submit" value="&Auml;ndern" type="submit" /></td>
</tr>
</table>
</form>
