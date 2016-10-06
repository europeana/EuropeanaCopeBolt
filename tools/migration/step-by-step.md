# Migration steps

## Check out the source

1. Check out the source as per normal from gitlab
2. Do not run bolt or nut yet
3. Run composer install --no-dev

## Set up database for import

4. set up a server with the databases for
    - europeana_him
    - europeana_pro
    - europeana_labs
    - europeana_research
5. make sure there is a user with read access to those 4 databases

## Import and merge databases

6. make sure that the user has create database access
7. run the script `1-migrate.sql`
    - this script will create the `europeana_cope` database
    - the data from all 4 databases will be copied to `europeana_cope`

## Set up relations and some housekeeping

8. The relations population script is created by running `php ./2-migrate-prepare.php > 2-relations-and-taxonomy.sql` on the console (running this again this is probably optional, unless the file `2-relations-and-taxonomy.sql` is missing)
9. After that use the `2-relations-and-taxonomy.sql` script on the `europeana_cope` database to populate the relations

## Prepare first run

10. Modify the bolt installation to use the `europeana_cope` database by setting the connection in `app/config_local.yml`
11. Replace `app/config/contenttypes.yml` with `tools/migration/1-contenttypes.yml`

## Data cleanup scripts

12. Run the script `3-cleanup-contenttypes-content.sql` to cleanup contenttypes and merge data
13. Replace the `app/config/contenttypes.yml` file with `tools/migration/3-contenttypes.yml`

## Finished

14. Run `php app/nut database:update` to setup all other tables for bolt
15. You can now login to bolt on http://example.com/admin
16. Bolt is now up to date and you can continue with the new site.
