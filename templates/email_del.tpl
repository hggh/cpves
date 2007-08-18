{if $if_superadmin == '1' or $if_admin == '1' and $access_domain }

{if $if_del_ok != "y" }
<div style="color:red;">
{$labels.de_email_del1} {$email} {$labels.de_email_del2}<br/><br/>
</div>
<form action="?module=email_del&#038;id={$id}&#038;did={$did}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" name="submit" value="{$labels.Del}" />
</form>
<br/>
{else}
<div style="color:blue;">{$labels.ed_email_deleted}<br/><br/></div>
<!-- <meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}"> -->
<br/>
{/if}

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}


