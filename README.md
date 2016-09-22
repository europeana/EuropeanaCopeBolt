# Bolt Install for 289.026 Europeana COPE

## installation

- Get the files from gitlab with a normal git clone.
- On the console do a `composer install --no-dev`
- Set the file access according to [https://docs.bolt.cm/3.1/installation/permissions]
- configure the database by creating a `app/config/config_local.yml` and setting it to use the following database:
```
database:
  driver: mysql
  databasename: europeana_cope
  username: {your username}
  password: {your password}
```

