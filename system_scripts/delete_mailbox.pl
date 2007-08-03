#!/usr/bin/perl -w
#create_mailfilters.pl
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

if (! -d $config{'vmail_home'} || ! -d  $config{'vmail_safe'})
{
	print "Error: ".$config{'vmail_home'}. " or ".$config{'vmail_safe'}." does not exists!\n";
	exit(1);
}
die "Already running!" if Proc::PID::File->running('dir' => '/tmp/' );

my $datum = `date +"%d-%m-%Y"`;
chomp($datum);

my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=". $config{'db_host'};
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});

my $sth = $dbh->prepare("SELECT dnsname,id FROM domains WHERE enew=0");
$sth->execute();
my $row;
my $domain_path;
my $domain_save;
while($row=$sth->fetchrow_hashref) {
	$domain_path = $config{'vmail_home'} . "/" . $row->{'dnsname'};
	if (-d $domain_path ) {
		`rmdir --ignore-fail-on-non-empty $domain_path`;
		if (-d $domain_path ) {
			$domain_save = $config{'vmail_safe'} ."/" . $datum ."/";
			system("mkdir -p $domain_save") unless (-d $domain_save);
			if (! system("mv $domain_path $domain_save")) {
				my $sth_save = $dbh->prepare("DELETE FROM domains WHERE id=?");
				$sth_save->execute($row->{'id'});
				undef $sth_save;
			}
			else {
				print "Error on move to safe dir: $domain_path -> $domain_save\n";
				exit(1);
			}
		}
	}
	undef $domain_path;
}

my $sql=sprintf("SELECT CONCAT(SUBSTRING_INDEX(a.email,'@\',1)) AS emailaddr,a.id, b.dnsname FROM users AS a LEFT JOIN domains AS b ON b.id=a.domainid WHERE a.enew='0'");
$sth = $dbh->prepare($sql);
undef $sql;
$sth->execute;
my @data;
while(@data= $sth->fetchrow_array) {
	my $emailaddr	= $data[0];
	my $dnsname	= $data[2];
	my $id		= $data[1];
	my $path_email=$config{'vmail_home'}."/". $dnsname. "/". $emailaddr;
	if (-d $path_email)
	{
		my $path_save = $config{'vmail_safe'} ."/" . $datum ."/". $dnsname."/";
		system("mkdir -p $path_save") unless (-d $path_save);
		if (-d $path_save)
		{
			if (! system("mv $path_email $path_save"))
			{
				$sql=sprintf("DELETE FROM users WHERE id=%s",
					$dbh->quote($id));
				$dbh->do($sql);
				undef $sql;
			}
			else
			{
				print "Error on move to safe dir: ". $path_email ." -> ". $path_save ."\n";
				exit(1);
			}
		}
	}

}

$sth->finish();
$dbh->disconnect();
