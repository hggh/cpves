{if $if_error_postmaster == 'y' }
Postmaster-Weiterleitung kann nicht gel&ouml;scht oder deaktiviert werden!
{elseif $if_error_domain_exits == 'y' }
Domain im Mailsystem schon vorhanden!
{elseif $if_error_email_exits == 'y' }
E-Mailadresse schon vorhanden!
{elseif $if_error_email_max_reached == 'y' }
Maximale Anzahl an E-Mailadressen erreicht, es k&ouml;nnen keine weiteren E-Mailadressen angelegt werden!<br/> - Bitte wenden sie sich an Ihren Administrator! -
{elseif $if_error_missing_input == 'y' }
Fehlerhafte Eingabe!
{elseif $if_error_password_long == 'y' }
Passwort muss zwischen 3 und {$max_passwd_len} Zeichen lang sein! 
{elseif $if_error_password_empty == 'y'}
Passwort darf nicht leer sein!
{elseif $if_error_password_old_wrong == 'y'}
Altes Passwort falsch!
{elseif $if_error_sadmim_exits == 'y'}
Superadmin mit diesem Benutzernamen schon vorhanden!
{elseif $if_error_autores_subject_empty == 'y'}
Betreff des Autoresponders darf nicht leer sein!
{elseif $if_error_autores_msg_empty == 'y'}
Nachricht des Autoresponders darf nicht leer sein! 
{elseif $if_error_autores_subject_to_long == 'y'}
Betreff des Autoresponders ist zu lang!
{elseif $if_error_autores_send_times == 'y'}
Fehler: Sende Autoresponder bis! INTERNAL ERROR!
{elseif $if_email_valid == 'y'}
E-Mailadresse ist nicht konform.
{elseif $if_error_forwds_max_reached == 'y'}
Maximale Anzahl an Weiterleitungen erreicht, es k&ouml;nnen keine weiteren Weiterleitungen angelegt werden!<br/> - Bitte wenden sie sich an Ihren Administrator! -
{elseif $if_error_login_failed == 'y' }
Benutzername oder Passwort falsch
{elseif $if_sadmin_wrong_char == 'y' }
Benutzername enthaelt ung&uuml;ltige Zeichen!<br/>
Benutzername darf nur Buchstaben und Zahlen enthalten!<br/>
Benutzername darf nicht l&auml;nger als 8 Zeichen umfassen!
{elseif $if_new_passwd_not_same == 'y'}
Neue Passw&ouml;rter stimmen nicht &uuml;berein!
{elseif $if_submit_email_wrong == 'y' }
E-Mailadresse ist ung&uuml;ltig
{elseif $if_forward_all_del == 'y' }
Es wurden alle Adressen der Weiterleitung<br/> zum L&ouml;schen markiert.<br/>
Bitte <a href="?module=forward_del&#038;did={$domainid}&#038;id={$id}">hier klicken</a> um die Weiterleitung zu l&ouml;schen!
{elseif $if_wrong_sa_threshold == 'y'}
Falsches Format f&uuml;r den Spamassassin-threshold!
{elseif $if_wrong_sa_subjecttag == 'y' }
Die Betreffszeile darf nicht l&auml;nger als 15 Zeichen sein!
{elseif $if_error_autores_date_wrong == 'y'}
Das Datum hat das falsche Format! (DD.MM.JJJJ)
{elseif $if_error_autores_time_wrong == 'y'}
Die Uhrzeit hat das falsche Format! (HH:MM:SS)
{elseif $if_error_autores_disable_in_past == 'y' }
Das angegebene Datum + Uhrzeit liegt in der Vergangenheit!
{elseif $if_error_sa_disabled_enable_bogofilter == 'y' }
Bogofilter ben&ouml;tigt Spamassassin!<br/>
Bitte erst Spamassassin freischalten.
{elseif $if_error_sa_disable_enable_sa_learn == 'y' }
Spam/Ham lernbar ben&ouml;tigt Spamassassin!<br/>
Bitte erst Spamassassin freischalten.
{elseif $if_error_sa_disable_enable_sa_wb_listing == 'y' }
Whitelisting ben&ouml;tigt Spamassassin!<br/>
Bitte erst Spamassassin freischalten.
{elseif $sa_whitelist_data_add_empty == 'y' }
Whitelistfeld darf nicht leer sein!
{elseif $sa_whitelist_data_add_wrong == 'y'}
Whitelistfeld enth&auml;lt ung&uuml;ltige Zeichen!
{elseif $if_wrong_del_known_spam_value == 'y'}
Falsches Format f&uuml;r die Option "L&ouml;sche erkannten Spam"!<br/>
Format: XX.Y (z.B. 12.3)
{elseif $if_wrong_del_known_spam_value_lower == 'y'}
Option "L&ouml;sche erkannten Spam"<br/> ist niedriger als "Markiere Nachricht" als Spam!
{elseif $if_error_forwardaddr_valid == 'y' }
Weiterleitungsadresse ist nicht konform!
{elseif $if_error_sa_disable_enable_spam_del == 'y' } 
Diese Option ben&ouml;tigt Spamassassin.<br/>
Bitte erst Spamassassin aktivieren, danach diese Option!
{elseif $if_error_artime == 'y'}
Archivieren nach n Tagen ist entweder leer oder ung&uuml;ltig!<br/>
Bitte nur Zahlen verwenden.
{/if}
