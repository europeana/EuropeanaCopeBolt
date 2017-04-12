-- merge homepages into structures

USE europeana_cope;

-- do similar things to the other content types
-- merge superflous fields, eg. files, filelists and filelist_downloads for projects, collections and publications
ALTER TABLE europeana_cope.bolt_projects CHANGE filelist_downloads document_folder VARCHAR( 256 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';
ALTER TABLE europeana_cope.bolt_pages CHANGE filelist_downloads document_folder VARCHAR( 256 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '';

ALTER TABLE europeana_cope.bolt_pages CHANGE filelist_files attachments LONGTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

-- remove columns that we don't use anymore
-- ALTER TABLE europeana_cope.bolt_table DROP column_name;

-- cleanup persons contenttype
-- only public information should ever be on the site
ALTER TABLE europeana_cope.bolt_persons DROP email;
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
UPDATE bolt_posts SET template='';
UPDATE bolt_data SET template='';
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
#UPDATE bolt_taxonomy SET template='';

-- update user one
UPDATE europeana_cope.bolt_users
SET email = 'lodewijk@twokings.nl',
  username = 'admin',
  password = '$2y$08$mH4dP.5RizoZM4djZk7TKuamh2N7Ne6ll8e5YPw4d.aV6j57xhqlO'
WHERE id = '1';

