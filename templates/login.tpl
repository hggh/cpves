{assign var='if_login_ok' value=$if_login_ok|default:'no'}
{if $if_login_ok !='yes'}
<form action="index.php?module=login" method="post">
<table>
<tr>
 <td>{t}username{/t}:</td>
 <td style="text-align: right;"><input value="" name="email" type="text" /></td>
</tr>
<tr>
 <td>{t}password{/t}:</td>
 <td style="text-align: right;"><input name="password" type="password" /></td>
</tr>
<tr>
 <td colspan="2" style="text-align:center"><input type="submit" name="login" value="{t}login{/t}" /></td>
</tr>
</table>
</form>
{/if}
