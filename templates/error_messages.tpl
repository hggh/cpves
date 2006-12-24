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
{/if}
