

{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

{if $if_del_ok != "y" }
<div style="color:red;">
Soll die eMail Adresse {$email} wirklich gel&ouml;scht werden?<br/><br/>
</div>
<form action="?module=email_del&#038;id={$id}&#038;did={$did}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" name="submit" value="L&ouml;schen" />
</form>
<br/>
{else}
<div style="color:blue;">eMailadresse wurde gel&ouml;scht!<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=?module=domain_view&#038;did={$did}">
<br/>
{/if}

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}


