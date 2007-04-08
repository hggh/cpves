<table>
  <tr>
    <td>Domain</td>
    <td>E-Mailadressen</td>
    <td>Weiterleitungen</td>

  </tr>
  {section name=row loop=$table_data}
  <tr bgcolor="{cycle values="$color1,$color2"}">
   <td style="padding-left:3px;">
   	<a href="?module=domain_view&#038;did={$table_data[row].id}">{$table_data[row].dnsname}</a></td>
   <td style="text-align:right;">{$table_data[row].count_email}</td>
   <td style="text-align:right;">{$table_data[row].count_forward}</td>
  </tr>
  
  {/section}
</table>
