# Europeana COPE project

This repository is the basic website for europeana cope.

## server requirements

Start with a server to set everything up. The minimum requirements for running Bolt are: https://docs.bolt.cm/3.3/getting-started/requirements

### server programs

For this site you need:
- SSH
- Nginx webserver
- PHP 7.x, with the extensions as outlined in the Bolt requirements
- MySQL
- Git

### user accounts

To install the site and do deployments, create a user account named `deploy` user, with access through SSH. This user also needs passwordless sudo, because that is a requirement for using deployer. This user can be used for `{{ your_shell_user }}` in the deployer configuration files.

In the MySQL database create a mysql user that has create rights for databases. This is needed for creating snapshots of the database and performing rollbacks with deployer. This user can be used for `{{ your_mysql_backup_user }}` in the deployer configuration files.

Another database user for normal access to the main database is needed for the Bolt CMS itself. This user can be used for `{{ your_mysql_user }}` in the deployer configuration files.

### Project root

The project root should be somewhere the webserver has access. By default this is in `/var/www`. 

Setup the directory `/var/www/cope` for this project. Make sure it's owned and accessible to the `www-data` user. 

For example:
```
$ cd /var/www
$ ls -al
drwxr-xr-x  4 root     root     4096 Sep 11 16:42 .
drwxr-xr-x 13 root     root     4096 Jun 27 12:40 ..
drwxrwxr-x  7 www-data www-data 4096 Sep 12 18:01 cope
```

Use `/var/www/cope` in the following config files where `{{ /your/root/path/for/the/app }}` or `/your/root/path/for/the/app` is given.

### Nginx configuration

Nginx needs to be setup so the public web directory is: `/var/www/cope/current/public`. This will always be the current public webroot setup by deployer.

### dropbox

Additionally the files are synced with Dropbox, so the dropbox client needs to run and be configured to use the Europeana account. The dropbox files path will be linked to the Bolt files directory.

The dropbox client is available on https://www.dropbox.com/install-linux

Setup a separate user for dropbox on the server (call that user `dropbox`) and use the phyton script from the dropbox linux install page to control the deamon.

The dropbox home directory will probably be `/home/dropbox/Dropbox (Europeana Pro)`, use this in the configuration files for `{{ your dropbox files root directory }}`

## deployment

Follow the instructions on https://github.com/jadwigo/bolt-deployer-recipe to setup deployer.

### deployer requirements

For deployer you need:
- A linux or mac computer
- Deployer from https://deployer.org/ 
- PHP 7.x on that computer (deployer will not run without it)
- Git

### bolt configuration with deployer

Use the following bolt configuration for the Europeana COPE site.

Create `./shared/.bolt.yml` and `./shared/app/config/config_local.yml` files with the correct accounts and paths. Also prepare all local extension configuration files.

Make sure passwords and other identifier keys are only set in files named after the pattern `*_local.yml` e.g. `./shared/app/config/extensions/apilogin.europeana_local.yml` as a local override for the `./current/app/config/extensions/apilogin.europeana.yml` configuration file.

The `.bolt.yml` file should look similar to:
```yml
paths:
  cache: '{{ /your/root/path/for/the/app }}/cache'
  files: '{{ your dropbox files root directory }}'
extensions:
  - Bolt\Extension\Europeana\ViewBlocks\ViewBlocksExtension
  - Bolt\Extension\Europeana\ZohoImport\ZohoImportExtension
  - Bolt\Extension\Europeana\SelectAsync\SelectAsyncExtension
  - Bolt\Extension\Europeana\ApiLogin\ApiLoginExtension
```

The `config_local.yml` file should look similar to:
```yml
database:
    driver: mysql
    databasename: {{ your database name }}
    username: {{ your mysql username }}
    password: {{ your mysql password }}

homepage: page/home

google_api_key: {{ your google api key }}
environment: prod
google_ua_key: {{ your google analytics user agent key }}

theme: europeana-cope

# Debug settings
debug: false
debug_show_loggedoff: false
debug_error_level: -1
debug_error_use_symfony: true
strict_variables: true

mailoptions:
    transport: smtp
    spool: false
    host: mail.europeana.eu
    port: 25
    username: {{ your smtp user }}
    password: {{ your smtp password }}
    senderMail: noreply@europeana.eu
    senderName: Europeana Pro
```

## setting up the database migration

Use the <a href="https://github.com/europeana/EuropeanaCopeBolt/blob/master/tools/migration/step-by-step.md">step by step</a> instructions to setup the databases during development.
