{if $if_email_saved == 'y'}
{t}emailaddress created.{/t}
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{elseif $if_catchall_saved == 'y' }
{t}Catchall entry saved.{/t}
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{elseif $if_forward_saved == 'y'}
{t}forwarding created.{/t}
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{elseif $if_sadmin_created == 'y'}
{t}superadmin created.{/t}
<meta http-equiv="refresh" content="1; URL=?module=sadmin_view">
{elseif $if_password_changed == 'y'}
{t}password changed.{/t}
{elseif $if_email_data_saved == 'y'}
{t}saved emailaddress.{/t}
{elseif $if_list_created == 'y'}
Mailingliste wurde erfolgreich angelegt.
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{elseif $if_sadmin_saved == 'y'}
{t}superadmin changed.{/t}
<meta http-equiv="refresh" content="1; URL=?module=sadmin_view">
{elseif $if_mf_rebuild == 'y' }
{t}rebuild all mailfilters.{/t}
{elseif $if_mailarchive_saved == 'y'}
{t}changes are saved.{/t}
{elseif $if_salearn_saved == 'y'}
{t}changes are saved.{/t}
{/if}
