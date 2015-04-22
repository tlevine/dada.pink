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
