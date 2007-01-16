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
{/if}