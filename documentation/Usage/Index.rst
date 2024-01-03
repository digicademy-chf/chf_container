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
above**, but it will lead to a brief downtime if performed in production. Enter
the container folder and execute the following command:

..  code-block:: shell

    git pull && podman compose down && podman compose up -d

..  _generate-files-for-further-installations:

Generate files for further installations
========================================

Make sure that you commit any important or permanent changes you make to your
fork of this environment so you can re-install it if necessary. In addition,
it is recommended that you periodically produce four files (in addition to the
two SSL certificate files required for production environment) and collect them
outside your repo as they may contain sensitive information. The collection
process could be automated on a host as part of a regular backup or performed
manually depending on your use case. The four files are:

- **web/config/system/settings.php**: use file as is.
- **web/public**: ZIP all content of this folder into ``public.zip``.
- **TBD fileadmin**
- **chf_database.sql**: use the following command in the container folder and
  change root password and database name if necessary.

..  code-block:: shell

    podman exec -i chf_database mysqldump -uroot -ppassword t3_chf > chf_database.sql
