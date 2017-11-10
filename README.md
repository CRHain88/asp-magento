Advanced Specialty Website
================================================================================

This repo contains the source code for advancedspecialty.com. It uses: Docker,
MySQL v5.6.32, and Magento2 v2.1.2.

<!-- toc -->

- [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Run Docker containers](#run-docker-containers)
- [Setup Magento](#setup-magento)
  * [Migrate Databases](#migrate-databases)
  * [Update Magento version](#update-magento-version)
- [Third-Party Magento Modules](#third-party-magento-modules)
- [FAQ](#faq)
  * [How do I view the IP of a linked Docker container?](#how-do-i-view-the-ip-of-a-linked-docker-container)
  * [How do I connect to a Docker container?](#how-do-i-connect-to-a-docker-container)
  * [How do I Deploy Docker Containers?](#how-do-i-deploy-docker-containers)
    + [Locally](#locally)
    + [On the Server](#on-the-server)
  * [CSS styles haven't loaded](#css-styles-havent-loaded)
  * [MySQL is throwing 'max_allowed_packet' error](#mysql-is-throwing-max_allowed_packet-error)

<!-- tocstop -->

Getting Started
--------------------------------------------------------------------------------


### Prerequisites

To set up a local instance of this repo, you must first download
[Docker](https://www.docker.com/products/overview).


### Run Docker containers

Run the following command in a Terminal window to start the Docker container. If
this Docker image doesn't exist, it will be built using the instructions found
in the `Dockerfile` (and `docker-compose.yml`).

```sh
$ npm start
```


Setup Magento
--------------------------------------------------------------------------------

1. Setup the database
    - Use the database name as defined in the docker-compose file.

        ```sql
        CREATE DATABASE [db_name];
        ```

    - Grant permissions to the user as defined in the docker-compose file.

        ```sql
        USE [db_name];
        GRANT ALL PRIVILEGES ON [db_name].* TO '[mysqluser]'@'%' WITH GRANT OPTION;
        ```

2. Go through the setup process
    - Set the database host to the name of the docker-compose service.
    - Set the database values accordingly, as shown in the docker-compose.
    - Follow the rest of the setup process.
    - **Take note of the confirmation screen**

3. Run Magento Cron

    ```bash
    ./bin/magento setup:cron:run
    ```

4. Set up Integration modules.
    - System > Integrations
    - Add new Integration
    - Enter information for the Integration
    - Save
    - Activate

5. Install [Third-Party modules](#third-party-magento-modules)


### Migrate Databases

Before doing any development, make sure to get the latest copy of the Database
from the production server. Advise Smart Vent that you'll be making some updates
and any edits they make should wait until after the code update is complete.

1. Create and download a backup of the source database from the Magento Admin
Panel.
2. Drop the destination database.
3. Re-create the destination database.
4. Run

  ```sh
  $ docker exec -i $CONTAINER_NAME \
    mysql -uroot -proot --database $DATABASE_NAME \
    < $SQL_BACKUP_PATH
  ```

  Where:

  - `$CONTAINER_NAME` is the name of the container (such as `asp_db_1`)
  - `$DATABASE_NAME` is the name of the database (such as `magento_asp`); and
  - `$SQL_BACKUP_PATH` is the directory where the `.sql` back up file was
    downloaded.


### Update Magento version

These instructions are for upgrading Magento versions. It's recommended to do
do this inside the Docker container.

1. Backup the Magento database.
2. Backup the Magento 2 directory.
3. In terminal, navigate to the Magento 2 directory, then update
   `composer.json`:

    ```sh
    $ cd ./asp-web/src/magento2; \
      composer require magento/product-community-edition 2.1.5 --no-update
    ```

    Where `$MAGENTO_VERSION` is the latest stable version (such as `2.1.5`)

4. Run the update command, which will prompt for repo.magento.com credentials.
   *Note: both the username and password are 32-bit random strings. Find the
    appropriate credentials for your account online.*
    ```sh
    $ composer update
    ```

5. Cleanup the installation.
    ```sh
    $ rm -rf var/di var/generation; \
      php bin/magento cache:clean; \
      php bin/magento cache:flush; \
      php bin/magento setup:upgrade; \
      php bin/magento setup:di:compile; \
      php bin/magento setup:static-content:deploy; \
      php bin/magento indexer:reindex
    ```

6. If you're curious to see if it worked, check the version.

    ```sh
    php ./bin/magento --version
    ```

Third-Party Magento Modules
--------------------------------------------------------------------------------

This project uses the following Magento modules:
  - [VES Mega Menu](http://landofcoder.com/magento-2-mega-menu.html)


FAQ
--------------------------------------------------------------------------------

### How do I view the IP of a linked Docker container?
To view the IP address of a linked container, look at the `/etc/hosts` file to
see how docker has mapped the ports.


### How do I connect to a Docker container?
```sh
$ docker exec -it $CONTAINER_NAME /bin/bash
```

Where `$CONTAINER_NAME` is the name of the container (such as `asp`).


### How do I Deploy Docker Containers?

#### Locally
In your local environment, run the following commands in Terminal.

```sh
$ # Commit Changes
$ docker commit [OPTIONS] CONTAINER [ REPOSITORY[:TAG] ]

$ # Save the Image
$ docker save -o asp_web.tar asp_web
```


#### On the Server
On the server, load the image by running the following command:

```sh
$ docker load -i asp_web.tar
```


### CSS styles haven't loaded
Make sure Magento is in developer mode

```sh
php bin/magento deploy:mode:set developer
```

In terminal, run the following command:

```sh
$ php bin/magento cache:clean
$ php ./bin/magento setup:static-content:deploy -t CRHain/asp
```

When finished, set the deploy mode back to default

```sh
php bin/magento deploy:mode:set production
```

### MySQL is throwing 'max_allowed_packet' error
In the MySQL container, enter the MySQL CLI.

```sh
$ mysql -u[user] -p[password]
```

Run the following commands:

```sh
mysql> set global net_buffer_length=1000000;
mysql> set global max_allowed_packet=1000000000;
```
