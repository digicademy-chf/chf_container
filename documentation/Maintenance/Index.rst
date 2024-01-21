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
version is to check that all images and packages listed in ``compose.yml`` and
the ``Containerfile``s have the **right version as per the official system
requirements**.

When you produce an update, also remember to indicate the new TYPO3 version in
the ``README.rst``.

..  _creating-a-new-release:

Creating a new release
======================

1. Commit all changes to the repo's main branch.
2. Add the new version number to ``CITATION.cff``.
3. Create a new release with the new version number, e.g. `v1.0.0`.

..  _updating-a-local-installation:

Updating a local installation
=============================

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

**Export your database before you update** your local installation to a new
version. Then execute the following command in your container folder to update,
but replace ``v1.0.0`` with the release tag you want to update to:

..  code-block:: shell

    podman compose down && \
    git checkout v1.0.0 && \
    podman compose up -d

If you **installed the environment without Git**, you can replace the ``git``
step with replacing the old folder by a new download. Remeber that the runtime
content of your containers is supposed to be persisted in the subfolders, and
the content of ``project`` is essential to be able to set up the environment on
a new host. If something goes wrong, you may need the latter content in
particular for a full re-install, so make sure you back it up before you
proceed with deleting the parent folder and replacing it with a new one.
