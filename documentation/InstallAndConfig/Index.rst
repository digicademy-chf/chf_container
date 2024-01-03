..  include:: /Includes.rst.txt

..  _install-and-config:

==================
Install and config
==================

To install this container set-up, your system needs either **Podman Desktop**
with the Compose engine enabled (:guilabel:`Settings`, :guilabel:`Resources`),
Docker Desktop, ``podman`` and ``podman-compose`` as command-line tools, or
Docker Engine as a command-line tool. In addition, Git is highly recommended.

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker`` and ``podman compose`` with ``docker compose`` in all examples
    provided below. You may need to use ``podman-compose`` or
    ``docker-compose`` depending on your configuration.

..  rst-class:: bignums

1.  Clone the repository

    Clone this repo via ``git clone`` and its SSH address or the HTTPS
    equivalent. The alternative route is not recommended as it does not allow
    for simple ``git pull`` updates of the resulting container environment:
    downloading the repo as a ZIP file and unpacking it.

2.  Choose the right environment file

    For a development environment, copy `.env.development` and rename it to
    `.env`. For a production environment, use `.env.production` instead and
    fill in the right credentials for your production environment.

3.  Start fresh or use existing data

    Pick one of the two paths listed below to either start with a new TYPO3 and
    CHF install or to use existing TYPO3 and CHF data to populate your project.

    ..  rst-class:: bignums

    a.  Blank installation

        Execute the following command to signal TYPO3 that you want to use its
        post-installation routine after the set-up is done:

        ..  code-block:: shell

            touch web/public/FIRST_INSTALL

    b.  Existing data

        To set up an environment based on existing TYPO3 and CHF data, you need
        a set of additional files that should not be included in public (or
        potentially public) repos due to user data and passkeys, but need to be
        available somewhere in your organisation to allow for a fully
        host-agnostic set-up. To apply them to a new install, save the files to
        the following file paths relative to the cotainer folder:

        - **settings.php**: web/config/system/settings.php
        - **public.zip**: web/public.zip, unpacked as /web/public
        - **TBD fileadmin**
        - **chf_database.sql**: chf_database.sql

        In addition, the following two files are required for production
        environments. For an entirely new production environment, you may need
        to use a cert bot to produce these two files via Let's Encrypt or
        another certificate authority.

        - **000-default-ssl.pem**: config/apache2/ssl/000-default-ssl.pem
        - **000-default-ssl.key**: config/apache2/ssl/000-default-ssl.key

4.  Create and start the containers

    Open a command-line interface in the container folder. Run the following
    commands to create all containers specified in the Compose file.

    ..  code-block:: shell

        podman compose up -d

    If you want to import an existing database, now is the time. Use the
    following command and alter the root password, database name, and file name
    to fit your data if necessary:

    ..  code-block:: shell

        podman exec -i chf_database mysql -uroot -ppassword t3_chf < chf_database.sql

5.  Install all required PHP packages

    When this is done, the following command retrieves all PHP packages
    required to run TYPO3 and the CHF.

    ..  code-block:: shell

        podman exec -i chf_web composer update && podman exec -i chf_web typo3 language:update

6.  Optionally set an alias for ``localhost`` 

    For a development environment, you may want to set up a local domain in the
    host operating system to help access the web app. On Linux or macOS, add
    the following line to the file ``/etc/hosts``.  On Windows, add it to
    ``C:\Windows\System32\Drivers\etc\hosts``:

    ..  code-block::

        127.0.0.1  chf.local

You can **now use** your TYPO3 and CHF installation. If you specified that you
want to start with no existing data, your first website visit will trigger the
post-installation routine that helps you set up a new database.
