<form action="?module=user_forward" method="post">
<table>
<tr>
</tr>
	<td>Alle E-Mails weiterleiten:</td>
	<td style="width:10px;"></td>
	
	<td>
	<input name="forwardaddress" value="{$forwardaddress}" type="text"/>
	</td>
</form>
<tr>
	<td>Kopie im Postfach belassen:</td>
	<td style="width:10px;"></td>
	<td>
		<select name="save_local">
		{if $if_forward_cc == 1 }
		<option value="1">Ja</option>
		<option value="0">Nein</option>
		{else}
		<option value="0">Nein</option>
		<option value="1">Ja</option>
		{/if}
		</select>
	</td>
	
</tr>
<tr>
	<td>Weiterleitung l&ouml;schen:</td>
	<td style="width:10px;"></td>
	<td>
		<input type="checkbox" name="delete_forward"/>
	</td>
</tr>
<tr>
	<td></td>
	<td style="width:10px;"></td>
	<td><input type="submit" name="submit" value="Speichern" /></td>

</tr>

</table>

</form>

{if $reload_page == 'y'}
<meta http-equiv="refresh" content="0; URL=user_forward.php">
{/if}