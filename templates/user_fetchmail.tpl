 
<table border="0">
<tr>
	<td style="font-weight:bold;padding-right:20px;">Server</td>
	<td style="font-weight:bold;padding-right:20px;">Protokoll</td>
	<td style="font-weight:bold;padding-right:20px;">Benutzer</td>
	<td style="font-weight:bold;padding-right:20px;">Aktiv</td>
	<td style="font-weight:bold;">L&ouml;schen</td>
</tr>
{foreach key=fid from=$table_fetchmail item=row}
<tr>
	<td style="padding-right:10px;"><a href="?module=user_fetchmail&#038;id={$row.id}">{$row.server}</a></td>
	<td>{if $row.proto == 1}POP3{elseif $row.proto == 2}IMAP{/if}
	</td>
	<td style="padding-right:10px;">{$row.username}</td>
	<td style="padding-right:10px;">{if $row.active == 1}<a href="?module=user_fetchmail&#038;disable={$row.id}"><img src="img/icons/button_ok.png" style="border:0px;vertical-align:middle;" /></a>
	{else}
	<a href="?module=user_fetchmail&#038;enable={$row.id}"><img src="img/icons/button_cancel.png" style="border:0px;vertical-align:middle;" /></a>
	{/if}
	</td>
	<td style="text-align:center;"><a href="?module=user_fetchmail&#038;delete={$row.id}"><img src="img/icons/delete.png" style="border:0px;vertical-align:middle;" /></a></td>
</tr>
{foreachelse}
<tr>
	<td colspan="5">Kein Fetchmail konfiguriert!</td>
</tr>
{/foreach}
</table>
<br/>
<h3>Neuen POP/IMAP Server hinzuf&uuml;gen:</h3>
<form action="?module=user_fetchmail" method="post">
<table style="border:0x;">
<tr>
	<td>Server:</td>
	<td><input type="text" name="fm_server" /></td>
</tr>
<tr>
	<td>Protokoll:</td>
	<td><select name="fm_proto" style="width:90px;">
		<option value="1">POP3</option>
		<option value="2">IMAP</option>
	</select></td>
</tr>
<tr>
	<td>Verbindung:</td>
	<td><select name="fm_conn_type" style="width:90px;">
		<option value="1">Kein SSL</option>
		<option value="2">Mit SSL</option>
	</select></td>
</tr>
<tr>
	<td>Benutzer:</td>
	<td><input type="text" name="fm_username" /></td>
</tr>
<tr>
	<td>Passwort:</td>
	<td><input type="password" name="fm_password" /></td>
</tr>
<tr>
	<td>Mails auf dem Server belassen:</td>
	<td><select name="fm_keep_mails" style="width:90px;">
		<option value="1">Nein</option>
		<option value="2">Ja</option>
	</select></td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" name="fm_submit" value="Speichern" /></td>
</tr>

</table></form>