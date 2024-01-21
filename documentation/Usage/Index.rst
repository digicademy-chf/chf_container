..  include:: /Includes.rst.txt

..  _usage:

=====
Usage
=====

On a production system, the frontend is available from your browser at the URL
provided by the host. In a development environment, enter ``127.0.0.1:8080``,
``localhost:8080``, or any other **host alias** such as ``chf.local:8080`` to
see the frontend. Add ``/typo3`` to the URL to access the TYPO3 backend.

..  _quick-periodical-updates:

Quick periodical updates
========================

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

The following steps should be performed periodically to **keep an existing
environment up to date**. This only updates the PHP packages inside the virtual
PHP environment.

..  code-block:: shell

    podman exec -i <project_name>_php composer update

..  _update-all-containers:

Update all containers
=====================

Alternatively, and to update all containers at the same time including the
various Debian packages they contain, destroy and rebuild the containers in one
go. This action **includes the PHP Composer update mentioned above** and is
thus ideal to update the entire stack, but it leads to a brief downtime while
the images are being rebuilt. Enter the container folder and execute the
following command:

..  code-block:: shell

    podman compose down && \
    podman compose up -d
