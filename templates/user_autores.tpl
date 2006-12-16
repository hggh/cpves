{if $if_subject_empty eq 'y'} 
<div style="text-align:center;color:red;">
	Betreff des Autoreply darf nicht leer sein! 
</div>
<br />
{/if} {if $if_msg_empty eq 'y'} 
<div style="text-align:center;color:red;">
	Nachricht des Autoreply darf nicht leer sein! 
</div>
<br />
{/if} {if $if_subject_tolong eq 'y'} 
<div style="text-align:center;color:red;">
	Betreff des Autoreply ist zu lang! 
</div>
<br />
{/if} {if $if_query_ok eq 'y' } 
<meta http-equiv="refresh" content="0; URL=./index.php">
{/if} 

{if $if_superadmin != 'y' } 
<form action="user_autores.php" method="post">
	<table>
		<tr>
			<td>Autoresponder aktiv:</td>
			<td>
				<select name="active"> 
					<option value="y">
						Ja 
					</option>
					{if $active eq 'n' } 
					<option value="n" selected="selected">
						Nein 
					</option>
					{else} 
					<option value="n">
						Nein 
					</option>
					{/if} </select> 
			</td>
		</tr>
		<tr>
			<td>Autoresponder Betreff:
			</td>
			<td>
				<input type="text" name="esubject" maxlength="50" value="{$esubject}" /> 
			</td>
		</tr>
		<tr>
			<td valign="top">Nachricht: 
			</td>
			<td>
<textarea name="msg" cols="50" rows="15">{$msg}</textarea> 
			</td>
		</tr>
		<tr>
			<input type="hidden" name="id" value="{$id}" /> 
			<td>
			</td>
			<td>
				<input type="submit" value="Speichern" name="u_submit" /> 
			</td>
		</tr>
	</table>
</form>
{/if} 