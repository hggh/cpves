{if $if_superadmin eq 'y' }
 


{if $passwd_not_true eq 'y' } 
<div style="text-align:center;color:red;">
	Neue Passw&ouml;rter stimmen nicht &uuml;berein!
</div>
{/if} 

 
{if $passwd_changed eq 'y' } 
<div style="text-align:center;color:blue;">
	Passwort erfolgreich ge&auml;ndert!
</div>
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if} 
<form action="sadmin_passwd.php" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>Benutzername:</td>
			<td>{$username}</td>
		</tr>
		<tr>
			<td>Altes Passwort:</td>
			<td>
				<input type="password" name="old_passwd"/>
			</td>
		</tr>
		<tr>
			<td>Neues Passwort:</td>
			<td>
				<input name="new_passwd1" maxlength="{$max_passwd_len}" type="password" />
			</td>
		</tr>
		<tr>
			<td>Wiederholen:</td>
			<td>
				<input name="new_passwd2" maxlength="{$max_passwd_len}" type="password" />
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<input name="s_submit" class="in_1" value="&Auml;ndern" type="submit" />
			</td>
		</tr>
	</table>
</form>
{else} 
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if} 