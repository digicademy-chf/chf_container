..  include:: /Includes.rst.txt

..  _install-and-config:

==================
Install and config
==================

To install this container set-up, your host system needs:

- A container engine with Compose support, such as
  - Podman Desktop with Compose enabled (:guilabel:`Settings`, :guilabel:`Resources`)
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

1.  Clone the repository

    Clone this repo using the command below and the actual release tag you need
    instead of ``v1.0.0``. The alternative route is not recommended as it does
    not allow for simple updates of the resulting container environment: just
    download a release package and unpack it.

    ..  code-block:: shell

        git clone https://github.com/digicademy-chf/chf_container.git --branch v1.0.0 && \
        cd chf_container

2.  Add your own content

    If you have used this container set-up before, just copy all
    project-specific files into the ``project`` folder. See
    :ref:`custom file overview <custom-file-overview>` for details about which
    files are required and which ones are only needed in production
    environments.

    If you want to set up a brand new development environment instead, copy
    the files ``.env.development`` (renamed to ``.env``), ``FIRST_INSTALL``,
    and ``composer.json`` from ``project.template`` to the ``project`` folder:

    ..  code-block:: shell

        cp project.template/.env.development project/.env && \
        cp project.template/FIRST_INSTALL project/FIRST_INSTALL && \
        cp project.template/composer.json project/composer.json

    Change the content of the PHP Composer file (``composer.json``) to point
    to your project's own TYPO3 sitepackage. Feel free to clone the boilerplate
    `CHF Project <https://github.com/digicademy-chf/chf_project>`__ as a
    template for your sitepackage to house all project-specific TYPO3 code.

    On Debian-based hosts and on Docker Desktop, permissions of mounted files
    and folders should not be an issue. On other hosts,
    :ref:`manage permissions <manage-permissions>` before you continue.

3.  Create and start the containers

    Run this command to create all containers specified in the Compose file:

    ..  code-block:: shell

        podman compose up -d

    If you added existing data to the ``project`` folder in the previous step,
    you will also want to import the database. Alter the root password of the
    new database if necessary:

    ..  code-block:: shell

        podman exec -i <project_name>_database mysql -uroot -ppassword chf < project/database.sql

4.  Optionally set an alias for ``localhost`` 

    For a development environment, you may want to set up an alias as a local
    domain in the host operating system to help access the web app. On Linux
    or macOS, add the line below to the file ``/etc/hosts`` using the alias that
    you want. On Windows, add it to ``C:\Windows\System32\Drivers\etc\hosts``.

    ..  code-block::

        127.0.0.1  chf.internal

**Congratulations**, you can now use your TYPO3 and CHF installation! A
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

..  _manage-permissions:

Manage permissions
==================

To grant the containers access to the volumes they mount, you need to make sure
that the permissions are correct. If you use Podman, non-root users inside the
container will be mapped to a subset of user IDs that the non-root host user
has access to. Use the following commands in the container folder on the host
to grant the correct permissions:

```
podman unshare chown 33:33 -R app && \
podman unshare chown 33:33 -R config/apache/apache.vhost.conf && \
podman unshare chown 33:33 -R config/apache/ssl && \
podman unshare chown 33:33 -R project/composer.json && \
podman unshare chown 33:33 -R project/fileadmin && \
podman unshare chown 33:33 -R project/settings.php && \
podman unshare chown 33:33 -R project/sites && \
podman unshare chown 33:33 -R project/cert.key && \
podman unshare chown 33:33 -R project/cert.crt && \
podman unshare chown 33:33 -R project/FIRST_INSTALL && \
podman unshare chown 999:999 -R database && \
podman unshare chown 999:999 -R config/manticore/manticore.conf && \
podman unshare chown 999:999 -R search
```

project/.env -> .env
project/composer.json -> app/composer.json
project/sites -> app/config/sites
project/settings.php -> app/config/system/settings.php
project/FIRST_INSTALL -> app/public/FIRST_INSTALL
project/fileadmin -> app/public/fileadmin
project/cert.key -> config/apache/ssl/cert.key
project/cert.crt -> config/apache/ssl/cert.crt
AND database.sql
DANN project und project.template weg?