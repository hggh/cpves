<form action="?module=sadmin_passwd" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>{t}username{/t}:</td>
			<td>{$username}</td>
		</tr>
		<tr>
			<td>{t}old password{/t}:</td>
			<td><input type="password" name="old_passwd"/></td>
		</tr>
		<tr>
			<td>{t}new password{/t}:</td>
			<td><input name="new_passwd1" maxlength="{$max_passwd_len}" type="password" /></td>
		</tr>
		<tr>
			<td>{t}repeat new password{/t}:</td>
			<td><input name="new_passwd2" maxlength="{$max_passwd_len}" type="password" /></td>
		</tr>
		<tr>
			<td>
			</td>
			<td><input name="s_submit" value="{t}change password{/t}" type="submit" /></td>
		</tr>
	</table>
</form>