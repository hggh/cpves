{if $if_superadmin == '1' or $if_admin == '1' and $access_domain }

{if $if_del_ok != "y" }
<div style="color:red;">
{t 1=$email}Should the emailaddress %1 really deleted?{/t}<br/><br/>
</div>
<form action="?module=email_del&#038;id={$id}&#038;did={$did}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" name="submit" value="{t}delete{/t}" />
</form>
<br/>
{else}
<div style="color:blue;">{t}emailaddress is deleted!{/t}<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
<br/>
{/if}

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}


