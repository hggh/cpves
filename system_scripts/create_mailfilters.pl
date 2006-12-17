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

my $conf = new Config::General("/etc/mail-admin/mail_config.conf");
my %config = $conf->getall;


$config{'db_host'} = "localhost" unless defined $config{'db_host'};
$config{'db_username'} = "mail" unless defined $config{'db_username'};
$config{'db_password'} = "" unless defined $config{'db_password'};
$config{'db_name'} = "mail_system" unless defined $config{'db_name'};
$config{'vmail_home'} = "/home/vmail" unless defined $config{'vmail_home'};
$config{'vmail_safe'} = "/home/vmail_backup" unless defined $config{'vmail_safe'};
$config{'spamassassin'} = "/usr/bin/spamc" unless defined $config{'spamassassin'};

if (! -d $config{'vmail_home'})
{
	print "Error: ".$config{'vmail_home'}. " does not exists!\n";
	exit(1);
}


my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=". $config{'db_host'};
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});

sub del_mailfilter($) {
	my $path=$_[0];
	if ( -d $path && -f "$path/.mailfilter")
	{
		`rm -f $path/.mailfilter`;
	}
}


my $sql=sprintf("SELECT CONCAT(%s ,'/',SUBSTRING_INDEX(b.email,'@\',-1),'/',SUBSTRING_INDEX(b.email,'@\',1)) AS epath, b.id AS emailid FROM mailfilter AS a LEFT JOIN users AS b ON b.id=a.email WHERE a.active='0' OR a.active='1' GROUP BY a.email",
	 $dbh->quote($config{'vmail_home'}));
my $sth = $dbh->prepare($sql);
undef $sql;
$sth->execute;
my @data;
my $temp_data;
while(@data = $sth->fetchrow_array)
{
	my $path= $data[0];
	my $id = $data[1];
	#print "-> " . $path . " -> ". $id . "\n";
	#Delete the mailfilters.
	del_mailfilter($path);
	#Delete Database entries
	$sql = sprintf("DELETE FROM mailfilter WHERE email=%s AND active='0'",
		$dbh->quote($id));
	$dbh->do($sql);
	undef $sql;

	#Select all with acitve=2 and active=1 and current emailid
	$sql = sprintf("SELECT CONCAT(%s,'/',SUBSTRING_INDEX(b.email,'@\',-1),'/',SUBSTRING_INDEX(b.email,'@\',1),'/') AS epath,a.prio, b.id AS emailid, b.email AS emailaddr,a.type,a.filter FROM mailfilter AS a LEFT JOIN users AS b ON b.id=a.email  WHERE a.active>=1 AND a.email=%s ORDER BY a.prio ASC",
		$dbh->quote($config{'vmail_home'}),
		$dbh->quote($id));
	my $sthu = $dbh->prepare($sql);
	undef $sql;
	$sthu->execute;
	if ($sthu->rows >=1) { #New or old filters available
		my @udata;
		my $mailfilter="";
		while(@udata=$sthu->fetchrow_array)
		{
			my $upath	= $udata[0];
			my $uid		= $udata[1];
			my $emailaddr	= $udata[3];
			my $type	= $udata[4];
			my $filter	= $udata[5];
			#print "  -> $upath - $uid -  $emailaddr - $type - $filter\n";
			if ( $type eq "spamassassin") {
				$mailfilter = sprintf("%s\nexception {\n xfilter \"%s -f -u %s \"\n}\n",
					$mailfilter,
					$config{'spamassassin'},
					$emailaddr);
			}
			if ( $type eq "autoresponder") {
				$mailfilter = sprintf("%s\nexception {\n cc \"|%s %s\"\n}\n ",
					$mailfilter,
					$config{'autoresponder'},
					$id);
			}
			if ( $type eq "forward_cc") {
				$mailfilter = sprintf("%s\ncc \"!%s\"\n",
					$mailfilter,
					$filter);
			}
			if ( $type eq "forward_to") {
				$mailfilter = sprintf("%s\nto \"!%s\"\n",
					$mailfilter,
					$filter);
			}
			if ( $type eq "move_spam") {
				#if ( -d "$path/Maildir/.$filter") {
					$mailfilter = sprintf("%s\nexception {\nif (/^X-Spam-Flag: Yes/)\n  to \"Maildir/.%s/\"\n}\n",
						$mailfilter,
						$filter);
					
				#}
				#else {
				#	print "Folder: $path/Maildir/.$filter does not exists.\n";
				#}
			}
			if ( $type eq "del_virus_notifi") {
				$temp_data=qq(if (/^X-Virus: CpVES\$/ && /^From: .*postmaster\@/ )\n{\nexception {\nto );
				$mailfilter = sprintf("%s\n%s \"|cat - > /dev/null\"\n}\n}\n",
					$mailfilter,
					$temp_data);
				
				
				undef $temp_data;
			}
				
		}
		if ( -d $path )
		{
			
			`echo '$mailfilter' > $path/.mailfilter`;
			`chmod 600 $path/.mailfilter`;
		}
		undef $mailfilter;
		$sql=sprintf("UPDATE mailfilter SET active='2' WHERE email=%s",
			$dbh->quote($id));
		$dbh->do($sql);
		undef $sql;
	} ## END new filters ava
	
	

}

$sth->finish();
$dbh->disconnect();

