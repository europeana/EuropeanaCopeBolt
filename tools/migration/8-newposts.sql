-- ## POSTS

ALTER TABLE europeana_cope.bolt_posts ADD COLUMN subsite_id int(11) NOT NULL DEFAULT 0;

-- pro
INSERT INTO europeana_cope.bolt_posts
    ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, teaser, body, attachments, parents, image, templatefields, posttype )
  SELECT
      'pro', b.id, b.slug, b.datecreated, b.datechanged, b.datepublish, b.datedepublish, b.username, b.ownerid, b.status, b.title, b.teaser, b.body, b.attachments, b.parents, b.image, b.templatefields, 'Blog'
  FROM europeana_pro.bolt_blogposts b
  WHERE b.datecreated >= '2017-04-19 00:00:00'
  AND b.id NOT IN (
    SELECT distinct(t.content_id) FROM europeana_pro.bolt_taxonomy t
    WHERE t.contenttype IN ('blogpost', 'blogposts') AND t.slug IN ('culturelover')
  );

-- pro publications
INSERT INTO europeana_cope.bolt_posts
    ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, subtitle, body, isbn, files, image, parents, teaser, intro, templatefields, posttype )
  SELECT
      'pro', p.id, p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.title, p.subtitle, p.body, p.isbn, p.filelist, p.image, p.parents, p.teaser, p.introduction,  p.templatefields, 'Publication'
  FROM europeana_pro.bolt_publications p
  WHERE p.datecreated >= '2017-04-19 00:00:00'
  AND p.id NOT IN (
    SELECT distinct(t.content_id) FROM europeana_pro.bolt_taxonomy t
    WHERE t.contenttype IN ('publication', 'publications') AND t.slug IN ('culturelover')
  );

-- pro pressreleases
INSERT INTO europeana_cope.bolt_posts
    ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, subtitle, body, isbn, files, image, parents, intro, templatefields, posttype )
  SELECT
    'pro', p.id, p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.title, p.subtitle, p.body, p.isbn, p.filelist, p.image, p.parents, p.introduction,  p.templatefields, 'Pressrelease'
  FROM europeana_pro.bolt_pressreleases p
  WHERE p.datecreated >= '2017-04-19 00:00:00'
  AND p.id NOT IN (
    SELECT distinct(t.content_id) FROM europeana_pro.bolt_taxonomy t
    WHERE t.contenttype IN ('pressrelease', 'pressreleases') AND t.slug IN ('culturelover')
  );

-- ## TAXONOMY

ALTER TABLE europeana_cope.bolt_taxonomy ADD COLUMN subsite_id int(11) NOT NULL DEFAULT 0;
ALTER TABLE europeana_cope.bolt_taxonomy ADD COLUMN subsite varchar(255) NOT NULL DEFAULT 0;

-- pro
INSERT INTO europeana_cope.bolt_taxonomy
    ( subsite, subsite_id, content_id, contenttype, taxonomytype, slug, name, sortorder )
  SELECT
      'pro', t.content_id, t.content_id, 'posts',  t.taxonomytype, t.slug, t.name, t.sortorder
  FROM europeana_pro.bolt_taxonomy t
    JOIN europeana_pro.bolt_blogposts b ON b.id = t.content_id AND t.contenttype = 'blogposts'
  WHERE b.datecreated >= '2017-04-19 00:00:00'
  AND b.id NOT IN (
    SELECT distinct(t.content_id) FROM europeana_pro.bolt_taxonomy t
    WHERE t.contenttype IN ('blogpost', 'blogposts') AND t.slug IN ('culturelover')
  );

-- pro publications
INSERT INTO europeana_cope.bolt_taxonomy
    ( subsite, subsite_id, content_id, contenttype, taxonomytype, slug, name, sortorder )
  SELECT
      'pro', t.content_id, t.content_id, 'posts', t.taxonomytype, t.slug, t.name, t.sortorder
  FROM europeana_pro.bolt_taxonomy t
    JOIN europeana_pro.bolt_publications p ON p.id = t.content_id AND t.contenttype = 'publications'
  WHERE p.datecreated >= '2017-04-19 00:00:00'
  AND p.id NOT IN (
    SELECT distinct(t.content_id) FROM europeana_pro.bolt_taxonomy t
    WHERE t.contenttype IN ('publication', 'publications') AND t.slug IN ('culturelover')
  );

-- pro pressreleases
INSERT INTO europeana_cope.bolt_taxonomy
    ( subsite, subsite_id, content_id, contenttype, taxonomytype, slug, name, sortorder )
  SELECT
      'pro', t.content_id, t.content_id, 'posts', t.taxonomytype, t.slug, t.name, t.sortorder
  FROM europeana_pro.bolt_taxonomy t
    JOIN europeana_pro.bolt_pressreleases p ON p.id = t.content_id AND t.contenttype = 'pressreleases'
  WHERE p.datecreated >= '2017-04-19 00:00:00'
  AND p.id NOT IN (
    SELECT distinct(t.content_id) FROM europeana_pro.bolt_taxonomy t
    WHERE t.contenttype IN ('pressrelease', 'pressreleases') AND t.slug IN ('culturelover')
  );

-- SET BETTER ID'S

UPDATE europeana_cope.bolt_taxonomy r,
  europeana_cope.bolt_posts x
SET r.content_id = x.id
WHERE x.subsite_id = r.content_id
      AND x.subsite = r.subsite
      AND r.contenttype = 'posts';


ALTER TABLE europeana_cope.bolt_taxonomy DROP subsite_id;
ALTER TABLE europeana_cope.bolt_taxonomy DROP subsite;

-- ## RELATIONS

-- ## There are only a handful relations to network members or pages
-- ## There are some relatiosn to blogposts, but that might be a culturelover or normal blogpost
-- ## debugging this will take longer than recreating the relations manually
#
# ALTER TABLE europeana_cope.bolt_relations ADD COLUMN subsite_id int(11) NOT NULL DEFAULT 0;
# ALTER TABLE europeana_cope.bolt_relations ADD COLUMN subsite varchar(255) NOT NULL DEFAULT 0;
#
# -- pro
# INSERT INTO europeana_cope.bolt_relations
#     ( subsite, subsite_id, from_contenttype, from_id, to_contenttype, to_id )
#   SELECT
#       'pro', r.to_id, 'posts', r.from_id, r.to_contenttype, r.to_id
#   FROM europeana_pro.bolt_relations r
#     JOIN europeana_pro.bolt_blogposts b ON b.id = r.from_id AND r.from_contenttype = 'blogposts'
#   WHERE b.datecreated >= '2017-04-19 00:00:00'
#     AND NOT (r.to_contenttype IN ('person', 'persons'));
#
# INSERT INTO europeana_cope.bolt_relations
#     ( subsite, subsite_id, from_contenttype, from_id, to_contenttype, to_id )
#   SELECT 'pro', r.to_id, 'posts', r.to_id, r.from_contenttype, r.from_id
#   FROM europeana_pro.bolt_relations r
#     JOIN europeana_pro.bolt_blogposts b ON b.id = r.to_id AND r.to_contenttype = 'blogposts'
#   WHERE b.datecreated >= '2017-04-19 00:00:00'
#     AND NOT (r.from_contenttype IN ('person', 'persons'));
#
# -- pro publications
# INSERT INTO europeana_cope.bolt_relations
#     ( subsite, subsite_id, from_contenttype, from_id, to_contenttype, to_id )
#   SELECT
#       'pro', r.to_id, 'posts', r.from_id, r.to_contenttype, r.to_id
#   FROM europeana_pro.bolt_relations r
#     JOIN europeana_pro.bolt_publications p ON p.id = r.from_id AND r.from_contenttype = 'publications'
#   WHERE p.datecreated >= '2017-04-19 00:00:00'
#     AND NOT (r.to_contenttype IN ('person', 'persons'));
#
# INSERT INTO europeana_cope.bolt_relations
#     ( subsite, subsite_id, from_contenttype, from_id, to_contenttype, to_id )
#   SELECT 'pro', r.to_id, 'posts', r.to_id, r.from_contenttype, r.from_id
#   FROM europeana_pro.bolt_relations r
#     JOIN europeana_pro.bolt_publications p ON p.id = r.to_id AND r.to_contenttype = 'publications'
#   WHERE p.datecreated >= '2017-04-19 00:00:00'
#     AND NOT (r.from_contenttype IN ('person', 'persons'));
#
# -- pro pressreleases
# INSERT INTO europeana_cope.bolt_relations
#     ( subsite, subsite_id, from_contenttype, from_id, to_contenttype, to_id )
#   SELECT
#       'pro', r.to_id, 'posts', r.from_id, r.to_contenttype, r.to_id
#   FROM europeana_pro.bolt_relations r
#     JOIN europeana_pro.bolt_pressreleases p ON p.id = r.from_id AND r.from_contenttype = 'pressreleases'
#   WHERE p.datecreated >= '2017-04-19 00:00:00'
#     AND NOT (r.to_contenttype IN ('person', 'persons'));
#
# INSERT INTO europeana_cope.bolt_relations
#     ( subsite, subsite_id, from_contenttype, from_id, to_contenttype, to_id )
#   SELECT
#       'pro', r.to_id, 'posts', r.to_id, r.from_contenttype, r.from_id
#   FROM europeana_pro.bolt_relations r
#     JOIN europeana_pro.bolt_pressreleases p ON p.id = r.to_id AND r.to_contenttype = 'pressreleases'
#   WHERE p.datecreated >= '2017-04-19 00:00:00'
#     AND NOT (r.from_contenttype IN ('person', 'persons'));

-- Make better ID's

# UPDATE europeana_cope.bolt_relations r,
#   europeana_cope.bolt_posts x
# SET r.from_id = x.id
# WHERE x.subsite_id = r.from_id
#       AND x.subsite = r.subsite
#       AND r.from_contenttype = 'posts';
#
# UPDATE europeana_cope.bolt_relations r,
#        europeana_cope.bolt_posts x,
#        europeana_cope.bolt_persons p,
#        europeana_pro.bolt_network n
#   SET r.to_id = p.id,
#       r.to_contenttype = 'persons'
#   WHERE x.subsite_id = r.to_id
#     AND p.uid = n.uid
#     AND x.subsite = r.subsite
#     AND r.to_contenttype = 'network';

-- CLEANUP
ALTER TABLE europeana_cope.bolt_posts DROP subsite_id;
# ALTER TABLE europeana_cope.bolt_relations DROP subsite_id;
# ALTER TABLE europeana_cope.bolt_relations DROP subsite;
