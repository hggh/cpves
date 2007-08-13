 
<table border="1">
<tr>
	<td>Server</td>
	<td>Protokoll</td>
	<td>Benutzer</td>
	<td>Aktiv</td>
	<td>L&ouml;schen</td>
</tr>
</table>
<br/>
<h3>Neuen POP/IMAP Server hinzuf&uuml;gen:</h3>
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
	<td><select name="fm_ssl" style="width:90px;">
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

</table>