-- merge homepages into structures

USE europeana_cope;

-- because structures have less fields we'll discard all links etc.
-- they must be manually recreated as related blocks
INSERT INTO europeana_cope.bolt_structures (
  slug, datecreated, datechanged, datepublish, datedepublish,
  username, ownerid, status, title,
  intro, body, image, suffix, teaser, teaser_image,
  structure_sortorder, structure_parent, hide_list, templatefields, template,
  default_content
)
SELECT
  slug, datecreated, datechanged, datepublish, datedepublish,
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

-- do similar things to the other content types
-- merge superflous fields, eg. files, filelists and filelist_downloads for projects, collections and publications
ALTER TABLE europeana_cope.bolt_projects CHANGE filelist_downloads document_folder VARCHAR( 256 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';
ALTER TABLE europeana_cope.bolt_taskforces CHANGE filelist_downloads document_folder VARCHAR( 256 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';
ALTER TABLE europeana_cope.bolt_pages CHANGE filelist_downloads document_folder VARCHAR( 256 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';

ALTER TABLE europeana_cope.bolt_taskforces CHANGE filelist_files attachments LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
ALTER TABLE europeana_cope.bolt_pages CHANGE filelist_files attachments LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

-- remove columns that we don't use anymore
-- ALTER TABLE europeana_cope.bolt_table DROP column_name;
ALTER TABLE europeana_cope.bolt_structures DROP date_start;
ALTER TABLE europeana_cope.bolt_structures DROP date_end;

ALTER TABLE europeana_cope.bolt_documentation DROP support_navigation;
ALTER TABLE europeana_cope.bolt_events DROP support_navigation;
ALTER TABLE europeana_cope.bolt_pages DROP support_navigation;

ALTER TABLE europeana_cope.bolt_pages DROP liststyle;

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

-- kill all custom templates
UPDATE bolt_applications SET template='';
UPDATE bolt_posts SET template='';
UPDATE bolt_data SET template='';
UPDATE bolt_documentation SET template='';
UPDATE bolt_events SET template='';
#UPDATE bolt_footers SET template='';
#UPDATE bolt_homepage SET template='';
UPDATE bolt_jobs SET template='';
#UPDATE bolt_locations SET template='';
UPDATE bolt_pages SET template='';
UPDATE bolt_persons SET template='';
UPDATE bolt_projects SET template='';
#UPDATE bolt_relations SET template='';
#UPDATE bolt_resources SET template='';
UPDATE bolt_structures SET template='';
UPDATE bolt_taskforces SET template='';
#UPDATE bolt_taxonomy SET template='';
