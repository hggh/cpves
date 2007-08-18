{if $if_user_index == 'y' }
{include file="user_index.tpl"}
{elseif $if_superadmin == 1 and $if_ad_user != 'y' }
{include file="index_sadmin.tpl"}
{elseif $if_admin == '1' and $if_ad_user != 'y' }
{include file="index_admin.tpl"}
{/if}