#!/usr/bin/perl 
#sa_learn.pl
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
$config{'sa_learn_spamassassin'} = "1" unless defined $config{'sa_learn_spamassassin'};
$config{'sa_learn_bogofilter'} = "0" unless defined $config{'sa_learn_bogofilter'};
$config{'sa_learn'} = "/usr/bin/sa-learn" unless defined $config{'sa_learn'};
$config{'find'} = "/usr/bin/find" unless defined $config{'find'};
$config{'spamassassin_database'} = "/home/spammer/.spamassassin/" unless defined $config{'spamassassin_database'};
$config{'bogofilter_database'} = "/home/vmail/.bogofilter/" unless defined $config{'bogofilter_database'};
$config{'sa_learn_days_older'} = "3" unless defined $config{'sa_learn_days_older'};
$config{'sa_learn_days_newer'} = "5" unless defined $config{'sa_learn_days_newer'};
$config{'bogofilter'} = "/usr/bin/bogofilter" unless defined $config{'bogofilter'};
$config{'vmail_user'} = "vmail" unless defined $config{'vmail_user'};
$config{'spamassassin_user'} = "spammer" unless defined $config{'spamassassin_user'};


die("Error: Spamassassin and Bogofilter learning is disabled.") if ($config{'sa_learn_spamassassin'} == 0 && $config{'sa_learn_bogofilter'} == 0);

die("Error: sa-learn not found") if ($config{'sa_learn_spamassassin'} == 1 && ! -x $config{'sa_learn'} );

die("Error: bogofilter not found") if ($config{'sa_learn_bogofilter'} == 1 && ! -x $config{'bogofilter'} );

die("Error: spamassassin_database dir not found") if ($config{'sa_learn_spamassassin'} == 1 && ! -d $config{'spamassassin_database'});

die("Error: bogofilter_database dir not found") if ($config{'sa_learn_bogofilter'} == 1 && ! -d $config{'bogofilter_database'});

die("Error: run this script as user root!") unless (`id -u` == 0);

die "Already running!" if Proc::PID::File->running('dir' => '/tmp/' );

my $spamassassin = $config{'sa_learn'} .
	 " --dbpath " .$config{'spamassassin_database'} . 
	 " --showdots ";
my $bogofilter = $config{'bogofilter'} . " -b -vvv " .
	" --bogofilter-dir=" .$config{'bogofilter_database'};
my $find = $config{'find'};
my $find_opts = " -type f -size -2000k " .
		" -ctime -" .
		$config{'sa_learn_days_newer'} . " ";
if ($config{'sa_learn_days_older'} !=0) {
	$find_opts .= " -ctime +" .
		$config{'sa_learn_days_older'};
}

my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=". $config{'db_host'};
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'}) or die ("Error: Could not connect to database.");

my $sth = $dbh->prepare("SELECT CONCAT( SUBSTRING_INDEX(b.email,'\@',-1),'/',SUBSTRING_INDEX(b.email,'\@',1),'/') AS emailpath,a.type,a.id,a.folder FROM spamassassin_learn AS a LEFT JOIN users AS b ON b.id=a.email WHERE a.active='1' ORDER BY a.email");

$sth->execute;
my $row;
my $path;
my $sa_type;
my $bo_type;
my $sa_cmd;
my $bo_cmd;
while ($row=$sth->fetchrow_hashref) {
	$path = $config{'vmail_home'} . "/" . $row->{'emailpath'} . "Maildir/.";
	$path   .= $row->{'folder'} . "/cur/";
	next unless ( -d $path );
	if ($row->{'type'} eq "spam") {
		$sa_type = " --spam ";
		$bo_type = " --register-spam ";
	}
	elsif ($row->{'type'} eq "ham") {
		$sa_type = " --ham ";
		$bo_type = " --register-ham ";
	}
	if ($config{'sa_learn_spamassassin'} == 1 ) {
		$sa_cmd = $find . " $path " . $find_opts .
			"| xargs " . $spamassassin . $sa_type;
		print $sa_cmd . "\n\n";
		system($sa_cmd);
		system("chown -R ". $config{'spamassassin_user'} . " " . $config{'spamassassin_database'} );
	}
	if ($config{'sa_learn_bogofilter'} == 1 ) {
		$bo_cmd = $find . " $path " . $find_opts .
			" | " . $bogofilter . $bo_type;
		system($bo_cmd);
		system("chown -R ". $config{'vmail_user'} . " " . $config{'bogofilter_database'} );
	}
	undef $sa_cmd;
	undef $bo_cmd;
	undef $sa_type;
	undef $bo_type;
	undef $path;
}
$sth->finish;
$dbh->disconnect();