<form action="?module=sadmin_add" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>{t}username{/t}:</td>
			<td><input name="username" maxlength="8" value="{$sausername|default:''}"  type="text" /></td>
		</tr>
		<tr>
			<td>{t}full name{/t}:</td>
			<td><input name="full_name" value="{$full_name|default:''}"  type="text" /></td>
		</tr>
		<tr>
			<td>{t}password{/t}:</td>
			<td><input name="passwd"  value="" type="password" maxlength="{$max_passwd_len}" /></td> 
		</tr>
		<tr>
			<td>{t}access{/t}:</td>
			<td><select name="access"> 
				<option value="1">{t}yes{/t}</option>
				<option value="0">{t}no{/t}</option>
			</select></td>
		</tr>
		<tr>
			<td>{t}superadmin manager{/t}:</td>
			<td><select name="manager">
				<option value="0">{t}no{/t}</option>
				<option value="1">{t}yes{/t}</option>
				
			</select></td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<input type="submit" name="submit" value="{t}create{/t}"  /> 
			</td>
		</tr>
	</table>
</form>
