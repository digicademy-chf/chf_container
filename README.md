# DFD Docker Environment

## To Do

- Make the environment start
- Add all necessary gitignore items
- Add the SphinxSearch container with a basic config

# Updating the Docker image

To update the Docker image, you need to clone this repo and add three files to the `composer` folder: `known_hosts`, `auth.json`, and `.gitconfig`. For the `known_hosts` file, find the same file in the SSH folder on your machine, copy it, and remove all lines that do not start with `gitlab.rlp.net`. For the `auth.json` file, acquire a personal access token by clicking on your profile icon on GitLab RLP, then `Edit profile`, `Access tokens`, provide a name for the token (such as `dfd-docker`, set the scope to `api`, clear the date, and hit `Create personal access token`. Store the token somewhere safe. Then copy and rename the `auth-template.json` file, paste the `<token>`, and save the file. For the `.gitconfig` file, copy and rename `.gitconfig-template`, insert your GitLab RLP user name and token, and save the file.

1. Commit your changes to this repo.
2. Open a command line in the folder containing this docker image.
3. Build the container via `sudo docker build -f Dockerfile -t registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd-docker/dfd-typo3 .`
4. Push the container to the registry via `sudo docker push registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd-docker/dfd-typo3`