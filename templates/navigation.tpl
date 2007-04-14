<div id="leftside">
<h1>Menu</h1>
<p>
<a class="nav active" href="index.php?user=n">&Uuml;bersicht</a>
{if $if_domain_view == 'y' }
	<a class="nav sub" href="?module=domain_view&#038;did={$did}">Domainansicht</a>
	<a class="nav sub" href="?module=email_add&#038;did={$did}">Neue eMailadresse</a>
	<a class="nav sub" href="?module=forward_add&#038;did={$did}">Neue Weiterleitung</a>
	{if $if_listings == 'y' }
	<a class="nav sub" href="?module=list_add&#038;did={$did}">Neue Liste</a>
	{/if}
{/if}
{if $if_superadmin eq 'y' }
    <a class="nav" href="?module=sadmin_passwd">Passwort &#228;ndern</a>
{/if}
{if $if_admin eq 'y'  }
	<a class="nav" href="index.php?user=y">Pers&ouml;nliche Einstellungen</a>
{/if}
{if $if_superadmin != 'y' && $menu_user_open == 'y' }
	<a class="nav sub" href="?module=user_autores">Autoresponder</a>
	{if $if_spamassassin == '1'}
	<a class="nav sub" href="?module=user_spam">Spamfilter</a>
	{/if}
	{if $if_forwarding == '1'}
	<a class="nav sub" href="?module=user_forward">Weiterleitung</a>
	{/if}
	<a class="nav sub" href="?module=user_options">Optionen</a>
	<!-- <a class="nav sub" href="?module=user_mailfilter">Mailfilter</a> -->
	{if $p_mailarchive == 1}
	<a class="nav sub" href="?module=user_archivemail">Mailarchiv</a>
	{/if}
{/if}
{if $if_superadmin != 'y' && $if_admin !='y' && $if_login != 'y'}
	<a class="nav" href="?module=user_autores">Autoresponder</a>
	{if $if_spamassassin == '1'}
	<a class="nav" href="?module=user_spam">Spamfilter</a>
	{/if}
	{if $if_forwarding == '1'}
	<a class="nav" href="?module=user_forward">Weiterleitung</a>
	{/if}
	<a class="nav" href="?module=user_options">Optionen</a>
	<!-- <a class="nav" href="?module=user_mailfilter">Mailfilter</a> -->
	{if $p_mailarchive == 1}
	<a class="nav" href="?module=user_archivemail">Mailarchiv</a>
	{/if}
{/if}
{if $if_superadmin == 'y' }
	<a class="nav" href="?module=domain_add">Neue Domain anlegen</a>
{/if}
{if $if_manager == 'y' }
	<a class="nav" href="?module=sadmin_view">Superadmin UserManager</a>
	<a class="nav" href="?module=sadmin_add">Neuen SuperAdmin anlegen</a>
{/if}
<a class="nav" href="?module=logout">Logout</a>

</p>
</div>