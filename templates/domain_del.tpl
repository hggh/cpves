

{if $if_superadmin == 'y' }

{if $if_del_ok == 'n' }

{if $if_no_data != 'y' }
<table >
<tr>
 <td style="width: 110px;">eMailadressen:</td>
</tr>
{section name=row loop=$table_data}
<tr style="background-color:{cycle values=#rcolor#}" >
 <td>{$table_data[row].email}</a></td>
</tr>
{/section}
</table>
{else}
<div style="text-align:center;color:blue;">
Keine eMailadressen unter dieser Domain gefunden!</div>
{/if}
<br/>
<div style="text-align:center">
<span style="color:red">Soll diese Domain wirklich gel&ouml;scht werden?</span>
<br/>
<form action="domain_del.php" method="post">
<input type="hidden" name="id" value="{$id}"/>
<input type="hidden" name="state" value="delete"/>
<input type="hidden" name="del_ok" value="y"/>
<input type="submit" class="in_1" name="del" value="L&ouml;schen"/>
</form>
</div>
{else}
<div style="text-align:center;color:blue;">Domain wird gel&ouml;scht!</div><br/>
<meta http-equiv="refresh" content="2; URL=./index.php">
{/if}


{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}


