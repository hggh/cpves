{if $imap_folder_exits == 1 }
<table border="0">
	{foreach from=$available_folders item=row}
	<tr>
		<td>{$row.name_display}</td>
	</tr>
	{/foreach}
</table>
{else}
Keinen IMAP-Ordner gefunden. Daher ist kein Mailarchiv m&ouml;lich!
{/if}