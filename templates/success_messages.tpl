{if $if_email_saved == 'y'}
E-Mailadresse angelegt.
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{elseif $if_catchall_saved == 'y' }
Catchall wurde gespeichert.
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{elseif $if_forward_saved == 'y'}
Weiterleitung angelegt.
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{elseif $if_sadmin_created == 'y'}
Superadmin wurde angelegt.
<meta http-equiv="refresh" content="1; URL=?module=sadmin_view">
{elseif $if_password_changed == 'y'}
Passwort erfolgreich ge&auml;ndert.
{elseif $if_email_data_saved == 'y'}
Daten der E-Mailadresse erfolgreich gespeichert.
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{elseif $if_list_created == 'y'}
Mailingliste wurde erfolgreich angelegt.
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{elseif $if_sadmin_saved == 'y'}
Superadmin erfolgreich ge&auml;ndert.
<meta http-equiv="refresh" content="1; URL=?module=sadmin_view">
{elseif $if_mf_rebuild == 'y' }
Die Mailfilter werden neu gebaut.
{/if}
