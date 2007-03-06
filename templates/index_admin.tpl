<table>
  <tr>
    <td>Domain</td>
    <td>eMail-Adressen</td>
    <td>Weiterleitungen</td>

  </tr>
  {section name=row loop=$table_data}
  <tr bgcolor="{cycle values="$color1,$color2"}">
   <td><a href="?module=domain_view&#038;did={$table_data[row].id}">{$table_data[row].dnsname}</a></td>
   <td>{$table_data[row].count_email}</td>
   <td>{$table_data[row].count_forward}</td>
  </tr>
  
  {/section}
</table>