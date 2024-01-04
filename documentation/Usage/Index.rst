..  include:: /Includes.rst.txt

..  _usage:

=====
Usage
=====

On a production system, the frontend should be available at the URL provided by
the host. Add ``/typo3`` to this URL to access the TYPO3 backend.

In a development environment, enter either ``localhost``, ``127.0.0.1`` or any
custom URL you have given to this IP address, such as ``chf.local`` to see the
frontend. Add ``/typo3`` to log into the backend.

..  _periodical-updates:

Periodical updates
==================

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker`` and ``podman compose`` with ``docker compose`` in all examples
    provided below. You may need to use ``podman-compose`` or
    ``docker-compose`` depending on your configuration.

The following steps should be performed periodically to **keep an existing
environment up to date**. This updates all Debian packages inside the virtual
web server and also incorporates any changes made to the required PHP packages.

..  code-block:: shell

    git pull && podman exec -i chf_web apt update && podman exec -i chf_web composer update

..  _update-all-containers:

Update all containers
=====================

Alternatively, and to update all containers at the same time, destroy and
rebuild the containers in one go. This action **includes both steps mentioned
above**, but it will lead to a brief downtime if performed in production while
the image is being rebuilt. Enter the container folder and execute the
following command:

..  code-block:: shell

    git pull && podman compose down && podman compose up -d

..  _back-up-content-files:

Back up content files
=====================

Make sure that you commit any important or permanent changes you make to your
clone of the environment so you can re-install it if necessary. Some files as
well as the database, however, are necessary to re-install the container but
should be collected outside this repo to avoid leaking user data, confidential
files, or passwords.

For this purpose, you can use a shell script and an additional command that
compile those content files and save them in the ``content`` folder. It is
recommended to find a good storage space for these in your organisation
or even to periodically call the shell script as part of a backup cron job.
The script can be called as follows from the container folder; you may need to
alter the root password, database name, and file name:

..  code-block:: shell

    sh ./contentbackup.sh && \
    podman exec -i chf_database mysqldump -uroot -ppassword t3_chf > content/chf_database.sql
