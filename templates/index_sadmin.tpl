<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>Domain</td>
		<td>E-Mailadressen</td>
		<td>Weiterleitungen</td>
		<td>Aktivieren/Deaktivieren</td>
		<td>L&#246;schen</td>
		<td>Notiz</td>
	</tr>
	{foreach from=$table_data item=row} 
	<tr  bgcolor="{cycle values="$color1,$color2"}">
		<td style="padding-left:3px;">
		<a href="?module=domain_view&#038;did={$row.id}">{$row.dnsname}</a></td>
		<td>{$row.count_email}</td>
		<td>{$row.count_forward}</td>
		<td>
			{if $row.access == "y" }
				<a href="?module=main&#038;state=disable&#038;did={$row.id}">
				<img src="img/icons/button_ok.png" style="vertical-align:middle;" title="Deaktivieren" /></a>
			{else}
				<a href="?module=main&#038;state=enable&#038;did={$row.id}" >
				<img src="img/icons/button_cancel.png" style="vertical-align:middle;" title="Aktivieren" /></a>
			{/if} 
		</td>
		<td>
			<a href="?module=domain_del&#038;did={$row.id}">
			<img src="img/icons/delete.png" style="border:0px;" title="Domain löschen" />
			</a>
		</td>
		<td>{$row.dnote}</td>
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
