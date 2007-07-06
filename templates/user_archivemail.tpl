{if $imap_folder_exits == 1 }
<table border="0">
	{foreach key=fid from=$available_folders item=row}
	{if $row.type == 'spam' }
	{* If spam folder: only delete option should be used *}
	{else}
	<tr>
	<td valign="top" style="padding-right:10px;"><b>IMAP-Order: </b> <i>{$row.name_display}</i></td>
	<td valign="top" style="padding-bottom:19px;">
	<form action="?module=user_archivemail" method="post">
		<table>
		<tr>
			<td colspan="2" style="font-weight:bold;" class="domain_view">Mailarchiv erstellen:</td>
		</tr>
		<tr>
			<td>Archivieren nach:</td>
			<td><input type="text" size="5" value="" name="armail_time{$fid}" />   (Tagen)</td>
		</tr>
		
		<tr>
			<td>Nur gelesene Mails:</td>
			<td><input type="checkbox" checked="checked" name="armail_read{$fid}" value="1"></td>
		</tr>
		
		<td colspan="2" style="font-weight:bold;" class="domain_view">Archiv-Ordnername:</td>
		
		<tr>
			<td>Mit Monat (z.B. Archiv\Ordner_05):</td>
			<td><input type="checkbox" id="armail_folder_month{$fid}" name="armail_folder_month{$fid}"/></td>
		</tr>
		
		<tr>
			<td>Mit Jahr (z.B. Archiv\Ordner_2007):</td>
			<td><input type="checkbox" id="armail_folder_year{$fid}" name="armail_folder_year{$fid}"/></td>
		</tr>
		<tr>
			<td>Mit Jahr und Monat:</td>
			<td><input type="checkbox" value="1" id="checkboth{$fid}" name="checkboth" onClick="armail_check_both({$fid});" /></td>
		</tr>
		<tr>
			<td>Archivierung aktiv:</td>
			<td><select name="armail_active">
			<option selected="selected" value="0">Nein</option>
			<option value="1">Ja</option>
			</select></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:right;">
			<input type="hidden" name="armail_folder" value="{$row.name}"/>
			<input type="hidden" name="armail_id" value="{$fid}"/>
			<input type="submit" name="armail_save" value="Speichern"/></td>
		</tr>
		</table></form>
	</td>
	</tr>
	{/if}
	{/foreach}
</table>
{else}
Keinen IMAP-Ordner gefunden. Daher ist kein Mailarchiv m&ouml;lich!
{/if}