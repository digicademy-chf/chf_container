# DFD Docker Environment

- Description: DFD development (and possibly production) environment
- Author: Jonatan Jalle Steller (jonatan.steller@adwmainz.de)
- Requirements: Git, Docker Engine or Docker Desktop
- Version: 1.95

## Setup

1. Check out this repo via `git clone git@gitlab.rlp.net:adwmainz/digicademy/dfd/dfd_docker.git` (with a working SSH key for GitLab RLP) or `git clone https://gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker.git` (requires credentials for every sync).
2. For a development environment, copy and rename the file `.env.development` to `.env`. For a production environment, use `.env.production` instead and add the required credentials (at least for the `DB` entries).
3. [Not implemented yet: adapt the Manticore configuration to development or production needs.]
4. Open a terminal in the folder containing this repo and enter `sudo docker compose up -d`.

## Updating the image

Before you can build a new image, three files need to be added to the `composer` folder: `known_hosts`, `auth.json`, and `.gitconfig`. For `known_hosts`, find the same file in the SSH folder on your machine, copy it, and remove all lines but the one that starts with `gitlab.rlp.net`. For `auth.json`, acquire a personal access token by clicking on your profile icon on GitLab RLP, then `Edit profile`, `Access tokens`, provide a name for the token (such as `dfd_docker`), set the scope to `api`, optionally clear the date, and hit `Create personal access token`. Store the token somewhere safe. Then copy and rename the `auth.example.json` file, paste the `<token>`, and save the file. For `.gitconfig`, copy and rename `.gitconfig.example`, insert your GitLab RLP `<username>` and `<token>`, and save the file.

1. Commit your changes to this repo.
2. Open a terminal in the folder containing this repo.
3. Build the image via `sudo docker build -f Dockerfile -t registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd-webserver .`.
4. Push the image to the registry via `sudo docker push registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd-webserver`.

## Roadmap

- Properly set up Typo3 12
- Check if all gitignore entries are in place
- Add the Manticore container with a basic config
- If possible/beneficial, adapt the repo for production use
