..  include:: /Includes.rst.txt

..  _introduction:

============
Introduction
============

This container set-up may be used as a development **environment to build
custom projects** based on the Cultural Heritage Framework (CHF). Depending on
whether you have a container-ready host with a solid firewall and a backup
routine available, it may even serve as a production environment.

The **subfolder** ``project`` is designed to hold your project-specific content
as files that you can move from one host to anoter. The other subfolders
``config``, ``database``, ``search``, and ``web`` keep the runtime content of
your container available ("persistent") as you start, stop, destroy, or
re-create the containers using them.

..  _screenshots:

Screenshots
===========

TBD

..  _production-hosts:

Production hosts
================

Please note that under production conditions, this simple container set-up is
designed to **run on a host** that directs traffic towards the webserver
container, redirects port 80 to port 443, features more robust firewall
settings, and performs regular backups of the ``web`` folder and the database.