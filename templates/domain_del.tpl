{if $if_superadmin == '1' }

{if $if_del_ok == 'n' }

{if $if_no_data && $if_no_data != 'y' }
<table >
<tr>
 <td style="width:110px;font-weight:bold;">{t}emailaddresses{/t}:</td>
</tr>
{section name=row loop=$table_data}
<tr style="background-color:{cycle values=#rcolor#}" >
 <td style="padding-left:10px;">{$table_data[row].email}</a></td>
</tr>
{/section}
</table>
{else}
<div style="color:blue;">
{t}no emailaddresses exits within this domain{/t}</div>
{/if}
<br/>
<div style="text-align:left">
<div style="color:red;margin-bottom:10px;">{t}Should this domain really deleted?{/t}</div>
<form action="?module=domain_del" method="post">
<input type="hidden" name="did" value="{$did}"/>
<input type="hidden" name="state" value="delete"/>
<input type="hidden" name="del_ok" value="y"/>
<input type="submit" name="del" value="{t}Delete{/t}"/>
</form>
</div>
{else}
<div style="color:blue;">{t}delete domain...{/t}</div><br/>
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}