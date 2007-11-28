<table>
<tr>
	<td>{t}domainname{/t}</td>
	<td>{t}emailaddresses{/t}</td>
	<td>{t}forwardings{/t}</td>
	{if $config.display_mb_size == 1 }
	<td>{t}size{/t}</td>
	{/if}
</tr>
{section name=row loop=$table_data}
<tr bgcolor="{cycle values="$color1,$color2"}">
	<td style="padding-left:3px;">
	<div style="float:left;">
		<a href="?module=domain_view&#038;did={$row.id}">{$row.dnsname}</a></div>
		{if $row.vacation == 1}
		<div style="float:right;padding:0px;">
		<a class="tooltip" href="#">
		<img src="img/icons/autoresponder.png" title="" align="middle"/>
		<span>{t}vacation{/t}:<br/>{$row.vacation_infos}</span></a>
		</div>
		{/if}
	</td>
	<td style="text-align:right;">{$table_data[row].count_email}</td>
	<td style="text-align:right;">{$table_data[row].count_forward}</td>
	{if $config.display_mb_size == 1 }
	<td>{$row.mb_size.size} {if $row.mb_size.unit == 'gb'}GB{else}MB{/if}</td>
	{/if}
</tr>
{/section}
</table>
