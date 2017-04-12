-- queries for intro
USE europeana_cope;
-- queries for relations_from
UPDATE bolt_relations r, bolt_data x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'apps';
UPDATE bolt_relations r, bolt_posts x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'posts';
UPDATE bolt_relations r, bolt_pages x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'collections';
UPDATE bolt_relations r, bolt_data x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'data';
UPDATE bolt_relations r, bolt_data x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'documentation';
UPDATE bolt_relations r, bolt_events x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'events';
UPDATE bolt_relations r, bolt_footers x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'footers';
UPDATE bolt_relations r, bolt_jobs x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'jobs';
UPDATE bolt_relations r, bolt_locations x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'locations';
UPDATE bolt_relations r, bolt_pages x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'pages';
UPDATE bolt_relations r, bolt_posts x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'pressreleases';
UPDATE bolt_relations r, bolt_projects x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'projects';
UPDATE bolt_relations r, bolt_persons x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'persons';
UPDATE bolt_relations r, bolt_posts x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'publications';
UPDATE bolt_relations r, bolt_resources x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'resources';
UPDATE bolt_relations r, bolt_landingpages x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'structures';
UPDATE bolt_relations r, bolt_projects x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = 'taskforces';
-- queries for relations_to
UPDATE bolt_relations r, bolt_data x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'apps';
UPDATE bolt_relations r, bolt_posts x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'posts';
UPDATE bolt_relations r, bolt_pages x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'collections';
UPDATE bolt_relations r, bolt_data x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'data';
UPDATE bolt_relations r, bolt_data x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'documentation';
UPDATE bolt_relations r, bolt_events x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'events';
UPDATE bolt_relations r, bolt_footers x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'footers';
UPDATE bolt_relations r, bolt_jobs x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'jobs';
UPDATE bolt_relations r, bolt_locations x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'locations';
UPDATE bolt_relations r, bolt_pages x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'pages';
UPDATE bolt_relations r, bolt_posts x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'pressreleases';
UPDATE bolt_relations r, bolt_projects x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'projects';
UPDATE bolt_relations r, bolt_persons x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'persons';
UPDATE bolt_relations r, bolt_posts x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'publications';
UPDATE bolt_relations r, bolt_resources x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'resources';
UPDATE bolt_relations r, bolt_landingpages x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'structures';
UPDATE bolt_relations r, bolt_projects x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = 'taskforces';
-- queries for relations_ct_from
UPDATE bolt_relations r SET r.to_contenttype = 'pages' WHERE r.to_contenttype = 'apps';
UPDATE bolt_relations r SET r.to_contenttype = 'pages' WHERE r.to_contenttype = 'apps';
UPDATE bolt_relations r SET r.to_contenttype = 'posts' WHERE r.to_contenttype = 'blogposts';
UPDATE bolt_relations r SET r.to_contenttype = 'posts' WHERE r.to_contenttype = 'blogposts';
UPDATE bolt_relations r SET r.to_contenttype = 'pages' WHERE r.to_contenttype = 'collections';
UPDATE bolt_relations r SET r.to_contenttype = 'pages' WHERE r.to_contenttype = 'collections';
UPDATE bolt_relations r SET r.to_contenttype = 'posts' WHERE r.to_contenttype = 'publications';
UPDATE bolt_relations r SET r.to_contenttype = 'posts' WHERE r.to_contenttype = 'publications';
UPDATE bolt_relations r SET r.to_contenttype = 'posts' WHERE r.to_contenttype = 'pressreleases';
UPDATE bolt_relations r SET r.to_contenttype = 'posts' WHERE r.to_contenttype = 'pressreleases';
UPDATE bolt_relations r SET r.to_contenttype = 'data' WHERE r.to_contenttype = 'documentation';
UPDATE bolt_relations r SET r.to_contenttype = 'data' WHERE r.to_contenttype = 'documentation';
UPDATE bolt_relations r SET r.to_contenttype = 'projects' WHERE r.to_contenttype = 'taskforces';
UPDATE bolt_relations r SET r.to_contenttype = 'projects' WHERE r.to_contenttype = 'taskforces';
-- queries for taxonomy
UPDATE bolt_taxonomy t, bolt_data c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'apps';
UPDATE bolt_taxonomy t, bolt_posts c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'posts';
UPDATE bolt_taxonomy t, bolt_pages c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'collections';
UPDATE bolt_taxonomy t, bolt_data c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'data';
UPDATE bolt_taxonomy t, bolt_data c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'documentation';
UPDATE bolt_taxonomy t, bolt_events c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'events';
UPDATE bolt_taxonomy t, bolt_footers c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'footers';
UPDATE bolt_taxonomy t, bolt_jobs c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'jobs';
UPDATE bolt_taxonomy t, bolt_locations c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'locations';
UPDATE bolt_taxonomy t, bolt_pages c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'pages';
UPDATE bolt_taxonomy t, bolt_posts c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'pressreleases';
UPDATE bolt_taxonomy t, bolt_projects c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'projects';
UPDATE bolt_taxonomy t, bolt_persons c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'persons';
UPDATE bolt_taxonomy t, bolt_posts c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'publications';
UPDATE bolt_taxonomy t, bolt_resources c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'resources';
UPDATE bolt_taxonomy t, bolt_landingpages c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'structures';
UPDATE bolt_taxonomy t, bolt_projects c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = 'taskforces';
-- queries for usernames
UPDATE bolt_data c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_posts c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_pages c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_data c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_data c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_events c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_footers c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_jobs c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_locations c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_pages c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_posts c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_projects c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_persons c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_posts c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_resources c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_landingpages c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
UPDATE bolt_projects c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;
-- queries for user_dedupe
UPDATE bolt_users u, bolt_users u2
SET
  u.username = concat('dupe-', u.subsite, '-', u.subsite_id, '-', u.username),
  u.email = concat('dupe-', u.subsite, '-', u.subsite_id, '-', u.email)
WHERE
  u.id <> u2.id
  AND u.username = u2.username
  AND u.id > u2.id;
UPDATE bolt_users u, bolt_users u2
SET
  u.email = concat('dupe-', u.email)
WHERE
  u.id <> u2.id
  AND u.email = u2.email
  AND u.id > u2.id;
DELETE FROM bolt_users WHERE username like 'dupe-%';
-- queries for user_id
UPDATE bolt_data c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_posts c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_pages c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_data c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_data c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_events c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_footers c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_jobs c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_locations c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_pages c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_posts c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_projects c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_persons c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_posts c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_resources c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_landingpages c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
UPDATE bolt_projects c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;
-- queries for cleanup
ALTER TABLE bolt_relations DROP subsite;
ALTER TABLE bolt_taxonomy DROP subsite;
-- queries for cleanup_id
ALTER TABLE bolt_relations DROP subsite_id;
ALTER TABLE bolt_taxonomy DROP subsite_id;
ALTER TABLE bolt_data DROP subsite_id;
ALTER TABLE bolt_posts DROP subsite_id;
ALTER TABLE bolt_pages DROP subsite_id;
ALTER TABLE bolt_events DROP subsite_id;
ALTER TABLE bolt_footers DROP subsite_id;
ALTER TABLE bolt_jobs DROP subsite_id;
ALTER TABLE bolt_locations DROP subsite_id;
ALTER TABLE bolt_projects DROP subsite_id;
ALTER TABLE bolt_persons DROP subsite_id;
ALTER TABLE bolt_resources DROP subsite_id;
ALTER TABLE bolt_landingpages DROP subsite_id;
