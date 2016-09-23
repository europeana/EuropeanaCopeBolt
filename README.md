# Bolt Install for 289.026 Europeana COPE

## installation

- Get the files from gitlab with a normal git clone.
- Set the file access according to https://docs.bolt.cm/3.1/installation/permissions 
- On the console do a `composer install --no-dev` to get the vendor directory and resources.
- On the console run php app/nut extensions:setup to get the correct extensions.
- configure the database by creating a `app/config/config_local.yml` and setting it to use the following database:

```
database:
  driver: mysql
  databasename: europeana_cope
  username: {your username}
  password: {your password}
```

