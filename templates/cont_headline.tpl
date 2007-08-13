{if $template == "sadmin_view.tpl"}
	{$headline.sadmin_user_overview}
{elseif $template == "sadmin_add.tpl"}
	{$headline.sadmin_user_add}
{elseif $template == "sadmin_options.tpl"}
	{$headline.sadmin_options}
{elseif $template == "index_admin.tpl"}
	{$headline.sadmin_overview}
{elseif $template == "sadmin_edit.tpl" }
	{$headline.sadmin_user_overview}
{elseif $template == "domain_add.tpl" }
	{$headline.sadmin_domain_add}
{elseif $template == "domain_view.tpl"}
	{$dnsname}: {$headline.sadmin_domain_overview}
{elseif $template == "email_add.tpl"}
	{$dnsname}: {$labels.new_mailaddress_add}
{elseif $template == "email_view.tpl"}
	{$full_email}: {$labels.edit}
{elseif $template == "forward_add.tpl"}
	{$dnsname}: {$labels.new_forwarding_add}
{elseif $template == "forward_catchall.tpl"}
	{$dnsname}: {$headline.catchall}
{elseif $template == "sadmin_passwd.tpl"}
	{$labels.password_change}
{elseif $template == "user_spam.tpl"}
	{$email}: {$labels.spamfilter}
{elseif $template == "user_password.tpl" }
	{$email}: {$labels.password}
{elseif $template == "user_fetchmail.tpl" }
	{$email}: Fetchmail
{elseif $template == "user_salearn.tpl"}
	{$email}: {$labels.sa_learn_title}
{elseif $template == "user_forward.tpl"}
	{$email}: {$labels.forwarding}
{elseif $template == "user_autores.tpl"}
	{$email}: {$labels.autoresponder}
{elseif $template == "main.tpl" && $if_superadmin == 'y'}
	{$headline.sadmin_domain_overview}
{elseif $template == "main.tpl" && $if_admin == 'y' && $if_user_index != 'y' }
	{$headline.domain_overview}
{elseif $template == "main.tpl" && $if_admin == 'y' && $if_user_index == 'y' }
	{$labels.personal_settings}
{elseif $template == "forward_view.tpl"}
	{$forward}: {$labels.edit}
{elseif $template == "email_del.tpl"}
	{$email}: {$labels.email_address} {$labels.del} 
{elseif $template == "forward_del.tpl"}
	{$dnsname}: {$labels.forwarding} {$labels.del}
{elseif $template == "domain_del.tpl" && $if_del_ok == 'n'}
	{$domain}: {$labels.del}
{elseif $template == "domain_del.tpl" && $if_del_ok != 'n' }
	{$labels.domain_del}
{elseif $template == "user_options.tpl" }
	{$email}: {$labels.settings}
{elseif $template == "user_archivemail.tpl" }
	{$email}: {$labels.mailarchive}
{elseif $template == "user_mailfilter.tpl" }
	{$email}: {$labels.mailfilter}
{elseif $template == "login.tpl" }
	{$labels.login}
{elseif $template == "list_add.tpl" }
	{$dnsname}: {$labels.mailing_create}
{elseif $template == "list_del.tpl" }
	{$dnsname}: {$labels.mailing_del}
{elseif $template == "list_view.tpl" }
	{$address}: {$labels.mailing_edit}
{/if}