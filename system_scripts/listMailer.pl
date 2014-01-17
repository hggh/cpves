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

#use strict;
use MIME::Entity;
use Email::Simple;
use Email::Find;
use DBI;
use Config::General;
use Net::SMTP;
use Sys::Syslog;

my $sender;
my @addresses;
my @emailfrom;
my $conf = new Config::General("/etc/cpves/mail_config.conf");
my %config = $conf->getall;
$config{'db_host'} = "localhost" unless defined $config{'db_host'};
$config{'db_username'} = "mail" unless defined $config{'db_username'};
$config{'db_password'} = "" unless defined $config{'db_password'};
$config{'db_name'} = "mail_system" unless defined $config{'db_name'};
$config{'vmail_home'} = "/home/vmail/" unless defined $config{'vmail_home'};
$config{'vmail_safe'} = "/home/vmail_backup" unless defined $config{'vmail_safe'};
$config{'mailserver_smtp'} = "127.0.0.1" unless defined $config{'mailserver_smtp'};
$config{'ml_postmaster'} = 'postmaster@localhost' unless defined $config{'ml_postmaster'};
my $dsn = "DBI:mysql:database=".$config{'db_name'}.";host=".$config{'db_host'};

openlog('listMailer', "ndelay,pid", LOG_MAIL);

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
 syslog(LOG_ERR, 'No valid sender address given');
 exit(0);
}

my $list = $ARGV[0];

# Read List config from DB
my $dbh = DBI->connect($dsn, $config{'db_username'}, $config{'db_password'});
my $sql = sprintf("SELECT * FROM lists WHERE address = %s AND access = '1'",
		$dbh->quote($list));
my $sth = $dbh->prepare($sql);
undef($sql);
$sth->execute;
if( $sth->rows == 0 ) {
 # No active list found
 $sth->finish();
 $dbh->disconnect();
 syslog(LOG_ERR, 'No valid mailinglist found ');
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
 my $recp;
 foreach $recp (@addresses) {
  my $smtp = Net::SMTP->new($config{'mailserver_smtp'});
  $smtp->mail($sender);
  $smtp->to($recp);
  $smtp->data();
  $smtp->datasend($data);
  $smtp->dataend();
  $smtp->quit;
 }
 undef($recp);
 undef($data);
 undef($sender);
}

sub getAllAddresses {
 my $id = shift;
 my $sql = sprintf("SELECT recp FROM list_recp WHERE id = %d", $id);
 my $sth = $dbh->prepare($sql);
 $sth->execute;
 my $row;
 my @result;
 while( $row = $sth->fetchrow_hashref) {
  push(@result, $row->{recp});
 }
 $sth->finish;
 undef($row);
 undef($id);
 undef($sql);
 undef($sth);
 return @result;
}

my $row = $sth->fetchrow_hashref;
$mail->header_set("List-Post", "<mailto:$list>");
$mail->header_set("List-Owner", "<mailto:$config{'ml_postmaster_addr'}>");
$sth->finish();
if( $row->{public} eq 'n' ) {
 if( 0 == isSenderAllowed($row->{id}, $sender) ) {
  # Not subscribed to list, so he can't post
  my $e_send_to = MIME::Entity->build(
		Type    => "text/plain",
		Charset => "utf-8",
		Disposition => 'inline',
		Data    => "The sender $sender is not allowed to post on the list $list\n\nYour original email:\n\n" . $mail->body);
  $e_send_to->head->add("User-Agent", 'CpVES/ListMailer');
  $e_send_to->head->add("To", $sender);
  $e_send_to->head->add("Sender", sprintf("%s <%s>", $config{'ml_postmaster_name'}, $config{'ml_postmaster_addr'}));
  $e_send_to->head->add("From", sprintf("%s <%s>", $config{'ml_postmaster_name'}, $config{'ml_postmaster_addr'}));
  $e_send_to->head->add("Subject", "Mailinglist error");
  $e_send_to->send;
  $e_send_to->stringify;
  syslog(LOG_WARNING, sprintf('sender %s is not allowed for private list %s', $sender, $list));
 } else {
  # Send Mail to all subscribed
  @addresses = getAllAddresses($row->{id});
  syslog(LOG_INFO, sprintf('sending from %s for private listid %s', $sender, $list));
  sendto($mail->as_string , $sender);
 }
} else {
 # Send Mail to all subscribed
 @addresses = getAllAddresses($row->{id});
 syslog(LOG_INFO, sprintf('sending from %s for public listid %s', $sender, $list));
 sendto($mail->as_string , $sender);
}
