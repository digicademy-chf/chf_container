..  image:: https://img.shields.io/badge/Container-Podman-purple.svg
    :alt: Podman
    :target: https://podman.io

..  image:: https://img.shields.io/badge/Container-Docker-blue.svg
    :alt: Docker
    :target: https://docker.io

..  image:: https://img.shields.io/badge/TYPO3-13-orange.svg
    :alt: TYPO3 13
    :target: https://get.typo3.org/version/13

..  image:: https://img.shields.io/badge/License-MIT-blue.svg
    :alt: License: MIT
    :target: https://spdx.org/licenses/MIT.html

=============
CHF Container
=============

**This version is designed for use with TYPO3 13.**

This is a container set-up for development and production environments of
projects based on the Cultural Heritage Framework (CHF). It is designed to be
usable across projects to either produce a fresh installation or to use a set
of project-specific files, which should be stored separately. The set-up
revolves around a file in accordance with the
`Compose specification <https://compose-spec.io/>`__ for container-based
applications that should allow you to set up your environment(s) on Linux,
macOS, or Windows via, for example, Podman Desktop or Docker Desktop. The
Compose file orchestrates a network consisting of an Apache webserver, a PHP-
and PHP Composer-capable Debian image that runs TYPO3, a MariaDB database,
Manticore search, Oxigraph triple store, and a Postfix container for email
jobs. An optional ``debug`` profile adds phpMyAdmin to this set-up. The
documentation provides install instructions as well as a few pointers towards
how to use the container-based environment.

:Repository:  https://github.com/digicademy-chf/chf_container
:Read online: https://digicademy-chf.github.io/chf_container

Roadmap
=======

This is a pre-release version. The following steps are required for the
software to move out of beta:

- Remove "dev" indicators to only use public packages

In addition, the following features are nice to have:

- Apache rewrites for Meilisearch and Oxigraph as required
- Clarification on setting up SSL certificates
