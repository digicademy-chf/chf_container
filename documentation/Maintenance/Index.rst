..  include:: /Includes.rst.txt

..  _maintenance:

===========
Maintenance
===========

The web server used in this environment is a standard Debian image with a few
additional packages. In most cases, **this image should be sufficient as is**.
Under some circumstances, however, it may be necessary to build your own image
with additional packages, add it to a container registry of your choice, and
change the image path in the file ``compose.yml`` accordingly.

..  _creating-a-new-release:

Creating a new release
======================

1. Commit all changes to the repo's main branch.
2. Add the new version number to ``CITATION.cff``.
3. Create a new release with the new version number, e.g. `v0.9.0`.

..  _building-the-image:

Building the image
==================

..  attention::

    If you are using Docker instead of Podman, replace ``podman`` with
    ``docker`` and ``podman compose`` with ``docker compose`` in all examples
    provided below. You may need to use ``podman-compose`` or
    ``docker-compose`` depending on your configuration.

In the container folder, use the following steps to build your own image or to
update the original one. before you start, make sure you know the **new version
number** to be used by the release.

1. Make changes to the ``Containerfile``.
2. Build the image via ``podman build -f Containerfile -t
   ghcr.io/digicademy_chf/chf_project_container:0.9.0 .`` using the new version
   number at the end. Alter the image name if necessary.
3. If successful, push the image to the registry using ``podman push
   ghcr.io/digicademy_chf/chf_project_container``. Alter the location if
   necessary.
4. To use the new image, also change the version number tag in ``compose.yml``.

After a new image is released, make sure you also **release the according
version of the code** :ref:`as per the instructions above <>`. Make sure to
:ref:`update any development and production environments
<update-all-containers>` afterwards for the changes to take effect.

..  _syncing-with-upstream:

Syncing with upstream
=====================

If you forked this repository to build a custom environment for your project,
it may be useful to periodically sync upstream changes via ``git fetch
upstream`` and then merging the resulting branch ``upstream/main`` into your
main branch. If you use web interfaces built around Git, such as GitHub or
GitLab, and have the right permission level, they will likely offer you a
button like ``Sync fork`` on the main page of your repo to simplify this.
