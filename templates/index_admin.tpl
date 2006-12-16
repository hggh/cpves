<table>
  <tr>
    <td>Domain</td>
    <td>eMail-Adressen</td>
    <td>Weiterleitungen</td>

  </tr>
  {section name=row loop=$table_data}
  <tr>
   <td><a href="domain_view.php?id={$table_data[row].id}">{$table_data[row].dnsname}</a></td>
   <td>{$table_data[row].count_email}</td>
   <td>{$table_data[row].count_forward}</td>
  </tr>
  
  {/section}
</table>


