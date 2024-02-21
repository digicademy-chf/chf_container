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

..  _quick-install:

Quick install
=============

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

All commands for a **fresh install** with ``v1.0.0`` replaced by the release
tag you need:

..  code-block:: shell

    git clone https://github.com/digicademy-chf/chf_container.git --branch v1.0.0 && \
    cd chf_container && \
    cp template.development.env .env && \
    cp App/composer.template.json App/composer.json && \
    podman compose up -d && \
    podman exec -i <project_name>_php composer install

And two sets of commands for a **custom install** with ``v1.0.0`` replaced by
the release tag you need:

..  code-block:: shell

    git clone https://github.com/digicademy-chf/chf_container.git --branch v1.0.0 && \
    cd chf_container

Now add project-specific files and replace ``password`` by the actual root
password of the database and ``chf`` by the name of your database:

..  code-block:: shell

    podman compose up -d && \
    podman exec -i <project_name>_database mysql -uroot -ppassword chf < database.sql && \
    podman exec -i <project_name>_php composer install

..  _step-by-step:

Step by step
============

..  rst-class:: bignums

1.  Clone repository

    Clone this repo using the command below and the actual release tag you need
    instead of ``v1.0.0``.

    ..  code-block:: shell

        git clone https://github.com/digicademy-chf/chf_container.git --branch v1.0.0 && \
        cd chf_container

2.  Prepare custom content or fresh install

    If you have custom, projects-specific files, copy them into this folder.
    See :ref:`custom file overview <custom-file-overview>` for further details.

    If you want to set up a fresh install instead, execute the following
    command to use template files for the environment file and
    :file:`composer.json`:

    ..  code-block:: shell

        cp template.development.env .env && \
        cp App/composer.template.json App/composer.json

3.  Create and start containers

    Run this command to create all containers specified in the Compose file:

    ..  code-block:: shell

        podman compose up -d

    If you added existing data in the previous step, you will also want to
    import your existing database. Alter the root password if necessary:

    ..  code-block:: shell

        podman exec -i <project_name>_database mysql -uroot -ppassword chf < database.sql

4.  Install PHP packages

    The last required step is to install the PHP packages via PHP Composer. In
    a development environment, and to avoid issues with ``composer update``
    down the line, packages you want to work on locally can go into the
    :file:`App/packages` folder.

    ..  code-block::

        podman exec -i <project_name>_php composer install

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
``chf.local:8080`` or any other specified alias depending on whether and how
you executed the last step.

..  _add-phpmyadmin:

Add phpMyAdmin
==============

On a development system (not in production), you may want to be able to inspect
the database. You can create a phpMyAdmin container along with the regular
containers using the ``debug`` profile. Use this command instead of the one
listed in step 3:

    ..  code-block:: shell

        podman compose --profile=debug up -d

When the installation is done, phpMyAdmin is available on port ``8081`` or any
other port you specified in your ``.env`` file.
