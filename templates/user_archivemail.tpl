{if $imap_folder_exits == 1 }
<table border="0">
	{foreach from=$available_folders item=row}
	<tr>
		<td valign="top"><b>IMAP-Order: </b> <i>{$row.name_display}</i></td>
		<td style="wight:10px;">&nbsp;</td>
		<td valign="top">Mailarchiv erstellen:<br/>
		Archivieren nach <input type="text" size="5" value="" name="armail_time" /> Tagen<br/>
		Nur gelesene Mails: <input type="checkbox" name="armail_read" value="1"><br/>
		Archivordner: <input type="checkbox" name="armail_folder_month"/> Mit Monat (z.B. Archiv\Ordner_05)<br/>
		<input type="checkbox" name="armail_folder_ywear"/> Mit Jahr (z.B. Archiv\Ordner_2007)<br/>
		F&uuml;r <i>Archiv\Ordner_05_2007 bitte beiden Ordneroptionen aktivieren!</i>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	{/foreach}
</table>
{else}
Keinen IMAP-Ordner gefunden. Daher ist kein Mailarchiv m&ouml;lich!
{/if}