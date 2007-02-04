{if $if_email_saved == 'y'}
E-Mailadresse angelegt.
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$id}">
{elseif $if_catchall_saved == 'y' }
Catchall wurde gespeichert.
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$id}">
{elseif $if_forward_saved == 'y'}
Weiterleitung angelegt.
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$id}">
{elseif $if_sadmin_created == 'y'}
Superadmin wurde angelegt.
<meta http-equiv="refresh" content="1; URL=./sadmin_view.php">
{elseif $if_password_changed == 'y'}
Passwort erfolgreich ge&auml;ndert.
{elseif $if_email_data_saved == 'y'}
Daten der E-Mailadresse erfolgreicht gespeichert.
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$domainid}">
{elseif $if_list_created == 'y'}
Mailingliste wurde erfolgreich angelegt.
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$id}">
{/if}