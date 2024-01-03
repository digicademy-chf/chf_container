..  include:: /Includes.rst.txt

..  _useful-commands:

===============
Useful commands
===============

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker`` and ``podman compose`` with ``docker compose`` in all examples
    provided below. You may need to use ``podman compose`` or
    ``docker-compose`` depending on your configuration.

All Podman (or Docker) commands listed here work in the container folder.

..  _container-lifecycle:

Container lifecycle
===================

Containers are used to provide certain functionality that is relatively
isolated from the host system. As such, they may be created or destroyed and
existing containers may be started or stopped. The set-up provided here
persists all relevant data (configuration, server files, database, and search
index) in subfolders on the host system to make sure that the entire container
pod (or network) can be **safely destroyed and re-created**.

- Create and start containers:

  ..  code-block:: shell

      podman compose up -d

- Destroy containers:

  ..  code-block:: shell

      podman compose down

- Start existing containers:

  ..  code-block:: shell

      podman compose start

- Stop containers:

  ..  code-block:: shell

      podman compose stop

..  _accessing-containers:

Accessing containers
====================

While **files can be edited on the host system** if you follow the
:ref:`installation instructions <install-and-config>`, certain tasks may
require you to enter a specific container and perform a command-line action.
You can either access the command line inside the container and enter your
commands there, or use Podman (or Docker) to pass the command on to the
container for execution.

- Access the command line to run any command you need:

  ..  code-block:: shell

      podman exec -it chf_web bash

- Get out of the container's command-line interface:

  ..  code-block:: shell

      exit

- Execute a command inside the container straight from the host; replace ``ls
  -la`` with the command you need:

  ..  code-block:: shell

      podman exec -i chf_web ls -la

..  _common-tasks:

Common tasks
============

The following tasks are common during development or, for example, for the 
**host system to run** via a cron job or other scheduling services. They are
given as abbreviated one-liners here, but you may just as well access the
container's command line first and then run the same command without ``podman
exec -i chf_web`` or  ``podman exec -i chf_database``, respectively.

- Update all PHP Composer packages:

  ..  code-block:: shell

      podman exec -i chf_web composer update

- Require a new PHP Composer package; if it is in a non-standard repository
  like your own git instance, you first need to add the repo to
  ``web/composer.json``:

  ..  code-block:: shell

      podman exec -i chf_web composer require digicademy-chf/chf_bib

- Restart the Apache server:

  ..  code-block:: shell

      podman exec -i chf_web systemctl restart apache2

- Export the database as a file; you may need to change the root password and
  the name of the database to export depending on the config in your ``.env``
  file:

  ..  code-block:: shell

      podman exec -i chf_database mysqldump -uroot -ppassword t3_chf > chf_database.sql
