<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>{t}domainname{/t}</td>
		<td>{t}emailaddresses{/t}</td>
		<td>{t}fowardings{/t}</td>
		{if $config.display_mb_size == 1 }
		<td>{t}size{/t}</td>
		{/if}
		<td>{t}activate/deactivate{/t}</td>
		<td>{t}delete{/t}</td>
		<td>{t}note{/t}</td>
	</tr>
	{foreach from=$table_data item=row} 
	<tr  bgcolor="{cycle values="$color1,$color2"}">
		<td style="padding-left:3px;">
		<div style="float:left;">
		<a href="?module=domain_view&#038;did={$row.id}">{$row.dnsname}</a></div>
		{if $row.vacation == 1}
		<div style="float:right;padding:0px;">
		<img src="img/icons/autoresponder.png" title="{$row.vacation_infos}" align="middle"/>
		</div>
		{/if}
		</td>
		<td>{$row.count_email}</td>
		<td>{$row.count_forward}</td>
		{if $config.display_mb_size == 1 }
		<td>{$row.mb_size.size} {if $row.mb_size.unit == 'gb'}GB{else}MB{/if}</td>
		{/if}
		<td>
			{if $row.access == "1" }
				<a href="?module=main&#038;state=disable&#038;did={$row.id}">
				<img src="img/icons/button_ok.png" style="vertical-align:middle;" title="{t}deactivate this domain.{/t}" /></a>
			{else}
				<a href="?module=main&#038;state=enable&#038;did={$row.id}" >
				<img src="img/icons/button_cancel.png" style="vertical-align:middle;" title="{t}activate this domain.{/t}" /></a>
			{/if} 
		</td>
		<td>
			<a href="?module=domain_del&#038;did={$row.id}">
			<img src="img/icons/delete.png" style="border:0px;" title="{t}delete this domain.{/t}" />
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
