{if $if_dns_added eq 'y' } 
<br />
	{if $if_dns_not_found eq 'y' } <span style="color:red;">{$labels.da_new_domain} ({$new_dnsname}) {$labels.da_not_found}
		<br />{$labels.da_mails_not_work}</span>
	<br />
	<br />
	{/if} {if $if_mx eq 'y'} 
	<table style="border:0px;">
		<tr>
			<td colspan="4" class="header" style="text-align:left;">
				{$labels.da_domain} {$new_dnsname} {$labels.da_mx_entries}:
			</td>
		</tr>
		<tr>
			<td>{$labels.prio}</td>
			<td>{$labels.mx_address}</td>
			<td style="width:230px;">{$labels.da_ip_type}</td>
			<td>{$labels.da_goes_to_mailsys}</td>
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
		{$labels.da_no_mx_entry_to_mailsys}
		<br />
		{$labels.da_no_mail_revc}
	</div>
	<br />
	<br />
	{/if} 
	<br/>
	<a href="?module=domain_view&#038;did={$did}">{$label.da_to_domain_view}</a>

{/if}

{if $if_dns_added != 'y'} 
<form action="?module=domain_add" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>{$labels.domainname}:</td>
		<td><input type="text" value="{$dnsname}" name="dnsname" />
		</td>
	</tr>
	<tr>
		<td>{$labels.note}:</td>
		<td>
		<input type="text" value="" name="dnote" maxlength="30" />
		</td>
	</tr>
	<tr>
		<td>{$labels.imap_connection}:</td>
		<td>
			<select name="p_imap"> 
				<option value="1">{$labels.opt_yes}</option>
				<option value="0">{$labels.opt_no}</option>
			</select> 
		</td>
	</tr>
	<tr>
		<td>{$labels.pop3_connection}:</td>
		<td>
			<select name="p_pop3"> 
				<option value="1">{$labels.opt_yes}</option>
				<option value="0">{$labels.opt_no}</option>
			</select> 
		</td>
	</tr>
	<tr>
		<td>{$labels.p_webmail}:</td>
		<td><select name="p_webmail">
			<option value="1">{$labels.opt_yes}</option>
			<option value="0">{$labels.opt_no}</option>
		</select></td>
	</tr>
	<tr>
		<td>{$labels.p_sa}:</td>
		<td><select name="p_spamassassin">
			<option value="1">{$labels.opt_yes}</option>
			<option value="0" onclick="document.getElementById('p_bogofilter').value=0;document.getElementById('p_sa_wb_listing').value=0;">{$labels.opt_no}</option>
		</select></td>
	</tr>
	<tr>
		<td>{$labels.p_bogofilter}:</td>
		<td><select id="p_bogofilter" name="p_bogofilter">
			<option value="0">{$labels.opt_no}</option>
			<option value="1">{$labels.opt_yes}</option>
		</select></td>
	</tr>
	<tr>
		<td>{$labels.p_mailarchive}:</td>
		<td><select name="p_mailarchive">
			<option value="0">{$labels.opt_no}</option>
			<option value="1">{$labels.opt_yes}</option>
		</select></td>
	</tr>
	<tr>
		<td>{$labels.p_sa_whitelist}:</td>
		<td><select name="p_sa_wb_listing" id="p_sa_wb_listing">
			<option value="0">{$labels.opt_no}</option>
			<option value="1">{$labels.opt_yes}</option>
		</select></td>
	</tr>
	<tr>
		<td>{$labels.da_max_mailaddrs}:</td>
		<td><input value="0" name="max_email"/>&#160; 0 = {$labels.da_open_end}</td>
	</tr>
	<tr>
		<td>{$labels.da_max_forwards}:</td>
		<td><input value="0" name="max_forward" />&#160; 0 = {$labels.da_open_end}</td>
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
{/if} 