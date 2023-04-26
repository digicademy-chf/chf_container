# DFD Docker

- Description: Portal für Namenforschung development and production environment
- Author: Jonatan Jalle Steller ([jonatan.steller@adwmainz.de](mailto:jonatan.steller@adwmainz.de))
- Requirements: `git`, `docker-ce` or Docker Desktop
- License: MIT
- Version: 1.9.8

Environment to run the *Portal für Namenforschung*, which also contains the Digital Dictionary of Surnames in Germany (*Digitales Famieliennamenwörterbuch Deutschlands*, DFD). Contains all configuration files for a customised Debian webserver with PHP, a MariaDB database, a Manticore search engine, and a Postfix container for email jobs.

## Setup

Before you start, [download three files](https://seafile.rlp.net/smart-link/11605d5e-9276-4048-a0cf-511ae67d6468/) that cannot be part of this repo: `settings.php`, `public.zip`, and `dfd_database.sql`. Ask the maintainer(s) to grant you access or to update the files for you if necessary.

1. Clone this repo via `git clone git@gitlab.rlp.net:adwmainz/digicademy/dfd/dfd_docker.git` or the HTTPS equivalent.
2. For a development environment, copy `.env.development` and rename it to `.env`. For a production environment, use `.env.production` instead and add the required, secret credentials.
3. Place `settings.php` into `dfd_docker/dfd/config/system`.
4. Place `public.zip` into `dfd_docker/dfd`, unpack it to create a new folder `public`, and delete the ZIP file.
5. Place `dfd_database.sql` into `dfd_docker`.
6. Direct your terminal to the main Docker folder `dfd_docker` and start all containers via `sudo docker compose up -d`.
7. Import the database dump via `sudo docker exec -i dfd_database mysql -uroot -ppassword t3_dfd < dfd_database.sql`. On a production system, use the user and password from the production credentials instead.
8. Enter the webserver container via `sudo docker exec -it dfd_webserver bash`.
9. Here, first enter `cd dfd` and then `composer update` to install all packages.
10. Update the language packs via `typo3 language:update`, wait for the result, and close the connection via `exit`.

For a development environment, set up the local domain in the host operating system. On Linux or macOS, add the following line to `/etc/hosts`. On Windows, add it to `C:\Windows\System32\Drivers\etc\hosts`.

```
127.0.0.1    namenforschung.local
```

In a production environment, you may need to use the cert bot inside the webserver container after the above setup to get SSL working properly.

## Usage

Open [namenforschung.local](http://namenforschung.local/) in a browser to see the development environment. Use [namenforschung.local/typo3](http://namenforschung.local/typo3) to see the TYPO3 backend. The production environment should be available at [namenforschung.net](https://namenforschung.net/) and the TYPO3 backend at [namenforschung.net/typo3](https://namenforschung.net/typo3).

If you experience issues working with one of the Digicademy packages in a development environment, it is safe to use `chown -R <username>:<usergroup> <folder>` and `chmod -R 774 <folder>` as long as the container still has read access.

## Maintenance

The following steps should be performed periodically to keep an existing environment up to date. This also implements any changes made to the required Composer packages.

1. Enter the environment: `sudo docker exec -it dfd_webserver bash`.
2. Update Debian: `sudo apt-get update`.
3. Perform a Composer update: `cd dfd && composer update`.

## Development

If changes to the `Dockerfile` are necessary, use the following steps to update the image it produces and stores on GitLab RLP.

1. Commit your changes to this repo.
2. Open a terminal in the folder containing this repo.
3. Build the image: `sudo docker build -f Dockerfile -t registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd_webserver .`.
4. Push the image to the registry: `sudo docker push registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd_docker/dfd_webserver`.
5. Update development and production environments accordingly.

## Useful commands

Start the containers:

```
docker compose start
```

Stop the containers:

```
docker compose stop
```

Fully destroy the containers:

```
docker compose down
```

Log into a running container:

```
sudo docker exec -it dfd_webserver bash
```

Update all Composer packages:

```
sudo docker exec -it dfd_webserver bash
cd dfd
composer update
```

Require a new Composer package (after adding the repo in `composer.json` if necessary):

```
sudo docker exec -it dfd_webserver bash
cd dfd
composer require digicademy/da-bib:@dev
```

Export the database (change username and password in a production environment):

```
sudo docker exec -i dfd_database mysqldump -uroot -ppassword t3_dfd > dfd_database.sql
```

## Roadmap

- Build the image again including the SSL config for production.
- Add the Manticore container with a basic config.
