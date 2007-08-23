<div id="leftside">
<h1>{t}menu{/t}</h1>
<p>
<a class="nav active" href="index.php?user=n">{t}summary{/t}</a>
{if $if_domain_view == 'y' }
	<a class="nav sub" href="?module=domain_view&#038;did={$did}">{t}domain summary{/t}</a>
	<a class="nav sub" href="?module=email_add&#038;did={$did}">{t}new emailaddress{/t}</a>
	<a class="nav sub" href="?module=forward_add&#038;did={$did}">{t}new forward{/t}</a>
	{if $if_listings == 'y' }
	<a class="nav sub" href="?module=list_add&#038;did={$did}">{t}new mailinglist{/t}</a>
	{/if}
{/if}
{if $if_superadmin == 1 }
    <a class="nav" href="?module=sadmin_passwd">{t}change password{/t}</a>
    <a class="nav" href="?module=sadmin_options">{t}settings{/t}</a>
{/if}
{if $if_admin == '1'  }
	<a class="nav" href="index.php?user=y">{t}personal settings{/t}</a>
{/if}
{if $if_superadmin != '1' && $menu_user_open == 'y' && $if_login != 'y' }
	<a class="nav sub" href="?module=user_password">{t}change password{/t}</a>
	<a class="nav sub" href="?module=user_autores">{t}vacation{/t}</a>
	{if $if_spamassassin == '1'}
	<a class="nav sub" href="?module=user_spam">{t}spamfilter{/t}</a>
	{/if}
	{if $p_sa_learn == '1' }
	<a class="nav sub" href="?module=user_salearn">{t}ham/spam learning{/t}</a>
	{/if}
	{if $if_forwarding == '1'}
	<a class="nav sub" href="?module=user_forward">{t}forwarding{/t}</a>
	{/if}
	<a class="nav sub" href="?module=user_options">{t}settings{/t}</a>
	{if $p_mailfilter == 1 }
	 <a class="nav sub" href="?module=user_mailfilter">{t}mailfilter{/t}</a>
	{/if}
	{if $p_mailarchive == 1}
	<a class="nav sub" href="?module=user_archivemail">{t}archivemail{/t}</a>
	{/if}
	{if $p_fetchmail == 1}
	<a class="nav sub" href="?module=user_fetchmail">{t}fetchmail{/t}</a>
	{/if}
{/if}
{if $if_superadmin != '1' && $if_admin !='1' && $if_login != 'y'}
	<a class="nav" href="?module=user_password">{t}change password{/t}</a>
	<a class="nav" href="?module=user_autores">{t}vacation{/t}</a>
	{if $if_spamassassin == '1'}
	<a class="nav" href="?module=user_spam">{t}spamfilter{/t}</a>
	{/if}
	{if $p_sa_learn == '1' }
	<a class="nav" href="?module=user_salearn">{t}ham/spam learing{/t}</a>
	{/if}
	{if $if_forwarding == '1'}
	<a class="nav" href="?module=user_forward">{t}forwarding{/t}</a>
	{/if}
	<a class="nav" href="?module=user_options">{t}settings{/t}</a>
	{if $p_mailfilter == 1 }
	<a class="nav" href="?module=user_mailfilter">{t}mailfilter{/t}</a>
	{/if}
	{if $p_mailarchive == 1}
	<a class="nav" href="?module=user_archivemail">{t}archivemail{/t}</a>
	{/if}
	{if $p_fetchmail == 1}
	<a class="nav" href="?module=user_fetchmail">{t}fetchmail{/t}</a>
	{/if}
{/if}
{if $if_superadmin == '1' }
	<a class="nav" href="?module=domain_add">{t}add new domain{/t}</a>
{/if}
{if $if_manager == '1' }
	<a class="nav" href="?module=sadmin_view">{t}supadmin manager{/t}</a>
	<a class="nav" href="?module=sadmin_add">{t}create new superadmin{/t}</a>
{/if}
{if $webmail_link != false }
	<a class="nav" href="{$webmail_link}">{t}webmail{/t}</a>
{/if}
{if $mailgraph_link != false && $if_superadmin == '1' }
	<a class="nav" href="{$mailgraph_link}">{t}mailstats{/t}</a>
{/if}
<a class="nav" href="?module=logout">{t}logout{/t}</a>

</p>
</div>