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

If you cloned the container template to build a custom environment for your
project, it may be useful to periodically sync upstream changes. If you just
have a local clone, fetch (and merge) changes from the ``origin``. In case you
forked the project on GitHub, you will likely see a :guilabel:`Sync fork`
button supporting you in merging any upstream changes.

If you copied the template to any other platform built around Git, such as
GitLab, it will now funcion as your ``origin`` instead of the original repo.
The simplest solution is illustrated in the following commands:

1. In your local clone of your repo, add an additional ``upstream``:

   ..  code-block:: shell

       git remote add upstream https://github.com/digicademy-chf/chf_project_container.git

2. Apply upstream patches to a local branch called ``upstream/main``:

   ..  code-block:: shell

       git pull upstream main

3. Resolve any issues should they appear.
4. Push the changes to your ``origin/main`` as usual.
