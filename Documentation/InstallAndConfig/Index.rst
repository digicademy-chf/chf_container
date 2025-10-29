..  include:: /Includes.rst.txt

..  _install-and-config:

==================
Install and config
==================

To install this container set-up, your host system needs:

- A container engine with Compose support, such as

  - Podman Desktop
  - or its command-line tools ``podman`` and ``podman-compose``
  - or Docker Desktop
  - or its command-line tool Docker Engine

- Git

..  _step-by-step:

Step by step
============

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

..  rst-class:: bignums

1.  Clone repository

    Clone this repo using the command below and, optionally, the actual release
    tag you need instead of ``v1.0.0``.

    ..  code-block:: shell

        git clone https://github.com/digicademy-chf/chf_container.git --branch v1.0.0 && \
        cd chf_container

2.  Prepare custom content or fresh install

    If you want to set up a fresh install, execute the following command to use
    template files for the environment file and :file:`composer.json`:

    ..  code-block:: shell

        cp template.development.env .env && \
        cp App/composer.development.json App/composer.json

    If you want to use custom, projects-specific files instead, copy them into
    the :file:`chf_container` folder. See
    :ref:`custom file overview <custom-file-overview>` for further details.

    For production environments, replace ``development`` with ``production`` in
    the two commands listed above.

3.  Create and start containers

    Run this command to create all containers specified in the Compose file:

    ..  code-block:: shell

        podman compose up -d

4.  Install PHP packages

    The last required step is to install the PHP packages via PHP Composer.
    The following commands set up a fresh environment:

    ..  code-block::

        podman exec -i chf_app composer install && \
        podman exec -i chf_app ./vendor/bin/typo3 setup --force

    To set up an environment using existing data, retrieve the PHP packages
    and import an existing database instead. Replace ``chf`` and ``password``
    with the actual data of your customised set-up:

    ..  code-block::

        podman exec -i chf_app composer update && \
        podman exec -i chf_database mariadb -uroot -ppassword chf_t3 < database.sql

5.  Optionally set an alias for ``localhost``

    For a development environment, you may want to set up an alias as a local
    domain in the host operating system to help access the web app. On Linux
    or macOS, add the line below to the file :file:`/etc/hosts` using the alias that
    you want. On Windows, add it to :file:`C:\\Windows\\System32\\Drivers\\etc\\hosts`.

    ..  code-block::

        127.0.0.1  chf.internal

**Congratulations**, you can now use your TYPO3 and CHF installation. A
production environment will now be available at the host's URL. A development
environment can be found at ``127.0.0.1:8080``, ``localhost:8080``,
``chf.internal:8080`` or any other specified alias depending on whether and how
you executed the last step.

In a fresh install, you may want to log in to TYPO3 as admin, navigate to
:guilabel:`Settings`, :guilabel:`Configure Installation-Wide Options`, and
:guilabel:`[SYS][systemLocale]`. Here you may set the locale for system-wide
actions such as setting file names by entering the name of a Linux locale to
use, such as ``en_US.UTF-8`` or ``de_DE.UTF-8``.

..  _add-cron:

Add a cron job
==============

TYPO3 has a scheduler that allows you to clear caches and perform other regular
tasks. For the scheduler to run properly, add the following cron job on the
host. This is especially important in a production environment. On a regular
Linux system, you may add a file ``/etc/cron.d/chf-scheduler`` with the
following content:

..  code-block:: cron

* * * * * www-data podman exec -i chf_app /var/www/html/vendor/bin/typo3 scheduler:run

You may need to replace ``www-data`` with the user running the container,
``podman`` with ``docker``, and ``chf_app`` with the actual name of your
project's PHP container. In Kubernetes environments, the command may be adapted
for use with ``CronJob``.

..  _add-oxigraph:

Add a SPARQL endpoint
=====================

You can create an Oxigraph container along with the regular containers by
adding the ``graph`` profile name to the ``COMPOSE_PROFILES`` variable of your
``.env`` file and restart the container setup.

Oxigraph becomes available on port ``8878`` or any other port you specify in
``.env``.

..  _add-nocodb:

Add a tablar database
=====================

You can create a NoCoDB container along with the regular containers by adding
the ``table`` profile name to the ``COMPOSE_PROFILES`` variable of your
``.env`` file and restart the container setup.

To install an exisiting NoCoDB database from a file, run:

..  code-block::

    podman exec -i chf_tablebase mariadb -uroot -ppassword chf_nc < tablebase.sql

NoCoDB becomes available on port ``8090`` or any other port you specify in
``.env``.

..  _add-phpmyadmin:

Add a database inspection tool
==============================

On a development system (not in production), you may want to be able to inspect
the TYPO3 database. You can create a phpMyAdmin container along with the
regular containers by adding the ``inspect`` profile name to the
``COMPOSE_PROFILES`` variable of your ``.env`` file and restart the container
setup.

When the installation is done, phpMyAdmin is available on port ``8081`` or any
other port you specify in ``.env``.
