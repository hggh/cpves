{if $if_superadmin == '1' or $if_admin == '1'and $access_domain }

{if $if_del_ok != "y" }
<table>
<tr>
 <td>{t}from:{/t}</td>
 <td style="text-align:right;">{$efrom}</td>
</tr>
<tr>
 <td valign="top">{t}forward to:{/t}</td>
 <td style="text-align:right;">
 {section name=row loop=$forwards}
 {$forwards[row].etosingle}<br/>
 {/section}
 </td>
</tr>
<tr>
 <td colspan="2" style="color:red;">{t}Do you want to delete this forwarding?{/t}</td>
</tr>
<tr>
 <td colspan="2"><form action="?module=forward_del&#038;did={$did}&#38;id={$id}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" name="submit" value="{t}delete{/t}" />
</form></td>
</tr>
</table>


<br/>
{else}
{if $if_error_postmaster eq 'y' }
<a href="?module=domain_view&#038;did={$did}">{t}back to summary{/t}</a>
{else}
<div style="color:blue;">{t}forwarding was deleted{/t}<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{/if}
<br/>
{/if}

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}