

{if $if_superadmin eq 'y' or $if_admin eq 'y'and $access_domain }

{if $if_del_ok != "y" }
<div style="color:red;">
Soll die eMail Adresse {$email} wirklich gel&ouml;scht werden?<br/><br/>
</div>
<form action="email_del.php?id={$id}&#038;domainid={$domainid}" method="post">
<input type="hidden" name="del_ok" value="true"/>
<input type="submit" class="in_1" name="submit" value="L&ouml;schen" />
</form>
<br/>
{else}
<div style="color:blue;">eMailadresse wurde gel&ouml;scht!<br/><br/></div>
<meta http-equiv="refresh" content="1; URL=./domain_view.php?id={$domainid}">
<br/>
{/if}

{else}
<meta http-equiv="refresh" content="1; URL=./index.php">
{/if}


