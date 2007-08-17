<div id="leftside">
<h1>Menu</h1>
<p>
<a class="nav active" href="index.php?user=n">{$labels.menu}</a>
{if $if_domain_view == 'y' }
	<a class="nav sub" href="?module=domain_view&#038;did={$did}">{$labels.domain_view}</a>
	<a class="nav sub" href="?module=email_add&#038;did={$did}">{$labels.new_mailaddress}</a>
	<a class="nav sub" href="?module=forward_add&#038;did={$did}">{$labels.new_forwarding}</a>
	{if $if_listings == 'y' }
	<a class="nav sub" href="?module=list_add&#038;did={$did}">{$labels.new_ml}</a>
	{/if}
{/if}
{if $if_superadmin == 1 }
    <a class="nav" href="?module=sadmin_passwd">{$labels.password_change}</a>
    <a class="nav" href="?module=sadmin_options">{$labels.options}</a>
{/if}
{if $if_admin == '1'  }
	<a class="nav" href="index.php?user=y">{$labels.personal_settings}</a>
{/if}
{if $if_superadmin != '1' && $menu_user_open == 'y' }
	<a class="nav sub" href="?module=user_password">{$labels.password_change}</a>
	<a class="nav sub" href="?module=user_autores">{$labels.autoresponder}</a>
	{if $if_spamassassin == '1'}
	<a class="nav sub" href="?module=user_spam">{$labels.spamfilter}</a>
	{/if}
	{if $p_sa_learn == '1' }
	<a class="nav sub" href="?module=user_salearn">{$labels.sa_learn}</a>
	{/if}
	{if $if_forwarding == '1'}
	<a class="nav sub" href="?module=user_forward">{$labels.email_forwarding}</a>
	{/if}
	<a class="nav sub" href="?module=user_options">{$labels.options}</a>
	{if $p_mailfilter == 1 }
	 <a class="nav sub" href="?module=user_mailfilter">Mailfilter</a>
	{/if}
	{if $p_mailarchive == 1}
	<a class="nav sub" href="?module=user_archivemail">Mailarchiv</a>
	{/if}
	{if $p_fetchmail == 1}
	<a class="nav sub" href="?module=user_fetchmail">Fetchmail</a>
	{/if}
{/if}
{if $if_superadmin != '1' && $if_admin !='1' && $if_login != 'y'}
	<a class="nav" href="?module=user_password">{$labels.password_change}</a>
	<a class="nav" href="?module=user_autores">{$labels.autoresponder}</a>
	{if $if_spamassassin == '1'}
	<a class="nav" href="?module=user_spam">{$labels.spamfilter}</a>
	{/if}
	{if $p_sa_learn == '1' }
	<a class="nav" href="?module=user_salearn">{$labels.sa_learn}</a>
	{/if}
	{if $if_forwarding == '1'}
	<a class="nav" href="?module=user_forward">{$labels.email_forwarding}</a>
	{/if}
	<a class="nav" href="?module=user_options">{$labels.options}</a>
	{if $p_mailfilter == 1 }
	<a class="nav" href="?module=user_mailfilter">Mailfilter</a>
	{/if}
	{if $p_mailarchive == 1}
	<a class="nav" href="?module=user_archivemail">Mailarchiv</a>
	{/if}
	{if $p_fetchmail == 1}
	<a class="nav" href="?module=user_fetchmail">Fetchmail</a>
	{/if}
{/if}
{if $if_superadmin == '1' }
	<a class="nav" href="?module=domain_add">{$labels.new_domain}</a>
{/if}
{if $if_manager == '1' }
	<a class="nav" href="?module=sadmin_view">{$labels.sadmin_manager}</a>
	<a class="nav" href="?module=sadmin_add">{$labels.create_new_sadmin}</a>
{/if}
{if $webmail_link != false }
	<a class="nav" href="{$webmail_link}">Webmail</a>
{/if}
{if $mailgraph_link != false && $if_superadmin == '1' }
	<a class="nav" href="{$mailgraph_link}">Mailstatistik</a>
{/if}
<a class="nav" href="?module=logout">{$labels.logout}</a>

</p>
</div>