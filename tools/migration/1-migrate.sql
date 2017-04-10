CREATE DATABASE IF NOT EXISTS europeana_cope DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE europeana_cope;

-- core business collections and data --

DROP TABLE IF EXISTS bolt_projects;
CREATE TABLE IF NOT EXISTS bolt_projects (
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
  body longtext NULL, # pro
  date_end date DEFAULT NULL, # pro
  date_start date DEFAULT NULL, # pro
  filelist longtext NULL, # pro
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # pro
  intro longtext NULL, # pro
  logo longtext NULL, # pro
  structure_parent longtext NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT 0, # pro
  subtitle varchar(256) NOT NULL DEFAULT '', # pro
  teaser longtext NULL, # pro
  templatefields longtext NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  url varchar(256) NOT NULL DEFAULT '', # pro
  PRIMARY KEY (id)
);

INSERT INTO europeana_cope.bolt_projects ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, subtitle, date_start, date_end, teaser, intro, body, url, logo, filelist, structure_parent, filelist_downloads, structure_sortorder, templatefields
) SELECT 'pro', p.id,
  p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.title, p.subtitle, p.date_start, p.date_end, p.teaser, p.intro, p.body, p.url, p.logo, p.filelist, p.structure_parent, p.filelist_downloads, p.structure_sortorder, p.templatefields
FROM europeana_pro.bolt_projects p;

DROP TABLE IF EXISTS bolt_collections;
CREATE TABLE IF NOT EXISTS bolt_collections (
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
  body longtext NULL, # research
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # research
  filelist_files longtext NULL, # research
  hide_list tinyint(1) NOT NULL DEFAULT 0, # research
  hide_related tinyint(1) NOT NULL DEFAULT 0, # research
  hide_related_section tinyint(1) NOT NULL DEFAULT 0, # research
  imagelist longtext NULL, # research
  intro longtext NULL, # research
  liststyle longtext NULL, # research
  listtitle varchar(256) NOT NULL DEFAULT '', # research
  secondary_mail tinyint(1) NOT NULL DEFAULT 0, # research
  source varchar(256) NOT NULL DEFAULT '', # research
  source_url varchar(256) NOT NULL DEFAULT '', # research
  structure_parent longtext NULL, # research
  structure_sortorder int(11) NOT NULL DEFAULT 0, # research
  support_navigation longtext NULL, # research
  teaser longtext NULL, # research
  teaser_image longtext NULL, # research
  templatefields longtext NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  PRIMARY KEY (id)
);

INSERT INTO europeana_cope.bolt_collections ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, intro, teaser, body, teaser_image, secondary_mail, hide_list, filelist_files, filelist_downloads, hide_related, hide_related_section, listtitle, imagelist, liststyle, support_navigation, source, source_url, templatefields, structure_parent, structure_sortorder
) SELECT 'research', r.id,
    r.slug, r.datecreated, r.datechanged, r.datepublish, r.datedepublish, r.username, r.ownerid, r.status, r.title, r.intro, r.teaser, r.body, r.teaser_image, r.secondary_mail, r.hide_list, r.filelist_files, r.filelist_downloads, r.hide_related, r.hide_related_section, r.listtitle, r.imagelist, r.liststyle, r.support_navigation, r.source, r.source_url, r.templatefields, r.structure_parent, r.structure_sortorder
FROM europeana_research.bolt_collections r;

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
  body longtext NULL, # labs
  contact_email varchar(256) NOT NULL DEFAULT '', # labs
  contact_name varchar(256) NOT NULL DEFAULT '', # labs
  contact_website varchar(256) NOT NULL DEFAULT '', # labs
  hero longtext NULL, # labs
  image longtext NULL, # labs
  intro longtext NULL, # labs
  link1 varchar(256) NOT NULL DEFAULT '', # labs
  link2 varchar(256) NOT NULL DEFAULT '', # labs
  link3 varchar(256) NOT NULL DEFAULT '', # labs
  teaser longtext NULL, # labs
  templatefields longtext NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  PRIMARY KEY (id)
);

INSERT INTO europeana_cope.bolt_applications ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, intro, teaser, body, image, link1, link2, link3, contact_name, contact_email, contact_website, templatefields, hero
) SELECT 'labs', a.id,
  a.slug, a.datecreated, a.datechanged, a.datepublish, a.datedepublish, a.username, a.ownerid, a.status, a.title, a.intro, a.teaser, a.body, a.image, a.link1, a.link2, a.link3, a.contact_name, a.contact_email, a.contact_website, a.templatefields, a.hero
FROM europeana_labs.bolt_apps a;

DROP TABLE IF EXISTS bolt_data;
CREATE TABLE IF NOT EXISTS bolt_data (
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
  apiconsolelink varchar(256) NOT NULL DEFAULT '', # labs # research
  body longtext NULL, # labs # research
  contact_email varchar(256) NOT NULL DEFAULT '', # labs # research
  contact_name varchar(256) NOT NULL DEFAULT '', # labs # research
  country varchar(256) NOT NULL DEFAULT '', # research
  image longtext NULL, # labs # research
  intro longtext NULL, # labs # research
  itemtype varchar(256) NOT NULL DEFAULT '', # research
  language_coverage varchar(256) NOT NULL DEFAULT '', # research
  portallink varchar(256) NOT NULL DEFAULT '', # labs # research
  provided_by varchar(256) NOT NULL DEFAULT '', # labs # research
  provided_by_link varchar(256) NOT NULL DEFAULT '', # labs # research
  spatial_coverage varchar(256) NOT NULL DEFAULT '', # research
  subjects varchar(256) NOT NULL DEFAULT '', # research
  teaser longtext NULL, # labs # research
  templatefields longtext NULL, # labs
  time_coverage varchar(256) NOT NULL DEFAULT '', # research
  title varchar(256) NOT NULL DEFAULT '', # labs # research
  PRIMARY KEY (id)
);

INSERT INTO europeana_cope.bolt_data ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, intro, teaser, body, image, provided_by, provided_by_link, portallink, apiconsolelink, contact_name, contact_email, templatefields
) SELECT 'labs', d.id,
  d.slug, d.datecreated, d.datechanged, d.datepublish, d.datedepublish, d.username, d.ownerid, d.status, d.title, d.intro, d.teaser, d.body, d.image, d.provided_by, d.provided_by_link, d.portallink, d.apiconsolelink, d.contact_name, d.contact_email, d.templatefields
FROM europeana_labs.bolt_data d;

INSERT INTO europeana_cope.bolt_data ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, templatefields, username, ownerid, status, title, intro, teaser, body, image, provided_by, provided_by_link, portallink, apiconsolelink, contact_name, contact_email
) SELECT 'research', d.id,
  d.slug, d.datecreated, d.datechanged, d.datepublish, d.datedepublish, d.templatefields, d.username, d.ownerid, d.status, d.title, d.intro, d.teaser, d.body, d.image, d.provided_by, d.provided_by_link, d.portallink, d.apiconsolelink, d.contact_name, d.contact_email
FROM europeana_research.bolt_data d;

DROP TABLE IF EXISTS bolt_documentation;
CREATE TABLE IF NOT EXISTS bolt_documentation (
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
  title varchar(256) NOT NULL DEFAULT '', # labs
  intro longtext NULL, # labs
  teaser longtext NULL, # labs
  body longtext NULL, # labs
  teaser_image longtext NULL, # labs
  secondary_mail tinyint(1) NOT NULL DEFAULT 0, # labs
  hide_related tinyint(1) NOT NULL DEFAULT 0, # labs
  hide_related_section tinyint(1) NOT NULL DEFAULT 0, # labs
  files longtext NULL, # labs
  link1 varchar(256) NOT NULL DEFAULT '', # labs
  link2 varchar(256) NOT NULL DEFAULT '', # labs
  link3 varchar(256) NOT NULL DEFAULT '', # labs
  support_navigation longtext NULL, # labs
  structure_sortorder int(11) NOT NULL DEFAULT 0, # labs
  structure_parent longtext NULL, # pro
  templatefields longtext NULL, # pro
  templateselect longtext NULL, # pro
  PRIMARY KEY (id)
);

# INSERT INTO europeana_cope.bolt_documentation ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, intro, teaser, body, teaser_image, secondary_mail, hide_related, hide_related_section, files, link1, link2, link3, support_navigation, structure_sortorder
# ) SELECT 'labs', d.id,
#   d.slug, d.datecreated, d.datechanged, d.datepublish, d.datedepublish, d.username, d.ownerid, d.status, d.title, d.intro, d.teaser, d.body, d.teaser_image, d.secondary_mail, d.hide_related, d.hide_related_section, d.files, d.link1, d.link2, d.link3, d.support_navigation, d.structure_sortorder
# FROM europeana_labs.bolt_documentation d;

INSERT INTO europeana_cope.bolt_documentation ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, intro, teaser, body, teaser_image, secondary_mail, hide_related, hide_related_section, files, link1, link2, link3, support_navigation, structure_sortorder, templatefields, structure_parent, templateselect
) SELECT 'labs', a.id,
    a.slug, a.datecreated, a.datechanged, a.datepublish, a.datedepublish, a.username, a.ownerid, a.status, a.title, a.intro, a.teaser, a.body, a.teaser_image, a.secondary_mail, a.hide_related, a.hide_related_section, a.files, a.link1, a.link2, a.link3, a.support_navigation, a.structure_sortorder, a.templatefields, a.structure_parent, a.templateselect
FROM europeana_labs.bolt_api a;

DROP TABLE IF EXISTS bolt_publications;
CREATE TABLE IF NOT EXISTS bolt_publications (
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
  title varchar(256) NOT NULL DEFAULT '', # pro
  subtitle longtext NULL, # pro
  body longtext NULL, # pro
  isbn varchar(256) NOT NULL DEFAULT '', # pro
  filelist longtext NULL, # pro
  image longtext NULL, # pro
  parents longtext NULL, # pro
  teaser longtext NULL, # pro
  introduction varchar(256) NOT NULL DEFAULT '', # pro
  structure_sortorder int(11) NOT NULL DEFAULT 0, # pro
  structure_parent longtext NULL, # pro
  templatefields longtext NULL, # pro
  PRIMARY KEY (id)
);

INSERT INTO europeana_cope.bolt_publications ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, subtitle, body, isbn, filelist, image, parents, teaser, introduction, structure_sortorder, structure_parent, templatefields
) SELECT 'pro', p.id,
  p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.title, p.subtitle, p.body, p.isbn, p.filelist, p.image, p.parents, p.teaser, p.introduction, p.structure_sortorder, p.structure_parent, p.templatefields
FROM europeana_pro.bolt_publications p;

-- people and places --

DROP TABLE IF EXISTS bolt_persons;
CREATE TABLE IF NOT EXISTS bolt_persons (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL DEFAULT '', # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL DEFAULT '', # all
  subsite varchar(32) NOT NULL DEFAULT 'unknown', # all [ content is either 'pro', 'zoho', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL DEFAULT 0, # all [ intermediary ID used for importing - remove after import ]
  account_name varchar(256) NOT NULL DEFAULT '', # zoho
  account_uid varchar(256) NOT NULL DEFAULT '', # zoho
  author_name varchar(256) NOT NULL DEFAULT '', # zoho
  author_uid varchar(256) NOT NULL DEFAULT '', # zoho
  candidacy_intro longtext NULL, # zoho
  candidacy_teaser longtext NULL, # zoho
  checkbox_chief tinyint(1) NOT NULL DEFAULT 0, # pro
  checkbox_europeana tinyint(1) NOT NULL DEFAULT 0, # pro
  checkbox_network tinyint(1) NOT NULL DEFAULT 0, # pro
  community longtext NULL, # zoho
  community_role varchar(256) NOT NULL DEFAULT '', # zoho
  company varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  company_url varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  contact_aggregator tinyint(1) NOT NULL DEFAULT 0, # pro
  contact_blog tinyint(1) NOT NULL DEFAULT 0, # pro
  contact_blogpost tinyint(1) NOT NULL DEFAULT 0, # labs # pro # research # zoho
  contact_collection tinyint(1) NOT NULL DEFAULT 0, # research
  contact_event tinyint(1) NOT NULL DEFAULT 0, # labs # pro # research # zoho
  contact_job tinyint(1) NOT NULL DEFAULT 0, # pro # research # zoho
  contact_member tinyint(1) NOT NULL DEFAULT 0, # pro
  contact_network tinyint(1) NOT NULL DEFAULT 0, # pro
  contact_person tinyint(1) NOT NULL DEFAULT 0, # labs # pro # research # zoho
  contact_pressrelease tinyint(1) NOT NULL DEFAULT 0, # pro # research # zoho
  contact_publication tinyint(1) NOT NULL DEFAULT 0, # pro # research # zoho
  contact_staff tinyint(1) NOT NULL DEFAULT 0, # pro
  contact_tag tinyint(1) NOT NULL DEFAULT 0, # labs # pro # research # zoho
  contact_taskforce tinyint(1) NOT NULL DEFAULT 0, # pro # research # zoho
  contact_tech tinyint(1) NOT NULL DEFAULT 0, # pro
  country varchar(256) NOT NULL DEFAULT '', # zoho
  department longtext NULL, # pro # research # zoho
  description longtext NULL, # zoho
  email varchar(256) NOT NULL DEFAULT '', # him # labs # pro # research # zoho
  europeana_id varchar(256) NOT NULL DEFAULT '', # zoho
  europeana_tech longtext NULL, # zoho
  first_name varchar(256) NOT NULL DEFAULT '', # him # labs # pro # research # zoho
  hide_list tinyint(1) NOT NULL DEFAULT 0, # him
  image longtext NULL, # him # labs # pro # research # zoho
  introduction longtext NULL, # labs # pro # research # zoho # him
  job_title varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  last_name varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  latime varchar(256) NOT NULL DEFAULT '', # zoho
  linkedin varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  modified_name varchar(256) NOT NULL DEFAULT '', # zoho
  modified_uid varchar(256) NOT NULL DEFAULT '', # zoho
  network_participation longtext NULL, # zoho
  other_links_1 varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  other_links_2 varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  other_links_3 varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  other_number varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  phone varchar(256) DEFAULT '', # him
  public_email varchar(256) NOT NULL DEFAULT '', # zoho
  public_phone varchar(256) NOT NULL DEFAULT '', # zoho
  public_photo longtext NULL, # zoho
  secondary_email varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  sector varchar(256) NOT NULL DEFAULT '', # zoho
  skype varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  statutes_agree longtext NULL, # zoho
  statutes_read longtext NULL, # zoho
  structure_parent longtext, # labs # pro # research # zoho # him
  structure_sortorder int(11) NOT NULL DEFAULT 0, # him # labs # pro # research # zoho
  team longtext, # pro # research # zoho # him
  telephone_number varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  templatefields longtext NULL, # him # labs # pro # research # zoho
  twitter varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  uid varchar(256) NOT NULL DEFAULT '', # zoho
  PRIMARY KEY (id)
);

-- labs
INSERT INTO europeana_cope.bolt_persons ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, first_name, last_name, company, company_url, job_title, introduction, image, email, secondary_email, telephone_number, other_number, linkedin, twitter, skype, other_links_1, other_links_2, other_links_3, contact_blogpost, contact_event, contact_person, contact_tag, structure_sortorder, templatefields, structure_parent
) SELECT 'labs', p.id,
  p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.first_name, p.last_name, p.company, p.company_url, p.job_title, p.introduction, p.image, p.email, p.secondary_email, p.telephone_number, p.other_number, p.linkedin, p.twitter, p.skype, p.other_links_1, p.other_links_2, p.other_links_3, p.contact_blogpost, p.contact_event, p.contact_person, p.contact_tag, p.structure_sortorder, p.templatefields, p.structure_parent
FROM europeana_labs.bolt_persons p;

-- pro
INSERT INTO europeana_cope.bolt_persons ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, first_name, last_name, checkbox_europeana, checkbox_network, company, company_url, job_title, team, introduction, image, email, secondary_email, telephone_number, other_number, linkedin, twitter, skype, other_links_1, other_links_2, other_links_3, checkbox_chief, contact_blog, contact_event, contact_job, contact_staff, contact_publication, contact_aggregator, contact_tech, contact_network, contact_member, contact_blogpost, contact_pressrelease, department, contact_taskforce, contact_tag, contact_person, structure_sortorder, structure_parent, templatefields
) SELECT 'pro', p.id,
  p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.first_name, p.last_name, p.checkbox_europeana, p.checkbox_network, p.company, p.company_url, p.job_title, p.team, p.introduction, p.image, p.email, p.secondary_email, p.telephone_number, p.other_number, p.linkedin, p.twitter, p.skype, p.other_links_1, p.other_links_2, p.other_links_3, p.checkbox_chief, p.contact_blog, p.contact_event, p.contact_job, p.contact_staff, p.contact_publication, p.contact_aggregator, p.contact_tech, p.contact_network, p.contact_member, p.contact_blogpost, p.contact_pressrelease, p.department, p.contact_taskforce, p.contact_tag, p.contact_person, p.structure_sortorder, p.structure_parent, p.templatefields
FROM europeana_pro.bolt_persons p;

-- research
INSERT INTO europeana_cope.bolt_persons ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, first_name, last_name, company, company_url, job_title, department, team, introduction, image, email, secondary_email, telephone_number, other_number, linkedin, twitter, skype, other_links_1, other_links_2, other_links_3, contact_blogpost, contact_event, contact_job, contact_person, contact_publication, contact_pressrelease, contact_taskforce, contact_tag, contact_collection, templatefields, structure_parent, structure_sortorder
) SELECT 'research', p.id,
  p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.first_name, p.last_name, p.company, p.company_url, p.job_title, p.department, p.team, p.introduction, p.image, p.email, p.secondary_email, p.telephone_number, p.other_number, p.linkedin, p.twitter, p.skype, p.other_links_1, p.other_links_2, p.other_links_3, p.contact_blogpost, p.contact_event, p.contact_job, p.contact_person, p.contact_publication, p.contact_pressrelease, p.contact_taskforce, p.contact_tag, p.contact_collection, p.templatefields, p.structure_parent, p.structure_sortorder
FROM europeana_research.bolt_persons p;

-- zoho
INSERT INTO europeana_cope.bolt_persons ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, first_name, last_name, company, company_url, job_title, department, team, introduction, image, email, secondary_email, telephone_number, other_number, linkedin, twitter, skype, other_links_1, other_links_2, other_links_3, contact_blogpost, contact_event, contact_job, contact_person, contact_publication, contact_pressrelease, contact_taskforce, contact_tag, structure_sortorder, structure_parent, uid, network_participation, community, community_role, europeana_id, author_uid, author_name, modified_uid, modified_name, latime, account_uid, account_name, public_email, public_phone, statutes_read, statutes_agree, public_photo, europeana_tech, sector, country, description, templatefields, candidacy_teaser, candidacy_intro
) SELECT 'zoho', p.id,
  p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.first_name, p.last_name, p.company, p.company_url, p.job_title, p.department, p.team, p.introduction, p.image, p.email, p.secondary_email, p.telephone_number, p.other_number, p.linkedin, p.twitter, p.skype, p.other_links_1, p.other_links_2, p.other_links_3, p.contact_blogpost, p.contact_event, p.contact_job, p.contact_person, p.contact_publication, p.contact_pressrelease, p.contact_taskforce, p.contact_tag, p.structure_sortorder, p.structure_parent, p.uid, p.network_participation, p.community, p.community_role, p.europeana_id, p.author_uid, p.author_name, p.modified_uid, p.modified_name, p.latime, p.account_uid, p.account_name, p.public_email, p.public_phone, p.statutes_read, p.statutes_agree, p.public_photo, p.europeana_tech, p.sector, p.country, p.description, p.templatefields, p.candidacy_teaser, p.candidacy_intro
FROM europeana_pro.bolt_network p;

DROP TABLE IF EXISTS bolt_taskforces;
CREATE TABLE IF NOT EXISTS bolt_taskforces (
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
  title varchar(256) NOT NULL DEFAULT '', # pro
  department longtext NULL, # pro
  subtitle varchar(256) NOT NULL DEFAULT '', # pro
  date_start date DEFAULT NULL, # pro
  date_end date DEFAULT NULL, # pro
  teaser longtext NULL, # pro
  intro longtext NULL, # pro
  body longtext NULL, # pro
  teaser_image longtext NULL, # pro
  filelist_files longtext NULL, # pro
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # pro
  structure_sortorder int(11) NOT NULL DEFAULT 0, # pro
  structure_parent longtext NULL, # pro
  templatefields longtext NULL, # pro
  PRIMARY KEY (id)
);

INSERT INTO europeana_cope.bolt_taskforces ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, department, subtitle, date_start, date_end, teaser, intro, body, teaser_image, filelist_files, filelist_downloads, structure_sortorder, structure_parent, templatefields
) SELECT 'pro', t.id,
  t.slug, t.datecreated, t.datechanged, t.datepublish, t.datedepublish, t.username, t.ownerid, t.status, t.title, t.department, t.subtitle, t.date_start, t.date_end, t.teaser, t.intro, t.body, t.teaser_image, t.filelist_files, t.filelist_downloads, t.structure_sortorder, t.structure_parent, t.templatefields
FROM europeana_pro.bolt_taskforces t;

DROP TABLE IF EXISTS bolt_locations;
CREATE TABLE IF NOT EXISTS bolt_locations (
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
  europeana_office tinyint(1) NOT NULL DEFAULT 0, # labs # pro # research
  europeana_place tinyint(1) NOT NULL DEFAULT 0, # labs # pro # research
  geolocation longtext NULL, # labs # pro # research
  templatefields longtext NULL, # labs # pro # research
  title varchar(256) NOT NULL DEFAULT '', # labs # pro # research
  PRIMARY KEY (id)
);

-- labs
INSERT INTO europeana_cope.bolt_locations ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, geolocation, europeana_place, europeana_office, templatefields
) SELECT 'labs', l.id,
  l.slug, l.datecreated, l.datechanged, l.datepublish, l.datedepublish, l.username, l.ownerid, l.status, l.title, l.geolocation, l.europeana_place, l.europeana_office, l.templatefields
FROM europeana_labs.bolt_locations l;

-- pro
INSERT INTO europeana_cope.bolt_locations ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, geolocation, europeana_place, europeana_office, templatefields
) SELECT 'pro', l.id,
  l.slug, l.datecreated, l.datechanged, l.datepublish, l.datedepublish, l.username, l.ownerid, l.status, l.title, l.geolocation, l.europeana_place, l.europeana_office, l.templatefields
FROM europeana_pro.bolt_locations l;

-- research
INSERT INTO europeana_cope.bolt_locations ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, geolocation, europeana_place, europeana_office, templatefields
) SELECT 'research', l.id,
  l.slug, l.datecreated, l.datechanged, l.datepublish, l.datedepublish, l.username, l.ownerid, l.status, l.title, l.geolocation, l.europeana_place, l.europeana_office, l.templatefields
FROM europeana_research.bolt_locations l;

-- dynamic and timed content --

DROP TABLE IF EXISTS bolt_blogposts;
CREATE TABLE IF NOT EXISTS bolt_blogposts (
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
  attachments longtext NULL, # him # pro # research
  author longtext, # him
  body longtext NULL, # labs # pro # research # him
  files longtext NULL, # labs
  hero longtext NULL, # labs
  hide_list tinyint(1) NOT NULL DEFAULT 0, # him
  image longtext NULL, # him # labs # pro # research
  intro longtext NULL, # labs # him
  originalurl varchar(256) NOT NULL DEFAULT '', # pro
  parents longtext NULL, # pro
  structure_parent longtext NULL, # labs # pro # research # him
  structure_sortorder int(11) NOT NULL DEFAULT 0, # him # labs # pro # research
  teaser longtext NULL, # pro # him
  teaser_image longtext NULL, # him
  templatefields longtext NULL, # him # labs # pro # research
  title varchar(256) DEFAULT '', # him # labs # pro # research
  PRIMARY KEY (id)
);


-- labs
INSERT INTO europeana_cope.bolt_blogposts ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, body, image, files, structure_sortorder, templatefields, structure_parent, hero, intro
) SELECT 'labs', b.id,
  b.slug, b.datecreated, b.datechanged, b.datepublish, b.datedepublish, b.username, b.ownerid, b.status, b.title, b.body, b.image, b.files, b.structure_sortorder, b.templatefields, b.structure_parent, b.hero, b.intro
FROM europeana_labs.bolt_blog b;

-- pro
INSERT INTO europeana_cope.bolt_blogposts ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, teaser, body, attachments, parents, image, structure_sortorder, structure_parent, templatefields
) SELECT 'pro', b.id,
  b.slug, b.datecreated, b.datechanged, b.datepublish, b.datedepublish, b.username, b.ownerid, b.status, b.title, b.teaser, b.body, b.attachments, b.parents, b.image, b.structure_sortorder, b.structure_parent, b.templatefields
FROM europeana_pro.bolt_blogposts b;

-- research
INSERT INTO europeana_cope.bolt_blogposts ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, body, image, attachments, templatefields, structure_parent, structure_sortorder
) SELECT 'research', b.id,
  b.slug, b.datecreated, b.datechanged, b.datepublish, b.datedepublish, b.username, b.ownerid, b.status, b.title, b.body, b.image, b.attachments, b.templatefields, b.structure_parent, b.structure_sortorder
FROM europeana_research.bolt_blogposts b;

DROP TABLE IF EXISTS bolt_events;
CREATE TABLE IF NOT EXISTS bolt_events (
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
  body longtext NULL, # labs # pro # him
  end_event datetime DEFAULT NULL, # him # labs # pro
  external_link varchar(256) NOT NULL DEFAULT '', # labs
  file varchar(256) NOT NULL DEFAULT '', # pro
  filelist longtext NULL, # labs # pro
  hide_list tinyint(1) NOT NULL DEFAULT 0, # him
  image longtext NULL, # him
  intro longtext, # him
  secondary_mail tinyint(1) NOT NULL DEFAULT 0, # labs # pro
  start_event datetime DEFAULT NULL, # him # labs # pro
  structure_parent longtext NULL, # labs # pro # him
  structure_sortorder int(11) NOT NULL DEFAULT 0, # him # labs # pro
  support_navigation longtext NULL, # pro
  teaser longtext NULL, # labs # pro # him
  teaser_image longtext NULL, # him # labs # pro
  templatefields longtext NULL, # him # labs # pro
  title varchar(256) DEFAULT '', # him # labs # pro
  unconfirmed_end tinyint(1) NOT NULL DEFAULT 0, # him # labs # pro
  unconfirmed_start tinyint(1) NOT NULL DEFAULT 0, # him # labs # pro
  PRIMARY KEY (id)
);

-- labs
INSERT INTO europeana_cope.bolt_events ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, start_event, unconfirmed_start, end_event, unconfirmed_end, teaser, body, teaser_image, filelist, secondary_mail, structure_sortorder, external_link, templatefields, structure_parent
) SELECT 'labs', e.id,
  e.slug, e.datecreated, e.datechanged, e.datepublish, e.datedepublish, e.username, e.ownerid, e.status, e.title, e.start_event, e.unconfirmed_start, e.end_event, e.unconfirmed_end, e.teaser, e.body, e.teaser_image, e.filelist, e.secondary_mail, e.structure_sortorder, e.external_link, e.templatefields, e.structure_parent
FROM europeana_labs.bolt_events e;

-- pro
INSERT INTO europeana_cope.bolt_events ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, start_event, unconfirmed_start, end_event, unconfirmed_end, teaser, body, intro, teaser_image, secondary_mail, filelist, structure_sortorder, support_navigation, structure_parent, templatefields
) SELECT 'pro', e.id,
  e.slug, e.datecreated, e.datechanged, e.datepublish, e.datedepublish, e.username, e.ownerid, e.status, e.title, e.start_event, e.unconfirmed_start, e.end_event, e.unconfirmed_end, e.teaser, e.body, e.introduction, e.teaser_image, e.secondary_mail, e.filelist, e.structure_sortorder, e.support_navigation, e.structure_parent, e.templatefields
FROM europeana_pro.bolt_events e;

DROP TABLE IF EXISTS bolt_jobs;
CREATE TABLE IF NOT EXISTS bolt_jobs (
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
  position varchar(256) NOT NULL DEFAULT '', # pro
  department longtext NULL, # pro
  postion_type longtext NULL, # pro
  teaser longtext NULL, # pro
  title varchar(256) DEFAULT '', # new
  body longtext NULL, # pro
  salary_eur varchar(256) NOT NULL DEFAULT '', # pro
  scale_eur varchar(256) NOT NULL DEFAULT '', # pro
  salary_gbp varchar(256) NOT NULL DEFAULT '', # pro
  scale_gbp varchar(256) NOT NULL DEFAULT '', # pro
  deadline date DEFAULT NULL, # pro
  deadlinelabel varchar(256) NOT NULL DEFAULT '', # pro
  filelist longtext NULL, # pro
  structure_parent longtext NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT 0, # pro
  templatefields longtext NULL, # pro
  PRIMARY KEY (id)
);

INSERT INTO europeana_cope.bolt_jobs ( subsite, subsite_id, title, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, position, department, postion_type, teaser, body, salary_eur, scale_eur, deadline, filelist, structure_sortorder
) SELECT 'pro', j.id,
  j.position, j.slug, j.datecreated, j.datechanged, j.datepublish, j.datedepublish, j.username, j.ownerid, j.status, j.position, j.department, j.postion_type, j.teaser, j.body, j.salary_eur, j.scale_eur, j.deadline, j.filelist, j.structure_sortorder
FROM europeana_labs.bolt_jobs j;

DROP TABLE IF EXISTS bolt_pressreleases;
CREATE TABLE IF NOT EXISTS bolt_pressreleases (
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
  attachments longtext NULL, # him
  author varchar(256) DEFAULT '', # him
  body longtext NULL, # pro # him
  filelist longtext NULL, # pro
  hide_list tinyint(1) NOT NULL DEFAULT 0, # him
  image longtext NULL, # him # pro
  intro longtext, # him
  introduction longtext NULL, # pro
  isbn varchar(256) NOT NULL DEFAULT '', # pro
  parents longtext NULL, # pro
  structure_parent longtext NULL, # pro # him
  structure_sortorder int(11) NOT NULL DEFAULT 0, # him # pro
  subtitle longtext NULL, # pro
  teaser longtext, # him
  teaser_image longtext NULL, # him
  templatefields longtext NULL, # pro # him
  title varchar(256) DEFAULT '', # him # pro
  PRIMARY KEY (id)
);

-- pro
INSERT INTO europeana_cope.bolt_pressreleases ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, subtitle, body, isbn, filelist, image, parents, introduction, structure_sortorder, structure_parent, templatefields
) SELECT 'pro', p.id,
  p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.title, p.subtitle, p.body, p.isbn, p.filelist, p.image, p.parents, p.introduction, p.structure_sortorder, p.structure_parent, p.templatefields
FROM europeana_pro.bolt_pressreleases p;

-- static pages and structural components --

DROP TABLE IF EXISTS bolt_structures;
CREATE TABLE IF NOT EXISTS bolt_structures (
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
  body longtext NULL, # pro # him
  children longtext NULL, # pro
  contacts longtext NULL, # pro
  content longtext NULL, # labs # pro # research
  date_end date DEFAULT NULL, # labs # pro # research
  date_start date DEFAULT NULL, # labs # pro # research
  default_content longtext, # him
  footer longtext NULL, # labs # pro # research
  hide_list tinyint(1) NOT NULL DEFAULT 0, # him
  image longtext NULL, # him # labs # pro # research
  intro longtext, # him # pro
  parent longtext NULL, # pro
  position longtext NULL, # pro
  secondary_mail tinyint(1) NOT NULL DEFAULT 0, # labs # pro # research
  selectfield longtext NULL, # pro
  structure_parent longtext NULL, # labs # pro # research # him
  structure_sortorder int(11) NOT NULL DEFAULT 0, # him # labs # pro # research
  subclass longtext NULL, # labs # pro # research
  suffix longtext NULL, # pro # him
  teaser longtext NULL, # labs # pro # research# him
  teaser_image longtext NULL, # him
  template varchar(256) DEFAULT '', # him # labs # pro # research
  templatefields longtext NULL, # him # labs # pro # research
  title varchar(256) DEFAULT '', # him # labs # pro # research
  PRIMARY KEY (id)
);

-- labs
INSERT INTO europeana_cope.bolt_structures ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, secondary_mail, teaser, image, template, content, subclass, footer, date_start, date_end, structure_sortorder, templatefields, structure_parent
) SELECT 'labs', s.id,
  s.slug, s.datecreated, s.datechanged, s.datepublish, s.datedepublish, s.username, s.ownerid, s.status, s.title, s.secondary_mail, s.teaser, s.image, s.template, s.content, s.subclass, s.footer, s.date_start, s.date_end, s.structure_sortorder, s.templatefields, s.structure_parent
FROM europeana_labs.bolt_structures s;

-- pro
INSERT INTO europeana_cope.bolt_structures ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, selectfield, contacts, secondary_mail, intro, image, template, parent, teaser, position, children, subclass, content, footer, date_start, date_end, structure_sortorder, structure_parent, templatefields, body, suffix
) SELECT 'pro', s.id,
    s.slug, s.datecreated, s.datechanged, s.datepublish, s.datedepublish, s.username, s.ownerid, s.status, s.title, s.selectfield, s.contacts, s.secondary_mail, s.intro, s.image, s.template, s.parent, s.teaser, s.position, s.children, s.subclass, s.content, s.footer, null, null, s.structure_sortorder, s.structure_parent, s.templatefields, s.body, s.suffix
  FROM europeana_pro.bolt_structures s;

-- research
INSERT INTO europeana_cope.bolt_structures ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, secondary_mail, teaser, image, template, content, subclass, footer, date_start, date_end, templatefields, structure_parent, structure_sortorder
) SELECT 'research', s.id,
  s.slug, s.datecreated, s.datechanged, s.datepublish, s.datedepublish, s.username, s.ownerid, s.status, s.title, s.secondary_mail, s.teaser, s.image, s.template, s.content, s.subclass, s.footer, s.date_start, s.date_end, s.templatefields, s.structure_parent, s.structure_sortorder
FROM europeana_research.bolt_structures s;

DROP TABLE IF EXISTS bolt_pages;
CREATE TABLE IF NOT EXISTS bolt_pages (
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
  title varchar(256) NOT NULL DEFAULT '', # all
  body longtext NULL, # all
  intro longtext, # pro # labs # him #research
  teaser longtext, # pro # labs # him #research
  parent longtext NULL, # pro
  position longtext NULL, # pro
  contacts longtext NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT 0, # all
  structure_parent longtext NULL, # all
  secondary_mail tinyint(1) NOT NULL DEFAULT 0, # pro # labs # research
  teaser_image longtext NULL, # all
  show_page tinyint(1) NOT NULL DEFAULT 0, # pro
  support_navigation longtext NULL, # pro # labs # research
  filelist_files longtext NULL, # pro # research
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # pro # research
  hide_list tinyint(1) NOT NULL DEFAULT 0, # all
  parents longtext NULL, # pro
  listtitle varchar(256) NOT NULL DEFAULT '', # pro # research
  imagelist longtext NULL, # pro # research
  liststyle longtext NULL, # pro # research
  hide_related tinyint(1) NOT NULL DEFAULT 0, # pro # labs # research
  hide_related_section tinyint(1) NOT NULL DEFAULT 0, # pro # labs # research
  templatefields longtext NULL, # all
  files longtext NULL, # labs
  link1 varchar(256) NOT NULL DEFAULT '', # labs
  link2 varchar(256) NOT NULL DEFAULT '', # labs
  link3 varchar(256) NOT NULL DEFAULT '', # labs
  hero longtext NULL, # labs
  templateselect varchar(256) NOT NULL DEFAULT '', # labs
  template varchar(256) DEFAULT '', # him
  image longtext NULL, # him
  PRIMARY KEY (id)
);

-- labs
INSERT INTO europeana_cope.bolt_pages ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, intro, teaser, body, teaser_image, secondary_mail, hide_related, hide_related_section, support_navigation, structure_sortorder, files, link1, link2, link3, templatefields, structure_parent, hero, hide_list, templateselect
) SELECT 'labs', p.id,
  p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.title, p.intro, p.teaser, p.body, p.teaser_image, p.secondary_mail, p.hide_related, p.hide_related_section, p.support_navigation, p.structure_sortorder, p.files, p.link1, p.link2, p.link3, p.templatefields, p.structure_parent, p.hero, p.hide_list, p.templateselect
FROM europeana_labs.bolt_pages p;

-- pro
INSERT INTO europeana_cope.bolt_pages ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, parent, position, contacts, secondary_mail, teaser, body, teaser_image, show_page, support_navigation, filelist_files, filelist_downloads, intro, hide_list, parents, listtitle, imagelist, liststyle, hide_related, hide_related_section, structure_sortorder, structure_parent, templatefields
) SELECT 'pro', p.id,
    p.slug, p.datecreated, p.datechanged, p.datepublish, null, p.username, p.ownerid, p.status, p.title, p.parent, p.position, p.contacts, p.secondary_mail, p.teaser, p.body, p.teaser_image, p.show_page, p.support_navigation, p.filelist_files, p.filelist_downloads, p.intro, p.hide_list, p.parents, p.listtitle, p.imagelist, p.liststyle, p.hide_related, p.hide_related_section, p.structure_sortorder, p.structure_parent, p.templatefields
  FROM europeana_pro.bolt_pages p;


-- research
INSERT INTO europeana_cope.bolt_pages ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, intro, teaser, body, teaser_image, secondary_mail, hide_list, filelist_files, filelist_downloads, hide_related, hide_related_section, listtitle, imagelist, liststyle, support_navigation, templatefields, structure_parent, structure_sortorder
) SELECT 'research', p.id,
  p.slug, p.datecreated, p.datechanged, p.datepublish, p.datedepublish, p.username, p.ownerid, p.status, p.title, p.intro, p.teaser, p.body, p.teaser_image, p.secondary_mail, p.hide_list, p.filelist_files, p.filelist_downloads, p.hide_related, p.hide_related_section, p.listtitle, p.imagelist, p.liststyle, p.support_navigation, p.templatefields, p.structure_parent, p.structure_sortorder
FROM europeana_research.bolt_pages p;

DROP TABLE IF EXISTS bolt_homepage;
CREATE TABLE IF NOT EXISTS bolt_homepage (
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
  bannerimage longtext NULL, # labs # pro # research
  bannerlink varchar(256) NOT NULL DEFAULT '', # labs # pro # research
  bannerlink_select longtext NULL, # pro
  bannertext longtext NULL, # labs # pro # research
  brandcolour longtext NULL, # labs # pro # research
  brandlocation longtext NULL, # labs # pro # research
  brandopacity longtext NULL, # labs # pro # research
  callout_1 longtext NULL, # labs # pro # research
  callout_2 longtext NULL, # labs # pro # research
  callout_3 longtext NULL, # labs # pro # research
  callout_4 longtext NULL, # pro
  callout_5 longtext NULL, # pro
  callout_6 longtext NULL, # pro # research
  flag_colour_1 longtext NULL, # labs
  flag_colour_2 longtext NULL, # labs
  flag_colour_3 longtext NULL, # labs
  flag_label_1 varchar(256) NOT NULL DEFAULT '', # labs
  flag_label_2 varchar(256) NOT NULL DEFAULT '', # labs
  flag_label_3 varchar(256) NOT NULL DEFAULT '', # labs
  imageattribution varchar(256) NOT NULL DEFAULT '', # labs # pro # research
  imagelicense longtext NULL, # labs # pro # research
  latest_image_1 longtext NULL, # labs
  latest_image_2 longtext NULL, # labs
  latest_image_3 longtext NULL, # labs
  latest_teaser_1 longtext NULL, # labs
  latest_teaser_2 longtext NULL, # labs
  latest_teaser_3 longtext NULL, # labs
  latest_title_1 varchar(256) NOT NULL DEFAULT '', # labs
  latest_title_2 varchar(256) NOT NULL DEFAULT '', # labs
  latest_title_3 varchar(256) NOT NULL DEFAULT '', # labs
  latest_url_1 varchar(256) NOT NULL DEFAULT '', # labs
  latest_url_2 varchar(256) NOT NULL DEFAULT '', # labs
  latest_url_3 varchar(256) NOT NULL DEFAULT '', # labs
  subtitle longtext NULL, # labs # pro # research
  templatefields longtext NULL, # labs # pro # research
  title varchar(256) NOT NULL DEFAULT '', # labs # pro # research
  use_manual_1 tinyint(1) NOT NULL DEFAULT 0, # labs
  use_manual_2 tinyint(1) NOT NULL DEFAULT 0, # labs
  use_manual_3 tinyint(1) NOT NULL DEFAULT 0, # labs
  PRIMARY KEY (id)
);

-- labs
INSERT INTO europeana_cope.bolt_homepage ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, bannerimage, imageattribution, imagelicense, brandcolour, brandopacity, brandlocation, bannertext, bannerlink, subtitle, callout_1, callout_2, callout_3, use_manual_1, flag_colour_1, flag_label_1, latest_title_1, latest_teaser_1, latest_image_1, latest_url_1, use_manual_2, flag_colour_2, flag_label_2, latest_title_2, latest_teaser_2, latest_image_2, latest_url_2, use_manual_3, flag_colour_3, flag_label_3, latest_title_3, latest_teaser_3, latest_image_3, latest_url_3, templatefields
) SELECT 'labs', h.id,
  h.slug, h.datecreated, h.datechanged, h.datepublish, h.datedepublish, h.username, h.ownerid, h.status, h.title, h.bannerimage, h.imageattribution, h.imagelicense, h.brandcolour, h.brandopacity, h.brandlocation, h.bannertext, h.bannerlink, h.subtitle, h.callout_1, h.callout_2, h.callout_3, h.use_manual_1, h.flag_colour_1, h.flag_label_1, h.latest_title_1, h.latest_teaser_1, h.latest_image_1, h.latest_url_1, h.use_manual_2, h.flag_colour_2, h.flag_label_2, h.latest_title_2, h.latest_teaser_2, h.latest_image_2, h.latest_url_2, h.use_manual_3, h.flag_colour_3, h.flag_label_3, h.latest_title_3, h.latest_teaser_3, h.latest_image_3, h.latest_url_3, h.templatefields
FROM europeana_labs.bolt_homepage h;

-- pro
INSERT INTO europeana_cope.bolt_homepage ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, bannerimage, bannertext, bannerlink_select, bannerlink, subtitle, callout_1, callout_2, callout_3, callout_4, callout_5, callout_6, title, imageattribution, imagelicense, brandcolour, brandopacity, brandlocation, templatefields
) SELECT 'pro', h.id,
  h.slug, h.datecreated, h.datechanged, h.datepublish, h.datedepublish, h.username, h.ownerid, h.status, h.bannerimage, h.bannertext, h.bannerlink_select, h.bannerlink, h.subtitle, h.callout_1, h.callout_2, h.callout_3, h.callout_4, h.callout_5, h.callout_6, h.title, h.imageattribution, h.imagelicense, h.brandcolour, h.brandopacity, h.brandlocation, h.templatefields
FROM europeana_pro.bolt_homepage h;

-- research
INSERT INTO europeana_cope.bolt_homepage ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, bannerimage, imageattribution, imagelicense, brandcolour, brandopacity, brandlocation, bannertext, bannerlink, subtitle, callout_1, callout_2, callout_3, callout_6, templatefields
) SELECT 'research', h.id,
  h.slug, h.datecreated, h.datechanged, h.datepublish, h.datedepublish, h.username, h.ownerid, h.status, h.title, h.bannerimage, h.imageattribution, h.imagelicense, h.brandcolour, h.brandopacity, h.brandlocation, h.bannertext, h.bannerlink, h.subtitle, h.callout_1, h.callout_2, h.callout_3, h.callout_6, h.templatefields
FROM europeana_research.bolt_homepage h;

-- blocks and resources --

DROP TABLE IF EXISTS bolt_footers;
CREATE TABLE IF NOT EXISTS bolt_footers (
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
  image longtext NULL, # him # labs # pro # research
  linklist_left longtext NULL, # labs # pro # research # him
  linklist_other longtext NULL, # labs # pro # research # him
  linklist_right longtext NULL, # labs # pro # research # him
  mission longtext NULL, # labs # pro # research # him
  socialmedia longtext NULL, # labs # pro # research # him
  templatefields longtext NULL, # him # labs # pro # research
  title varchar(256) DEFAULT '', # him # labs # pro # research
  PRIMARY KEY (id)
);

-- labs
INSERT INTO europeana_cope.bolt_footers ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, image, socialmedia, linklist_left, linklist_right, mission, linklist_other, templatefields
) SELECT 'labs', f.id,
  f.slug, f.datecreated, f.datechanged, f.datepublish, f.datedepublish, f.username, f.ownerid, f.status, f.title, f.image, f.socialmedia, f.linklist_left, f.linklist_right, f.mission, f.linklist_other, f.templatefields
FROM europeana_labs.bolt_footers f;

-- pro
INSERT INTO europeana_cope.bolt_footers ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, image, socialmedia, linklist_left, linklist_right, mission, linklist_other, templatefields
) SELECT 'pro', f.id,
  f.slug, f.datecreated, f.datechanged, f.datepublish, f.datedepublish, f.username, f.ownerid, f.status, f.title, f.image, f.socialmedia, f.linklist_left, f.linklist_right, f.mission, f.linklist_other, f.templatefields
FROM europeana_pro.bolt_footers f;

-- research
INSERT INTO europeana_cope.bolt_footers ( subsite, subsite_id, slug, datecreated, datechanged, datepublish, datedepublish, username, ownerid, status, title, image, socialmedia, linklist_left, linklist_right, mission, linklist_other, templatefields
) SELECT 'research', f.id,
  f.slug, f.datecreated, f.datechanged, f.datepublish, f.datedepublish, f.username, f.ownerid, f.status, f.title, f.image, f.socialmedia, f.linklist_left, f.linklist_right, f.mission, f.linklist_other, f.templatefields
FROM europeana_research.bolt_footers f;

DROP TABLE IF EXISTS bolt_resources;
CREATE TABLE IF NOT EXISTS bolt_resources (
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
  body longtext, # him
  cssclass varchar(256) DEFAULT '', # him
  cssid varchar(256) DEFAULT '', # him
  htmllink varchar(256) DEFAULT '', # him
  image longtext NULL, # him
  templatefields longtext NULL, # him
  title varchar(256) DEFAULT '', # him
  weight int(11) NOT NULL DEFAULT 0, # him
  PRIMARY KEY (id)
);

-- metadata, relations and users --

DROP TABLE IF EXISTS bolt_users;
CREATE TABLE bolt_users (
  id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(32) NOT NULL DEFAULT '',
  password varchar(128) NOT NULL DEFAULT '',
  email varchar(254) NOT NULL DEFAULT '',
  lastseen datetime DEFAULT NULL,
  lastip varchar(45) NOT NULL DEFAULT '',
  displayname varchar(32) NOT NULL DEFAULT '',
  stack longtext NULL,
  enabled tinyint(1) NOT NULL DEFAULT '1',
  shadowpassword varchar(128) DEFAULT NULL,
  shadowtoken varchar(128) DEFAULT NULL,
  shadowvalidity datetime DEFAULT NULL,
  failedlogins int(11) NOT NULL DEFAULT 0,
  throttleduntil datetime DEFAULT NULL,
  roles longtext NULL,
  subsite varchar(32) NOT NULL DEFAULT 'unknown', # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL DEFAULT 0, # all [ intermediary ID used for importing - remove after import ]
  PRIMARY KEY (`id`)
);

-- labs
INSERT INTO europeana_cope.bolt_users ( subsite, subsite_id, username, password, email, lastseen, lastip, displayname, stack, enabled, shadowpassword, shadowtoken, shadowvalidity, failedlogins, throttleduntil, roles
) SELECT 'labs', u.id,
  u.username, u.password, u.email, u.lastseen, u.lastip, u.displayname, u.stack, u.enabled, u.shadowpassword, u.shadowtoken, u.shadowvalidity, u.failedlogins, u.throttleduntil, u.roles
FROM europeana_labs.bolt_users u;

-- pro
INSERT INTO europeana_cope.bolt_users ( subsite, subsite_id, username, password, email, lastseen, lastip, displayname, stack, enabled, shadowpassword, shadowtoken, shadowvalidity, failedlogins, throttleduntil, roles
) SELECT 'pro', u.id,
  u.username, u.password, u.email, u.lastseen, u.lastip, u.displayname, u.stack, u.enabled, u.shadowpassword, u.shadowtoken, u.shadowvalidity, u.failedlogins, u.throttleduntil, u.roles
FROM europeana_pro.bolt_users u;

-- research
INSERT INTO europeana_cope.bolt_users ( subsite, subsite_id, username, password, email, lastseen, lastip, displayname, stack, enabled, shadowpassword, shadowtoken, shadowvalidity, failedlogins, throttleduntil, roles
) SELECT 'research', u.id,
  u.username, u.password, u.email, u.lastseen, u.lastip, u.displayname, u.stack, u.enabled, u.shadowpassword, u.shadowtoken, u.shadowvalidity, u.failedlogins, u.throttleduntil, u.roles
FROM europeana_research.bolt_users u;


DROP TABLE IF EXISTS bolt_taxonomy;
CREATE TABLE bolt_taxonomy (
  id int(11) NOT NULL AUTO_INCREMENT,
  content_id int(11) NOT NULL DEFAULT 0,
  contenttype varchar(32) NOT NULL DEFAULT '',
  taxonomytype varchar(32) NOT NULL DEFAULT '',
  slug varchar(64) NOT NULL DEFAULT '',
  name varchar(64) NOT NULL DEFAULT '',
  sortorder int(11) NOT NULL DEFAULT 0,
  subsite varchar(32) NOT NULL DEFAULT 'unknown', # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL DEFAULT 0, # all [ intermediary ID used for importing - remove after import ]
  PRIMARY KEY (`id`)
);

-- labs
INSERT INTO europeana_cope.bolt_taxonomy ( subsite, subsite_id, content_id, contenttype, taxonomytype, slug, name, sortorder
) SELECT 'labs', t.id,
  t.content_id, t.contenttype, t.taxonomytype, t.slug, t.name, t.sortorder
FROM europeana_labs.bolt_taxonomy t;

-- pro
INSERT INTO europeana_cope.bolt_taxonomy ( subsite, subsite_id, content_id, contenttype, taxonomytype, slug, name, sortorder
) SELECT 'pro', t.id,
  t.content_id, t.contenttype, t.taxonomytype, t.slug, t.name, t.sortorder
FROM europeana_pro.bolt_taxonomy t;

-- research
INSERT INTO europeana_cope.bolt_taxonomy ( subsite, subsite_id, content_id, contenttype, taxonomytype, slug, name, sortorder
) SELECT 'research', t.id,
  t.content_id, t.contenttype, t.taxonomytype, t.slug, t.name, t.sortorder
FROM europeana_research.bolt_taxonomy t;


DROP TABLE IF EXISTS bolt_relations;
CREATE TABLE bolt_relations (
  id int(11) NOT NULL AUTO_INCREMENT,
  from_contenttype varchar(32) NOT NULL DEFAULT '',
  from_id int(11) NOT NULL DEFAULT 0,
  to_contenttype varchar(32) NOT NULL DEFAULT '',
  to_id int(11) NOT NULL DEFAULT 0,
  subsite varchar(32) NOT NULL DEFAULT 'unknown', # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL DEFAULT 0, # all [ intermediary ID used for importing - remove after import ]
  PRIMARY KEY (`id`)
);

-- labs
INSERT INTO europeana_cope.bolt_relations ( subsite, subsite_id, from_contenttype, from_id, to_contenttype, to_id
) SELECT 'labs', r.id,
  r.from_contenttype, r.from_id, r.to_contenttype, r.to_id
FROM europeana_labs.bolt_relations r;

-- pro
INSERT INTO europeana_cope.bolt_relations ( subsite, subsite_id, from_contenttype, from_id, to_contenttype, to_id
) SELECT 'pro', r.id,
  r.from_contenttype, r.from_id, r.to_contenttype, r.to_id
FROM europeana_pro.bolt_relations r;

-- research
INSERT INTO europeana_cope.bolt_relations ( subsite, subsite_id, from_contenttype, from_id, to_contenttype, to_id
) SELECT 'research', r.id,
  r.from_contenttype, r.from_id, r.to_contenttype, r.to_id
FROM europeana_research.bolt_relations r;

-- add queries from migrate-prepare below
