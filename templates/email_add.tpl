{if $if_superadmin == '1' or $if_admin == '1'and $access_domain }
<form action="?module=email_add&#038;did={$did}" method="post">
<table>
<tr>
 <td style="width:190px;">{t}emailaddress:{/t}</td>
 <td style="width:300px;"><input type="text" name="emailaddr" value="{$eMail}"/>@{$dnsname}</td>
</tr>
<tr>
 <td>{t}full name:{/t}</td>
 <td><input type="text" name="full_name" value="{$full_name}"/></td>
</tr>
<tr>
 <td>{t}password:{/t}</td>
 <td><input type="password" name="npassword" maxlength="{$max_passwd_len}" value=""/></td>
</tr>
{if $if_imap == '1' }
<tr>
 <td>{t}imap connection:{/t}</td>
 <td><select name="imap">
     <option value="1">{t}yes{/t}</option>
     <option value="0">{t}no{/t}</option></select></td>
</tr>
{/if}
{if $if_pop3 == '1' }
<tr>
 <td>{t}pop3 connection:{/t}</td>
 <td><select name="pop3">
     <option value="1">{t}yes{/t}</option>
     <option value="0">{t}no{/t}</option></select></td>
</tr>
{/if}
{if $if_webmail == '1' }
<tr>
 <td>{t}webmail available:{/t}</td>
 <td><select name="webmail">
     <option value="1">{t}yes{/t}</option>
     <option value="0">{t}no{/t}</option></select></td>
</tr>
{/if}
{if $if_spamassassin == '1'}
<tr>
	<td>{t}spamassassin available:{/t}</td>
	<td><select name="p_spamassassin">
		<option value="1">{t}yes{/t}</option>
		<option value="0">{t}no{/t}</option>
	</select></td>
</tr>
{/if}

<tr>
<td></td>
<td><input type="submit" name="submit" value="{t}create emailaddress{/t}" /></td>
</tr>
</table>
</form>
{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}