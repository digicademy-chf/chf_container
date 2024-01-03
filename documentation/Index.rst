..  include:: /Includes.rst.txt

.. _start:

=====================
CHF Project Container
=====================

:Package name:
    digicademy/chf_project_container

:Version:
    |release|

:Language:
    en

:Author:
    `Jonatan Jalle Steller <mailto:jonatan.steller@adwmainz.de>`__,
    CHF Project Container contributors

:License:
    This document is published under the
    `CC BY 4.0 <https://creativecommons.org/licenses/by/4.0/>`__
    license.

:Rendered:
    |today|

----

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

----

**Table of contents:**

..  toctree::
    :maxdepth: 2
    :titlesonly:

    Introduction/Index
    AdaptTheEnvironment/Index
    InstallAndConfig/Index
    Usage/Index
    UsefulCommands/Index
    Maintenance/Index

..  Meta Menu

..  toctree::
    :hidden:

    Sitemap
