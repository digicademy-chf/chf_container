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

..  _syncing-with-upstream:

Syncing with upstream
=====================

If you forked this repository to build a custom environment for your project,
it may be useful to periodically sync upstream changes via
``git fetch upstream`` and then merging the resulting branch ``upstream/main``
into your main branch. If you use web interfaces built around Git, such as
GitHub or GitLab, and have the right permission level, they will likely offer
you a button like :guilabel:`Sync fork` on the main page of your repo to simplify this.
