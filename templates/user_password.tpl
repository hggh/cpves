<br/>
<form action="?module=user_password" method="post">
<table>
<tr>
 <td>{t}emailaddress{/t}</td>
 <td>{$email}</td>
</tr>
<tr>
 <td>{t}old password:{/t}</td>
 <td><input type="password" name="old_passwd" /></td>
</tr>
<tr>
 <td>{t}new password:{/t}</td>
 <td><input name="new_passwd1" maxlength="{$max_passwd_len}" type="password" /></td>
</tr>
<tr>
 <td>{t}repeat new password:{/t}</td>
 <td><input name="new_passwd2" maxlength="{$max_passwd_len}" type="password" /></td>
</tr>
<tr>
 <td colspan="2" style="text-align:center;">
 <input name="u_submit" value="{t}change password{/t}" type="submit" /></td>
</tr>
</table>
</form>
