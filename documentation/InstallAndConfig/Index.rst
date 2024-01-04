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

3.  Optionally add existing data

    If you want to use existing data, add the following files to the
    ``content`` folder. They are supposed to be kept separate from this repo
    because they may contain sensitive information.
    
        - ``settings.php``
        - ``public.zip``
        - ``chf_database.sql``
        - ``000-default-ssl.pem`` (only for production environments)
        - ``000-default-ssl.key`` (only for production environments)

    For an entirely new production environment, you may need to use a cert bot
    to produce the latter two files via Let's Encrypt or another certificate
    authority.

4.  Create and start the containers

    Open a command-line interface in the container folder and run the following
    set of commands. They move the files in the ``content`` folder to the right
    place, create all containers specified in the Compose file, and import the
    database. You may need to alter the root password, database name, and file
    name. Leave out the two ``ssl`` lines if the two files are not available.

    ..  code-block:: shell

        mv content/settings.php web/config/system/settings.php && \
        unzip content/public.zip web && rm content/public.zip && \
        mv content/000-default-ssl.pem config/apache2/ssl/000-default-ssl.pem && \
        mv content/000-default-ssl.key config/apache2/ssl/000-default-ssl.key && \
        podman compose up -d && \
        podman exec -i chf_database mysql -uroot -ppassword t3_chf < content/chf_database.sql
    
    If you do not want to import existing data, use the following command
    instead. The empty file it creates signifies TYPO3 that you are doing a
    fresh install.

    ..  code-block:: shell

        touch web/public/FIRST_INSTALL && \
        podman compose up -d
    
5.  Optionally set an alias for ``localhost`` 

    For a development environment, you may want to set up a local domain in the
    host operating system to help access the web app. On Linux or macOS, add
    the following line to the file ``/etc/hosts``.  On Windows, add it to
    ``C:\Windows\System32\Drivers\etc\hosts``:

    ..  code-block::

        127.0.0.1  chf.local

You can **now use** your TYPO3 and CHF installation. If no data was put in the
``content`` directory, your first website visit will trigger the
post-installation routine that helps you set up a new TYPO3 instance.
