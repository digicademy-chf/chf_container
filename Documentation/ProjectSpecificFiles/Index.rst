..  include:: /Includes.rst.txt

..  _project-specific-files:

======================
Project-specific files
======================

This container set-up may be **adapted to custom projects** via a set of
additional files that should be stored and regularly updated in an independent
storage. You can re-create your custom container environment by dropping them
into a local clone of this repo and creating the containers. Please make sure
that you do not store files containing secret credentials or user data in
public or semi-public repositories.

..  _database-file:

Database file
=============

While most files can be backed up as they are, it is recommended that you back
up your database periodically instead of relying on the runtime files stored in
the :file:`Database` folder. Use this command to **generate a database file**,
and adjust the root password of the database as required:

..  code-block:: shell

    podman exec -i <project_name>_database mysqldump -uroot -ppassword chf > database.sql

..  _custom-file-overview:

Custom file overview
====================

==================================  ==========================================================================================================================
File                                Description
==================================  ==========================================================================================================================
:file:`.env`                        Provides environment variables; use :file:`template.development.env` or fill the blanks in :file:`template.production.env`
:file:`App/composer.json`           Configuration for PHP Composer to get the right PHP packages; use :file:`composer.template.json`
:file:`App/*`                       Contains custom file content of your project, may contain sensitive content or uploads
:file:`Config/apache/ssl/cert.crt`  One of two confidential SSL certificate files, only required for production environments
:file:`Config/apache/ssl/cert.key`  The second confidential SSL certificate file, only required for production environments
:file:`database.sql`                Full manual export of the database, may contain user information
==================================  ==========================================================================================================================

..  _typo3-sitepackage:

TYPO3 sitepackage
=================

When you are producing a new TYPO3 and CHF instance, you may want your **own
sitepackage** to store your configuration, overrides, and additional code. Feel
free to clone and use the boilerplate
`CHF Project <https://github.com/digicademy-chf/chf_project>`__ as a
template.

..  _ssl-certificate-files:

SSL certificate files
=====================

For an entirely new production environment, you may need to use a **cert bot**
to produce the two files :file:`cert.crt` and :file:`cert.key` via
`Let's Encrypt <https://letsencrypt.org/>`__ or another certificate authority.
The files validate secure connections to your public website and need to be
renewed periodically.
