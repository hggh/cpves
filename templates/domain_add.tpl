{assign var='if_dns_added' value=$if_dns_added|default:'n'}
{if $if_dns_added eq 'y' } 
<br />
	{if $if_dns_not_found eq 'y' }
	<span style="color:red;">{t 1=$new_dnsname}the new domainname (%1) was not found in the DNS system!{/t}<br/>
	{t}mailtraffic for this domain will not work!{/t}</span>
	<br />
	<br />
	{/if} {if $if_mx eq 'y'} 
	<table style="border:0px;">
		<tr>
			<td colspan="4" class="header" style="text-align:left;">{t 1=$new_dnsname}the new domain %1 has got the following MX entries{/t}:</td>
		</tr>
		<tr>
			<td>{t}prio{/t}</td>
			<td>{t}MX address{/t}</td>
			<td style="width:230px;">{t}ip type{/t}</td>
			<td>{t}MX points to our server{/t}</td>
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
	<div style="color:red;">{t escape='off'}no MX entry points to our server.<br>You will not receive mail for this domain!{/t}
	</div>
	<br />
	<br />
	{/if} 
	<br/>
	<a href="?module=domain_view&#038;did={$did}">{t}go to domain summary...{/t}</a>

{/if}

{if $if_dns_added != 'y'} 
<form action="?module=domain_add" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>{t}domainname{/t}:</td>
		<td><input type="text" value="{$dnsname|default:''}" name="dnsname" />
		</td>
	</tr>
	<tr>
		<td>{t}note{/t}:</td>
		<td>
		<input type="text" value="" name="dnote" maxlength="30" />
		</td>
	</tr>
	<tr>
		<td>{t}imap connection{/t}:</td>
		<td>
			<select name="p_imap"> 
				<option value="1">{t}yes{/t}</option>
				<option value="0">{t}no{/t}</option>
			</select> 
		</td>
	</tr>
	<tr>
		<td>{t}pop3 connection{/t}:</td>
		<td>
			<select name="p_pop3"> 
				<option value="1">{t}yes{/t}</option>
				<option value="0">{t}no{/t}</option>
			</select> 
		</td>
	</tr>
	<tr>
		<td>{t}webmail available{/t}:</td>
		<td><select name="p_webmail">
			<option value="1">{t}yes{/t}</option>
			<option value="0">{t}no{/t}</option>
		</select></td>
	</tr>
	<tr>
		<td>{t}spamassassin available{/t}:</td>
		<td><select name="p_spamassassin">
            <option value="1">{t}yes{/t}</option>
			<option selected value="0" onclick="document.getElementById('p_bogofilter').value=0;document.getElementById('p_sa_wb_listing').value=0;">{t}no{/t}</option>
		</select></td>
	</tr>
	<tr>
		<td>{t}bogofilter available{/t}:</td>
		<td><select id="p_bogofilter" name="p_bogofilter">
			<option value="0">{t}no{/t}</option>
			<option value="1">{t}yes{/t}</option>
		</select></td>
	</tr>
	<tr>
		<td>{t}mailarchive available{/t}:</td>
		<td><select name="p_mailarchive">
			<option value="0">{t}no{/t}</option>
			<option value="1">{t}yes{/t}</option>
		</select></td>
	</tr>
	<tr>
		<td>{t}spamfilter whitelist available{/t}:</td>
		<td><select name="p_sa_wb_listing" id="p_sa_wb_listing">
			<option value="0">{t}no{/t}</option>
			<option value="1">{t}yes{/t}</option>
		</select></td>
	</tr>
	<tr>
		<td>{t}max emailaddresses{/t}:</td>
		<td><input value="0" name="max_email"/>&#160; 0 = {t}no limit{/t}</td>
	</tr>
	<tr>
		<td>{t}max forwardings{/t}:</td>
		<td><input value="0" name="max_forward" />&#160; 0 = {t}no limit{/t}</td>
	</tr>
	<tr>
		<td>
		</td>
		<td>
		<input type="submit" name="submit" value="{t}create domain{/t}" />
		</td>
	</tr>
</table>
</form>
{/if} 
