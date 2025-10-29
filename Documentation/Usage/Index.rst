..  include:: /Includes.rst.txt

..  _usage:

=====
Usage
=====

On a production system, the frontend is available from your browser at the URL
provided by the host. In a development environment, enter ``127.0.0.1:8080``,
``localhost:8080``, or any other **host alias** such as ``chf.internal:8080``
to see the frontend. Add ``/typo3`` to the URL to access the TYPO3 backend.

The optional components become available via these URLs:

- SPARQL endpoint (Oxigraph)): ``127.0.0.1:8878``, ``localhost:8878``, or ``chf.internal:8878``
- Tabular database (NoCoDB)): ``127.0.0.1:8090``, ``localhost:8090``, or ``chf.internal:8090``
- Inspection tool (phpMyAdmin): ``127.0.0.1:8081``, ``localhost:8081``, or ``chf.internal:8081``

..  _quick-periodical-updates:

Quick periodical updates
========================

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

The following steps may be performed periodically to **keep an existing
environment up to date**. This only updates the Debian and the PHP packages
inside the server and PHP containers. Adjust ``chf`` as required:

..  code-block:: shell

    podman exec -i chf_server apt-get update && \
    podman exec -i chf_app apt-get update && \
    podman exec -i chf_app composer update

..  _update-all-containers:

Update all containers
=====================

Alternatively, and to update all containers at the same time, destroy, prune,
and rebuild the containers in one go. This action includes the PHP Composer
update mentioned above and is thus ideal to update the full stack, but it leads
to a short downtime while the images are being downloaded again and rebuilt.
Enter the container folder and execute the following command:

..  code-block:: shell

    podman compose down && \
    podman system prune && \
    podman compose up -d

Leaving out the prune command means that your container management software may
use an existing container as is instead of updating it.
