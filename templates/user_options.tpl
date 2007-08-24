<form action="?module=user_options" name="options" method="post">
<table>
<tr>
</tr>
<tr>
	<td>{t}webinterface language:{/t}</td>
	<td style="width:10px;"></td>
	<td><select name="web_lang">
		<option value="en_US">en_US</option>
	</select></td>
</tr>
<tr>
	<td>{t}delete virus notifactions:{/t}</td>
	<td style="width:10px;"></td>
	<td>
		<select name="del_virus_notifi">
		{if $del_virus_notifi == 1}
			<option value="1" selected="selected">{t}yes{/t}</option>
			<option value="0">{t}no{/t}</option>
		{else}
			<option value="1">{t}yes{/t}</option>
			<option value="0" selected="selected">{t}no{/t}</option>
		{/if}
		</select>  
	</td>
</tr>
<tr>
	<td>{t}filter doubled mails:{/t}</td>
	<td style="width:10px;"></td>
	<td>
		<select name="del_dups_mails">
		{if $del_dups_mails == 1}
			<option value="1" selected="selected">{t}yes{/t}</option>
			<option value="0">{t}no{/t}</option>
		{else}
			<option value="1">{t}yes{/t}</option>
			<option value="0" selected="selected">{t}no{/t}</option>
		{/if}
		</select>
	</td>
</tr>

<tr>
	<td></td>
	<td style="width:10px;">
	<td>
	<input name="save_option" type="submit" value="{t}save{/t}" /></td>
</tr>
</table>
</form>