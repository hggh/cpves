 
<table border="0">
<tr>
	<td style="font-weight:bold;padding-right:20px;">{t}server{/t}</td>
	<td style="font-weight:bold;padding-right:20px;">{t}protocol{/t}</td>
	<td style="font-weight:bold;padding-right:20px;">{t}username{/t}</td>
	<td style="font-weight:bold;padding-right:20px;">{t}active{/t}</td>
	<td style="font-weight:bold;">{t}delete{/t}</td>
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
	<td colspan="5">{t}no fetchmail exists.{/t}</td>
</tr>
{/foreach}
</table>
<br/>
<h3>{t}add new server:{/t}</h3>
<form action="?module=user_fetchmail" method="post">
<table style="border:0x;">
<tr>
	<td>{t}server:{/t}</td>
	<td><input type="text" name="fm_server" /></td>
</tr>
<tr>
	<td>{t}protocol:{/t}</td>
	<td><select name="fm_proto" style="width:90px;">
		<option value="1">POP3</option>
		<option value="2">IMAP</option>
	</select></td>
</tr>
<tr>
	<td>{t}connection type:{/t}</td>
	<td><select name="fm_conn_type" style="width:90px;">
		<option value="1">{t}no SSL{/t}</option>
		<option value="2">{t}with SSL{/t}</option>
	</select></td>
</tr>
<tr>
	<td>{t}username:{/t}</td>
	<td><input type="text" name="fm_username" /></td>
</tr>
<tr>
	<td>{t}password:{/t}</td>
	<td><input type="password" name="fm_password" /></td>
</tr>
<tr>
	<td>{t}keep mails on the server:{/t}</td>
	<td><select name="fm_keep_mails" style="width:90px;">
		<option value="1">{t}no{/t}</option>
		<option value="2">{t}yes{/t}</option>
	</select></td>
</tr>
<tr>
	<td></td>
	<td><input type="submit" name="fm_submit" value="{t}save{/t}" /></td>
</tr>

</table></form>
