{if $if_superadmin != 'y' } 
<table>
<form action="?module=user_autores" method="post">
	<tr>
		<td>Autoresponder aktiv:</td>
		<td><select name="autores_active">
			<option value="y" onclick="cpves_autores_field('');">Ja</option>
			{if $autores_active eq 'n' }
			<option value="n" onclick="cpves_autores_field('true');" selected="selected">Nein</option>
			{else}
			<option value="n"  onclick="cpves_autores_field('true');">Nein</option>
			{/if}
		</select></td>
	</tr>
	<tr>
		<td>Sende Autoresonder an den Absender:</td>
		<td>
			{html_options name="autores_sendback_times" options="$autores_sendback_times_selects" selected=$autores_sendback_times_value  style="width:200px;"}
		</td>
	</tr>
	<tr>
		<td>Autoresponder Betreff:</td>
		<td><input type="text" id="autores_subject" name="autores_subject" maxlength="50" value="{$autores_subject}" /></td>
	</tr>
	<tr>
		<td valign="top">Nachricht:</td>
		<td>
		<textarea name="autores_msg" id="autores_msg" cols="50" rows="15">{$autores_msg}</textarea>
		</td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" value="Speichern" name="autores_submit" /></td>
	</tr>
	
	<tr>
		<td colspan="2">&#160;</td>
	</tr>
	<tr>
		<td colspan="2">&#160;</td>
	</tr></form>

	<form action="?module=user_autores" method="post">
	<tr>
		<td valign="top">Deaktiviere Autoresponder:</td>
		<td><select name="autores_datedisable_active" id="autores_datedisable_active">
		<option value="1" onclick="cpves_autores_datedisable('')">Ja</option>
		{if $autores_disable.active == 0 }
		<option value="0" onclick="cpves_autores_datedisable('true')" selected="selected">Nein</option>
		{else}
		<option value="0" onclick="cpves_autores_datedisable('true')">Nein</option>
		{/if}
		</select></td>
	</tr>
	<tr>
		<td>Ab Datum:</td>
		<td><input type="text" name="autores_datedisable_date" value="{$autores_disable.a_date}" id="autores_datedisable_date"/></td>
	</tr>
	<tr>
		<td>Ab Uhrzeit:</td>
		<td><input type="text" name="autores_datedisable_time" value="{$autores_disable.a_time}" id="autores_datedisable_time"/></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" id="autores_datedisable_submit" name="autores_datedisable_submit" value="Speichern" /></td>
	</tr>
	</form>


	<tr style="height:25px;">
		<td></td>
		<td></td>
	</tr>
	
	<form action="?module=user_autores" method="post">
	<tr>
		<td>Aktiviere validierte Empf&auml;ngeradressen:</td>
		<td>{if $val_tos_active == 1 }
		<input type="radio" id="autores_valtos_active_on" onclick="submit();" checked="checked" name="val_tos_active" value="1"> Ja <input type="radio" onclick="submit();" name="val_tos_active" id="autores_valtos_active_off"  value="0"> Nein
		{else}
		<input type="radio" onclick="submit();"  id="autores_valtos_active_on"  name="val_tos_active" value="1"> Ja <input type="radio" checked="checked" onclick="submit();"  id="autores_valtos_active_off" name="val_tos_active"  value="0"> Nein{/if}</td>
	</tr>
	
	<tr>
		<td valign="top">Validierte Empf&auml;ngeradressen:</td>
		<td>
		<select style="min-width:250px;" name="val_tos[]" id="autores_valtos_data" size="8" multiple="true">
		{foreach from=$table_val_tos item=row }
		<option value="{$row.id}">{$row.recip}</option>
		{/foreach}
		</select><br/>
		<input type="submit" id="autores_valtos_del" name="val_tos_del" value="Markierte L&ouml;schen" />
		</td>
		
	</tr>
	<tr>
		<td>Hinzuf&uuml;gen:</td>
		<td><input type="text" id="autores_valtos_add_data" name="val_tos_da" /><input type="submit" id="autores_valtos_add_submit" name="val_tos_add" value="Hinzuf&uuml;gen" /></td>
	</tr></form>
</table>
{if $autores_active eq 'n' }
	<script type="text/javascript">cpves_autores_field('true');
	</script>
{/if}
{if $autores_disable.active == 0 }
	<script type="text/javascript">
	cpves_autores_datedisable('true');
	</script>
{/if}
{if $val_tos_active == 0 }
	<script type="text/javascript">
	cpves_autores_valtos('true');
	</script>
{/if}


{/if}
