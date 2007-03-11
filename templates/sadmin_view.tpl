{if $if_superadmin eq 'y' and $if_manager eq 'y' } 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><h3>Benutzername</h3></td>
		<td><h3>Name</h3></td>
		<td><h3>Aktivieren/Deaktivieren</h3></td>
		<td><h3>L&ouml;schen</h3></td>
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
			{if $table_data[row].access == "y" } 
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
{else} 
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if} 
 