..  include:: /Includes.rst.txt

..  _maintenance:

===========
Maintenance
===========

The following information is primarily **intended for the further development**
of this package, but may also be useful for those using the set-up as they
migrate to newer TYPO3 versions and need to change their development and
production environments accordingly.

..  _update-to-a-new-major-typo3-version:

Update to a new major TYPO3 version
===================================

The main change that is required to make this set-up fit for a new TYPO3
version is to check that all images listed in :file:`compose.yml` and the
:file:`Containerfile` files adhere to the **desired PHP and MariaDB versions
as per the official system requirements**.

In the next step, update the version numbers in all :file:`composer.json`
variants according to the required TYPO3 version. When you produce an update,
also remember to indicate the new TYPO3 version in the file :file:`README.rst`.

..  _updating-a-local-installation:

Updating a local installation
=============================

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

**Export your database** and back up at least the ``App`` folder before you
update your local installation to a new version, just to be safe. Then execute
the following command in your container folder to update:

..  code-block:: shell

    podman compose down && \
    git pull && \
    podman system prune && \
    podman compose up -d

If you **installed the environment without Git**, you can replace the ``git``
step with replacing the old folder by a new download. Remeber, however, that
the runtime content of your containers is persisted in the subfolders and needs
to be added back to the newly created folder.

..  _creating-a-new-release:

Creating a new release
======================

1. Commit all changes to the repo's main branch.
2. Add the new version number and release date to :file:`guides.xml` and :file:`CITATION.cff`.
3. Create a new release with the new version number, e.g. `v1.0.0`.
