-- merge homepages into structures
-- because structures have less fields we'll discard all links etc.
-- they must be manually recreated as related blocks
INSERT INTO europeana_cope.bolt_structures (
  subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish,
  username, ownerid, status, title,
  intro, body, image, suffix, teaser, teaser_image,
  structure_sortorder, structure_parent, hide_list, templatefields, template,
  default_content
)
SELECT
  subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish,
  username, ownerid, status, title,
  '', '', '', '', concat('<h3>', subtitle, '</h3>\n', bannertext, '\n', bannerlink, '\n', imageattribution, '\n', imagelicense), bannerimage,
  0, 0, 0, templatefields, '',
  ''
FROM europeana_cope.bolt_homepage;

-- skipped fields
-- brandcolour, brandopacity, brandlocation, callout_1, callout_2, callout_3,
-- use_manual_1, flag_colour_1, flag_label_1, latest_title_1, latest_teaser_1, latest_image_1, latest_url_1,
-- use_manual_2, flag_colour_2, flag_label_2, latest_title_2, latest_teaser_2, latest_image_2, latest_url_2,
-- use_manual_3, flag_colour_3, flag_label_3, latest_title_3, latest_teaser_3, latest_image_3, latest_url_3,

DROP TABLE europeana_cope.bolt_homepage;

-- rename apps to applications

DROP TABLE IF EXISTS bolt_applications;
CREATE TABLE IF NOT EXISTS bolt_applications (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL DEFAULT '', # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL DEFAULT '', # all
  subsite varchar(32) NOT NULL DEFAULT 'unknown', # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL DEFAULT 0, # all [ intermediary ID used for importing - remove after import ]
  body longtext NOT NULL, # labs
  contact_email varchar(256) NOT NULL DEFAULT '', # labs
  contact_name varchar(256) NOT NULL DEFAULT '', # labs
  contact_website varchar(256) NOT NULL DEFAULT '', # labs
  hero longtext NOT NULL, # labs
  image longtext NOT NULL, # labs
  intro longtext NOT NULL, # labs
  link1 varchar(256) NOT NULL DEFAULT '', # labs
  link2 varchar(256) NOT NULL DEFAULT '', # labs
  link3 varchar(256) NOT NULL DEFAULT '', # labs
  teaser longtext NOT NULL, # labs
  templatefields longtext NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  PRIMARY KEY (id)
);

INSERT INTO bolt_applications
(
  id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, subsite, body, contact_email, contact_name, contact_website, image, intro, link1, link2, link3, teaser, templatefields, title
)
  SELECT
    id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, subsite, body, contact_email, contact_name, contact_website, image, intro, link1, link2, link3, teaser, templatefields, title
  FROM bolt_apps;

UPDATE bolt_relations r SET r.from_contenttype = 'applications' WHERE r.from_contenttype = 'apps';
UPDATE bolt_relations r SET r.to_contenttype = 'applications' WHERE r.to_contenttype = 'apps';
UPDATE bolt_taxonomy t SET t.contenttype = 'applications' WHERE t.contenttype = 'apps';


-- do similar things to the other content types
-- merge superflous fields, eg. files, filelists and filelist_downloads for projects, collections and publications
ALTER TABLE europeana_cope.bolt_projects CHANGE filelist_downloads document_folder VARCHAR( 256 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';
ALTER TABLE europeana_cope.bolt_collections CHANGE filelist_downloads document_folder VARCHAR( 256 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';
ALTER TABLE europeana_cope.bolt_taskforces CHANGE filelist_downloads document_folder VARCHAR( 256 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';
ALTER TABLE europeana_cope.bolt_pages CHANGE filelist_downloads document_folder VARCHAR( 256 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';

ALTER TABLE europeana_cope.bolt_collections CHANGE filelist_files attachments LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE europeana_cope.bolt_taskforces CHANGE filelist_files attachments LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE europeana_cope.bolt_pages CHANGE filelist_files attachments LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

-- remove columns that we don't use anymore
-- ALTER TABLE europeana_cope.bolt_table DROP column_name;
ALTER TABLE europeana_cope.bolt_structures DROP date_start;
ALTER TABLE europeana_cope.bolt_structures DROP date_end;

ALTER TABLE europeana_cope.bolt_collections DROP support_navigation;
ALTER TABLE europeana_cope.bolt_documentation DROP support_navigation;
ALTER TABLE europeana_cope.bolt_events DROP support_navigation;
ALTER TABLE europeana_cope.bolt_pages DROP support_navigation;

ALTER TABLE europeana_cope.bolt_collections DROP liststyle;
ALTER TABLE europeana_cope.bolt_pages DROP liststyle;

ALTER TABLE europeana_cope.bolt_collections DROP secondary_mail;
ALTER TABLE europeana_cope.bolt_documentation DROP secondary_mail;
ALTER TABLE europeana_cope.bolt_events DROP secondary_mail;
ALTER TABLE europeana_cope.bolt_structures DROP secondary_mail;
ALTER TABLE europeana_cope.bolt_pages DROP secondary_mail;

-- cleanup persons contenttype
-- only public information should ever be on the site
ALTER TABLE europeana_cope.bolt_persons DROP email;
ALTER TABLE europeana_cope.bolt_persons DROP secondary_mail;
ALTER TABLE europeana_cope.bolt_persons DROP phone;
ALTER TABLE europeana_cope.bolt_persons DROP telephone_number;
ALTER TABLE europeana_cope.bolt_persons DROP other_number;
ALTER TABLE europeana_cope.bolt_persons DROP public_photo; -- remove checkbox
ALTER TABLE europeana_cope.bolt_persons DROP introduction;
ALTER TABLE europeana_cope.bolt_persons DROP contact_blogpost;
ALTER TABLE europeana_cope.bolt_persons DROP contact_event;
ALTER TABLE europeana_cope.bolt_persons DROP contact_job;
ALTER TABLE europeana_cope.bolt_persons DROP contact_person;
ALTER TABLE europeana_cope.bolt_persons DROP contact_publication;
ALTER TABLE europeana_cope.bolt_persons DROP contact_pressrelease;
ALTER TABLE europeana_cope.bolt_persons DROP contact_taskforce;
ALTER TABLE europeana_cope.bolt_persons DROP contact_tag;
ALTER TABLE europeana_cope.bolt_persons DROP community;
ALTER TABLE europeana_cope.bolt_persons DROP community_role;
-- rename columns
ALTER TABLE europeana_cope.bolt_persons CHANGE image public_photo longtext;
ALTER TABLE europeana_cope.bolt_persons CHANGE description bio longtext;
