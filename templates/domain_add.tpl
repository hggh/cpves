{if $if_superadmin eq 'y' }
  
{if $if_dns_added eq 'y' } 
<br />
	{if $if_dns_not_found eq 'y' } <span style="color:red;">Neue Domain ({$new_dnsname} ) in DNS nicht gefunden!!
		<br />
		Mailverkehr wird nicht funkionieren!</span>
	<br />
	<br />
	{/if} {if $if_mx eq 'y'} 
	<table style="border:0px;">
		<tr>
			<td colspan="4" class="header" style="text-align:left;">
				Die Domain {$new_dnsname} hat folgende MX-Eintr&auml;ge:
			</td>
		</tr>
		<tr>
			<td>Prioritaet</td>
			<td>MX Adresse</td>
			<td style="width:230px;">IP Adresse (Type)</td>
			<td>Zeigt auf MailSystem
			</td>
		</tr>
		{section name=row loop=$mx_entry} 
		<tr style="background-color:{cycle values=#rcolor#}">
			<td>{$mx_entry[row].prio}</td>
			<td>{$mx_entry[row].mx_name}</td>
			<td>{$mx_entry[row].ipaddr} ({$mx_entry[row].iptype})</td>
			{if $mx_entry[row].this_server == "true" } 
			<td style="text-align:center;"><img src="img/icons/button_ok.png" style="border:0px;"/></td>
			{else}
			<td style="text-align:center;"><img src="img/icons/button_cancel.png" style="border:0px;"/></td>
			{/if} 
		</tr>
		{/section} 
	</table>
	<br />
	<br />
	{/if} {if $points eq 'n' } 
	<div style="color:red;">
		Kein MX Eintrag der Domain zeigt auf unsere eMailsystem IP!
		<br />
		Kein Mailempfang &uuml;ber diesen Server m&ouml;glich!
	</div>
	<br />
	<br />
	{/if} 
	<br/>
	<a href="?module=domain_view&#038;did={$did}">Zur Domainansicht...</a>

{/if}

{if $if_dns_added != 'y'} 
<form action="?module=domain_add" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>Domainname:</td>
		<td><input type="text" value="{$dnsname}" name="dnsname" />
		</td>
	</tr>
	<tr>
		<td>Notiz:</td>
		<td>
		<input type="text" value="" name="dnote" maxlength="30" />
		</td>
	</tr>
	<tr>
		<td>IMAP-Verbindung:</td>
		<td>
			<select name="p_imap"> 
				<option value="1">{$labels.opt_yes}</option>
				<option value="0">{$labels.opt_no}</option>
			</select> 
		</td>
	</tr>
	<tr>
		<td>POP3-Verbindung:</td>
		<td>
			<select name="p_pop3"> 
				<option value="1">{$labels.opt_yes}</option>
				<option value="0">{$labels.opt_no}</option>
			</select> 
		</td>
	</tr>
	<tr>
		<td>Webmail m&ouml;glich:</td>
		<td><select name="p_webmail">
			<option value="1">{$labels.opt_yes}</option>
			<option value="0">{$labels.opt_no}</option>
		</select></td>
	</tr>
	<tr>
		<td>Spamassassin m&ouml;glich:</td>
		<td><select name="p_spamassassin">
			<option value="1">{$labels.opt_yes}</option>
			<option value="0" onclick="document.getElementById('p_bogofilter').value=0;">{$labels.opt_no}</option>
		</select></td>
	</tr>
	<tr>
		<td>Bogofilter m&ouml;glich:</td>
		<td><select id="p_bogofilter" name="p_bogofilter">
			<option value="0">{$labels.opt_no}</option>
			<option value="1">{$labels.opt_yes}</option>
		</select></td>
	</tr>
	<tr>
		<td>Mailarchiv m&ouml;glich:</td>
		<td><select name="p_mailarchive">
			<option value="0">{$labels.opt_no}</option>
			<option value="1">{$labels.opt_yes}</option>
		</select></td>
	</tr>
	<tr>
		<td>Spamfilter - Whitelist:</td>
		<td><select name="p_sa_wb_listing">
			<option value="0">{$labels.opt_no}</option>
			<option value="1">{$labels.opt_yes}</option>
		</select></td>
	</tr>
	<tr>
		<td>Max. E-Mailadressen:</td>
		<td><input value="0" name="max_email"/>&#160; 0 = Unbegrenzt</td>
	</tr>
	<tr>
		<td>Max. Weiterleitungen:</td>
		<td><input value="0" name="max_forward" />&#160; 0 = Unbegrenzt</td>
	</tr>
	<tr>
		<td>
		</td>
		<td>
		<input type="submit" name="submit" value="{$labels.create}" />
		</td>
	</tr>
</table>
</form>
{/if} {else} 
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}