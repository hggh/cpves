{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

{if $if_del_ok != "y" }
<table>
<tr>
 <td>Von:</td>
 <td style="text-align:right;">{$efrom}</td>
</tr>
<tr>
 <td valign="top">Nach:</td>
 <td style="text-align:right;">
 {section name=row loop=$forwards}
 {$forwards[row].etosingle}<br/>
 {/section}
 </td>
</tr>
<tr>
 <td colspan="2" style="color:red;">Soll diese Weiterleitung gel&ouml;scht werden?</td>
</tr>
<tr>
 <td colspan="2"><form action="?module=forward_del&#038;did={$did}&#38;id={$id}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" name="submit" value="L&ouml;schen" />
</form></td>
</tr>
</table>


<br/>
{else}
{if $if_error_postmaster eq 'y' }
<a href="?module=domain_view&#038;did={$did}">Zur&uuml;ck zur &Uuml;bersicht</a>
{else}
<div style="color:blue;">Weiterleitung wurde gel&ouml;scht!<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{/if}
<br/>
{/if}

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}