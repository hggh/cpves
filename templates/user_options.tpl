<form action="?module=user_options" name="options" method="post">
<table>
<tr>
</tr>
<tr>
	<td>L&ouml;sche Virenbenachrichtigungen:</td>
	<td style="width:10px;"></td>
	<td>
		<select name="del_virus_notifi">
		{if $del_virus_notifi eq 1}
			<option value="1" selected="selected">Ja</option>
			<option value="0">Nein</option>
		{else}
			<option value="1">Ja</option>
			<option value="0" selected="selected">Nein</option>
		{/if}
		</select>  
	</td>
</tr>

<tr>
	<td></td>
	<td style="width:10px;">
	<td>
	<input name="save_option" type="submit" value="Speichern" /></td>
</tr>
</table>
</form>