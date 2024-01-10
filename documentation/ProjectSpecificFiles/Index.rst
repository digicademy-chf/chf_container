..  include:: /Includes.rst.txt

..  _project-specific-files:

======================
Project-specific files
======================

This container set-up may be **adapted to custom projects** via a set of files
that live in the ``project`` subfolder. It is recommended that you store these
files and keep that storage up to date so you can always use this set of files,
drop it into the subfolder of this repo, and re-create the container
environment on a new host. Make sure you do not store files containing secret
credentials or user data in public or semi-public repositories, though.

..  _database-file:

Database file
=============

While the files and folders in ``project`` are automatically connected to the
right location via symlinks and are thus always up to date, the **database file
first needs to be generated** before it can be copied. This is achieved via the
following command, which may require you to adjust the current root password of
the database first:

..  code-block:: shell

    podman exec -i <project_name>_database mysqldump -uroot -ppassword chf > project/database.sql

..  _custom-file-overview:

Custom file overview
====================

Your ``project`` folder may contain the following files. Templates are stored in ``project.template``.

=======================  ========  ==================================================================================================
File or folder           Template  Description
=======================  ========  ==================================================================================================
``.gitignore``           Yes       Optional gitignore file to avoid accidentally pushing sensitive files to public repos
``README.md``            Yes       Optional readme file to store additional information along with your custom files
``FIRST_INSTALL``        Yes       Empty file to trigger TYPO3's setup wizard
``.env``                 Yes       Provides environment variables, use ``.env.development`` or fill the blanks in ``.env.production``
``composer.json``        Yes       Configuration for PHP Composer to retrieve the PHP packages listed here and their dependencies
``settings.php``         No        Contains basic TYPO3 config including a few password hashes, created by the setup wizard
``sites``                Yes       Folder holding config files for all sites the instance runs, created by the setup wizard
``fileadmin``            No        Folder containing uploaded files
``database.sql``         No        Full manual export of the database, may contain user information
``cert.crt``             No        One of two confidential SSL certificate files, only required for production environments
``cert.key``             No        The second confidential SSL certificate file, only required for production environments
=======================  ========  ==================================================================================================

..  _ssl-certificate-files:

SSL certificate files
=====================

For an entirely new production environment, you may need to use a cert bot to
produce the two files ``cert.crt`` and ``cert.key`` via
`Let's Encrypt <https://letsencrypt.org/>`__ or another certificate authority.
They files validate secure connections to your public website and need to be
renewed periodically.
