In the ``/var/log/wtmp`` section of ``/etc/logrotate.conf``,
set ``rotate`` to something really high, like 1000000000000.
This way, logs will never be deleted, only renamed to
``/var/log/wtmp.[0-9]*``.
