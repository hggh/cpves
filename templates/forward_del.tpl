

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
 <td colspan="2"><form action="forward_del.php?domainid={$domainid}&#38;id={$id}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" class="in_1" name="submit" value="L&ouml;schen" />
</form></td>
</tr>
</table>


<br/>
{else}
{if $if_postmaster eq 'y' }
<div style="color:red;">Postmaster Weiterleitung kann nicht gel&ouml;scht werden!</div>
{else}
<div style="color:blue;">Weiterleitung wurde gel&ouml;scht!<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$domainid}">
{/if}
<br/>
{/if}

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}


