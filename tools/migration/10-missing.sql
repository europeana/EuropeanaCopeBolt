ALTER TABLE europeana_cope.bolt_posts ADD COLUMN subsite_id int(11) NOT NULL DEFAULT 0;
ALTER TABLE europeana_cope.bolt_taxonomy ADD COLUMN subsite_id int(11) NOT NULL DEFAULT 0;
ALTER TABLE europeana_cope.bolt_taxonomy ADD COLUMN subsite varchar(255) NOT NULL DEFAULT 0;

-- labs
INSERT IGNORE INTO europeana_cope.bolt_posts
(subsite, subsite_id, slug, datecreated, datechanged, datepublish,
 datedepublish, username, ownerid, status, title, body, attachments,
 image )
  SELECT 'labs', b.id, b.slug, b.datecreated, b.datechanged, b.datepublish,
    b.datedepublish, b.username, b.ownerid, b.status, b.title, b.body, b.files,
    b.image
  FROM europeana_labs.bolt_blog b
  WHERE
    b.datecreated >= '2017-04-20 00:00:00'
  ORDER BY b.datecreated DESC;

-- ## TAXONOMY

-- labs
INSERT INTO europeana_cope.bolt_taxonomy
( subsite, subsite_id, content_id, contenttype, taxonomytype, slug, name, sortorder )
  SELECT
    'labs', t.content_id, t.content_id, 'posts',  t.taxonomytype, t.slug, t.name, t.sortorder
  FROM europeana_labs.bolt_taxonomy t
    JOIN europeana_labs.bolt_blog b ON b.id = t.content_id AND t.contenttype = 'blog'
  WHERE
    b.datecreated >= '2017-04-20 00:00:00'
  ORDER BY b.datecreated DESC;

-- SET BETTER ID'S

UPDATE europeana_cope.bolt_taxonomy t,
  europeana_cope.bolt_posts x
SET t.content_id = x.id
WHERE x.subsite_id = t.content_id
      AND x.subsite = 'labs'
      AND t.subsite = 'labs'
      AND t.contenttype = 'posts';


-- research
INSERT IGNORE INTO europeana_cope.bolt_posts
(subsite, subsite_id, slug, datecreated, datechanged, datepublish,
 datedepublish, username, ownerid, status, title, body, attachments,
 image )
  SELECT 'research', b.id, b.slug, b.datecreated, b.datechanged, b.datepublish,
    b.datedepublish, b.username, b.ownerid, b.status, b.title, b.body, b.attachments,
    b.image
  FROM europeana_research.bolt_blogposts b
  WHERE
    b.datecreated > '2017-04-20 00:00:00'
  ORDER BY b.datecreated DESC;

-- ## TAXONOMY

-- research
INSERT INTO europeana_cope.bolt_taxonomy
( subsite, subsite_id, content_id, contenttype, taxonomytype, slug, name, sortorder )
  SELECT
    'research', t.content_id, t.content_id, 'posts',  t.taxonomytype, t.slug, t.name, t.sortorder
  FROM europeana_research.bolt_taxonomy t
    JOIN europeana_research.bolt_blogposts b ON b.id = t.content_id AND t.contenttype = 'blogposts'
  WHERE
    b.datecreated > '2017-04-20 00:00:00'
  ORDER BY b.datecreated DESC;

-- SET BETTER ID'S

UPDATE europeana_cope.bolt_taxonomy t,
  europeana_cope.bolt_posts x
SET t.content_id = x.id
WHERE x.subsite_id = t.content_id
      AND x.subsite = 'research'
      AND t.subsite = 'research'
      AND t.contenttype = 'posts';

-- ##################################################################################################

ALTER TABLE europeana_cope.bolt_taxonomy DROP subsite_id;
ALTER TABLE europeana_cope.bolt_taxonomy DROP subsite;
ALTER TABLE europeana_cope.bolt_posts DROP subsite_id;
