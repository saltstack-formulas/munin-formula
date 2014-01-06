munin
=====
``munin`` is a monioring application with a master/node architecture. The master periodically connects to each node and collects information from it. The nodes each run a ``munin-node`` service that listens for these connections.

States
======
``munin.master``
    Installs the munin master package. The master runs as a cronjob, not a service. The distro packages normally automatically create those.
``munin.master.config`` (includes ``munin.master``)
    Generates a config file for the munin master based on pillar data.
``munin.node``
    Installs the munin node package and enables the node service.
``munin.node.config`` (includes ``munin.node``)
    Generates a config file for the munin node based on pillar data.

Configuration
=============
The ``pillar.example`` has example pillar data for both the master and node, though ``munin.master.config`` only uses data from ``munin_master`` and ``munin.node.config`` only uses data from ``munin_node``.

Master Config
-------------
Consult http://munin-monitoring.org/wiki/munin.conf and ``man munin.conf`` for the full list of directives.

Node Config
-----------
Consult http://munin-monitoring.org/wiki/munin-node.conf and ``man munin-node.conf`` for the full list of directives.

For node configuration directives that allow repetition (ie: ``ignore_files``), make ``pillar['munin_node']['ignore_files']`` a list of values (see ``pillar.example`` for an example of this).
