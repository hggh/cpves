{if $imap_folder_exits == 1 }
<table border="0">
	{foreach key=fid from=$available_folders item=row}
	{if $row.type != 'inbox' }
	<tr>
	<td valign="top" style="padding-right:10px;"><b>IMAP-Ordner: </b> <i>{$row.name_display}</i></td>
	<td valign="top" style="padding-bottom:19px;">
	<form action="?module=user_salearn" method="post">
	<table border="0">
	<tr>
		<td>Lernen als:</td>
		<td><select name="sa_learn_type">
		{if $row.satype == 'spam'}
		<option value="0">Nicht lernen</option>
		<option value="ham">Ham</option>
		<option selected="selected" value="spam">Spam</option>
		{elseif $row.satype == 'ham' }
		<option value="0">Nicht lernen</option>
		<option selected="selected" value="ham">Ham</option>
		<option value="spam">Spam</option>
		{else}
		<option value="0">Nicht lernen</option>
		<option value="ham">Ham</option>
		<option value="spam">Spam</option>
		{/if}
		</select></td>
	</tr>
	<tr>
		<td></td>
		<td>
		<input type="hidden" name="sa_learn_folder" value="{$row.name}"/>
		<input type="hidden" name="sa_learn_id" value="{$fid}"/>
		<input type="submit" name="sa_learn_submit" value="Speichern"/></td>
	</tr>
	</table></form>
	</td>
	</tr>
	{/if}
	{/foreach}
</table>
{else}
Keinen IMAP-Ordner gefunden. Daher ist kein Spam/Hamlernbar!
{/if}