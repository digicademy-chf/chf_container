..  include:: /Includes.rst.txt

..  _usage:

=====
Usage
=====

On a production system, the frontend is available from your browser at the URL
provided by the host. In a development environment, enter ``127.0.0.1``,
``localhost``, or any other **host alias** such as ``chf.local`` to see the
frontend. Add ``/typo3`` to the URL to access the TYPO3 backend.

..  _periodical-updates:

Periodical updates
==================

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

The following steps should be performed periodically to **keep an existing
environment up to date**. This updates all Debian packages inside the virtual
web server and also incorporates any changes made to the required PHP packages.

..  code-block:: shell

    podman exec -i <project_name>_web apt update && \
    podman exec -i <project_name>_web composer update

..  _update-all-containers:

Update all containers
=====================

Alternatively, and to update all containers at the same time, destroy and
rebuild the containers in one go. This action **includes both steps mentioned
above**, but it will lead to a brief downtime if performed in production while
the image is being rebuilt. Enter the container folder and execute the
following command:

..  code-block:: shell

    podman compose down && \
    podman compose up -d

..  _back-up-content-files:
