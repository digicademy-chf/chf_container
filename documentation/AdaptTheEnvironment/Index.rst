..  include:: /Includes.rst.txt

..  _adapt-the-environment:

=====================
Adapt the environment
=====================

The container template provided at `chf_project_container
<https://github.com/digicademy-chf/chf_project_container>`__ may be adapted to
other projects, whether they use the Cultural Heritage Framework and TYPO3 or
not. To use the template as a developement and/or production environment,
**fork the original repo**, adjust the items listed below, and then push the
changes to your own repo.

..  _items-to-adjust:

Items to adjust
===============

1. In ``compose.yml``, change all ``container_name``s and ``network`` names to
   something specific to your project. This allows for installing multiple CHF
   project pods (or networks) on the same host.
2. In ``config/php/php.ini``, change the server admin's email address two
   times.
3. Adjust ``.env.development`` to your needs.
4. Edit ``web/composer.json`` to point to the repository and name of your TYPO3
   sitepackage. If you are just getting started, fork the boilerplate
   `CHF Project <https://github.com/digicademy-chf/chf_project>`__, adjust its
   name and settings, and provide its new credentials here.
5. Adapt the file ``web/config/sites/chf/config.yaml`` to your needs and change
   the folder name ``chf``. If you need more orientation, simply delete the
   entire ``chf`` folder, run TYPO3's post-installation routine and use the
   ``config.yaml`` produced in the guided process.
6. Optionally adapt ``Readme.rst`` and ``Citation.cff`` to your project's name,
   description, and contributors to differentiate it from the template.
7. Optionally revise the commands provided in the ``documentation`` folder to
   fit your project's container names.
8. Optionally, if you want to use this set-up as a production environment, fill
   in and securely store the ``.env.production`` file as well as two
   certificate files ``config/apache2/ssl/000-default-ssl.pem`` and
   ``config/apache2/ssl/000-default-ssl.key`` outsite any public (or
   potentially public) repo.

Depending on the amount of things you alter, periodically **pulling changes
from the forked original repo** may become more cumbersome. If you make changes
that other users of the container template may also benefit from, please
consider contributing them upstream.

..  _production-hosts:

Production hosts
================

Please note that under production conditions, this simple container set-up is
designed to **run on a host** that directs traffic towards the webserver
container, redirects port 80 to port 443, features more robust firewall
settings, and performs regular backups of the ``web`` folder and the database.
