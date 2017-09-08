-- ##################################
-- Create blogposts table
-- ##################################

DROP TABLE IF EXISTS europeana_cope.bolt_blogposts;
CREATE TABLE IF NOT EXISTS europeana_cope.bolt_blogposts (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(128) NOT NULL,
  `datecreated` datetime NOT NULL,
  `datechanged` datetime NOT NULL,
  `datepublish` datetime DEFAULT NULL,
  `datedepublish` datetime DEFAULT NULL,
  `username` varchar(32) DEFAULT '',
  `ownerid` int(11) DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `subsite` longtext NULL,
  `attachments` longtext NULL,
  `author` longtext NULL,
  `body` longtext NULL,
  `files` longtext NULL,
  `hero` longtext NULL,
  `hide_list` tinyint(1) NOT NULL DEFAULT '0',
  `image` longtext NULL,
  `intro` longtext NULL,
  `originalurl` varchar(256) NOT NULL DEFAULT '',
  `parents` longtext NULL,
  `structure_parent` longtext NULL,
  `structure_sortorder` int(11) NOT NULL DEFAULT '0',
  `teaser` longtext NULL,
  `teaser_image` longtext NULL,
  `templatefields` longtext NULL,
  `title` varchar(256) DEFAULT '',
  `calltoactiontext` varchar(256) DEFAULT '',
  `calltoactionlink` varchar(256) DEFAULT '',
  `filelist_downloads` varchar(256) DEFAULT '',
  `hide_related` tinyint(1) NOT NULL DEFAULT '0',
  `support_navigation` tinyint(1) NOT NULL DEFAULT '0',
  `contact_record` longtext NULL,
  `contact_blurb` longtext NULL,
  `template` varchar(256) DEFAULT '',
  `introduction` varchar(256) DEFAULT '',
  `original_url` varchar(256) DEFAULT '',
  `original_author` varchar(256) DEFAULT '',
  `subsite_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE INDEX `IDX_6D96B2CA989D9B62` ON europeana_cope.bolt_blogposts (`slug`);
CREATE INDEX `IDX_6D96B2CAAFBA6FD8` ON europeana_cope.bolt_blogposts (`datecreated`);
CREATE INDEX `IDX_6D96B2CABE74E59A` ON europeana_cope.bolt_blogposts (`datechanged`);
CREATE INDEX `IDX_6D96B2CAA5131421` ON europeana_cope.bolt_blogposts (`datepublish`);
CREATE INDEX `IDX_6D96B2CAB7805520` ON europeana_cope.bolt_blogposts (`datedepublish`);
CREATE INDEX `IDX_6D96B2CA7B00651C` ON europeana_cope.bolt_blogposts (`status`);

TRUNCATE europeana_cope.bolt_blogposts;

-- ##################################
-- Copy all culturelover posts to new content type
-- ##################################

-- pro
INSERT IGNORE INTO europeana_cope.bolt_blogposts
  ( id, subsite, subsite_id, slug, datecreated, datechanged, datepublish,
    datedepublish, username, ownerid, status, title, teaser, body, attachments,
        parents, image, structure_sortorder, structure_parent, templatefields )
  SELECT b.id, 'pro', b.id, b.slug, b.datecreated, b.datechanged, b.datepublish,
    b.datedepublish, b.username, b.ownerid, b.status, b.title, b.teaser, b.body, b.attachments,
    b.parents, b.image, b.structure_sortorder, b.structure_parent, b.templatefields
  FROM europeana_pro.bolt_blogposts b
  WHERE b.id IN (
      SELECT distinct(t.content_id) FROM europeana_pro.bolt_taxonomy t
      WHERE t.contenttype = 'blogposts' AND t.slug IN ('culturelover', 'culturelover-fashion', 'europeana-fashion', 'europeana-enduser', 'europeana-1418')
    );



UPDATE europeana_cope.bolt_blogposts set status = 'held' where status = 'trash';

-- ##################################
-- Create blogevents table
-- ##################################


DROP TABLE IF EXISTS europeana_cope.bolt_blogevents;
CREATE TABLE IF NOT EXISTS europeana_cope.bolt_blogevents (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(128) NOT NULL,
  `datecreated` datetime NOT NULL,
  `datechanged` datetime NOT NULL,
  `datepublish` datetime DEFAULT NULL,
  `datedepublish` datetime DEFAULT NULL,
  `username` varchar(32) DEFAULT '',
  `ownerid` int(11) DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `templatefields` longtext NULL,
  `title` varchar(256) DEFAULT '',
  `start_event` datetime DEFAULT NULL,
  `unconfirmed_start` tinyint(1) NOT NULL DEFAULT '0',
  `end_event` datetime DEFAULT NULL,
  `unconfirmed_end` tinyint(1) NOT NULL DEFAULT '0',
  `introduction` varchar(256) DEFAULT '',
  `teaser` longtext NULL,
  `body` longtext NULL,
  `teaser_image` longtext NULL,
  `attachments` longtext NULL,
  `original_url` varchar(256) DEFAULT '',
  `location_name` varchar(256) DEFAULT '',
  `geolocation` longtext,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE INDEX `IDX_75BBACEE989D9B62` ON europeana_cope.bolt_blogevents (`slug`);
CREATE INDEX `IDX_75BBACEEAFBA6FD8` ON europeana_cope.bolt_blogevents (`datecreated`);
CREATE INDEX `IDX_75BBACEEBE74E59A` ON europeana_cope.bolt_blogevents (`datechanged`);
CREATE INDEX `IDX_75BBACEEA5131421` ON europeana_cope.bolt_blogevents (`datepublish`);
CREATE INDEX `IDX_75BBACEEB7805520` ON europeana_cope.bolt_blogevents (`datedepublish`);
CREATE INDEX `IDX_75BBACEE7B00651C` ON europeana_cope.bolt_blogevents (`status`);

-- ##################################
-- Copy all culturelover events to new content type
-- ##################################

-- pro
INSERT IGNORE INTO europeana_cope.bolt_blogevents
  ( id, slug, datecreated, datechanged, datepublish,
    datedepublish, username, ownerid, status, title, start_event, unconfirmed_start,
    end_event, unconfirmed_end, teaser, body, introduction, teaser_image, attachments,
    templatefields, location_name, geolocation )
  SELECT e.id, e.slug, e.datecreated, e.datechanged, e.datepublish,
    e.datedepublish, e.username, e.ownerid, e.status, e.title, e.start_event, e.unconfirmed_start,
    e.end_event, e.unconfirmed_end, e.teaser, e.body, e.introduction, e.teaser_image, e.filelist,
    e.templatefields, l.title, l.geolocation
  FROM europeana_pro.bolt_events e
    JOIN europeana_pro.bolt_relations r
      ON r.from_id = e.id AND r.from_contenttype = 'events'
    JOIN europeana_pro.bolt_locations l
      ON r.to_id = l.id AND r.to_contenttype = 'locations'
  WHERE e.id IN (
    SELECT distinct(t.content_id) FROM europeana_pro.bolt_taxonomy t
    WHERE t.contenttype = 'events'
    AND t.slug in ('culturelover', 'culturelover-fashion', 'europeana-fashion', 'europeana-enduser', 'europeana-1418')
  );

-- ##################################
-- Add all taxonomies for
-- ##################################

CREATE TABLE IF NOT EXISTS europeana_cope.bolt_taxonomy (
  id int(11) NOT NULL AUTO_INCREMENT,
  content_id int(11) NOT NULL DEFAULT 0,
  contenttype varchar(32) NOT NULL DEFAULT '',
  taxonomytype varchar(32) NOT NULL DEFAULT '',
  slug varchar(64) NOT NULL DEFAULT '',
  name varchar(64) NOT NULL DEFAULT '',
  sortorder int(11) NOT NULL DEFAULT 0,
  subsite varchar(32) NOT NULL DEFAULT 'unknown',
  subsite_id int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

DELETE FROM europeana_cope.bolt_taxonomy WHERE contenttype = 'blogposts';

-- pro
INSERT INTO europeana_cope.bolt_taxonomy ( content_id, contenttype, taxonomytype, slug, name, sortorder
) SELECT t.content_id, t.contenttype, t.taxonomytype, t.slug, t.name, t.sortorder
    FROM europeana_pro.bolt_taxonomy t
    JOIN europeana_pro.bolt_taxonomy cl
    ON (
          cl.content_id = t.content_id
          AND cl.contenttype = 'blogposts'
          AND cl.slug in ('culturelover', 'culturelover-fashion', 'europeana-fashion', 'europeana-enduser', 'europeana-1418')
        )
    WHERE t.contenttype = 'blogposts'
    GROUP BY t.id;

DELETE FROM europeana_cope.bolt_taxonomy WHERE contenttype = 'blogevents';

-- pro
INSERT INTO europeana_cope.bolt_taxonomy ( content_id, contenttype, taxonomytype, slug, name, sortorder
) SELECT t.content_id, 'blogevents',  t.taxonomytype, t.slug, t.name, t.sortorder
    FROM europeana_pro.bolt_taxonomy t
    JOIN europeana_pro.bolt_taxonomy cl
    ON (
          cl.content_id = t.content_id
          AND cl.contenttype = 'events'
          AND cl.slug in ('culturelover', 'culturelover-fashion', 'europeana-fashion', 'europeana-enduser', 'europeana-1418')
        )
    WHERE t.contenttype = 'events'
    GROUP BY t.id;


-- ##################################
-- Fix culturelover authors
-- ##################################

DELETE FROM europeana_cope.bolt_relations WHERE to_contenttype = 'blogposts';
DELETE FROM europeana_cope.bolt_relations WHERE to_contenttype = 'blogevents';
DELETE FROM europeana_cope.bolt_relations WHERE from_contenttype = 'blogposts';
DELETE FROM europeana_cope.bolt_relations WHERE from_contenttype = 'blogevents';

-- pro
INSERT INTO europeana_cope.bolt_relations
  ( from_contenttype, from_id, to_contenttype, to_id )
  SELECT 'blogposts', r.from_id, 'persons', p.id
  FROM europeana_pro.bolt_relations r
  JOIN europeana_pro.bolt_network n ON n.id = r.to_id
  JOIN europeana_cope.bolt_persons p ON p.uid = n.uid
    WHERE
      from_contenttype = 'blogposts'
      AND from_id IN (SELECT id FROM europeana_cope.bolt_blogposts)
      AND to_contenttype = 'network';

INSERT INTO europeana_cope.bolt_relations
  ( from_contenttype, from_id, to_contenttype, to_id )
  SELECT 'blogposts', r.from_id, 'persons', p.id
  FROM europeana_pro.bolt_relations r
  JOIN europeana_pro.bolt_network n ON n.id = r.to_id
  JOIN europeana_cope.bolt_persons p ON p.uid = n.uid
    WHERE
      to_contenttype = 'blogposts'
      AND from_id IN (SELECT id FROM europeana_cope.bolt_blogposts)
      AND from_contenttype = 'network';

-- pro
INSERT INTO europeana_cope.bolt_relations
  ( from_contenttype, from_id, to_contenttype, to_id )
  SELECT 'blogevents', r.from_id, 'persons', p.id
  FROM europeana_pro.bolt_relations r
  JOIN europeana_pro.bolt_network n ON n.id = r.to_id
  JOIN europeana_cope.bolt_persons p ON p.uid = n.uid
    WHERE
      from_contenttype = 'blogevents'
      AND from_id IN (SELECT id FROM europeana_cope.bolt_blogposts)
      AND to_contenttype = 'network';

INSERT INTO europeana_cope.bolt_relations
  ( from_contenttype, from_id, to_contenttype, to_id )
  SELECT 'blogevents', r.from_id, 'persons', p.id
  FROM europeana_pro.bolt_relations r
  JOIN europeana_pro.bolt_network n ON n.id = r.to_id
  JOIN europeana_cope.bolt_persons p ON p.uid = n.uid
    WHERE
      to_contenttype = 'blogevents'
      AND from_id IN (SELECT id FROM europeana_cope.bolt_blogposts)
      AND from_contenttype = 'network';

-- ##################################
-- Depublish all posts that would have been culturelover posts
-- ##################################

UPDATE europeana_cope.bolt_posts b SET b.status = 'held'
    WHERE b.id IN (
        SELECT distinct(t.content_id) FROM europeana_cope.bolt_taxonomy t
        WHERE t.contenttype = 'posts' AND t.slug IN ('culturelover', 'culturelover-fashion', 'europeana-fashion', 'europeana-enduser', 'europeana-1418')
    );

UPDATE europeana_cope.bolt_events e SET e.status = 'held'
    WHERE e.id IN (
        SELECT distinct(t.content_id) FROM europeana_cope.bolt_taxonomy t
        WHERE t.contenttype = 'events' AND t.slug IN ('culturelover', 'culturelover-fashion', 'europeana-fashion', 'europeana-enduser', 'europeana-1418')
    );
