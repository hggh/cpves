function forwardadd_fillform() {
	var fwd = document.forms[0].to.value;
	if ( fwd == "" ) {
		document.forms[0].to.value=document.forms[0].mail.options[document.forms[0].mail.selectedIndex].text;
	}
	if (fwd.search('@') >= 1) {
		reg = new RegExp(',$');
		if (reg.test(fwd)) {
			document.forms[0].to.value=fwd + '\n' + document.forms[0].mail.options[document.forms[0].mail.selectedIndex].text;
		}
		else {
			document.forms[0].to.value=fwd +',\n'+document.forms[0].mail.options[document.forms[0].mail.selectedIndex].text;
		}
	}
}

function armail_check_both(a) {
	var c = document.getElementById('checkboth' +a).checked;
	document.getElementById('armail_folder_month'+a).checked=c;
	document.getElementById('armail_folder_year' +a).checked=c;
}
function cpves_autores_field(c) {
	document.getElementById('autores_subject').disabled=c;
	document.getElementById('autores_msg').disabled=c;
	document.getElementById('autores_datedisable_active').disabled=c;
	document.getElementById('autores_datedisable_date').disabled=c;
	document.getElementById('autores_datedisable_time').disabled=c;
	document.getElementById('autores_datedisable_submit').disabled=c;
	document.getElementById('autores_valtos_active_off').disabled=c;
	document.getElementById('autores_valtos_active_on').disabled=c;
	document.getElementById('autores_valtos_data').disabled=c;
	document.getElementById('autores_valtos_del').disabled=c;
	document.getElementById('autores_valtos_add_data').disabled=c;
	document.getElementById('autores_valtos_add_submit').disabled=c;
}
function cpves_autores_datedisable(c) {
	document.getElementById('autores_datedisable_date').disabled=c;
	document.getElementById('autores_datedisable_time').disabled=c;
}
function cpves_autores_valtos(c) {
	document.getElementById('autores_valtos_data').disabled=c;
	document.getElementById('autores_valtos_del').disabled=c;
	document.getElementById('autores_valtos_add_data').disabled=c;
	document.getElementById('autores_valtos_add_submit').disabled=c;
}
function cpves_sa_active(a) { 
	if (a == 1 ) {
		document.getElementById('spamassassin_threshold').disabled='';
		document.getElementById('spamassassin_subject_header').disabled='';
		document.getElementById('del_known_spam').disabled='';
		document.getElementById('del_known_spam_value').disabled='';
		document.getElementById('bogofilter_active').disabled='';
	}
	else {
		document.getElementById('spamassassin_threshold').disabled=true;
		document.getElementById('spamassassin_subject_header').disabled=true;
		document.getElementById('del_known_spam').disabled=true;
		document.getElementById('del_known_spam_value').disabled=true;
		document.getElementById('bogofilter_active').disabled=true;
	}
}
function cpves_sa_del_knowndisable(a) {
	if (a == 1) {
		document.getElementById('del_known_spam_value').disabled='';
	}
	else {
		document.getElementById('del_known_spam_value').disabled=true;
	}
}
function cpves_sa_warning_ok() {
                document.getElementById('sa_form').submit();
		tb_remove();
}
function cpves_mf_rebuild_ok() {
		document.getElementById('mf_rebuild').value="1";
		document.getElementById('sadmin_mf_rebuild').submit();
		tb_remove();
}
function cpves_update_sa_warning() {
	var neu=document.getElementById('spamassassin_threshold').value;
	document.getElementById('sa_thresshold_value').innerHTML=neu;
	neu=document.getElementById('del_known_spam_value').value;
	document.getElementById('sa_del_known_spam').innerHTML=neu;
}
function cpves_sa_check_warning() {
	if (document.getElementById('del_known_spam').value == 0 || document.getElementById('spamassassin_active').value == 0 ) {
		cpves_check_state=0;
		document.getElementById('sa_form').submit();
	}
	cpves_update_sa_warning();
}