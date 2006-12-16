<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>Domain</td>
		<td>eMail-Adressen</td>
		<td>Weiterleitungen</td>
		<td>Aktivieren/Deaktivieren</td>
		<td>L&#246;schen</td>
		<td>Notiz</td>
	</tr>
	{foreach from=$table_data item=row} 
	<tr>
		<td>
			<a href="domain_view.php?id={$row.id}">{$row.dnsname}</a> 
		</td>
		<td>
			<p>
				{$row.count_email} 
			</p>
		</td>
		<td>
			<p>
				{$row.count_forward} 
			</p>
		</td>
		<td>
			{if $row.access == "y" } 
			<form action="index.php" method="post" >
				<input type="image" src="img/icons/button_ok.png" value="disable" style="vertical-align:middle;" name="state" alt="Deaktivieren" /> <input type="hidden" name="id" value="{$row.id}" /> 
			</form>
			{else} 
			<form action="index.php" method="post" >
				<input type="image" src="img/icons/button_cancel.png" style="vertical-align:middle;" value="enable" name="state" alt="Aktivieren" /> <input type="hidden" name="id" value="{$row.id}" /> 
			</form>
			{/if} 
		</td>
		<td>
			<a href="domain_del.php?id={$row.id}">
			<img src="img/icons/delete.png" style="border:0px;" title="Domain l&#038;schen" />
			</a>
		</td>
		<td>
			<p>
				{$row.dnote} 
			</p>
		</td>
	</tr>
	{/foreach} 
</table>
{** {if $if_blacklist_listet == 'y' } 
<tr>
	<td colspan="3" style="text-align:left;" class="header">
		Unsere Server IP ({$ipaddr}) ist gelistet: 
	</td>
</tr>
{section name=row loop=$table_spam} 
<tr>
	<td>
		{$table_spam[row].spam} 
	</td>
</tr>
{/section} {/if} 
</table>
**}
