..  include:: /Includes.rst.txt

..  _introduction:

============
Introduction
============

This container set-up may be used as a development **environment to build
custom projects** based on the Cultural Heritage Framework (CHF). Depending on
whether you have a container-ready host with a solid firewall and a routine to
back up your data, the set-up may also serve as a production environment.

The **subfolder** ``Config`` contains set-up information while ``App``,
``Database``, ``Files``, ``Graph``, ``Search``, ``Table``, and ``Tablebase``
keep the runtime content of containers available (persistent) on the host as
you start, stop, destroy, or re-create them. Please note that the environment
ignores project-specific files such as an :file:`.env` file and a
:file:`composer.json`: these should be stored in a separate location as files
that you add to the content of this repo to set up your environment on a new
host.

If you want to set up a CHF-capable environment with a hoster that does not
allow further containerisation but provides PHP-capable web space and a
database, the most relevant file you need is :file:`composer.json`. Check the
`TYPO3 system requirements <https://get.typo3.org/version/13#system-requirements>`__
to see if your hoster ticks all required boxes.

..  _screenshots:

Screenshots
===========

TBD

..  _production-hosts:

Production hosts
================

Please note that under production conditions, this simple container set-up is
designed to **run on a host** that directs traffic towards the webserver
container, manages its ports, features more robust firewall settings, and
performs regular backups of, at least, the ``App`` folder and the database.
