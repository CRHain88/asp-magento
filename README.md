Uses Docker

Uses MySQL v5.6.32

Uses Magento2 v2.0.2

## Magento

### Debugging

#### CSS styles haven't loaded

Running the following command:
```bash
php bin/magento setup:static-content:deploy
```

To deploy just the ASP theme:
```bash
php ./bin/magento setup:static-content:deploy -t CRHain/asp
```

## Docker

### Initial Set up

#### Build the image
```bash
docker build -t asp:latest .
```

#### Run the image
```bash
docker-compose up
```

### Start existing containers
```bash
docker-compose up
```

### Migrate Databases
1. Create and download a backup of the source database.
2. Drop the destination database.
3. Re-create the destination database.
4. Run
  ```bash
  docker exec -i $CONTAINER_NAME mysql -uroot -proot --database $DATABASE_NAME < $SQL_BACKUP_PATH
  ```
  Where:
  * `$CONTAINER_NAME` is the name of the container (such as `asp_db_1`)
  * `$DATABASE_NAME` is the name of the database (such as `magento_asp`); and
  * `$SQL_BACKUP_PATH` is the directory where the `.sql` back up file was downloaded.

### Linked Docker containers
To view the IP address of a linked container, look at the /etc/hosts file to see how docker has mapped the ports.

### Deploy Docker Containers

Commit Changes

```bash
docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
```

Save Image
```bash
docker save -o asp_web.tar asp_web
```

Load Image (on remote server)
```bash
docker load -i asp_web.tar
```
