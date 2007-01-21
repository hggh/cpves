<div id="leftside">
<h1>Menu</h1>
<p>
<a class="nav active" href="index.php?user=n">&Uuml;bersicht</a>
{if $if_domain_view == 'y' }
	<a class="nav sub" href="domain_view.php?id={$domain_id}">Domainansicht</a>
	<a class="nav sub" href="email_add.php?id={$domain_id}">Neue eMailadresse</a>
	<a class="nav sub" href="forward_add.php?id={$domain_id}">Neue Weiterleitung</a>
	{if $if_listings == 'y' }
	<a class="nav sub" href="list_add.php?id={$domain_id}">Neue Liste</a>
	{/if}
{/if}
{if $if_superadmin eq 'y' }
    <a class="nav" href="sadmin_passwd.php">Passwort &#228;ndern</a>
{/if}
{if $if_admin eq 'y'  }
	<a class="nav" href="index.php?user=y">Pers&ouml;nliche Einstellungen</a>
{/if}
{if $if_superadmin != 'y' && $menu_user_open == 'y' }
	<a class="nav sub" href="user_autores.php">Autoresponder</a>
	{if $if_spamassassin == '1'}
	<a class="nav sub" href="user_spam.php">Spamfilter</a>
	{/if}
	<a class="nav sub" href="user_forward.php">Weiterleitung</a>
	<a class="nav sub" href="user_options.php">Optionen</a>
{/if}
{if $if_superadmin != 'y' && $if_admin !='y' && $if_login != 'y'}
	<a class="nav" href="user_autores.php">Autoresponder</a>
	{if $if_spamassassin == '1'}
	<a class="nav" href="user_spam.php">Spamfilter</a>
	{/if}
	<a class="nav" href="user_forward.php">Weiterleitung</a>
	<a class="nav" href="user_options.php">Optionen</a>
{/if}
{if $if_superadmin == 'y' }
	<a class="nav" href="domain_add.php">Neue Domain anlegen</a>
{/if}
{if $if_manager == 'y' }
	<a class="nav" href="sadmin_view.php">Superadmin UserManager</a>
	<a class="nav" href="sadmin_add.php">Neuen SuperAdmin anlegen</a>
{/if}
<a class="nav" href="./logout.php">Logout</a>

</p>
</div>
