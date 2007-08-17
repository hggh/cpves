<table border="0">
	<tr>
		<td style="width:140px;">Mailfiter:</td>
		<td><form id="sadmin_mf_rebuild" method="post"><input type="hidden" id="mf_rebuild" name="mf_rebuild" value="0"/>
		<input type="submit"  alt="#TB_inline?height=300&width=400&inlineId=myOnPageContent" title="Baue alle Mailfilter neu" class="thickbox" name="mf_rebuild_save" value="Baue alle Mailfilter neu"  />
		</form></td>
	</tr>
</table>


<div id="myOnPageContent" style="display:none">
<span style="color:red;font-weight:bold;font-size:15pt;">- ACHTUNG -</span><br/>
<br/>
<span style="font-weight:none;">Diese Funktion baut alle Mailfilter neu!<br/>Falls die <b>.mailfilter</b>-Dateien von Hand angepasst wurden, werden Sie hiermit gel&ouml;scht!</span>
<br/>
<p style="text-align:center">
<a href="#" onClick="tb_remove();">Abbrechen</a> |
<a href="#" onclick="cpves_mf_rebuild_ok();">Ja, baue alle Mailfilter neu!</a>
</p>
</div>