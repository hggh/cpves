<form action="?module=user_spam" name="spam" id="sa_form" method="post">
<table>
	<tr>
		<td>{t}spamfilter active:{/t}</td>
		<td><select id="spamassassin_active" name="spamassassin_active">
		<option value="1" onclick="cpves_sa_active('1');">{t}yes{/t}</option>
		{if $spamassassin_active eq '0' }
		<option value="0" onclick="cpves_sa_active('0');" selected="selected">{t}no{/t}</option>
		{else}
		<option value="0" onclick="cpves_sa_active('0');">{t}no{/t}</option>
		{/if}
		</select></td>
	</tr>
	
	{if $p_bogofilter == 1}
	<tr>
		<td>{t}bogofilter active:{/t}</td>
		<td><select id="bogofilter_active" name="bogofilter_active">
		<option value="1">{t}yes{/t}</option>
		{if $bogofilter_active == 0}
		<option value="0" selected="selected">{t}no{/t}</option>
		{else}
		<option value="0">{t}no{/t}</option>
		{/if}
		</select></td>
	</tr>
	{/if}
	
	<tr>
		<td valign="top">{t}change subject:{/t}</td>
		<td>{if $rewrite_subject == '1' } 
		<input type="radio" name="rewrite_subject"  value="0" /> {t}no{/t} 
		<input type="radio" name="rewrite_subject" checked="checked" value="1" /> {t}yes{/t}<br />
		{else} 
		<input type="radio" checked="checked" name="rewrite_subject"  value="0" /> {t}no{/t} 
		<input type="radio" name="rewrite_subject" value="1" /> {t}yes{/t}<br />
		{/if}
		<input id="spamassassin_subject_header"  maxlength="15" name="rewrite_subject_header" value="{$rewrite_subject_header}" type="text" />
		</td>
	</tr>
	
	<tr>
		<td>{t}mark message as spam:{/t}</td>
		<td><input type="text" id="spamassassin_threshold" name="threshold" value="{$threshold}" /></td>
	</tr>

	<tr>
		<td valign="top">{t}move known spam:{/t}</td>
		<td>{if $move_spam eq '0' } <input type="radio" name="move_spam" checked="checked" value="0" /> {t}no{/t} 
		<input type="radio" name="move_spam"  value="1" /> {t}yes{/t}<br />
		{else} <input type="radio" name="move_spam"  value="0" /> {t}no{/t} 
			<input type="radio" name="move_spam"  checked="checked" value="1" /> {t}yes{/t} <br />{/if}
		
		{if $imap_folder_exits == "1" }
		<select name="spam_folder">
		{foreach from=$available_folders item=row}
			{if $move_spam_folder == $row.name}
				{if $row.type == 'spam'}
				 <option value="{$row.name}" style="font-weight:bold;" selected="selected">{$row.name_display}</option>
				{else}
				<option value="{$row.name}" selected="selected">{$row.name_display}</option> 
				{/if}
			{else}
				{if $row.type == 'spam'}
				<option style="font-weight:bold;" value="{$row.name}">{$row.name_display}</option>
				{else}
				<option value="{$row.name}">{$row.name_display}</option>
				{/if}
			{/if}
		{/foreach}</select>
		
		{else}<p>{t escape='off'}no IMAP folder exists.<br/>please create an folder first, to use this option.{/t}</p>
		{/if}
		</td>
	<tr>
	{if $p_spam_del == 1}
	<tr>
		<td valign="top">{t}delete known spam:{/t}</td>
		<td>
		<select name="del_known_spam" id="del_known_spam">
			<option value="0" onClick="cpves_sa_del_knowndisable('0')">{t}no{/t}</option>
			{if $del_known_spam == 1 }
			<option value="1" selected="selected" onClick="cpves_sa_del_knowndisable('1')" >{t}yes{/t}</option>
			{else}
			<option value="1" onClick="cpves_sa_del_knowndisable('1')">{t}yes{/t}</option>
			{/if}
			
		</select><br/>
		<input type="text" name="del_known_spam_value" id="del_known_spam_value" value="{$del_known_spam_value}"/>
		{if $del_known_spam != 1}
		<script type="text/javascript">
		cpves_sa_del_knowndisable('0');
		</script>
		{/if}
		
		</td>
	</tr>
	{/if}
	<tr>
		<td></td>
		<td>
		<input type="hidden" name="save_option" value="OK" />
		<input type="submit"  alt="#TB_inline?height=300&width=400&inlineId=myOnPageContent" title="{t}delete known spam?{/t}" class="thickbox" name="save" value="{t}save{/t}" onclick="cpves_sa_check_warning();" />
		</td>
	</tr>

	{if $spamassassin_active eq '0' }
	<script type="text/javascript">
	cpves_sa_active('0');
	</script>
	{/if}
</table>
</form>
<div id="myOnPageContent" style="display:none">
<span style="color:red;font-weight:bold;font-size:15pt;">{t}- Warning -{/t}</span><br/>
<br/>
<span style="font-weight:bold;">{t}This option is dangerous, an wrong value will delete spam and Ham!{/t}</span><br/><br/>
{t}The threshold value for the delete spam option should be twice as high as the threshold for mark spam only!{/t}
<br/><br/>
{t}spam mark threshold:{/t} <span id="sa_thresshold_value"></span><br/>
{t}spam delete threshold:{/t} <span id="sa_del_known_spam"></span><br/>
<br/>
<p style="text-align:center">
<a href="#" onClick="tb_remove();">{t}abort{/t}</a> |
<a href="#" onclick="cpves_sa_warning_ok();">{t}Yes, I will delete spam{/t}</a>
</p>
</div>