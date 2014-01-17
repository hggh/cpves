<h2>{t 1=$full_name}Welcome to CpVES %1{/t}</h2>
{if $imap_folder_exits == 1 }
<h3>{t}IMAP folders{/t}:</h3><br/>
<table border="0">
<tr>
	<td valign="top" style="font-weight:bold;padding-right:20px;" >{t}folder{/t}</td>
	<td style="font-weight:bold;">{t}messages{/t}</td>
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
{if  $display_mb_size == 1}
{t 1=$mb_size}Your current mailbox size is %1 M.{/t}
{/if}

