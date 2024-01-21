..  include:: /Includes.rst.txt

..  _introduction:

============
Introduction
============

This container set-up may be used as a development **environment to build
custom projects** based on the Cultural Heritage Framework (CHF). Depending on
whether you have a container-ready host with a solid firewall and a routine to
back up your data available, the set-up may even serve as a production
environment.

The **subfolder** ``project`` is designed to hold your project-specific content
as files that you can move from one host to anoter. The other subfolders
``config``, ``database``, ``search``, and ``app`` keep the runtime content of
your container available ("persistent") as you start, stop, destroy, or
re-create the containers using them.

If you want to use PHP-capable web space with a database instead, refer to the
`TYPO3 system requirements <https://docs.typo3.org/m/typo3/tutorial-getting-started/main/en-us/SystemRequirements/Index.html>`__
directly to see if the host fits the bill. In this case, the only relevant part
of CHF Container may be the ``composer.json`` template.

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
performs regular backups of the ``app`` folder and the database, at least.
