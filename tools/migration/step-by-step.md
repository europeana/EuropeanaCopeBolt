# Migration steps

## Check out the source

1. Check out the source as per normal from gitlab
2. Do not run bolt or nut yet
3. Setup `app/config_local.yml` that points to the database `europeana_cope` with correct credentials
4. Run ./boltflow.sh

## Set up database for import

5. set up a server with the databases for
    - europeana_pro
    - europeana_labs
    - europeana_research
6. make sure there is a user with read access to those 3 databases
7. import a copy of the production databases from the 3 sites into these databases

## Import and merge databases

8. make sure that the same user has create database access
9. In your mysql admin tool of choice, run the script `1-migrate.sql`
    - this script will create the `europeana_cope` database
    - the data from all 4 databases will be copied to `europeana_cope`

## Set up relations and some housekeeping

10. The relations population script is created by running `php ./2-migrate-prepare.php > 2-relations-and-taxonomy.sql` on the console (running this again this is probably optional, unless the file `2-relations-and-taxonomy.sql` is missing)
12. After that use the `2-relations-and-taxonomy.sql` script on the `europeana_cope` database to populate the relations

## Data cleanup scripts

13. Run the script `3-cleanup-contenttypes-content.sql` to cleanup contenttypes and merge data
14. Replace the `app/config/contenttypes.yml` file with `tools/migration/3-contenttypes.yml`
15. After that use the `4-bolt-modifications.sql` script on the `europeana_cope` database to fix some bolt related field settings.

## Last preparation

16. Run `php app/nut database:update` to setup all other tables for bolt - this should do almost nothing

## First run

17. You can now login to bolt on http://example.com/admin
18. Bolt is now up to date and you can continue with the new site.
