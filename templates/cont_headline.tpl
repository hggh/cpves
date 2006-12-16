{if $template == "sadmin_view.tpl"}
	Superadmin Benutzer &Uuml;bersicht
{elseif $template == "sadmin_add.tpl"}
	Superadmin: Benutzer hinzuf&uuml;gen
{elseif $template == "index_admin.tpl"}
	Superadmin: Uebersicht
{elseif $template == "sadmin_edit.tpl" }
	Superadmin Benutzer &Uuml;bersicht
{elseif $template == "domain_add.tpl" }
	Superadmin: Neue Domain anlegen	
{elseif $template == "domain_view.tpl"}
	{$dnsname}: &Uuml;bersicht
{elseif $template == "email_add.tpl"}
	{$dnsname}: Neue eMailadresse anlegen
{elseif $template == "email_view.tpl"}
	{$full_email}: Bearbeiten
{elseif $template == "forward_add.tpl"}
	{$dnsname}: Neue Weiterleitung anlegen
{elseif $template == "forward_catchall.tpl"}
	{$dnsname}: Catchall
{elseif $template == "sadmin_passwd.tpl"}
	Passwort &auml;ndern
{elseif $template == "user_spam.tpl"}
	{$email}: Spamfilter
{elseif $template == "user_forward.tpl"}
	{$email}: Weiterleitung
{elseif $template == "user_autores.tpl"}
	{$email}: Autoresponder
{elseif $template == "index.tpl" && $if_superadmin == 'y'}
	Superadmin: Domain&uuml;bersicht
{elseif $template == "index.tpl" && $if_admin == 'y' && $if_user_index != 'y' }
	Domain&uuml;bersicht
{elseif $template == "index.tpl" && $if_admin == 'y' && $if_user_index == 'y' }
	Pers&ouml;nliche Einstellungen
{elseif $template == "forward_view.tpl"}
	{$forward}: Bearbeiten
{elseif $template == "email_del.tpl"}
	{$email}: eMailadresse l&ouml;schen 
{elseif $template == "forward_del.tpl"}
	Weiterleitung l&ouml;schen
{elseif $template == "domain_del.tpl" && $if_del_ok == 'n'}
	{$domain}: L&ouml;schen
{elseif $template == "domain_del.tpl" && $if_del_ok != 'n' }
	Domain l&ouml;schen
{elseif $template == "user_options.tpl" }
	{$email}: Einstellungen
{elseif $template == "login.tpl" }
	Login
{/if}
