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

    Clone this repo using the command below:

    ..  code-block:: shell

        git clone https://github.com/digicademy-chf/chf_container.git

2.  Set up a fresh install or apply custom files

    If you want to set up a fresh install, execute the following command to
    produce an environment file and a :file:`composer.json` from templates.
    For production environments, replace ``development`` with ``production``:

    ..  code-block:: shell

        cd chf_container && \
        cp template.development.env .env && \
        cp App/composer.development.json App/composer.json

    Alternatively, if you want to apply existing project-specific files, copy
    them into the :file:`chf_container` folder now. See the
    :ref:`custom file overview <custom-file-overview>` for a list of common
    files.

3.  Start containers

    Run this command to pull and start all containers specified in the Compose
    file:

    ..  code-block:: shell

        podman compose up -d

4.  Initialise PHP packages

    Install the PHP packages via PHP Composer. The following commands set up a
    fresh environment:

    ..  code-block::

        podman exec -i chf_app composer install && \
        podman exec -i chf_app ./vendor/bin/typo3 setup --force

    To alternatively set up an environment using existing data, only retrieve
    the PHP packages and import an existing database as outlined below. Replace
    ``chf`` and ``password`` with the actual data of your customised set-up:

    ..  code-block::

        podman exec -i chf_app composer install && \
        podman exec -i chf_database mariadb -uroot -ppassword chf_t3 < database.sql

5.  Optionally set an alias for ``localhost``

    For a development environment, you may want to set up an alias as a local
    domain in the host operating system to help access the web app. On Linux
    or macOS, add the line below to the file :file:`/etc/hosts` using an alias
    you want. On Windows, add it to
    :file:`C:\\Windows\\System32\\Drivers\\etc\\hosts` instead:

    ..  code-block::

        127.0.0.1  chf.internal

**Congratulations**, you can now use your TYPO3 and CHF installation. A
production environment will now be available at URL set up in the host's
reverse proxy. A development environment can be found at ``127.0.0.1:8080``,
``localhost:8080``, ``chf.internal:8080`` or any other specified alias
depending on whether and how you executed the last step.

In a fresh install, you may first want to log in to TYPO3 as admin, navigate to
:guilabel:`Settings`, :guilabel:`Configure Installation-Wide Options`, and
:guilabel:`[SYS][systemLocale]`. Here you may set the **locale** for
system-wide actions such as setting file names by entering the name of a Linux
locale to use, such as ``en_US.UTF-8`` or ``de_DE.UTF-8``.

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
``podman`` with ``docker``, and ``chf`` with the actual name of your project.

..  _add-oxigraph:

Add a SPARQL endpoint
=====================

You can create an Oxigraph container along with the regular containers by
adding the ``graph`` profile name to the ``COMPOSE_PROFILES`` variable of your
:file:`.env` file. Then restart the container setup.

Oxigraph becomes available on port ``8878`` or any other port you specify in
:file:`.env`.

..  _add-nocodb:

Add a tablar database
=====================

You can create a NoCoDB container along with the regular containers by adding
the ``table`` profile name to the ``COMPOSE_PROFILES`` variable of your
:file:`.env` file. Then restart the container setup.

To install an exisiting NoCoDB database from a file, run:

..  code-block::

    podman exec -i chf_tablebase mariadb -uroot -ppassword chf_nc < tablebase.sql

NoCoDB becomes available on port ``8090`` or any other port you specify in
:file:`.env`.

..  _add-webdav:

Add a WebDAV file storage
=========================

You can create a WebDAV file storage container along with the regular
containers by adding the ``files`` profile name to the ``COMPOSE_PROFILES``
variable of your :file:`.env` file. Then restart the container setup.

User names and hashed passwords need to be provided in a custom file at
:file:`Config/httpd-dav/auth/.htpasswd`. The WebDAV endpoint becomes available
on port ``8463`` for production environments with SSL enabled, ``8100`` for
development environments, or any other port you specify in :file:`.env`.

..  _add-phpmyadmin:

Add a database inspection tool
==============================

On a development system (not in production!), you may want to be able to
inspect the TYPO3 database. You can create a phpMyAdmin container along with
the regular containers by adding the ``inspect`` profile name to the
``COMPOSE_PROFILES`` variable of your :file:`.env` file. Then restart the
container setup.

When the installation is done, phpMyAdmin is available on port ``8081`` or any
other port you specify in :file:`.env`.
