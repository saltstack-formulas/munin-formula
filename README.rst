munin
=====
``munin`` is a monioring application with a master/node architecture. The master periodically connects to each node and collects information from it. The nodes each run a ``munin-node`` service that listens for these connections.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``munin.master``
----------------

Installs the munin master package.

The master runs as a cronjob, not a service. The distro packages normally automatically create those.

``munin.master.config``
-----------------------

Includes ``munin.master``.

Generates a config file for the munin master based on pillar data.

``munin.node``
--------------

Installs the munin node package and enables the node service.

``munin.node.config``
---------------------

Includes ``munin.node``.

Generates a config file for the munin node based on pillar data.

``munin.tls``
-------------

Installs the Perl package Net::SSLEay so munin can use TLS.
    
Also, if the private key, certificate, or CA certificate are specified (as in ``pillar.example``), then the appropriate files are created. Note that it is up to the user to correctly specify the location of these files in their master and node config files.

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

TLS
---
Consult http://munin-monitoring.org/wiki/MuninConfigurationNetworkTLS.

Instructions for the non-paraonid TLS setup:

1. Generate a private key. For this example, we create a 1024-bit key: ``openssl genrsa -out private.pem 1024``
#. Create a Certificate Signing Reqest: ``openssl req -new -key private.pem -out request.csr``
#. Generate a self-signed certificate: ``openssl x509 -req -in request.csr -signkey private.pem -out certificate.crt``
#. Inline the contents of ``private.pem`` into ``pillar['munin_tls']['private_key']``.
#. Inline the contents of ``certificate.crt`` into ``pillar['munin_tls']['certificate_pem']``.
#. Optional: delete the ``private.pem``, ``request.csr``, and ``certificate.crt`` files you generated. They aren't really needed now that you've inlined the important stuff into pillar.
#. Update your munin config to enable TLS and also to point to the salt-managed PEM files. The default paths where this salt formula puts the PEM files are specified in ``munin/map.jinja``
