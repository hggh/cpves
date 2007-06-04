<form method="post">
<table border="0">
<tr>
	<td>Name des Filters:</td>
	<td><input type="text" name="ml_rule_name"/>
</tr>
<tr>
	<td valign="top">Regel:</td>
	<td>
		<select name="ml_rule_to">
			<option value="from">Von</option>
			<option value="to">An</option>
			<option value="subject">Betreff</option>
		</select><br/>
		<select name="ml_rule_cond">
			<option value="eq">enth&auml;lt</option>
			<option value="ne">enth&auml;lt nicht</option>
		</select>
	</td>
</tr>
<tr>
	<td>Trifft zu auf:</td>
	<td><input size="50" type="ml_rule_match"</td>
</tr>
<tr>
	<td>Priorit&auml;t:</td>
	<td>
	<select name="ml_prio">
		<option value="low">Niedrig</option>
		<option value="mid" selected="selected">Mittel</option>
		<option value="high">Hoch</option>
	</select>
	</td>
</tr>
<tr>
	<td>Mails verschieben nach:</td>
	<td>
	{if $imap_folder_exits == "1" }
		<select name="spam_folder">
		{foreach from=$available_folders item=row}
			<option value="{$row.name}">{$row.name_display}</option>
		{/foreach}</select>
		
		{else}<p>Kein Imap Ordner gefunden!<br/>Bitte Ordner im Mailprogramm anlegen!</p>
		{/if}
	</td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" name="ml_submit" value="Speichern" />
</tr>
</table>
</form>