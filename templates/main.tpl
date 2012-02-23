{assign var='if_user_index' value=$if_user_index|default:'n'}
{assign var='if_superadmin' value=$if_superadmin|default:'n'}
{assign var='if_ad_user' value=$if_ad_user|default:'n'}
{assign var='if_admin' value=$if_admin|default:'n'}
{if $if_user_index == 'y'}
{include file="user_index.tpl"}
{elseif $if_superadmin == 1 and $if_ad_user != 'y'}
{include file="index_sadmin.tpl"}
{elseif $if_admin == '1' and $if_ad_user != 'y'}
{include file="index_admin.tpl"}
{/if}
