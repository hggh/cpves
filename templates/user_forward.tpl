<form action="?module=user_forward" method="post">
<table>
<tr>
</tr>
	<td>{t}forward all mails to:{/t}</td>
	<td style="width:10px;"></td>
	
	<td>
	<input name="forwardaddress" value="{$forwardaddress}" type="text"/>
	</td>
</form>
<tr>
	<td>{t}save copy:{/t}</td>
	<td style="width:10px;"></td>
	<td>
		<select name="save_local">
		{if $if_forward_cc == 1 }
		<option value="1">{t}yes{/t}</option>
		<option value="0">{t}no{/t}</option>
		{else}
		<option value="0">{t}no{/t}</option>
		<option value="1">{t}yes{/t}</option>
		{/if}
		</select>
	</td>
	
</tr>
<tr>
	<td>{t}delete forwarding:{/t}</td>
	<td style="width:10px;"></td>
	<td>
		<input type="checkbox" name="delete_forward"/>
	</td>
</tr>
<tr>
	<td></td>
	<td style="width:10px;"></td>
	<td><input type="submit" name="submit" value="{t}save{/t}" /></td>

</tr>

</table>

</form>

{if $reload_page == 'y'}
<meta http-equiv="refresh" content="0; URL=?module=user_forward">
{/if}