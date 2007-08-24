{if $imap_folder_exits == 1 }
<table border="0">
	{foreach key=fid from=$available_folders item=row}
	{if $row.type != 'inbox' }
	<tr>
	<td valign="top" style="padding-right:10px;"><b>{t}IMAP folder:{/t}</b> <i>{$row.name_display}</i></td>
	<td valign="top" style="padding-bottom:19px;">
	<form action="?module=user_salearn" method="post">
	<table border="0">
	<tr>
		<td>{t}learn folder:{/t}</td>
		<td><select name="sa_learn_type">
		{if $row.satype == 'spam'}
		<option value="0">{t}not learning{/t}</option>
		<option value="ham">{t}ham{/t}</option>
		<option selected="selected" value="spam">{t}spam{/t}</option>
		{elseif $row.satype == 'ham' }
		<option value="0">{t}not learning{/t}</option>
		<option selected="selected" value="ham">{t}ham{/t}</option>
		<option value="spam">{t}spam{/t}</option>
		{else}
		<option value="0">{t}not learning{/t}</option>
		<option value="ham">{t}ham{/t}</option>
		<option value="spam">{t}spam{/t}</option>
		{/if}
		</select></td>
	</tr>
	<tr>
		<td></td>
		<td>
		<input type="hidden" name="sa_learn_folder" value="{$row.name}"/>
		<input type="hidden" name="sa_learn_id" value="{$fid}"/>
		<input type="submit" name="sa_learn_submit" value="{t}save{/t}"/></td>
	</tr>
	</table></form>
	</td>
	</tr>
	{/if}
	{/foreach}
</table>
{else}
{t}no IMAP folder was found. You can't learn messages as ham/spam!{/t}
{/if}