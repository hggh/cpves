#!/usr/bin/perl 
#sa_wb_listing.pl
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
#Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA

use strict;
use Email::Simple;
use Email::Find;
use DBI;
use Config::General;
my @email_from;
my $email_input;
my $did;
my $emailid;

my $conf = new Config::General("/etc/mail-admin/mail_config.conf");
my %config = $conf->getall;
$config{'db_host'} = "localhost" unless defined $config{'db_host'};
$config{'db_username'} = "mail" unless defined $config{'db_username'};
$config{'db_password'} = "" unless defined $config{'db_password'};
$config{'db_name'} = "mail_system" unless defined $config{'db_name'};
my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=".$config{'db_host'};

$did         = shift;
$emailid     = shift;
$email_input = shift;

if ($did eq '' || $did !~ m/^([0-9]+)$/) {
	print "1\n";
	exit(0);
}

my $efinder = Email::Find->new(sub {
	my ($email,$orig_email) = @_;
	push (@email_from, lc($email->format));
	});
	
$efinder->find(\$email_input);
my $mail_from;
if ( (scalar (@email_from)) eq 0) {
	print "1\n";
	exit(0);
}
else {
	$mail_from = $email_from[0];
}

(my $mail_addr, my $mail_host) = split(/@/, $mail_from);
my $state=1;
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});

#Check Domain:
my $sth=$dbh->prepare("SELECT id FROM sa_wb_listing WHERE type='1' AND email='0' AND sa_from=? AND domainid=?");
$sth->execute('@'.$mail_host, $did);
if ($sth->rows== 1) {
	$state=0;
}
else {
	$sth->finish();
	$sth=$dbh->prepare("SELECT id FROM sa_wb_listing WHERE  type='1' AND email='0' AND sa_from=? AND domainid=?");
	$sth->execute($mail_from, $did);
	if ($sth->rows== 1) {
		$state=0;
	}
}
$sth->finish();
$dbh->disconnect();
print $state,"\n";
exit(0);

