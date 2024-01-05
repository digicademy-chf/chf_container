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
the ``Containerfile`` have the **right version as per the official system
requirements**.

Please note that each Debian release includes **specific PHP versions** that
need to match TYPO3's expectations. When you produce an update, also remember
to indicate the new TYPO3 version in the ``README.rst``.

..  _creating-a-new-release:

Creating a new release
======================

1. Commit all changes to the repo's main branch.
2. Add the new version number to ``CITATION.cff``.
3. Create a new release with the new version number, e.g. `v0.9.0`.

..  _updating-a-local-installation:

Updating a local installation
=============================

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker``. In some configurations you may need to hyphenate
    ``podman-compose`` or ``docker-compose``.

**Export your database before you update** your local installation to a new
version. Then execute the following command in your container folder to update,
after replacing ``v0.9.0`` with the release tag you want to update to:

..  code-block:: shell

    podman compose down && \
    git clone https://github.com/digicademy-chf/chf_container.git --branch v0.9.0 && \
    podman compose up -d

If you **installed the environment without Git**, you can replace the ``git``
step with replacing the old folder by a new download. Even if the runtime
content of your containers is supposed to be persisted in the subfolders,
remember not to throw away the content of ``project`` in particular. If
something goes wrong, you may need it for a full re-install.
