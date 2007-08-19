#!/usr/bin/perl 
#autoresponder.pl
#Copyright (C) 2006 Jonas Genannt <jonas.genannt@brachium-system.net>
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

use strict;
use MIME::Entity;
use Email::Simple;
use Email::Find;
use DBI;
use Config::General;
my @formated_email;
my $mail_from;
my @mail_to;

my $conf = new Config::General("/etc/cpves/mail_config.conf");
my %config = $conf->getall;


$config{'db_host'} = "localhost" unless defined $config{'db_host'};
$config{'db_username'} = "mail" unless defined $config{'db_username'};
$config{'db_password'} = "" unless defined $config{'db_password'};
$config{'db_name'} = "mail_system" unless defined $config{'db_name'};
$config{'vmail_home'} = "/home/vmail/" unless defined $config{'vmail_home'};
$config{'vmail_safe'} = "/home/vmail_backup" unless defined $config{'vmail_safe'};


my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=".$config{'db_host'};


my @emailfrom;
while (<stdin>)
{
	push(@emailfrom, $_);	
}

my $mail = Email::Simple->new(join('',@emailfrom));
undef (@emailfrom);

if ($mail->header("X-Spam-Flag") =~ m/yes/i)
{
	#exit, because of SPAM
	exit(0);
}
if ($mail->header("X-Bogosity") =~m/Spam, tests=bogofilter,/i)
{
	#exit, because of SPAM
	exit(0);
}
if ($mail->header("X-Loop") =~ m/no/i || $mail->header("X-No-Loop") =~ m/yes/i) {
	#exit, because of X-Loop Header in Mail
	exit(0);
}
if ($mail->as_string =~ m/^List-/mg || $mail->as_string=~ m/^X-Mailinglist/mg )
{
	#exit, because of ML's
	exit(0);
}

my $efinder = Email::Find->new(sub {
		my ($email,$orig_email) = @_;
		push (@formated_email, lc($email->format));
		return $orig_email;
	});

$efinder->find(\$mail->header("From"));
if ((scalar (@formated_email)) ne 1) {
	#end, because of no valid from email!
	exit(0);
}
$mail_from = shift(@formated_email);
undef(@formated_email);

if ($mail_from =~ m/postmaster/gi || $mail_from =~ m/MAILER-DAEMON/gi )
{
	#exit, because of postmaster email#
	exit(0);
}

$efinder->find(\$mail->header("To"));
if (scalar(@formated_email) le 0 ) {
	#end, because of no valid to email!
	exit(0);
}
@mail_to=@formated_email;

#Now check if autoresponder is enabled
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});
my $sql=sprintf("SELECT email,times FROM autoresponder WHERE email=%s AND active='y'",
	$dbh->quote($ARGV[0]));
my $sth = $dbh->prepare($sql);
undef($sql);
$sth->execute;
if ($sth->rows != 1)
{
	#exit because of autoresponder not active
	$sth->finish();
	$dbh->disconnect();
	exit(0);
}
my $row_autores = $sth->fetchrow_hashref;
my $autores_times = $row_autores->{'times'};
$sth->finish();

#Now check if allready send an autoresponder to the email address:
$sql=sprintf("SELECT id FROM autoresponder_send WHERE email=%s AND efromto=%s",
	$dbh->quote($ARGV[0]),
	$dbh->quote($mail_from) );
$sth = $dbh->prepare($sql);
undef($sql);
$sth->execute;
print "->> $autores_times  - ROws: ",$sth->rows, "\n";
if ($sth->rows < $autores_times || $autores_times eq "n")
{
	#Now collect data for autpresponder:
	$sql=sprintf("SELECT a.email AS mailaddr, b.esubject, b.msg FROM users AS a LEFT JOIN autoresponder AS b ON b.email=a.id WHERE b.active='y' AND a.id=%s",
		$dbh->quote($ARGV[0]));
	$sth = $dbh->prepare($sql);
	undef($sql);
	$sth->execute;
	my @row_ary  = $sth->fetchrow_array;
	my $sender   = $row_ary[0];
	my $subject  = $row_ary[1];
	my $mail_text = $row_ary[2];
	undef(@row_ary);
	
	#Now check if vaild repi list is enabled:
	$sth = $dbh->prepare("SELECT options FROM email_options WHERE email=? AND conf='auto_val_tos_active'");
	$sth->execute($ARGV[0]);
	my @row_val_ac;
	if ($sth->rows == 1) {
		@row_val_ac = $sth->fetchrow_array;
	}
	
	#Now create an valid repicipent list:
	my @valid_rep;
	push(@valid_rep,$sender);
	$sql=sprintf("SELECT recip FROM autoresponder_recipient WHERE email=%s",
		$dbh->quote($ARGV[0]));
	$sth = $dbh->prepare($sql);
	undef($sql);
	$sth->execute;
	while(@row_ary = $sth->fetchrow_array) {
		push(@valid_rep, $row_ary[0]);
	}
	undef(@row_ary);
	my $found=0;
	my $second;
	foreach my $first (@mail_to) {
		foreach $second (@valid_rep) {
			if ($first eq $second) {
				$found=1;
				last;
			} 
		}
		last if $found==1;
	}
	if ($found != 1 && $row_val_ac[0] eq 1 ) {
		#exits because not Mail to
		$sth->finish();
		$dbh->disconnect();
		exit(0);
	}
	
	##UTF-8 fix:
	if (! utf8::is_utf8($mail_text)) {
		utf8::decode($mail_text);
	}
	if (! utf8::is_utf8($subject)) {
		utf8::decode($subject);
	}

	my $e_send_to = MIME::Entity->build(
		Type    => "text/plain",
		Charset => "UTF-8",
		Disposition => 'inline',
		Data    => $mail_text);
			$e_send_to->head->add("User-Agent", 'CPM/Autoresponder');
			$e_send_to->head->add("To", $mail_from);
			$e_send_to->head->add("X-Loop", "No");
			$e_send_to->head->add("X-No-Loop", "Yes");
			$e_send_to->head->add("Sender",$sender );
			$e_send_to->head->add("From", $sender);
			$e_send_to->head->add("Subject", $subject );
			$e_send_to->send;
			$e_send_to->stringify;
	#OK send autoresponder to email and save email addr in DB
	$sql=sprintf("INSERT INTO autoresponder_send SET email=%s, efromto=%s",
		$dbh->quote($ARGV[0]), 
		$dbh->quote($mail_from) );
	$dbh->do($sql);
	undef($sql);

}

$sth->finish();
$dbh->disconnect();
