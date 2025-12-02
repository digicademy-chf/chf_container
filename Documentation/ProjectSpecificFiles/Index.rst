..  include:: /Includes.rst.txt

..  _project-specific-files:

======================
Project-specific files
======================

This container set-up may be **adapted to custom projects** via a set of
additional files that should be stored and regularly updated in an independent
location. You can re-create your custom container environment by dropping them
into a local clone of this repo and creating the containers. Please make sure
that you do not store files containing secret credentials or user data in
public or semi-public repositories.

..  _database-file:

Database file
=============

While most files can be backed up as they are, it is recommended that you back
up your database(s) periodically instead of relying on the runtime files stored
in the :file:`Database` folder (and, if you use the ``table`` profile for
NoCoDB, in the ``Tablebase`` folder). Use this command to **generate a database
file**, and adjust ``chf`` and ``password`` as required:

..  code-block:: shell

    podman exec -i chf_database mariadb-dump -uroot -ppassword chf_t3 > database.sql

For the NoCoDB database, use this command:

..  code-block:: shell

    podman exec -i chf_tablebase mariadb-dump -uroot -ppassword chf_nc > tablebase.sql

..  _custom-file-overview:

Custom file overview
====================

=======================================  ============================================================================================================================
File                                     Description
=======================================  ============================================================================================================================
:file:`.env`                             Provides environment variables; use :file:`template.development.env` or fill the blanks in :file:`template.production.env`
:file:`App/composer.json`                Configuration for PHP Composer to get the right PHP packages; use :file:`composer.template.json`
:file:`App/*`                            Contains custom file content of your project, may contain sensitive content or uploads
:file:`Config/httpd/ssl/cert.crt`        One of two confidential SSL certificate files, only required for production environments
:file:`Config/httpd/ssl/cert.key`        The second confidential SSL certificate file, only required for production environments
:file:`Config/httpd-dav/ssl/cert.crt`    One of two confidential SSL certificate files, only required for production environments with the ``files`` profile
:file:`Config/httpd-dav/ssl/cert.key`    The second confidential SSL certificate file, only required for production environments with the ``files`` profile
:file:`Config/httpd-dav/auth/.htpasswd`  List of usernames and hashed passwords for Basic Auth access to the WebDAV endpoint,only required with the ``files`` profile
:file:`database.sql`                     Full manual export of the TYPO3 database, may contain user information
:file:`tablebase.sql`                    Full manual export of the NoCoDB database, may contain user information
=======================================  ============================================================================================================================

..  _typo3-sitepackage:

TYPO3 sitepackage
=================

When you are producing a new TYPO3 and CHF instance, you may want your **own
sitepackage** to store your configuration, overrides, and additional code. Feel
free to use the reference sitepackages
`Namenforschung <https://gitlab.rlp.net/adwmainz/digicademy/dfd/namenforschung>`
and
`Corpus Vitrearum <https://gitlab.rlp.net/adwmainz/digicademy/cvma/corpusvitrearum>`
for inspiration. Make sure to include the new sitepackage in your
:file:`composer.json`.

..  _ssl-certificate-files:

SSL certificate files
=====================

For an entirely new production environment, you may need to use a **cert bot**
to produce the two files :file:`cert.crt` and :file:`cert.key` via
`Let's Encrypt <https://letsencrypt.org/>`__ or another certificate authority.
The files validate secure connections to your public website and need to be
renewed periodically.

If you use the ``files`` profile, you need to two additional credential files
for the WebDAV endpoint.
