{if $if_superadmin eq 'y' and $if_manager eq 'y' } 
<form action="?module=sadmin_add" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>{$labels.username}:</td>
			<td><input name="username" maxlength="8" value="{$sausername}"  type="text" /></td>
		</tr>
		<tr>
			<td>Name:</td>
			<td><input name="full_name" value="{$full_name}"  type="text" /></td>
		</tr>
		<tr>
			<td>{$labels.password}:</td>
			<td><input name="passwd"  value="" type="password" maxlength="{$max_passwd_len}" /></td> 
		</tr>
		<tr>
			<td>{$labels.access}:</td>
			<td><select name="access"> 
				<option value="enable">{$labels.opt_yes}</option>
				<option value="disable">Nein</option>
			</select></td>
		</tr>
		<tr>
			<td>{$labels.sadmin_manager}:</td>
			<td><select name="manager">
				<option value="disable">Nein</option>
				<option value="enable">{$labels.opt_yes}</option>
				
			</select></td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<input type="submit" name="submit" value="{$labels.create}"  /> 
			</td>
		</tr>
	</table>
</form>
{else} 
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}