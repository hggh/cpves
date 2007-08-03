<h2>Willkommen, {$full_name}</h2>
{if $imap_folder_exits == 1 }
<h3>IMAP Ordner&uuml;bersicht:</h3><br/>
<table border="0">
<tr>
	<td valign="top" style="font-weight:bold;padding-right:20px;" >IMAP-Ordner</td>
	<td style="font-weight:bold;">Nachrichten</td>
</tr>
	{foreach key=fid from=$available_folders item=row}
<tr>
	<td valign="top" >{$row.name_display}</td>
	<td valign="top" >{$row.messages}  {if $row.unseen != 0}&nbsp;(<b>{$row.unseen}</b>){/if}</td>
</tr>
	{/foreach}
</table><br/>
{else}
<br/><br/>
{/if}
