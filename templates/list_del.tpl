{if ($if_superadmin == 1 or $if_admin == '1' and $access_domain eq 'true') and $access_domain_mlists == 1 and $config.mailinglists == '1'}
{if $if_del_ok != "y" }
<table>
<tr>
 <td>{t}list{/t}:</td>
 <td style="text-align:right;">{$address}</td>
</tr>
<tr>
 <td valign="top">{t}recipients{/t}:</td>
 <td style="text-align:right;">
 {foreach item=row from=$recps}
 {$row}<br/>
 {foreachelse}
{t}no recipients found{/t}
 {/foreach}
 </td>
</tr>
<tr>
 <td colspan="2" style="color:red;">{t}Do you want to delete this list?{/t}</td>
</tr>
<tr>
 <td colspan="2"><form action="?module=list_del&#038;did={$did}&#38;id={$id}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" name="submit" value="{t}delete{/t}" />
</form></td>
</tr>
</table>

<br/>
{else}
<div style="color:blue;">{t}mailinglist deleted!{/t}<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{/if}
<br/>

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}
