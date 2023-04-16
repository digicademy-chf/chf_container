# DFD Docker

- Description: Portal für Namenforschung development and production environment
- Author: Jonatan Jalle Steller ([jonatan.steller@adwmainz.de](mailto:jonatan.steller@adwmainz.de))
- Requirements: `git`, `docker-ce` or Docker Desktop
- License: MIT
- Version: 1.9.7

Environment to run the *Portal für Namenforschung*, which also contains the Digital Dictionary of Surnames in Germany (*Digitales Famieliennamenwörterbuch Deutschlands*, DFD). Contains all configuration files for a customised Debian webserver with PHP, a MariaDB database, a Manticore search engine, and a Postfix container for email jobs.

## Setup

1. Clone this repo via `git clone git@gitlab.rlp.net:adwmainz/digicademy/dfd/dfd_docker.git` or the HTTPS equivalent.
2. For a development environment, copy `.env.development` and rename it to `.env`. For a production environment, use `.env.production` instead and add the required credentials.
3. Open a terminal in the `dfd_docker` folder, enter `cd dfd/local_packages`, and then clone the repo [`namenforschung`](https://gitlab.rlp.net/adwmainz/digicademy/dfd/namenforschung).
4. Go back to the main Docker folder via `cd .. && cd ..` and start all containers via `sudo docker compose up -d`.
5. Enter the webserver container via `sudo docker exec -it dfd_webserver bash`.
6. Here, run `composer update`, wait for the result, and then `exit`.

## Usage

Open `namenforschung.local` in a browser to see the development environment. The production environment should be available at `namenforschung.net`. Add `/typo3` to enter the TYPO3 backend.

If you experience issues working in the `dfd/local_packages` folder on your host system, it is safe to use `chown` on the entire folder as long as the container still has read access. File-level changes outside this folder can be made from inside the webserver container using `sudo docker exec -it dfd_webserver bash`.

## Maintenance

The following steps should be performed periodically to keep an existing environment up to date. This also implements any changes made to the required Composer packages.

1. Enter the environment: `sudo docker exec -it dfd_webserver bash`.
2. Update Debian: `sudo apt-get update`.
3. Perform a Composer update: `cd dfd && composer update`.

## Development

If changes to the `Dockerfile` are necessary, use the following steps to update it.

1. Commit your changes to this repo.
2. Open a terminal in the folder containing this repo.
3. Build the image: `sudo docker build -f Dockerfile -t registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd_webserver .`.
4. Push the image to the registry: `sudo docker push registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd_webserver`.
5. Update development and production environments accordingly.

## Roadmap

- Get the `local_packages` folder to show in the repo.
- Add info for SQL and uploaded files.
- Add production files locally.
- Make sure everything is in place to re-build the environment from scratch.
- Add the Manticore container with a basic config.
