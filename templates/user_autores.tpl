{if $if_superadmin != 'y' } 
<table>
<form action="?module=user_autores" method="post">
	<tr>
		<td>{t}vacation active{/t}:</td>
		<td><select name="autores_active">
			<option value="y" onclick="cpves_autores_field('');">{t}yes{/t}</option>
			{if $autores_active eq 'n' }
			<option value="n" onclick="cpves_autores_field('true');" selected="selected">{t}no{/t}</option>
			{else}
			<option value="n"  onclick="cpves_autores_field('true');">{t}no{/t}</option>
			{/if}
		</select></td>
	</tr>
	<tr>
		<td>{t}send vacation back to sender{/t}:</td>
		<td>
			{html_options name="autores_sendback_times" id="autores_sendback_times" options="$autores_sendback_times_selects" selected=$autores_sendback_times_value  style="width:200px;"}
		</td>
	</tr>
	<tr>
		<td>{t}vacation subject{/t}:</td>
		<td><input type="text" id="autores_subject" name="autores_subject" maxlength="50" value="{$autores_subject}" /></td>
	</tr>
	<tr>
		<td valign="top">{t}message{/t}:</td>
		<td>
		<textarea name="autores_msg" id="autores_msg" cols="50" rows="15">{$autores_msg}</textarea>
		</td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" value="{t}save vacation{/t}" name="autores_submit" /></td>
	</tr>
	
	<tr>
		<td colspan="2">&#160;</td>
	</tr>
	<tr>
		<td colspan="2">&#160;</td>
	</tr></form>

	<form action="?module=user_autores" method="post">
	<tr>
		<td valign="top">{t}automatic deactivation{/t}:</td>
		<td><select name="autores_datedisable_active" id="autores_datedisable_active">
		<option value="1" onclick="cpves_autores_datedisable('')">{t}yes{/t}</option>
		{if $autores_disable.active == 0 }
		<option value="0" onclick="cpves_autores_datedisable('true')" selected="selected">{t}no{/t}</option>
		{else}
		<option value="0" onclick="cpves_autores_datedisable('true')">{t}no{/t}</option>
		{/if}
		</select></td>
	</tr>
	<tr>
		<td>{t}date of deactivation{/t}:</td>
		<td><input type="text" name="autores_datedisable_date" value="{$autores_disable.a_date}" id="autores_datedisable_date"/></td>
	</tr>
	<tr>
		<td>{t}time of deactivation{/t}:</td>
		<td><input type="text" name="autores_datedisable_time" value="{$autores_disable.a_time}" id="autores_datedisable_time"/></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" id="autores_datedisable_submit" name="autores_datedisable_submit" value="{t}save{/t}" /></td>
	</tr>
	</form>


	<tr style="height:25px;">
		<td></td>
		<td></td>
	</tr>
	
	<form action="?module=user_autores" method="post">
	<tr>
		<td>{t}activate valid recipient lists{/t}:</td>
		<td>{if $val_tos_active == 1 }
		<input type="radio" id="autores_valtos_active_on" onclick="submit();" checked="checked" name="val_tos_active" value="1"> {t}yes{/t} <input type="radio" onclick="submit();" name="val_tos_active" id="autores_valtos_active_off"  value="0"> {t}no{/t}
		{else}
		<input type="radio" onclick="submit();"  id="autores_valtos_active_on"  name="val_tos_active" value="1"> {t}yes{/t} <input type="radio" checked="checked" onclick="submit();"  id="autores_valtos_active_off" name="val_tos_active"  value="0"> {t}no{/t}{/if}</td>
	</tr>
	
	<tr>
		<td valign="top">{t}valid recipients{/t}:</td>
		<td>
		<select style="min-width:250px;" name="val_tos[]" id="autores_valtos_data" size="8" multiple="true">
		{foreach from=$table_val_tos item=row }
		<option value="{$row.id}">{$row.recip}</option>
		{/foreach}
		</select><br/>
		<input type="submit" id="autores_valtos_del" name="val_tos_del" value="{t}delete selected{/t}" />
		</td>
		
	</tr>
	<tr>
		<td>{t}add new address{/t}:</td>
		<td><input type="text" id="autores_valtos_add_data" name="val_tos_da" /><input type="submit" id="autores_valtos_add_submit" name="val_tos_add" value="{t}add{/t}" /></td>
	</tr></form>
{if $p_autores_xheader == 1}
	<tr style="height:25px;">
		<td></td>
	</tr>
	<tr>
		<td valign="top">{t}vacation X-Header disable feature{/t}:</td>
	</tr>
	<tr>
		<td></td>
		<td>
			<table border="0">
			<tr>
				<td style="font-weight:bold;padding-right:30px;">{t}X-Header{/t}</td>
				<td style="font-weight:bold;padding-right:20px;">{t}Value{/t}</td>
				<td></td>
			</tr>
			{foreach item=row from=$table_xheader}
				<td>{$row.xheader}</td>
				<td>{$row.value}</td>
				<td><a href="?module=user_autores&#038;xheader={$row.id}&#038;do=del"><img src="img/icons/delete.png" style="border:0px;"/></a></td>
			{/foreach}
			</table>
		</td>

	</tr>
	<tr style="height:25px;">
		<td></td>
	</tr>
	<tr>
		<td valign="top">{t}add new X-Header{/t}:</td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td>
			<form action="?module=user_autores" method="post">
			<table border="0">
			<tr>
				<td style="padding-right:10px;">{t}X-Header{/t}:</td>
				<td><input type="text" name="xheader_name" /></td>
			</tr>
			<tr>
				<td style="padding-right:10px;">{t}Value{/t}:</td>
				<td><input type="text" name="xheader_value" /></td>
			</tr>
			</table>
			<input name="xheader_submit" type="submit" value="{t}save{/t}"/>
			</form>
		</td>
	</tr>
{/if}
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
