{if $imap_folder_exits == 1 }
<table border="0">
	{foreach key=fid from=$available_folders item=row}
	<tr>
	<td valign="top" style="padding-right:10px;"><b>IMAP-Order: </b> <i>{$row.name_display}</i></td>
	<td valign="top" style="padding-bottom:19px;">
	<table border="0">
	<tr>
		<td>Lernen aktiv:</td>
		<td><select name="sa_learn_active">
		<option value="1">Ja</option>
		<option value="0">Nein</option>
		</select></td>
	</tr>
	<tr>
		<td>Lernen als:</td>
		<td><select name="sa_learn_type">
		<option value="ham">Ham</option>
		<option value="spam">Spam</option>
		</select></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" name="sa_learn_submit" value="Speichern"/></td>
	</tr>
	</table>
	</td>
	</tr>
	{/foreach}
</table>
{else}
Keinen IMAP-Ordner gefunden. Daher ist kein Spam/Hamlernbar!
{/if}