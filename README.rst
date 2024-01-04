..  image:: https://img.shields.io/badge/Container-Podman-purple.svg
    :alt: Podman
    :target: https://podman.io

..  image:: https://img.shields.io/badge/Container-Docker-blue.svg
    :alt: Docker
    :target: https://docker.io

..  image:: https://img.shields.io/badge/TYPO3-12-orange.svg
    :alt: TYPO3 12
    :target: https://get.typo3.org/version/12

..  image:: https://img.shields.io/badge/License-MIT-blue.svg
    :alt: License: MIT
    :target: https://spdx.org/licenses/MIT.html

=============
CHF Container
=============

This is a container set-up for development and production environments of
projects based on the Cultural Heritage Framework (CHF). It is designed to be
usable across projects with a folder reserved for project-specific files, which
should be stored separately. The set-up revolves around a file in accordance
with the `Compose specification <https://compose-spec.io/>`__ for
container-based applications that should allow you to set up your
environment(s) on Linux, macOS, or Windows via, for example, Podman Desktop or
Docker Desktop. The Compose file orchestrates a pod (or network) consisting of
an Apache webserver, a PHP- and PHP Composer-capable Debian image that runs
TYPO3, a MariaDB database, Manticore search, and a Postfix container for email
jobs. The documentation provides install instructions as well as a few pointers
towards how to use the container-based environment.

:Repository:  https://github.com/digicademy-chf/chf_container
:Read online: https://digicademy-chf.github.io/chf_container

Roadmap
=======

This is a pre-release version. The following steps are required for the
software to move out of beta:

- Moved to FPM container and separate Apache container
- Instructions to manage folder permissions added if necessary
- Fileadmin added to the instructions
- Proper Manticore conf added
- Namenforschung and Corpus Vitrearum tested, "dev" removed

In addition, the following features would be nice to have:

- Clarification on setting up SSL certificates
