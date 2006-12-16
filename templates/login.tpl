{if $if_login_ok eq 'yes'}
<div style="text-align:center;color:blue;">
Erfolgreicht in das eMailsystem angemeldet, sie werden weitergeleitet.
<meta http-equiv="refresh" content="1; URL=index.php">
<br/>
</div>
{/if}
{if $if_no_passwd eq 'y' }
<div style="color:red;">
Fehler: Benutzername oder Passwort falsch!<br/>
<br/>
</div>
{/if}

{if $if_login_ok !='yes'}
<form action="login.php" method="post">
<table>
<tr>
 <td>Benutzername:</td>
 <td style="text-align: right;"><input class="in_1" name="email" type="text" /></td>
</tr>
<tr>
 <td>Passwort:</td>
 <td style="text-align: right;"><input class="in_1" name="password" type="password" /></td>
</tr>
<tr>
 <td colspan="2" style="text-align:center"><input class="in_1" type="submit" name="login" value="Anmelden" /></td>
</tr>
</table>
</form>
{/if}