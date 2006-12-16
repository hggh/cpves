 {if $if_superadmin eq 'y' } {if $if_empty eq 'y' } 
<div style="text-align:center;color:red;">
	Domainname leer! Bitte korregieren.
</div>
{/if} {if $if_dnsname_exists eq 'y' } 
<div style="text-align:center;color:red;">
	Domainname existiert bereits!
</div>
{/if} {if $if_dns_added eq 'y' } 
<div style="text-align:center;">
	Neue Domain {$new_dnsname} hinzugefuegt.
	<br />
	<br />
	{if $if_dns_not_found eq 'y' } <span style="color:red;">Neue Domain in keinem DNS gefunden!!
		<br />
		eMailverkehr wird nicht funkionieren!</span>
	<br />
	<br />
	{/if} {if $if_mx eq 'y'} 
	<table style="margin-left: auto; margin-right: auto;">
		<tr>
			<td colspan="4" class="header" style="text-align:left;">
				Die Domain {$new_dnsname} hat folgende MX-Eintr&auml;ge:
			</td>
		</tr>
		<tr>
			<td class="header">
				Prioritaet
			</td>
			<td class="header">
				MX Adresse
			</td>
			<td class="header" style="width:230px;">
				IP Adresse (Type)
			</td>
			<td class="header">
				Zeigt auf eMailSystem
			</td>
		</tr>
		{section name=row loop=$mx_entry} 
		<tr style="background-color:{cycle values=#rcolor#}">
			<td>
				{$mx_entry[row].prio}
			</td>
			<td>
				{$mx_entry[row].mx_name}
			</td>
			<td>
				{$mx_entry[row].ipaddr} ({$mx_entry[row].iptype})
			</td>
			{if $mx_entry[row].this_server == "true" } 
			<td>
				X
			</td>
			{else} 
			<td>
			</td>
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
		Kein eMailempfang &uuml;ber diesen Server m&ouml;glich!
	</div>
	<br />
	<br />
	{/if} 
</div>
{/if} {if $if_dns_added != 'y'} 
<form action="domain_add.php" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<p>
					Domainname:
				</p>
			</td>
			<td>
				<input class="in_1" type="text" value="{$dnsname}" name="dnsname" />
			</td>
		</tr>
		<tr>
			<td>
				<p>
					Notiz:
				</p>
			</td>
			<td>
				<input class="in_1" type="text" value="" name="dnote" maxlength="30" />
			</td>
		</tr>
		<tr>
			<td>
				<p>
					IMAP-Verbindung:
				</p>
			</td>
			<td>
				<select name="imap" class="in_1"> 
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
			<td>
				<p>
					POP3-Verbindung:
				</p>
			</td>
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
			<td>
				<p>
					Webmail m&ouml;glich:
				</p>
			</td>
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
			<td>
				<p>
					Max. eMailadressen:
				</p>
			</td>
			<td>
				<input class="in_1" value="0" name="max_email" title="0 = Unbegrenzt" />
			</td>
		</tr>
		<tr>
			<td>
				<p>
					Max. Weiterleitungen:
				</p>
			</td>
			<td>
				<input class="in_1" value="0" name="max_forward" title="0 = Unbegrenzt" />
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<input type="submit" name="submit" value="Domain eintragen" class="in_1" />
			</td>
		</tr>
	</table>
</form>
{/if} {else} 
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}