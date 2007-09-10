<table border="0">
	<tr>
		<td style="width:140px;">{t}mailfilter{/t}:</td>
		<td><form id="sadmin_mf_rebuild" method="post"><input type="hidden" id="mf_rebuild" name="mf_rebuild" value="0"/>
		<input type="submit"  alt="#TB_inline?height=300&width=400&inlineId=myOnPageContent" title="{t}rebuild all mailfilters{/t}" class="thickbox" name="mf_rebuild_save" value="{t}rebuild all mailfilters{/t}"  />
		</form></td>
	</tr>
<tr>
	<td>{t}webinterface language{/t}:</td>
	<td><form action="" method="post"><select name="web_lang">
		<option value="en_US">en_US</option>
		{foreach item=row from=$table_lang}
			{if $row.name == $web_lang }
			<option value="{$row.name}" selected="selected" >{$row.name}</option>
			{else}
			<option value="{$row.name}"  >{$row.name}</option>
			{/if}
		{/foreach}
	</select> <input type="submit" name="web_lang_submit" value="{t}save{/t}"/>
	</form></td>
</tr>
</table>


<div id="myOnPageContent" style="display:none">
<span style="color:red;font-weight:bold;font-size:15pt;">{t}- Warning -{/t}</span><br/>
<br/>
<span style="font-weight:none;">{t escape='off'}This function rebuilds all mailfilters!<br>If you changed some filters by hand, it will be deleted!{/t}</span>
<br/>
<p style="text-align:center">
<a href="#" onClick="tb_remove();">{t}abort{/t}</a> |
<a href="#" onclick="cpves_mf_rebuild_ok();">{t}Yes, rebuild all filters{/t}</a>
</p>
</div>