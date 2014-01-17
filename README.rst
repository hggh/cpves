==================
CpVES Installation
==================
.. contents:: Contents

Preface
=======
This INSTALL covers the installation on a clean Debian 7.
**Be careful if you install CpVES on a already running Debian.**

Replace settings with your proper ones (like pathes/IPs, <PASSWORD> etc.)

After following this guide, the following should be up and running:

* Nginx
* PHP/fpm 5.4 (debians default)
* MySQL 5.5 (debians default)
* Postfix forced TLS on port 25
* Postfix forced TLS on port 587
* Courier IMAPS with forced SSL on port 993
* Courier POP3S with forced SSL on port 995

In every step the debian default packages are used.

Every step is done as root user.

editor should be set to your favorite texteditor.

Setup & Configuration
=====================

cpves
-----
Create useraccount::

  adduser --disabled-login --gecos 'cpves' cpves

Create hosting structure::

  mkdir -p /var/www/virtual/cpves/{html,logs,sockets,files,sessions,tmp}
  chown cpves:www-data /var/www/virtual/cpves
  chmod 550 /var/www/virtual/cpves
  chown cpves:www-data /var/www/virtual/cpves/{html,logs,sockets,files}
  chown cpves:cpves /var/www/virtual/cpves/{sessions,tmp}
  chmod 700 /var/www/virtual/cpves/{sessions,tmp}
  chmod 750 /var/www/virtual/cpves/{html,sockets,files}
  chmod 770 /var/www/virtual/cpves/logs

Get cpves::

  cd /var/www/virtual/cpves/html
  sudo -u cpves git clone https://github.com/stefankoop/cpves .
  sudo -u cpves git checkout koop

Logrotate::

  cp /var/www/virtual/cpves/html/support/logrotate /etc/logrotate.d/cpves

Webserver
---------

nginx
#####

Install nginx::

  apt-get install nginx

Delete nginx default site::

  rm /etc/nginx/sites-enabled/default

vHost::

  cp /var/www/virtual/cpves/html/support/nginx.vhost /etc/nginx/sites-available/cpves
  ln -s /etc/nginx/sites-available/cpves /etc/nginx/sites-enabled/cpves

  editor /etc/nginx/sites-enabled/cpves
  # Adapt your settings
  
SSL::

  mkdir /etc/nginx/ssl
  openssl req -new -x509 -days 3650 -sha1 -newkey rsa:1024 -nodes -keyout /etc/nginx/ssl/cpves.key -out /etc/nginx/ssl/cpves.crt -subj '/O=*/OU=*/CN=*'
  cat /etc/nginx/ssl/cpves.key /etc/nginx/ssl/cpves.crt > /etc/nginx/ssl/cpves.pem

Reload nginx::
  
  /etc/init.d/nginx reload

php
---

fpm
###
Install packages::

  apt-get install php5-fpm php5-mhash php5-imap php5-mysql

Remove default fpm pool (php-fpm will not start without a pool)::

  rm /etc/php5/fpm/pool.d/www.conf

Pool::

  cp /var/www/virtual/cpves/html/support/phpfpm /etc/php5/fpm/pool.d/cpves.conf
  
Reload php-fpm::

  /etc/init.d/php5-fpm reload

Add cronjob to remove sessions older > 30 min::

  crontab -e
  */15 * * * * find /var/www/virtual/cpves/sessions/ -type f -cmin +30 -delete >> /dev/null 2>&1

Install PEAR and PEAR packages globally::

  apt-get install php-pear

  pear update-channels
  pear install Net_IPv6
  pear install Net_DNS
  pear install Net_CheckIP
  pear install Validate-0.8.5
  pear install DB


mysql
-----
Install MySQL::

  apt-get install mysql-server mysql-client

Remove test and insecure default settings::

  /usr/bin/mysql_secure_installation

  # This will remove testdatabases and passwordless accounts.
  # You will need the mysql root password you entered above

Create cpves database and user::

  ## replace <PASSWORD>
  mysql --defaults-file=/etc/mysql/debian.cnf -e "create database cpves character set utf8;"
  mysql --defaults-file=/etc/mysql/debian.cnf -e "create user 'cpves'@'localhost' identified by '<PASSWORD>';"
  mysql --defaults-file=/etc/mysql/debian.cnf -e "grant all privileges on cpves.* to 'cpves'@'localhost';"
  mysql --defaults-file=/etc/mysql/debian.cnf -e "flush privileges;"

Import and update cpves database::

  mysql --defaults-file=/etc/mysql/debian.cnf cpves < /var/www/virtual/cpves/html/mail_system.sql
  mysql --defaults-file=/etc/mysql/debian.cnf cpves < /var/www/virtual/cpves/html/mail_system_0.01_to_0.02.sql
  mysql --defaults-file=/etc/mysql/debian.cnf cpves < /var/www/virtual/cpves/html/mail_system_0.03_to_0.04.sql
  mysql --defaults-file=/etc/mysql/debian.cnf cpves < /var/www/virtual/cpves/html/mail_system_0.04_to_0.05.sql
  mysql --defaults-file=/etc/mysql/debian.cnf cpves < /var/www/virtual/cpves/html/mail_system_0.05_to_0.06.sql
  mysql --defaults-file=/etc/mysql/debian.cnf cpves < /var/www/virtual/cpves/html/mail_system_0.09_to_0.10.sql

Some more cpves
---------------

Webinterface configuration::

  sudo -u cpves cp /var/www/virtual/cpves/html/includes/config.inc.default.php /var/www/virtual/cpves/html/includes/config.inc.php
  sudo -u cpves editor /var/www/virtual/cpves/html/includes/config.inc.php

  # $config['server_ip']     (your mailserver ip)
  # $config['imap_server']   (your imap server[ip])
  # $dsn                     (your database credentials)

Login and change password::

  https://<YOURFQDN>
  user     : admin
  password : mail
  
  => CHANGE PASSWORD

cpves systemscripts::
  
  mkdir /etc/cpves
  cp /var/www/virtual/cpves/html/system_scripts/mail_config.default.conf /etc/cpves/mail_config.conf
  editor /etc/cpves/mail_config.conf
  # db_username = cpves
  # db_password = <PASSWORD>
  # db_name = cpves

  mkdir /usr/local/cpves
  cp /var/www/virtual/cpves/html/system_scripts/{create_mailboxes.pl,create_mailfilters.pl,delete_mailbox.pl,create_fetchmail.pl,create_mailbox_size.pl,sa_learn.pl} /usr/local/cpves/

postfix
-------
Install packages::
  
  apt-get install postfix postfix-mysql postfix-pcre

Add user for receiving mails::

  groupadd -g 5000 vmail
  useradd -g vmail -u 5000 vmail -d /home/vmail -m

Create directories to store (removed) email users::

  mkdir /home/vmail_safe
  chown vmail:vmail /home/vmail_safe

Add postfix to sasl group::

  adduser postfix sasl

Create postfix sasl configuration (replace <PASSWORD>)::

  editor /etc/postfix/sasl/smtpd.conf
  
  pwcheck_method: saslauthd
  mech_list: plain login
  allow_plaintext: true
  auxprop_plugin: sql
  sql_engine: mysql
  sql_hostnames: 127.0.0.1
  sql_user: cpves
  sql_passwd: <PASSWORD>
  sql_database: cpves
  sql_select: select cpasswd from users where email = '%u@%r'

The following is a **example postfix** *main.cf*. Edit to your needs::

  editor /etc/postfix/main.cf

  myorigin = /etc/mailname
  myhostname = <FQDN>

  smtpd_banner = $myhostname ESMTP $mail_name
  biff = no

  append_dot_mydomain = no

  delay_warning_time = 0h

  smtpd_use_tls = yes
  smtp_tls_note_starttls_offer = yes
  smtpd_tls_cert_file=/etc/postfix/smtpd.pem
  smtpd_tls_key_file=/etc/postfix/smtpd.pem
  smtpd_tls_CAfile = /etc/postfix/smtpd.pem
  smtpd_tls_loglevel = 1
  smtpd_tls_received_header = yes
  smtpd_tls_session_cache_timeout = 3600s
  tls_random_source = dev:/dev/urandom

  smtpd_sasl_auth_enable = yes
  smtpd_sasl_security_options = noanonymous
  broken_sasl_auth_clients = yes

  smtpd_error_sleep_time = 1s
  smtpd_soft_error_limit = 10
  smtpd_hard_error_limit = 20

  alias_database = hash:/etc/aliases
  myorigin = /etc/mailname
  mydestination = <FQDN>, <HOSTNAME>, localhost, localhost.localdomain
  relayhost =
  mynetworks = 127.0.0.0/8
  mailbox_size_limit = 0
  recipient_delimiter = +

  local_recipient_maps=mysql:/etc/postfix/mysql-virtual_email2email.cf $alias_maps

  alias_maps = mysql:/etc/postfix/mysql-virtual_forwardings.cf mysql:/etc/postfix/mysql-virtual_email2email.cf
  virtual_alias_domains =
  virtual_alias_maps = mysql:/etc/postfix/mysql-virtual_forwardings.cf mysql:/etc/postfix/mysql-virtual_email2email.cf
  virtual_mailbox_domains = mysql:/etc/postfix/mysql-virtual_domains.cf
  virtual_mailbox_maps = mysql:/etc/postfix/mysql-virtual_mailboxes.cf

  virtual_mailbox_base = /home/vmail

  virtual_uid_maps = static:5000
  virtual_gid_maps = static:5000

  smtpd_recipient_restrictions = permit_mynetworks,permit_sasl_authenticated,reject_unauth_destination
  smtpd_client_restrictions = permit_mynetworks,permit_sasl_authenticated

  virtual_transport = maildrop
  maildrop_destination_recipient_limit = 1
  maildrop_destination_concurrency_limit = 1

  message_size_limit = 104857600
  maximal_queue_lifetime = 1d
  bounce_queue_lifetime = 1d
  inet_protocols = ipv4

/etc/postfix/mysql-virtual_mailboxes.cf::

  editor /etc/postfix/mysql-virtual_mailboxes.cf
  
  user = cpves
  password = <PASSWORD>
  dbname = cpves
  table = users
  select_field = CONCAT(SUBSTRING_INDEX(email,'@',-1),'/',SUBSTRING_INDEX(email,'@',1),'/')
  where_field = email
  hosts = 127.0.0.1

/etc/postfix/mysql-virtual_domains.cf::

  editor /etc/postfix/mysql-virtual_domains.cf

  user = cpves
  password = <PASSWORD>
  dbname = cpves
  table = domains
  select_field = 'virtual'
  where_field = dnsname
  additional_conditions = AND access = '1'
  hosts = 127.0.0.1

/etc/postfix/mysql-virtual_email2email.cf::

  editor /etc/postfix/mysql-virtual_email2email.cf

  user = cpves
  password = <PASSWORD>
  dbname = cpves
  table = users
  select_field = email
  where_field = email
  additional_conditions = AND access = '1'
  hosts = 127.0.0.1

/etc/postfix/mysql-virtual_forwardings.cf::

  editor /etc/postfix/mysql-virtual_forwardings.cf

  user = cpves
  password = <PASSWORD>
  dbname = cpves
  table = forwardings
  select_field = eto
  where_field = efrom
  hosts = 127.0.0.1

/etc/postfix/master.cf::

  editor /etc/postfix/master.cf

  smtp      inet  n       -        y       -       -       smtpd
  submission inet n       -       y       -       -       smtpd -o smtpd_enforce_tls=yes
  pickup    fifo  n       -       -       60      1       pickup
  cleanup   unix  n       -       -       -       0       cleanup
  qmgr      fifo  n       -       n       300     1       qmgr
  tlsmgr    unix  -       -       -       1000?   1       tlsmgr
  rewrite   unix  -       -       -       -       -       trivial-rewrite
  bounce    unix  -       -       -       -       0       bounce
  defer     unix  -       -       -       -       0       bounce
  trace     unix  -       -       -       -       0       bounce
  verify    unix  -       -       -       -       1       verify
  flush     unix  n       -       -       1000?   0       flush
  proxymap  unix  -       -       n       -       -       proxymap
  proxywrite unix -       -       n       -       1       proxymap
  smtp      unix  -       -       -       -       -       smtp
  relay     unix  -       -       -       -       -       smtp
          -o smtp_fallback_relay=
  showq     unix  n       -       -       -       -       showq
  error     unix  -       -       -       -       -       error
  retry     unix  -       -       -       -       -       error
  discard   unix  -       -       -       -       -       discard
  local     unix  -       n       n       -       -       local
  virtual   unix  -       n       n       -       -       virtual
  lmtp      unix  -       -       -       -       -       lmtp
  anvil     unix  -       -       -       -       1       anvil
  scache    unix  -       -       -       -       1       scache
  maildrop  unix  -       n       n       -       -       pipe
    flags=DRhu user=vmail argv=/usr/bin/maildrop -d ${recipient}
  uucp      unix  -       n       n       -       -       pipe
    flags=Fqhu user=uucp argv=uux -r -n -z -a$sender - $nexthop!rmail ($recipient)
  ifmail    unix  -       n       n       -       -       pipe
    flags=F user=ftn argv=/usr/lib/ifmail/ifmail -r $nexthop ($recipient)
  bsmtp     unix  -       n       n       -       -       pipe
    flags=Fq. user=bsmtp argv=/usr/lib/bsmtp/bsmtp -t$nexthop -f$sender $recipient
  scalemail-backend unix  -       n       n       -       2       pipe
    flags=R user=scalemail argv=/usr/lib/scalemail/bin/scalemail-store ${nexthop} ${user} ${extension}
  mailman   unix  -       n       n       -       -       pipe
    flags=FR user=list argv=/usr/lib/mailman/bin/postfix-to-mailman.py
    ${nexthop} ${user}

Adjust rights::

  chmod o= /etc/postfix/mysql-virtual_*.cf
  chgrp postfix /etc/postfix/mysql-virtual_*.cf

Generate selfsigned certificate for postfix::

  openssl req -new -x509 -days 365 -nodes -out /etc/postfix/postfix.pem -keyout /etc/postfix/postfix.pem -subj '/O=*/OU=*/CN=*'


sasl/pam
--------
Install packages::
  
  apt-get install libsasl2-modules libsasl2-2 sasl2-bin  libsasl2-modules-sql libpam-mysql

Edit sasl configuration::

  editor /etc/default/saslauthd
  
  START=yes
  MECHANISMS="pam"
  OPTIONS="-c -m /var/spool/postfix/var/run/saslauthd -r"

Edit pam configuration for smtp(replace <PASSWORD>)::

  editor /etc/pam.d/smtp
  
  auth    required   pam_mysql.so user=cpves passwd=<PASSWORD> host=127.0.0.1 db=cpves table=users usercolumn=email passwdcolumn=cpasswd crypt=1
  account sufficient pam_mysql.so user=cpves passwd=<PASSWORD> host=127.0.0.1 db=cpves table=users usercolumn=email passwdcolumn=cpasswd crypt=1

gamin/fetchmail
---------------
If IMAP IDLE should be used::

  apt-get install gamin

If fetchmail should be used::

  apt-get install fetchmail

courier imap + pop3
-------------------
Install packages::

 apt-get install courier-authlib courier-authlib-mysql courier-imap courier-pop courier-maildrop  libdbi-perl libemail-simple-perl libemail-find-perl libconfig-general-perl libproc-pid-file-perl courier-pop-ssl courier-imap-ssl  libdbd-mysql-perl

We dont want plainttext imap and pop3::

  update-rc.d -f courier-imap remove && /etc/init.d/courier-imap stop
  update-rc.d -f courier-pop remove && /etc/init.d/courier-pop stop

Let courier authenticate against mysql (replace <PASSWORD>)::

  editor /etc/courier/authmysqlrc

  MYSQL_SERVER            localhost
  MYSQL_USERNAME          cpves
  MYSQL_PASSWORD          <PASSWORD>
  MYSQL_DATABASE          cpves
  MYSQL_USER_TABLE        users
  MYSQL_CRYPT_PWFIELD     cpasswd
  MYSQL_CLEAR_PWFIELD     passwd
  MYSQL_NAME_FIELD        full_name
  MYSQL_HOME_FIELD        CONCAT('/home/vmail/',SUBSTRING_INDEX(email,'@',-1),'/',SUBSTRING_INDEX(email,'@',1),'/')
  MYSQL_UID_FIELD         5000
  MYSQL_GID_FIELD         5000
  MYSQL_LOGIN_FIELD       email
  MYSQL_AUXOPTIONS_FIELD  CONCAT("disableimap=",if(p_imap=0,1,0),",disablepop3=",if(p_pop3=0,1,0),",disablewebmail=",if(p_webmail=0,1,0))
  MYSQL_WHERE_CLAUSE      access='1'

Add mysql to couriers authmodules::

  editor /etc/courier/authdaemonrc
  
  authmodulelist="authmysql"

cpves again
-----------

Add Cronjobs::

  crontab -u vmail -e
  
  */2 * * * *     perl /usr/local/cpves/create_mailboxes.pl
  */2 * * * *     perl /usr/local/cpves/create_mailfilters.pl
  */5 * * * *     perl /usr/local/cpves/delete_mailbox.pl
  */10 * * * *    perl /usr/local/cpves/create_fetchmail.pl
  01 23 * * *     perl /usr/local/cpves/create_mailbox_size.pl

Appendix
=========

Trigger cpves scripts
---------------------

via xinetd
##########

cpves configuration::

  sudo -u cpves editor /var/www/virtual/cpves/html/includes/config.inc.php

  ...
  $config['trigger_service_enabled'] = 1;
  $config['trigger_service_host'] = "localhost";
  $config['trigger_service_port'] = 7928;
  ...

  Add port to services::

  echo "mailcontrol     7928/tcp                        # Mailsystem control" >> /etc/services

  If not already installed, install xinetd::

  apt-get install xinetd

Create xinetd service::

  editor /etc/xinetd.d/mailcontrol
  
  service mailcontrol
  {
    disable         = no
    socket_type     = stream
    protocol        = tcp
    wait            = no
    user            = vmail
    server          = /usr/local/cpves/runScripts.sh
    only_from       = 127.0.0.1
  }  

Copy over cpves system script::

  cp /var/www/virtual/cpves/html/system_scripts/runScripts.sh /usr/local/cpves/
  chmod +x /usr/local/cpves/runScripts.sh

Insecure Postfix
----------------

Insecure CpVES
--------------

Insecure nginx
--------------

