..  include:: /Includes.rst.txt

..  _useful-commands:

===============
Useful commands
===============

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

All Podman (or Docker) commands listed here work when accessing them from the
container folder.

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

      podman exec -it <project_name>_server bash

- Get out of the container's command-line interface:

  ..  code-block:: shell

      exit

- Execute a command inside the container straight from the host; replace
  ``ls -la`` with the command you need:

  ..  code-block:: shell

      podman exec -i <project_name>_server ls -la

..  _common-tasks:

Common tasks
============

The following tasks are common during development or may otherwise be **called
from the host system**. They are given as abbreviated one-liners here, but you
may just as well access the container's command line first and then run the
same command without ``podman exec -i <project_name>_server``,
``podman exec -i <project_name>_php`` or 
``podman exec -i <project_name>_database``, respectively.

- Update all PHP Composer packages:

  ..  code-block:: shell

      podman exec -i <project_name>_php composer update

- Require a new PHP Composer package; if it is in a non-standard repository
  like your own git instance, you first need to add the repo to your
  ``project/composer.json``:

  ..  code-block:: shell

      podman exec -i <project_name>_php composer require digicademy/chf_bib

- Update TYPO3's language packs:

  ..  code-block:: shell

      podman exec -i <project_name>_php typo3 language:update

- Restart the Apache server:

  ..  code-block:: shell

      podman exec -i <project_name>_server systemctl restart apache2

- Export the database as a file; you may need to change the root password:

  ..  code-block:: shell

      podman exec -i <project_name>_database mysqldump -uroot -ppassword chf > project/database.sql

- Import a database file; you may need to change the root password:

  ..  code-block:: shell

      podman exec -i <project_name>_database mysqldump -uroot -ppassword chf > project/database.sql
