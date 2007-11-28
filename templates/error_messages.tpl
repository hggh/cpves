{if $if_error_postmaster == 'y' }
{t}you can not delete or deactivate the postmaster forward!{/t}
{elseif $if_error_domain_exits == 'y' }
{t}domain already exists!{/t}
{elseif $if_error_domain_wrong == 'y'}
{t}domainname contains illegal characters!{/t}
{elseif $if_error_email_exits == 'y' }
{t}emailaddress already exists!{/t}
{elseif $if_error_email_max_reached == 'y' }
{t}You have reached the max emailaddresses.{/t}<br/>
{t}Please contact your admin!{/t}
{elseif $if_error_missing_input == 'y' }
{t}missing input{/t}
{elseif $if_error_password_long == 'y' }
{t}password to short.{/t}<br/>
{t 1=$max_passwd_len}password should contain three between %1 characters{/t}
{elseif $if_error_password_empty == 'y'}
{t}password is empty!{/t}
{elseif $if_error_to_domain_not_exists == 'y'}
{t}the selected domains does not exists!{/t}
{elseif $if_error_domain_forwarded_already == 'y'}
{t}the domain is already forwarded to another domain.{/t}<br/>
{t}please return to domain overview!{/t}
{elseif $if_error_password_old_wrong == 'y'}
{t}old password is wrong!{/t}
{elseif $if_error_sadmim_exits == 'y'}
{t}superadmin already exists!{/t}
{elseif $if_error_autores_subject_empty == 'y'}
{t}vacation subject ist empty!{/t}
{elseif $if_error_autores_msg_empty == 'y'}
{t}vacation message is empty!{/t}
{elseif $if_error_autores_subject_to_long == 'y'}
{t}vacaction subject is to long!{/t}
{elseif $if_error_autores_send_times == 'y'}
{t}Internal vacaction ERROR!{/t}
{elseif $if_email_valid == 'y'}
{t}emailaddress is not valid!{/t}
{elseif $if_error_forwds_max_reached == 'y'}
{t}You have reached the max forwardings.{/t}<br/>
{t}Please contact your admin!{/t}
{elseif $if_error_login_failed == 'y' }
{t}username or password wrong!{/t}
{elseif $if_sadmin_wrong_char == 'y' }
{t}username not valid.{/t}<br/>
{t}username should contain only chars and numbers.{/t}<br/>
{t}username should only contain 8 chars!{/t}
{elseif $if_new_passwd_not_same == 'y'}
{t}new passwords does not match!{/t}
{elseif $if_illegal_sa_subjecttag == 'y'}
{t}subject contains illegal characters!{/t}
{elseif $if_submit_email_wrong == 'y' }
{t}emailaddress is not valid!{/t}
{elseif $if_forward_all_del == 'y' }
{t escape='off'}all addresses of this forwarding</br>selected to delete.<br/>{/t}
{t escape='off' 1=$id 2=$domainid}Please <a href="?module=forward_del&#038;did=%2&#038;id=%1">click here</a> to delete the forwarding!{/t}
{elseif $if_wrong_sa_threshold == 'y'}
{t}wrong input value for spamassassin threshold!{/t}
{elseif $if_wrong_sa_subjecttag == 'y' }
{t}subject should only be 15 chars long!{/t}
{elseif $if_error_autores_date_wrong == 'y'}
{t}wrong date format! (DD.MM.JJJJ){/t}
{elseif $if_error_autores_time_wrong == 'y'}
{t}wrong time format! (HH:MM:SS){/t}
{elseif $if_error_autores_disable_in_past == 'y' }
{t}date and time are in the past!{/t}
{elseif $if_error_sa_disabled_enable_bogofilter == 'y' }
{t}bogofilter needs spamassassin!{/t}<br/>
{t}Please enable spamassassin first!{/t}
{elseif $if_error_sa_disable_enable_sa_learn == 'y' }
{t}ham/spam learning needs spamassassin!{/t}<br/>
{t}Please enable spamassassin first!{/t}
{elseif $if_error_sa_disable_enable_sa_wb_listing == 'y' }
{t}whitelisting needs spamasassin!{/t}<br/>
{t}Please enable spamassassin first!{/t}
{elseif $sa_whitelist_data_add_empty == 'y' }
{t}whitelistfild is empty!{/t}
{elseif $sa_whitelist_data_add_wrong == 'y'}
{t}wrong input value for the whitelist!{/t}
{elseif $if_wrong_del_known_spam_value == 'y'}
{t}wrong format for the delete spam option!{/t}<br/>
{t}correct: XX.Y (e.x. 12.3){/t}
{elseif $if_wrong_del_known_spam_value_lower == 'y'}
{t}the value "delete spam" is to low!{/t}
{elseif $if_error_forwardaddr_valid == 'y' }
{t}forwarding address is not valid!{/t}
{elseif $if_error_sa_disable_enable_spam_del == 'y' }
{t}del know spam needs spamassassin!{/t}<br/>
{t}Please enable spamassassin first!{/t}
{elseif $if_error_artime == 'y'}
{t}the archive after n days is wrong. Please check!{/t}
{elseif $fm_missing_error == 'y'}
{t}Please check all input fields!{/t}
Bitte alle Felder ausf&uuml;llen!
{elseif $if_xheader_empty == 'y' }
{t}Both X-Header fields are required!{/t}
{elseif $ml_email_there == 'y'}
{t}email address is already on the list!{/t}
{elseif $move_spam_active_and_spam_fwd == 1}
{t}move known spam and forward known spam is active!{/t}<br/>
{t}You could either use move or forward option!{/t}
{elseif $if_error_other_domains_points_to_me == 'y'}
{t 1=$dnsname}Other domains points to %1.{/t}<br/>
{t}It's not possible to create an forward that forwards again!{/t}
{/if}
