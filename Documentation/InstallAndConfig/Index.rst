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

    Clone this repo using the command below and the actual release tag you need
    instead of ``v1.0.0``.

    ..  code-block:: shell

        git clone https://github.com/digicademy-chf/chf_container.git --branch v1.0.0 && \
        cd chf_container

2.  Prepare custom content or fresh install

    If you want to set up a fresh install, execute the following command to use
    template files for the environment file and :file:`composer.json`:

    ..  code-block:: shell

        cp template.development.env .env && \
        cp App/composer.template.json App/composer.json

    If you want to use custom, projects-specific files instead, copy them into
    the :file:`chf_container` folder. See
    :ref:`custom file overview <custom-file-overview>` for further details.

3.  Create and start containers

    Run this command to create all containers specified in the Compose file:

    ..  code-block:: shell

        podman compose up -d

4.  Install PHP packages

    The last required step is to install the PHP packages via PHP Composer.
    The following commands set up a fresh environment:

    ..  code-block::

        podman exec -i <project_name>_php composer install && \
        podman exec -i <project_name>_database mariadb-admin -uroot -ppassword drop information_schema && \
        podman exec -i <project_name>_php ./vendor/bin/typo3 setup --force

    To set up an environment using existing data, retrieve the PHP packages
    and import an existing database instead:

    ..  code-block::

        podman exec -i <project_name>_php composer update && \
        podman exec -i <project_name>_database mariadb-admin -uroot -ppassword drop information_schema && \
        podman exec -i <project_name>_database mariadb -uroot -ppassword chf_t3 < database.sql

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
