{if $if_query_ok eq 'y' } 
<meta http-equiv="refresh" content="0; URL=./index.php">
{/if} 

{if $if_superadmin != 'y' } 

<table><form action="?module=user_autores" method="post">
	<tr>
		<td>Autoresponder aktiv:</td>
		<td><select name="active">
			<option value="y">Ja</option>
			{if $active eq 'n' }
			<option value="n" selected="selected">Nein</option>
			{else}
			<option value="n">Nein</option>
			{/if}
		</select></td>
	</tr>
	<tr>
		<td>Autoresponder Betreff:</td>
		<td><input type="text" name="esubject" maxlength="50" value="{$esubject}" /></td>
	</tr>
	<tr>
		<td valign="top">Nachricht:</td>
		<td>
		<textarea name="msg" cols="50" rows="15">{$msg}</textarea>
		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="id" value="{$id}" /></td>
		<td><input type="submit" value="Speichern" name="u_submit" /></td>
	</tr>
	
	<tr>
		<td colspan="2">&#160;</td>
	</tr>
	<tr>
		<td colspan="2">&#160;</td>
	</tr></form>
	
	
	<form action="?module=user_autores" method="post">
	<tr>
		<td>Aktiviere validierte Empf&auml;ngeradressen:</td>
		<td>{if $val_tos_active == 1 }
		<input type="radio" onclick="submit();" checked="checked" name="val_tos_active" value="1"> Ja <input type="radio" onclick="submit();" name="val_tos_active"  value="0"> Nein
		{else}<input type="radio" onclick="submit();"  name="val_tos_active" value="1"> Ja <input type="radio" checked="checked" onclick="submit();" name="val_tos_active"  value="0"> Nein{/if}</td>
	</tr>
	
	<tr>
		<td valign="top">Validierte Empf&auml;ngeradressen:</td>
		<td>
		<select name="val_tos[]" size="8" multiple="true">
		{foreach from=$table_val_tos item=row }
		<option value="{$row.id}">{$row.recip}</option>
		{/foreach}
		</select><br/>
		<input type="submit" name="val_tos_del" value="Markierte L&ouml;schen" />
		</td>
		
	</tr>
	<tr>
		<td>Hinzuf&uuml;gen:</td>
		<td><input type="text" name="val_tos_da" /><input type="submit" name="val_tos_add" value="Hinzuf&uuml;gen" /></td>
	</tr></form>
</table>

{/if} 