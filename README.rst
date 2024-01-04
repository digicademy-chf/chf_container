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

=====================
CHF Project Container
=====================

This is a template for development and production environments of projects
based on the Cultural Heritage Framework (CHF). It is designed to be cloned and
adapted, and it includes a ``Containerfile`` with build instructions for a
webserver container capable of running TYPO3 and the CHF extensions. The set-up
revolves around a file in accordance with the `Compose specification
<https://compose-spec.io/>`__ for container-based applications and may be run
on Linux, Windows, or macOS using, for example, Podman Compose or Docker
Compose. The Compose file orchestrates a pod (or network) consisting of
standard Debian image with a few added packages and config options like a PHP
Composer config, a MariaDB database, Manticore search, and a Postfix container
for email jobs.

:Repository:  https://github.com/digicademy-chf/chf_project_container
:Read online: https://digicademy-chf.github.io/chf_project_container

Roadmap
=======

This is a pre-release version. The following steps are required for the
software to move out of beta:

- Add instructions to manage folder permissions if necessary
- Add fileadmin to the file backup/restore shell scripts and install list
- Namenforschung and Corpus Vitrearum tested, Manticore conf, "dev" removed

In addition, the following features would be nice to have:

- Clarification on setting up SSL certificates
