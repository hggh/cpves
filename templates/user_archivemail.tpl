{if $imap_folder_exits == 1 }
<table border="0">
	{foreach from=$available_folders item=row}
	<tr>
	<td valign="top" style="padding-right:10px;"><b>IMAP-Order: </b> <i>{$row.name_display}</i></td>
	<td valign="top" style="padding-bottom:19px;">
	<form >
		<table>
		<tr>
			<td colspan="2" style="font-weight:bold;" class="domain_view">Mailarchiv erstellen:</td>
		</tr>
		
		<tr>
			<td>Archivieren nach:</td>
			<td><input type="text" size="5" value="" name="armail_time" />   (Tagen)</td>
		</tr>
		
		<tr>
			<td>Nur gelesene Mails:</td>
			<td><input type="checkbox" name="armail_read" value="1"></td>
		</tr>
		
		<td colspan="2" style="font-weight:bold;" class="domain_view">Archiv-Ordnername:</td>
		
		<tr>
			<td>Mit Monat (z.B. Archiv\Ordner_05):</td>
			<td><input type="checkbox" name="armail_folder_month"/></td>
		</tr>
		
		<tr>
			<td>Mit Jahr (z.B. Archiv\Ordner_2007):</td>
			<td><input type="checkbox" name="armail_folder_year"/></td>
		</tr>
		<tr>
			<td>Mit Jahr und Monat:</td>
			<td><input type="checkbox" value="1" name="checkboth" onClick="armail_check_both();" /></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:right;"><input type="submit" name="armail_save" value="Speichern"/></td>
		</tr>
		</table></form>
	</td>
	</tr>
	{/foreach}
</table>
{else}
Keinen IMAP-Ordner gefunden. Daher ist kein Mailarchiv m&ouml;lich!
{/if}