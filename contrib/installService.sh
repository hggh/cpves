#!/bin/bash
echo "mailcontrol     7928/tcp                        # Mailsystem control" >> /etc/services
echo "service mailcontrol
{
        disable         = yes
        socket_type     = stream
        protocol        = tcp
        wait            = no
        user            = vmail
        server          = /etc/cpves/runScripts.sh
        only_from       = 127.0.0.1
}" >> /etc/xinetd.d/mailcontrol
