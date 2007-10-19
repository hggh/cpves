#!/usr/bin/perl 
#create_mailboxes.pl
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
use DBI;
use Config::General;
use Proc::PID::File;

my $conf = new Config::General("/etc/cpves/mail_config.conf");
my %config = $conf->getall;


$config{'db_host'} = "localhost" unless defined $config{'db_host'};
$config{'db_username'} = "mail" unless defined $config{'db_username'};
$config{'db_password'} = "" unless defined $config{'db_password'};
$config{'db_name'} = "mail_system" unless defined $config{'db_name'};
$config{'vmail_home'} = "/home/vmail" unless defined $config{'vmail_home'};
$config{'vmail_safe'} = "/home/vmail_backup" unless defined $config{'vmail_safe'};
$config{'vmail_user'} = "vmail" unless defined $config{'vmail_user'};

if (! -d $config{'vmail_home'})
{
	print "Error: ".$config{'vmail_home'}. " does not exists!\n";
	exit(1);
}
chomp (my $user = `id -un`);
die "Already running!" if Proc::PID::File->running('dir' => '/tmp/' );
die ("Error: Please run $0 as mailbox owner!") unless ($user eq $config{'vmail_user'});

my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=". $config{'db_host'};
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});

sub update_database($) {
	my $id=$_[0];
	my $sql=sprintf("UPDATE users SET enew='2' WHERE id=%s",
		$dbh->quote($id));
	$dbh->do($sql);
	undef $sql;
}


my $sql=sprintf("SELECT CONCAT( SUBSTRING_INDEX( a.email, '@\', 1 ) ) AS emailaddr, a.id, b.dnsname FROM users AS a LEFT JOIN domains AS b ON b.id = a.domainid WHERE a.enew = 1");
my $sth = $dbh->prepare($sql);
undef $sql;
$sth->execute;

my @data;
while(@data = $sth->fetchrow_array)
{
	my $dnsname= $data[2];
	my $id = $data[1];
	my $emailaddr = $data[0];
	die ("Error: emailaddress contains illegal chars!\n") unless ($emailaddr=~m/^([a-zA-Z0-9._\-]+)$/);
	die ("Error: domainname contains illegal chars!\n") unless ($dnsname=~m/^([a-zA-Z0-9._\-]+)$/);
	if ( ! -d "$config{'vmail_home'}/$dnsname") {
		`mkdir -p $config{'vmail_home'}/$dnsname`;
		`chmod 770 $config{'vmail_home'}/$dnsname`;
	}
	if ( ! -d "$config{'vmail_home'}/$dnsname/$emailaddr" )
	{
		`mkdir -p $config{'vmail_home'}/$dnsname/$emailaddr`;
		`chmod 770 $config{'vmail_home'}/$dnsname/$emailaddr`;
	}
	if ( -d "$config{'vmail_home'}/$dnsname/$emailaddr" && ! -d "$config{'vmail_home'}/$dnsname/$emailaddr/Maildir" )
	{
		if (! system("/usr/bin/maildirmake $config{'vmail_home'}/$dnsname/$emailaddr/Maildir"))
		{
			update_database($id);
		}
		else
		{
			print "Error on $id; eMail: $emailaddr\@$dnsname\n";
		}
	}
	undef $id;
	undef $emailaddr;
	undef $dnsname;
	

}

$sth->finish();
$dbh->disconnect();

