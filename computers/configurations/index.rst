# Configurations
Here are some changes I like to make in configuration files but have
not scripted.

## wtmp logs
wtmp checks login records. I use this to see which IP addresses I have
logged into my own servers from. Since I usually log into one of these
servers every time I connect to the internet, wtmp records almost all
of the IP addresses that I use.

By default, only a very short history is kept in the log.
Here is how to change that.

In the ``/var/log/wtmp`` section of ``/etc/logrotate.conf``,
set ``rotate`` to something really high, like 1000000000000.
This way, logs will never be deleted, only renamed to
``/var/log/wtmp.[0-9]*``.

## SSH ports
Firewalls often block port 22, so it is helpful for sshd to listen on
other ports. I suggest adding the following lines to ``sshd_config``
if you're not otherwise using the ports.

    Port 25
    Port 110
    Port 143
    Port 443

These correspond to SMTP, something I forgot, something else I forgot,
and HTTPS. Exclude lines corresponding to services that you're actually
running.
