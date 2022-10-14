# DFD Docker Environment

## To Do

- Make the environment start
- Add all necessary gitignore items
- Add the SphinxSearch container with a basic config

# Setting up a development environment

This tutorial assumes that you have successfully installed [Docker Desktop](https://docs.docker.com/get-docker/) (Windows, Mac, Linux) or [Docker Engine](https://docs.docker.com/engine/install/) (Linux).

1. Check out this repo via `sudo git clone git@gitlab.rlp.net:adwmainz/digicademy/dfd/dfd_docker.git`
2. Copy and rename the file `.env.example` to `.env`.
3. For a local development environment, choose your own credentials for the `DB` entries, e.g. `t3_dfd` for the first three and `password` for the fourth one.
4. ???

# Updating the Docker image

To update the Docker image, you need to clone this repo and add three files to the `composer` folder: `known_hosts`, `auth.json`, and `.gitconfig`. For the `known_hosts` file, find the same file in the SSH folder on your machine, copy it, and remove all lines that do not start with `gitlab.rlp.net`. For the `auth.json` file, acquire a personal access token by clicking on your profile icon on GitLab RLP, then `Edit profile`, `Access tokens`, provide a name for the token (such as `dfd-docker`, set the scope to `api`, clear the date, and hit `Create personal access token`. Store the token somewhere safe. Then copy and rename the `auth.example.json` file, paste the `<token>`, and save the file. For the `.gitconfig` file, copy and rename `.gitconfig.example`, insert your GitLab RLP user name and token, and save the file.

1. Commit your changes to this repo.
2. Open a command line in the folder containing this docker image.
3. Build the container via `sudo docker build -f Dockerfile -t registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd-typo3 .`
4. Push the container to the registry via `sudo docker push registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd-typo3`