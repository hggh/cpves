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

use DBI;
use Fcntl;
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
$config{'bogofilter'} = "/usr/bin/bogofilter" unless defined $config{'bogofilter'};
$config{'sa_wb_listing'} = "/etc/mail-admin/sa_wb_listing.pl" unless defined $config{'sa_wb_listing'};
$config{'reformail'} = "/usr/bin/reformail" unless defined $config{'reformail'};

my $sa_wblist = sprintf("exception {\nif ( /^From:\\s*(.*)/ )\n{\nADDR=getaddr(\$MATCH1)\nWHITELIST=`%s DID EMAILID \$ADDR`\nif (\$WHITELIST eq 0)\n{\nxfilter \"%s -A'X-CpVES: Whitelist'\"\n}\n}\n}\n", $config{'sa_wb_listing'}, $config{'reformail'} );

if (! -d $config{'vmail_home'})
{
	print "Error: ".$config{'vmail_home'}. " does not exists!\n";
	exit(1);
}


my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=". $config{'db_host'};
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});

#disable autoresponder:
my $da_sth= $dbh->prepare("SELECT email,id FROM autoresponder_disable WHERE UNIX_TIMESTAMP(a_date) < UNIX_TIMESTAMP() AND active='1'");
$da_sth->execute();
my @da_row;
my $dd_sth;
while (@da_row=$da_sth->fetchrow_array) {
	#print "->",$da_row[0], "\n";
	$dd_sth=$dbh->prepare("UPDATE mailfilter SET active='0' WHERE type='autoresponder' AND email=?");
	$dd_sth->execute($da_row[0]);
	undef $dd_sth;
	$dd_sth=$dbh->prepare("UPDATE autoresponder_disable SET active='0' WHERE id=?");
	$dd_sth->execute($da_row[1]);
	undef $dd_sth;
	$dd_sth=$dbh->prepare("UPDATE autoresponder SET active='n' WHERE email=?");
	$dd_sth->execute($da_row[0]);
	undef $dd_sth;
}

sub del_mailfilter($) {
	my $path=$_[0];
	if ( -d $path && -f "$path/.mailfilter")
	{
		`rm -f $path/.mailfilter`;
	}
}

sub get_bogofilter($$) {
	my $uid=$_[0];
	my $email=$_[1];
	my $b_sth = $dbh->prepare("SELECT options FROM email_options WHERE conf='bogofilter' AND email=?");
	$b_sth->execute($uid);
	if ($b_sth->rows == 1) {
		my @row_b = $b_sth->fetchrow_array;
		if ($row_b[0]== "1") {
			my $b_s_sth=$dbh->prepare("SELECT value FROM spamassassin WHERE preference='rewrite_header subject' AND username=?");
			$b_s_sth->execute($email);
			my $bogo_subject;
			if ($b_s_sth->rows == 1) {
				my @row_b_s=$b_s_sth->fetchrow_array;
				$bogo_subject=$row_b_s[0];
			}
			else {
				$bogo_subject='';
			}
			my $bogofilter_line;
			$bogofilter_line =sprintf("if (\$WHITELIST ne 0 )\n{\nif (! /^X-Spam-Status: Yes/)\n{\nexception {\n xfilter \"%s --bogofilter-dir %s/.bogofilter/  -e -p -C -l --spam-subject-tag '%s' --unsure-subject-tag '' \"\n }\n}\n}\n",
			
				$config{'bogofilter'},
				$config{'vmail_home'},
				$bogo_subject);
			return $bogofilter_line;
			
		}
	}
	return 0;
}

sub get_email_option($$$) {
	my $uid = $_[0];
	my $conf = $_[1];
	my $default = $_[2];
	my $ge_sth=$dbh->prepare("SELECT options FROM email_options WHERE email=? AND conf=?");
	$ge_sth->execute($uid,$conf);
	if ($ge_sth->rows==1) {
		my @row_ge = $ge_sth->fetchrow_array;
		return $row_ge[0];
	}
	else {
		return $default;
	}
}

my $sql=sprintf("SELECT CONCAT(%s ,'/',SUBSTRING_INDEX(b.email,'@\',-1),'/',SUBSTRING_INDEX(b.email,'@\',1)) AS epath, b.id AS emailid, b.domainid AS domainid FROM mailfilter AS a LEFT JOIN users AS b ON b.id=a.email WHERE a.active='0' OR a.active='1' GROUP BY a.email",
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
	my $did= $data[2];
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
		my $sa_wblist_temp='';
		while(@udata=$sthu->fetchrow_array)
		{
			my $upath	= $udata[0];
			my $uid		= $udata[1];
			my $emailaddr	= $udata[3];
			my $type	= $udata[4];
			my $filter	= $udata[5];
			#print "  -> $upath - $uid -  $emailaddr - $type - $filter\n";
			if ( $type eq "spamassassin") {
				$sa_wblist_temp = $sa_wblist;
				$sa_wblist_temp=~ s/DID/$did/;
				$sa_wblist_temp=~ s/EMAILID/$id/;

				$mailfilter = sprintf("%s\n%s", $mailfilter,$sa_wblist_temp );
				$mailfilter = sprintf("%s\nif (\$WHITELIST ne 0 )\n{\nexception {\n xfilter \"%s -f -u %s \"\n}\n}\n",
					$mailfilter,
					$config{'spamassassin'},
					$emailaddr);
				my $bogofilter=get_bogofilter($id,$emailaddr);
				if ($bogofilter ne "0" ) {
					$mailfilter =sprintf("%s\n%s",$mailfilter, $bogofilter);
				}
				if (get_email_option($id,'del_known_spam', '0') eq "1") {
					my $del_known_spam_value=get_email_option($id,'del_known_spam_value', '100');
					$mailfilter=sprintf("%s\nexception {\nif ( /^X-Spam-Status: Yes, score=([0-9.]+) required=/:h )\n{\nif (\$MATCH1 >= %s)\n{\nto \"|cat - > /dev/null\"\n}\n}\n}\n",
					$mailfilter,
					$del_known_spam_value);
				}
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
			if ( $type eq "move_spam" && get_email_option($id,'spamassassin', '0') eq "1") {
				#if ( -d "$path/Maildir/.$filter") {
					$mailfilter = sprintf("%s\nexception {\nif (/^X-Spam-Flag: Yes/ || /^X-Bogosity: Spam, tests=bogofilter/)\n  to \"Maildir/.%s/\"\n}\n",
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
			my $handle;
			sysopen($handle,"$path/.mailfilter", O_WRONLY|O_CREAT, 0600);
			print $handle $mailfilter;
			close($handle);
			undef $handle;
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

