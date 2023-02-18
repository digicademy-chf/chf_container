# DFD Development Docker

## Setting up a development environment

This tutorial assumes that you have successfully installed [Docker Desktop](https://docs.docker.com/get-docker/) (Windows, Mac, Linux) or [Docker Engine](https://docs.docker.com/engine/install/) (Linux).

1. Check out this repo via `sudo git clone https://gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker.git`.
2. Copy and rename the file `.env.example` to `.env`.
3. Edit the `.env` file: for a local development environment, choose your own credentials for the `DB` entries, e.g. `t3_dfd` for the first three and `password` for the fourth one. Do not use these credentials in production environments.
4. Open a terminal in the folder containing this repo and enter `sudo docker compose up -d`.

## Setting up a production environment

1. Check out this repo via `sudo git clone https://gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker.git`.
2. Copy and rename the file `.env.example` to `.env`.
3. Edit the `.env` file: for a production environment, choose credentials at least for the `DB` entries.
4. In the `sphinxsearch` folder, copy the file `development.conf` and call it `production.conf`, then edit the configuration based on the credentials you added to `.env`.
5. Open a terminal in the folder containing this repo and enter `sudo docker compose up -d`.

## Before you can build the Docker image

Three files need to be added to the `composer` folder: `known_hosts`, `auth.json`, and `.gitconfig`.

1. For `known_hosts`, find the same file in the SSH folder on your machine, copy it, and remove all lines that do not start with `gitlab.rlp.net`.
2. For `auth.json`, acquire a personal access token by clicking on your profile icon on GitLab RLP, then `Edit profile`, `Access tokens`, provide a name for the token (such as `dfd_docker`), set the scope to `api`, clear the date, and hit `Create personal access token`. Store the token somewhere safe. Then copy and rename the `auth.example.json` file, paste the `<token>`, and save the file.
3. For `.gitconfig`, copy and rename `.gitconfig.example`, insert your GitLab RLP `<username>` and `<token>`, and save the file.

## Building the Docker image

1. Commit your changes to this repo.
2. Open a terminal in the folder containing this repo.
3. Build: `sudo docker build -f Dockerfile -t registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd-webserver .`.
4. Push: `sudo docker push registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd-webserver`.

## Roadmap

- Get Typo3 12 to work
- Check if all gitignore entries are in place
- Revise this document
- Add the Manticore container with a basic config
