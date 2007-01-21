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
{/if}