<table border="0">
	<tr>
		<td style="font-weight:bold;padding-right:15px;">{t}from domain{/t}:</td>
		<td>@{$dnsname}</td>
	</tr>
{if $no_domains_found == '0'}
<form action="?module=domain_forward&#038did={$did}" method="post">
	<tr>
		<td style="font-weight:bold;">{t}to domain{/t}:</td>
		<td><select name="to_domain">
		{foreach from=$domains_display item=row}
		<option value="{$row.id}">{$row.dnsname}</option>
		{/foreach}
		</select></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" name="domains_forward_save" value="{t}save{/t}"/></td>
	</tr>
</form>
{else}
	<tr>
		<td colspan="2"><br/>{t}no more domains found, you can't create an internal forward!{/t}</td>
	</tr>
{/if}
</table>