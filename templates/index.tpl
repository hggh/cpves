

{if $if_user_index == 'y' }
{include file="user_index.tpl"}
{elseif $if_superadmin == 'y' and $if_ad_user != 'y' }
{include file="index_sadmin.tpl"}
{elseif $if_admin == 'y' and $if_ad_user != 'y' }
{include file="index_admin.tpl"}
{/if}


