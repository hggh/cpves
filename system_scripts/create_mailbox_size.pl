#!/usr/bin/perl 
#create_mailbox_size.pl
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
$config{'vmail_user'} = "vmail" unless defined $config{'vmail_user'};

chomp (my $user = `id -un`);
die ("Error: " .$config{'vmail_home'} . " does not exists!\n" )
	unless ( -d $config{'vmail_home'});
die "Already running!" if Proc::PID::File->running('dir' => '/tmp/' );
die ("Error: Please run $0 as mailbox owner!") unless ($user eq $config{'vmail_user'});  

my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=". $config{'db_host'};
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});

my $sth = $dbh->prepare("SELECT CONCAT(SUBSTRING_INDEX(email,'\@',-1),'/',SUBSTRING_INDEX(email,'\@',1),'/') AS epath,id FROM users WHERE enew='2' ");
$sth->execute();
my $row;
my $update = $dbh->prepare("UPDATE users SET mb_size=? WHERE id=?");
while ($row=$sth->fetchrow_hashref) {
	my $path = $config{'vmail_home'} .'/' . $row->{'epath'};
	if (-d $path) {
		chomp (my $mb_size = `du -s -m $path `);
		$update->execute($mb_size,$row->{'id'});
		undef $mb_size;
	}
	undef $path;
}

$dbh->disconnect();