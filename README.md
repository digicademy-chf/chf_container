# DFD Docker Environment

## To Do

- Make the environment start
- Add all necessary gitignore items
- Add the SphinxSearch container with a basic config

# Updating the Docker image

To update the Docker image, you need to have a personal access token for this GitLab instance. To acquire the token, open GitLab RLP, click on your profile icon, then `Edit profile`, `Access tokens`, provide a name for the token (such as `dfd-docker`, set the scope to `api`, clear the date, and hit `Create personal access token`. Store the token somewhere safe. Then go to the `composer` folder in this repo on your machine, open a terminal, and enter `composer config gitlab-token.gitlab.rlp <token>`. This downloads a file `auth.json` to the `composer` folder.

1. Commit your changes to this repo.
2. Open a command line in the folder containing this docker image.
3. Build the container via `sudo docker build -f Dockerfile -t registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd-docker/dfd-typo3 .`
4. Push the container to the registry via `sudo docker push registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd-docker/dfd-typo3`