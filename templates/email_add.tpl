{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }
<form action="?module=email_add&#038;did={$did}" method="post">
<table>
<tr>
 <td style="width:190px;">{$labels.email_address}:</td>
 <td style="width:300px;"><input type="text" name="emailaddr" value="{$eMail}"/>@{$dnsname}</td>
</tr>
<tr>
 <td>{$labels.full_name}:</td>
 <td><input type="text" name="full_name" value="{$full_name}"/></td>
</tr>
<tr>
 <td>{$labels.password}:</td>
 <td><input type="password" name="npassword" maxlength="{$max_passwd_len}" value=""/></td>
</tr>
{if $if_imap == '1' }
<tr>
 <td>IMAP-Verbindung:</td>
 <td><select name="imap">
     <option value="1">{$labels.opt_yes}</option>
     <option value="0">{$labels.opt_no}</option></select></td>
</tr>
{/if}
{if $if_pop3 == '1' }
<tr>
 <td>POP3-Verbindung:</td>
 <td><select name="pop3">
     <option value="1">{$labels.opt_yes}</option>
     <option value="0">{$labels.opt_no}</option></select></td>
</tr>
{/if}
{if $if_webmail == '1' }
<tr>
 <td>Webmail moeglich:</td>
 <td><select name="webmail">
     <option value="1">{$labels.opt_yes}</option>
     <option value="0">{$labels.opt_no}</option></select></td>
</tr>
{/if}
{if $if_spamassassin == '1'}
<tr>
	<td>Spamassassin sichtbar:</td>
	<td><select name="p_spamassassin">
		<option value="1">{$labels.opt_yes}</option>
		<option value="0">{$labels.opt_no}</option>
	</select></td>
</tr>
{/if}

<tr>
<td></td>
<td><input type="submit" name="submit" value="{$labels.create}" /></td>
</tr>
</table>
</form>
{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}