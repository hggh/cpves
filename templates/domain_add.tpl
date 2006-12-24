 {if $if_superadmin eq 'y' }
  
  
{if $if_dns_added eq 'y' } 

	{$new_dnsname} 
	<br />
	<br />
	{if $if_dns_not_found eq 'y' } <span style="color:red;">Neue Domain in keinem DNS gefunden!!
		<br />
		eMailverkehr wird nicht funkionieren!</span>
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

{/if} {if $if_dns_added != 'y'} 
<form action="domain_add.php" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>Domainname:</td>
			<td>
				<input type="text" value="{$dnsname}" name="dnsname" />
			</td>
		</tr>
		<tr>
			<td>Notiz:</p>
			</td>
			<td>
				<input type="text" value="" name="dnote" maxlength="30" />
			</td>
		</tr>
		<tr>
			<td>IMAP-Verbindung:</p>
			</td>
			<td>
				<select name="imap"> 
					<option value="enable">
						Ja
					</option>
					<option value="disable">
						Nein
					</option>
				</select> 
			</td>
		</tr>
		<tr>
			<td>POP3-Verbindung:</td>
			<td>
				<select name="pop3" class="in_1"> 
					<option value="enable">
						Ja
					</option>
					<option value="disable">
						Nein
					</option>
				</select> 
			</td>
		</tr>
		<tr>
			<td>Webmail m&ouml;glich:</td>
			<td>
				<select name="webmail" class="in_1"> 
					<option value="enable">
						Ja
					</option>
					<option value="disable">
						Nein
					</option>
				</select> 
			</td>
		</tr>
		<tr>
			<td>Max. E-Mailadressen:</td>
			<td>
				<input value="0" name="max_email" title="0 = Unbegrenzt" />
			</td>
		</tr>
		<tr>
			<td>Max. Weiterleitungen:</td>
			<td>
				<input value="0" name="max_forward" title="0 = Unbegrenzt" />
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<input type="submit" name="submit" value="Domain eintragen" />
			</td>
		</tr>
	</table>
</form>
{/if} {else} 
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}