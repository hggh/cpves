{if $template == "sadmin_view.tpl"}
	{t}Superadmin: user summary{/t}
{elseif $template == "sadmin_add.tpl"}
	{t}Superadmin: add user{/t}
{elseif $template == "sadmin_options.tpl"}
	{t}Superadmin: stettings{/t}
{elseif $template == "index_admin.tpl"}
	{t}Superadmin: summary{/t}
{elseif $template == "sadmin_edit.tpl" }
	{t}Superadmin: user summary{/t}
{elseif $template == "domain_add.tpl" }
	{t}Superadmin: add new domain{/t}
{elseif $template == "domain_view.tpl"}
	{$dnsname}: {t}summary{/t}
{elseif $template == "email_add.tpl"}
	{$dnsname}: {t}create new emailaddress{/t}
{elseif $template == "email_view.tpl"}
	{$full_email}: {t}edit{/t}
{elseif $template == "forward_add.tpl"}
	{$dnsname}: {t}create new forwarding{/t}
{elseif $template == "forward_catchall.tpl"}
	{$dnsname}: {$headline.catchall}
{elseif $template == "sadmin_passwd.tpl"}
	{t}change password{/t}
{elseif $template == "user_spam.tpl"}
	{$email}: {t}spamfilter{/t}
{elseif $template == "user_password.tpl" }
	{$email}: {t}password{/t}
{elseif $template == "user_fetchmail.tpl" }
	{$email}: {t}fetchmail{/t}
{elseif $template == "user_salearn.tpl"}
	{$email}: {t}learn spam/ham{/t}
{elseif $template == "user_forward.tpl"}
	{$email}: {t}forwarding{/t}
{elseif $template == "user_autores.tpl"}
	{$email}: {t}vacation{/t}
{elseif $template == "main.tpl" && $if_superadmin == '1'}
	{t}Superadmin: domain summary{/t}
{elseif $template == "main.tpl" && $if_admin == '1' && $if_user_index != 'y' }
	{t}domain summary{/t}
{elseif $template == "main.tpl" && $if_admin == '1' && $if_user_index == 'y' }
	{t}personal settings{/t}
{elseif $template == "forward_view.tpl"}
	{$forward}: {t}edit{/t}
{elseif $template == "email_del.tpl"}
	{$email}: {$labels.email_address} {t}delete{/t}
{elseif $template == "forward_del.tpl"}
	{$dnsname}: {t}delete forwarding{/t}
{elseif $template == "domain_del.tpl" && $if_del_ok == 'n'}
	{$domain}: {t}delete{/t}
{elseif $template == "domain_del.tpl" && $if_del_ok != 'n' }
	{t}delete domain{/t}
{elseif $template == "user_options.tpl" }
	{$email}: {t}settings{/t}
{elseif $template == "user_archivemail.tpl" }
	{$email}: {t}archive mails{/t}
{elseif $template == "user_mailfilter.tpl" }
	{$email}: {t}mailfilters{/t}
{elseif $template == "login.tpl" }
	{t}login{/t}
{elseif $template == "list_add.tpl" }
	{$dnsname}: {t}create new mailinglist{/t}
{elseif $template == "list_del.tpl" }
	{$dnsname}: {t}delete mailinglist{/t}
{elseif $template == "list_view.tpl" }
	{$address}: {t}edit mailinglist{/t}
{/if}