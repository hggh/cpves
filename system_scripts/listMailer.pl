#!/usr/bin/perl -w
#listMailer.pl
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
use Net::SMTP;

my $sender;
my @addresses;
my @emailfrom;
my $conf = new Config::General("/home/tgenannt/cpves/system_scripts/mail_config.conf");
my %config = $conf->getall;
$config{'db_host'} = "localhost" unless defined $config{'db_host'};
$config{'db_username'} = "mail" unless defined $config{'db_username'};
$config{'db_password'} = "" unless defined $config{'db_password'};
$config{'db_name'} = "mail_system" unless defined $config{'db_name'};
$config{'vmail_home'} = "/home/vmail/" unless defined $config{'vmail_home'};
$config{'vmail_safe'} = "/home/vmail_backup" unless defined $config{'vmail_safe'};

my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=".$config{'db_host'};

while (<stdin>) {
 push(@emailfrom, $_);	
}

my $mail = Email::Simple->new(join('', @emailfrom));
undef (@emailfrom);

my $efinder = Email::Find->new(
 sub {
  my ($email, $orig_email) = @_;
   $sender = $orig_email;
   return $orig_email;
 }
);
if( $efinder->find(\$mail->header("From")) != 1 ) {
 #end, because of invalid email!
 exit(0);
}

my $list = $ARGV[0];

# Read List config from DB
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});
my $sql = sprintf("SELECT * FROM lists WHERE address = %s AND access = 'y'",
		$dbh->quote($list));
my $sth = $dbh->prepare($sql);
undef($sql);
$sth->execute;
if( $sth->rows == 0 ) {
 # No active list found
 $sth->finish();
 $dbh->disconnect();
 exit(0);
}

sub isSenderAllowed {
 my $listID = shift;
 my $sender = shift;
 my $sql = sprintf("SELECT COUNT(*) FROM list_recp WHERE id = %d AND recp = %s",
		$listID,
		$dbh->quote($sender));
 my $query = $dbh->prepare($sql);
 $query->execute;
 my @row = $query->fetchrow_array;
 $query->finish;
 undef($query);
 undef($sql);
 if( $row[0] == 1 ) {
  return 1;
 } else {
  return 0;
 }
}

sub sendto {
 my($data, $sender) = @_;
 my $smtp = Net::SMTP->new('localhost');
 my $recp;
 foreach $recp (@addresses) {
  $smtp->mail($sender);
  $smtp->to($recp);
  $smtp->data();
  $smtp->datasend($data);
  $smtp->dataend();
 }
 $smtp->quit;
 undef($smtp);
 undef($recp);
 undef($data);
 undef($sender);
}

sub getAllAddresses {
 my $id = shift;
 my $sql = sprintf("SELECT recp FROM list_recp WHERE id = %d", $id);
 my $sth = $dbh->prepare($sql);
 $sth->execute;
 my @row;
 my @result;
 while( @row = $sth->fetchrow_array) {
  push(@result, $row[0]);
 }
 $sth->finish;
 undef(@row);
 undef($id);
 undef($sql);
 undef($sth);
 return @result;
}

my @row = $sth->fetchrow_array;
$mail->header_set("Reply-To", "$list");
$sth->finish();
if( $row[3] eq 'n' ) {
 if( 0 == isSenderAllowed($row[0], $sender) ) {
  # Not subscribed to list, so he can't post
  my $e_send_to = MIME::Entity->build(
		Type    => "text/plain",
		Charset => "iso-8859-15",
		Disposition => 'inline',
		Data    => "The sender $sender is not allowed to post on the list $list\n\nYour original email:\n\n" . $mail->body);
  $e_send_to->head->add("User-Agent", 'CPM/ListMailer');
  $e_send_to->head->add("To", $sender);
  $e_send_to->head->add("Sender", "Team-Ulm.de - Postmaster <postmaster\@team-ulm.de>");
  $e_send_to->head->add("From", "Team-Ulm.de - Postmaster <postmaster\@team-ulm.de>");
  $e_send_to->head->add("Subject", "Mailinglist error");
  $e_send_to->send;
  $e_send_to->stringify;
 } else {
  # Send Mail to all subscribed
  @addresses = getAllAddresses($row[0]);
  sendto($mail->as_string , $sender);
 }
} else {
 # Send Mail to all subscribed
 @addresses = getAllAddresses($row[0]);
 sendto($mail->as_string , $sender);
}
