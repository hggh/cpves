{if $if_superadmin eq 'y' } {if $old_passwd_wrong eq 'y' } 
<div style="text-align:center;color:red;">
	Altes Passwort falsch!
</div>
{/if} {if $passwd_not_true eq 'y' } 
<div style="text-align:center;color:red;">
	Neue Passw&ouml;rter stimmen nicht &uuml;berein!
</div>
{/if} {if $passwd_len eq 'y' } 
<div style="text-align:center;color:red;">
	Passwort muss zwischen 3 und {$max_passwd_len} Zeichen sein!
</div>
{/if} {if $passwd_empty eq 'y' } 
<div style="text-align:center;color:red;">
	Passwort darf nicht leer sein!
</div>
{/if} {if $passwd_changed eq 'y' } 
<div style="text-align:center;color:blue;">
	Passwort erfolgreich ge&auml;ndert!
</div>
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if} 
<form action="sadmin_passwd.php" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<p>
					Benutzername:
				</p>
			</td>
			<td>
				<p>
					{$username}
				</p>
			</td>
		</tr>
		<tr>
			<td>
				<p>
					Altes Passwort:
				</p>
			</td>
			<td>
				<input type="password" name="old_passwd" class="in_1" />
			</td>
		</tr>
		<tr>
			<td>
				<p>
					Neues Passwort:
				</p>
			</td>
			<td>
				<input name="new_passwd1" maxlength="{$max_passwd_len}" type="password" class="in_1" />
			</td>
		</tr>
		<tr>
			<td>
				<p>
					Wiederholen:
				</p>
			</td>
			<td>
				<input name="new_passwd2" maxlength="{$max_passwd_len}" type="password" class="in_1" />
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