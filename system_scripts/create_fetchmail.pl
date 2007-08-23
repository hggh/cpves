#!/usr/bin/perl 
#create_fetchmail.pl
#Copyright (C) 2007 Jonas Genannt <jonas.genannt@brachium-system.net>
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
use Fcntl;
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
$config{'fetchmail'} = "/usr/bin/fetchmail" unless defined $config{'fetchmail'};
$config{'vmail_user'} = "vmail" unless defined $config{'vmail_user'};

chomp (my $user = `id -un`);
die ("Error: " .$config{'vmail_home'} . " does not exists!\n" )
	unless ( -d $config{'vmail_home'});
die ("Error: " .$config{'fetchmail'} . " does not exists!\n" )
	unless ( -x $config{'fetchmail'});
die "Already running!" if Proc::PID::File->running('dir' => '/tmp/' );
die ("Error: Please run $0 as mailbox owner!") unless ($user eq $config{'vmail_user'});  

my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=". $config{'db_host'};
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});
my $sth = $dbh->prepare("SELECT a.server,a.proto,a.conn_type,a.username,a.password,a.keep_mails,b.email FROM fetchmail AS a LEFT JOIN users AS b ON b.id=a.email WHERE a.active=1 AND b.access=1");
$sth->execute;
my $row;
my $fetchmail="";
while ($row=$sth->fetchrow_hashref) {
	my $fetch_temp;
	$fetch_temp .= "poll \"" . $row->{'server'} . "\" ";
	$fetch_temp .= "proto pop3" if ($row->{'proto'} == 1);
	$fetch_temp .= "proto imap" if ($row->{'proto'} == 2);
	$fetch_temp .= " no dns\n";
	$fetch_temp .= "user \"" . $row->{'username'} . "\"\n";
	$fetch_temp .= "pass \"" . $row->{'password'} . "\"\n";
	$fetch_temp .= "ssl\n"     if ($row->{'conn_type'} == 2 );
	$fetch_temp .= "keep\n"    if ($row->{'keep_mails'} == 2); 
	$fetch_temp .= "is '" .    $row->{'email'} . "' here\n\n";
	$fetchmail  .= $fetch_temp; 
	undef $fetch_temp; 
}
my $handle;
`rm -f $config{'vmail_home'}/.fetchmailrc`;
sysopen($handle,"$config{'vmail_home'}/.fetchmailrc", O_WRONLY|O_CREAT, 0600);
print $handle $fetchmail;
close($handle);
undef $handle;
`chmod 600 $config{'vmail_home'}/.fetchmailrc`;

system("fetchmail -s");


$sth->finish();
$dbh->disconnect();