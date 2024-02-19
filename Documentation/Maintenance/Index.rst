..  include:: /Includes.rst.txt

..  _maintenance:

===========
Maintenance
===========

The following information is primarily **intended for the further development**
of this package, but may also be useful for those using the set-up as they
migrate to newer TYPO3 versions and need to change their development and
production environments accordingly.

..  _update-to-a-new-typo3-version:

Update to a new TYPO3 version
=============================

The main change that is required to make this set-up fit for a new TYPO3
version is to check that all images and packages listed in :file:`compose.yml`,
the :file:`Containerfile` files, and :file:`composer.json` adhere to the
**right PHP and MariaDB versions as per the official system requirements**.

When you produce an update, also remember to indicate the new TYPO3 version in
the file :file:`README.rst`.

..  _creating-a-new-release:

Creating a new release
======================

1. Commit all changes to the repo's main branch.
2. Add the new version number and release date to ``CITATION.cff``.
3. Create a new release with the new version number, e.g. `v1.0.0`.

..  _updating-a-local-installation:

Updating a local installation
=============================

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

**Export your database and back up the ``App`` folder** before you update your
local installation to a new version, just to be safe. Then execute the
following command in your container folder to update, but replace ``v1.0.0``
with the release tag you want to update to:

..  code-block:: shell

    podman compose down && \
    git checkout v1.0.0 && \
    podman compose up -d

If you **installed the environment without Git**, you can replace the ``git``
step with replacing the old folder by a new download. Remeber that the runtime
content of your containers is persisted in the subfolders and needs to be added
back to the newly created folder.
