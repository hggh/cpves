{assign var='if_email_saved' value=$if_email_saved|default:'n'}
{assign var='if_catchall_saved' value=$if_catchall_saved|default:'n'}
{assign var='if_forward_saved' value=$if_forward_saved|default:'n'}
{assign var='if_sadmin_created' value=$if_sadmin_created|default:'n'}
{assign var='if_password_changed' value=$if_password_changed|default:'n'}
{assign var='if_email_data_saved' value=$if_email_data_saved|default:'n'}
{assign var='if_sadmin_saved' value=$if_sadmin_saved|default:'n'}
{assign var='if_mf_rebuild' value=$if_mf_rebuild|default:'n'}
{assign var='if_mailarchive_saved' value=$if_mailarchive_saved|default:'n'}
{assign var='if_salearn_saved' value=$if_salearn_saved|default:'n'}
{assign var='domain_forward_saved' value=$domain_forward_saved|default:'n'}
{assign var='if_list_created' value=$if_list_created|default:'n'}
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
{elseif $domain_forward_saved =='y'}
{t}the domain forward was saved.{/t}<br>
{t}you will be forwarded to domain overview{/t}
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
{/if}
