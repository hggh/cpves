{if $if_superadmin eq 'y' and $if_manager eq 'y' } 
<form action="sadmin_add.php" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>Benutzername:</td>
			<td><input name="username" maxlength="8" value="{$sausername}"  type="text" /></td>
		</tr>
		<tr>
			<td>Name:</td>
			<td><input name="full_name" value="{$full_name}"  type="text" /></td>
		</tr>
		<tr>
			<td>Passwort:</td>
			<td><input name="passwd"  value="" type="password" maxlength="{$max_passwd_len}" /></td> 
		</tr>
		<tr>
			<td>Zugriff:</td>
			<td><select name="access"> 
				<option value="enable">Ja</option>
				<option value="disable">Nein</option>
			</select></td>
		</tr>
		<tr>
			<td>Manager:</td>
			<td><select name="manager"> 
				<option value="enable">Ja</option>
				<option value="disable" selected="selected">Nein</option>
			</select></td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<input type="submit" name="submit" value="Speichern"  /> 
			</td>
		</tr>
	</table>
</form>
{else} 
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}
