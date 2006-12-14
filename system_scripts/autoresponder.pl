#!/usr/bin/perl -w
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
my $formated_email;

my $conf = new Config::General("/etc/mail-admin/mail_config.conf");
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
if ($mail->as_string =~ m/^List-/mg )
{
	#exit, because of ML's
	exit(0);
}

my $efinder = Email::Find->new(sub {
		my ($email,$orig_email) = @_;
		$formated_email= $email->format;
		return $orig_email;
	});

if ($efinder->find(\$mail->header("From")) != 1)
{
	#end, because of ne valid email!
	exit(0);
}

if ($formated_email =~ m/postmaster/gi )
{
	#exit, because of postmaster email
	exit(0);
}

#print "eMail: $formated_email\n";



#Now check if autoresponder is enabled
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});
my $sql=sprintf("SELECT email FROM autoresponder WHERE email=%s AND active='y'",
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
$sth->finish();

#Now check if allready send an autoresponder to the email address:
$sql=sprintf("SELECT id FROM autoresponder_send WHERE email=%s AND efromto=%s",
	$dbh->quote($ARGV[0]),
	$dbh->quote($formated_email) );
$sth = $dbh->prepare($sql);
undef($sql);
$sth->execute;
if ($sth->rows == 0)
{
	#OK send autoresponder to email and save email addr in DB
	$sql=sprintf("INSERT INTO autoresponder_send SET email=%s, efromto=%s",
		$dbh->quote($ARGV[0]), 
		$dbh->quote($formated_email) );
	$dbh->do($sql);
	undef($sql);
	#Now collect data for autpresponder:
	$sql=sprintf("SELECT a.email AS mailaddr, b.esubject, b.msg FROM users AS a LEFT JOIN autoresponder AS b ON b.email=a.id WHERE b.active='y' AND a.id=%s",
		$dbh->quote($ARGV[0]));
	$sth = $dbh->prepare($sql);
	undef($sql);
	$sth->execute;
	print "Send now email .... \n";
	my @row_ary  = $sth->fetchrow_array;
	my $e_send_to = MIME::Entity->build(
		Type    => "text/plain",
		Charset => "iso-8859-15",
		Disposition => 'inline',
		Data    => $row_ary[2]);
			$e_send_to->head->add("User-Agent", 'CPM/Autoresponder');
			$e_send_to->head->add("To", $formated_email);
			$e_send_to->head->add("Sender", $row_ary[0]);
			$e_send_to->head->add("From", $row_ary[0]);
			$e_send_to->head->add("Subject", $row_ary[1]);
			$e_send_to->send;
			$e_send_to->stringify;

}

$sth->finish();
$dbh->disconnect();
