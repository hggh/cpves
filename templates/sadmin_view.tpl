<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><h3>{t}username{/t}</h3></td>
		<td><h3>{t}full name{/t}</h3></td>
		<td><h3>{t}activate/deactivate{/t}</h3></td>
		<td><h3>{t}delete{/t}</h3></td>
	</tr>
	{section name=row loop=$table_data} 
	<tr>
		<td>
			<a href="?module=sadmin_edit&#038;id={$table_data[row].id}">{$table_data[row].username}</a>
		</td>
		<td>
			<p>
				{$table_data[row].full_name}
		</td>
		<td>
			{if $table_data[row].access == '1' } 
			<a href="?module=sadmin_view&#038;state=disable&#038;id={$table_data[row].id}">
			<img src="img/icons/button_ok.png" style="border:0px;"></a>
			{else} 
			<a href="?module=sadmin_view&#038;state=enable&#038;id={$table_data[row].id}">
			<img src="img/icons/button_cancel.png" style="border:0px;"></a>
			{/if} 
		</td>
		<td>
			<a href="?module=sadmin_view&#038;state=delete&#038;id={$table_data[row].id}">
			<img src="img/icons/delete.png" style="border:0px;"></a>
		</td>
	</tr>
	{/section} 
</table>