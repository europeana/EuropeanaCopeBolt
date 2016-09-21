CREATE DATABASE IF NOT EXISTS test_europeana_cope DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE test_europeana_cope;

-- core business collections and data --

# DROP TABLE bolt_projects;
CREATE TABLE IF NOT EXISTS bolt_projects (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  body longtext NOT NULL, # pro
  date_end date DEFAULT NULL, # pro
  date_start date DEFAULT NULL, # pro
  filelist longtext NOT NULL, # pro
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # pro
  intro longtext NOT NULL, # pro
  logo longtext NOT NULL, # pro
  structure_parent longtext NOT NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  subtitle varchar(256) NOT NULL DEFAULT '', # pro
  teaser longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  url varchar(256) NOT NULL DEFAULT '', # pro
  PRIMARY KEY (id)
);

# DROP TABLE bolt_collections;
CREATE TABLE IF NOT EXISTS bolt_collections (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  body longtext NOT NULL, # research
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # research
  filelist_files longtext NOT NULL, # research
  hide_list tinyint(1) NOT NULL DEFAULT '0', # research
  hide_related tinyint(1) NOT NULL DEFAULT '0', # research
  hide_related_section tinyint(1) NOT NULL DEFAULT '0', # research
  imagelist longtext NOT NULL, # research
  intro longtext NOT NULL, # research
  liststyle longtext NOT NULL, # research
  listtitle varchar(256) NOT NULL DEFAULT '', # research
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # research
  source varchar(256) NOT NULL DEFAULT '', # research
  source_url varchar(256) NOT NULL DEFAULT '', # research
  structure_parent longtext NOT NULL, # research
  structure_sortorder int(11) NOT NULL DEFAULT '0', # research
  support_navigation longtext NOT NULL, # research
  teaser longtext NOT NULL, # research
  teaser_image longtext NOT NULL, # research
  templatefields longtext NOT NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  PRIMARY KEY (id)
);

# DROP TABLE bolt_apps;
CREATE TABLE IF NOT EXISTS bolt_apps (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
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

# DROP TABLE bolt_data;
CREATE TABLE IF NOT EXISTS bolt_data (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  apiconsolelink varchar(256) NOT NULL DEFAULT '', # labs # research
  body longtext NOT NULL, # labs # research
  contact_email varchar(256) NOT NULL DEFAULT '', # labs # research
  contact_name varchar(256) NOT NULL DEFAULT '', # labs # research
  country varchar(256) NOT NULL DEFAULT '', # research
  image longtext NOT NULL, # labs # research
  intro longtext NOT NULL, # labs # research
  # itemtype varchar(256) NOT NULL DEFAULT '', # research
  # language_coverage varchar(256) NOT NULL DEFAULT '', # research
  portallink varchar(256) NOT NULL DEFAULT '', # labs # research
  provided_by varchar(256) NOT NULL DEFAULT '', # labs # research
  provided_by_link varchar(256) NOT NULL DEFAULT '', # labs # research
  # spatial_coverage varchar(256) NOT NULL DEFAULT '', # research
  # subjects varchar(256) NOT NULL DEFAULT '', # research
  teaser longtext NOT NULL, # labs # research
  # templatefields longtext NOT NULL, # labs
  # time_coverage varchar(256) NOT NULL DEFAULT '', # research
  title varchar(256) NOT NULL DEFAULT '', # labs # research
  PRIMARY KEY (id)
);

# DROP TABLE bolt_documentation;
CREATE TABLE IF NOT EXISTS bolt_documentation (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  title varchar(256) NOT NULL DEFAULT '', # labs
  intro longtext NOT NULL, # labs
  teaser longtext NOT NULL, # labs
  body longtext NOT NULL, # labs
  teaser_image longtext NOT NULL, # labs
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # labs
  hide_related tinyint(1) NOT NULL DEFAULT '0', # labs
  hide_related_section tinyint(1) NOT NULL DEFAULT '0', # labs
  files longtext NOT NULL, # labs
  link1 varchar(256) NOT NULL DEFAULT '', # labs
  link2 varchar(256) NOT NULL DEFAULT '', # labs
  link3 varchar(256) NOT NULL DEFAULT '', # labs
  support_navigation longtext NOT NULL, # labs
  structure_sortorder int(11) NOT NULL DEFAULT '0', # labs
  PRIMARY KEY (id)
);

# DROP TABLE bolt_publications;
CREATE TABLE IF NOT EXISTS bolt_publications (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  title varchar(256) NOT NULL DEFAULT '', # pro
  subtitle longtext NOT NULL, # pro
  body longtext NOT NULL, # pro
  isbn varchar(256) NOT NULL DEFAULT '', # pro
  filelist longtext NOT NULL, # pro
  image longtext NOT NULL, # pro
  parents longtext NOT NULL, # pro
  teaser longtext NOT NULL, # pro
  introduction varchar(256) NOT NULL DEFAULT '', # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  structure_parent longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

-- people and places --

# DROP TABLE bolt_persons;
CREATE TABLE IF NOT EXISTS bolt_persons (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'zoho', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  account_name varchar(256) NOT NULL DEFAULT '', # zoho
  account_uid varchar(256) NOT NULL DEFAULT '', # zoho
  author_name varchar(256) NOT NULL DEFAULT '', # zoho
  author_uid varchar(256) NOT NULL DEFAULT '', # zoho
  candidacy_intro longtext NOT NULL, # zoho
  candidacy_teaser longtext NOT NULL, # zoho
  checkbox_chief tinyint(1) NOT NULL DEFAULT '0', # pro
  checkbox_europeana tinyint(1) NOT NULL DEFAULT '0', # pro
  checkbox_network tinyint(1) NOT NULL DEFAULT '0', # pro
  community longtext NOT NULL, # zoho
  community_role varchar(256) NOT NULL DEFAULT '', # zoho
  company varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  company_url varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  contact_aggregator tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_blog tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_blogpost tinyint(1) NOT NULL DEFAULT '0', # labs # pro # research # zoho
  contact_collection tinyint(1) NOT NULL DEFAULT '0', # research
  contact_event tinyint(1) NOT NULL DEFAULT '0', # labs # pro # research # zoho
  contact_job tinyint(1) NOT NULL DEFAULT '0', # pro # research # zoho
  contact_member tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_network tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_person tinyint(1) NOT NULL DEFAULT '0', # labs # pro # research # zoho
  contact_pressrelease tinyint(1) NOT NULL DEFAULT '0', # pro # research # zoho
  contact_publication tinyint(1) NOT NULL DEFAULT '0', # pro # research # zoho
  contact_staff tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_tag tinyint(1) NOT NULL DEFAULT '0', # labs # pro # research # zoho
  contact_taskforce tinyint(1) NOT NULL DEFAULT '0', # pro # research # zoho
  contact_tech tinyint(1) NOT NULL DEFAULT '0', # pro
  country varchar(256) NOT NULL DEFAULT '', # zoho
  department longtext NOT NULL, # pro # research # zoho
  description longtext NOT NULL, # zoho
  email varchar(256) NOT NULL DEFAULT '', # him # labs # pro # research # zoho
  europeana_id varchar(256) NOT NULL DEFAULT '', # zoho
  europeana_tech longtext NOT NULL, # zoho
  first_name varchar(256) NOT NULL DEFAULT '', # him # labs # pro # research # zoho
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  image longtext NOT NULL, # him # labs # pro # research # zoho
  introduction longtext NOT NULL, # labs # pro # research # zoho # him
  job_title varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  last_name varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  latime varchar(256) NOT NULL DEFAULT '', # zoho
  linkedin varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  modified_name varchar(256) NOT NULL DEFAULT '', # zoho
  modified_uid varchar(256) NOT NULL DEFAULT '', # zoho
  network_participation longtext NOT NULL, # zoho
  other_links_1 varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  other_links_2 varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  other_links_3 varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  other_number varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  phone varchar(256) DEFAULT '', # him
  public_email varchar(256) NOT NULL DEFAULT '', # zoho
  public_phone varchar(256) NOT NULL DEFAULT '', # zoho
  public_photo longtext NOT NULL, # zoho
  secondary_email varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  sector varchar(256) NOT NULL DEFAULT '', # zoho
  skype varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  statutes_agree longtext NOT NULL, # zoho
  statutes_read longtext NOT NULL, # zoho
  structure_parent longtext, # labs # pro # research # zoho # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him # labs # pro # research # zoho
  team longtext, # pro # research # zoho # him
  telephone_number varchar(256) NOT NULL DEFAULT '', # labs # pro # research # zoho
  templatefields longtext NOT NULL, # him # labs # pro # research # zoho
  twitter varchar(256) DEFAULT '', # him # labs # pro # research # zoho
  uid varchar(256) NOT NULL DEFAULT '', # zoho
  PRIMARY KEY (id)
);

# DROP TABLE bolt_taskforces;
CREATE TABLE IF NOT EXISTS bolt_taskforces (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  title varchar(256) NOT NULL DEFAULT '', # pro
  department longtext NOT NULL, # pro
  subtitle varchar(256) NOT NULL DEFAULT '', # pro
  date_start date DEFAULT NULL, # pro
  date_end date DEFAULT NULL, # pro
  teaser longtext NOT NULL, # pro
  intro longtext NOT NULL, # pro
  body longtext NOT NULL, # pro
  teaser_image longtext NOT NULL, # pro
  filelist_files longtext NOT NULL, # pro
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  structure_parent longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

# DROP TABLE bolt_locations;
CREATE TABLE IF NOT EXISTS bolt_locations (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  europeana_office tinyint(1) NOT NULL DEFAULT '0', # labs # pro # research
  europeana_place tinyint(1) NOT NULL DEFAULT '0', # labs # pro # research
  geolocation longtext NOT NULL, # labs # pro # research
  templatefields longtext NOT NULL, # labs # pro # research
  title varchar(256) NOT NULL DEFAULT '', # labs # pro # research
  PRIMARY KEY (id)
);

-- dynamic and timed content --

# DROP TABLE bolt_blogposts;
CREATE TABLE IF NOT EXISTS bolt_blogposts (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  attachments longtext NOT NULL, # him # pro # research
  author longtext, # him
  body longtext NOT NULL, # labs # pro # research # him
  files longtext NOT NULL, # labs
  hero longtext NOT NULL, # labs
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  image longtext NOT NULL, # him # labs # pro # research
  intro longtext NOT NULL, # labs # him
  originalurl varchar(256) NOT NULL DEFAULT '', # pro
  parents longtext NOT NULL, # pro
  structure_parent longtext NOT NULL, # labs # pro # research # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him # labs # pro # research
  teaser longtext NOT NULL, # pro # him
  teaser_image longtext NOT NULL, # him
  templatefields longtext NOT NULL, # him # labs # pro # research
  title varchar(256) DEFAULT '', # him # labs # pro # research
  PRIMARY KEY (id)
);

# DROP TABLE bolt_events;
CREATE TABLE IF NOT EXISTS bolt_events (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  body longtext NOT NULL, # labs # pro # him
  end_event datetime DEFAULT NULL, # him # labs # pro
  external_link varchar(256) NOT NULL DEFAULT '', # labs
  file varchar(256) NOT NULL DEFAULT '', # pro
  filelist longtext NOT NULL, # labs # pro
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  image longtext NOT NULL, # him
  intro longtext, # him
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # labs # pro
  start_event datetime DEFAULT NULL, # him # labs # pro
  structure_parent longtext NOT NULL, # labs # pro # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him # labs # pro
  support_navigation longtext NOT NULL, # pro
  teaser longtext NOT NULL, # labs # pro # him
  teaser_image longtext NOT NULL, # him # labs # pro
  templatefields longtext NOT NULL, # him # labs # pro
  title varchar(256) DEFAULT '', # him # labs # pro
  unconfirmed_end tinyint(1) NOT NULL DEFAULT '0', # him # labs # pro
  unconfirmed_start tinyint(1) NOT NULL DEFAULT '0', # him # labs # pro
  PRIMARY KEY (id)
);

# DROP TABLE bolt_jobs;
CREATE TABLE IF NOT EXISTS bolt_jobs (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  position varchar(256) NOT NULL DEFAULT '', # pro
  department longtext NOT NULL, # pro
  postion_type longtext NOT NULL, # pro
  teaser longtext NOT NULL, # pro
  body longtext NOT NULL, # pro
  salary_eur varchar(256) NOT NULL DEFAULT '', # pro
  scale_eur varchar(256) NOT NULL DEFAULT '', # pro
  salary_gbp varchar(256) NOT NULL DEFAULT '', # pro
  scale_gbp varchar(256) NOT NULL DEFAULT '', # pro
  deadline date DEFAULT NULL, # pro
  deadlinelabel varchar(256) NOT NULL DEFAULT '', # pro
  filelist longtext NOT NULL, # pro
  structure_parent longtext NOT NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

# DROP TABLE bolt_pressreleases;
CREATE TABLE IF NOT EXISTS bolt_pressreleases (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  attachments longtext NOT NULL, # him
  author varchar(256) DEFAULT '', # him
  body longtext NOT NULL, # pro # him
  filelist longtext NOT NULL, # pro
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  image longtext NOT NULL, # him # pro
  intro longtext, # him
  introduction longtext NOT NULL, # pro
  isbn varchar(256) NOT NULL DEFAULT '', # pro
  parents longtext NOT NULL, # pro
  structure_parent longtext NOT NULL, # pro # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him # pro
  subtitle longtext NOT NULL, # pro
  teaser longtext, # him
  teaser_image longtext NOT NULL, # him
  templatefields longtext NOT NULL, # pro # him
  title varchar(256) DEFAULT '', # him # pro
  PRIMARY KEY (id)
);

-- static pages and structural components --

# DROP TABLE bolt_structures;
CREATE TABLE IF NOT EXISTS bolt_structures (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  body longtext NOT NULL, # pro # him
  children longtext NOT NULL, # pro
  contacts longtext NOT NULL, # pro
  content longtext NOT NULL, # labs # pro # research
  date_end date DEFAULT NULL, # labs # pro # research
  date_start date DEFAULT NULL, # labs # pro # research
  default_content longtext, # him
  footer longtext NOT NULL, # labs # pro # research
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  image longtext NOT NULL, # him # labs # pro # research
  intro longtext, # him # pro
  parent longtext NOT NULL, # pro
  position longtext NOT NULL, # pro
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # labs # pro # research
  selectfield longtext NOT NULL, # pro
  structure_parent longtext NOT NULL, # labs # pro # research # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him # labs # pro # research
  subclass longtext NOT NULL, # labs # pro # research
  suffix longtext NOT NULL, # pro # him
  teaser longtext NOT NULL, # labs # pro # research# him
  teaser_image longtext NOT NULL, # him
  template varchar(256) DEFAULT '', # him # labs # pro # research
  templatefields longtext NOT NULL, # him # labs # pro # research
  title varchar(256) DEFAULT '', # him # labs # pro # research
  PRIMARY KEY (id)
);

# DROP TABLE bolt_pages;
CREATE TABLE IF NOT EXISTS bolt_pages (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  title varchar(256) NOT NULL DEFAULT '', # all
  body longtext NOT NULL, # all
  intro longtext, # pro # labs # him #research
  teaser longtext, # pro # labs # him #research
  parent longtext NOT NULL, # pro
  position longtext NOT NULL, # pro
  contacts longtext NOT NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # all
  structure_parent longtext NOT NULL, # all
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # pro # labs # research
  teaser_image longtext NOT NULL, # all
  show_page tinyint(1) NOT NULL DEFAULT '0', # pro
  support_navigation longtext NOT NULL, # pro # labs # research
  filelist_files longtext NOT NULL, # pro # research
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # pro # research
  hide_list tinyint(1) NOT NULL DEFAULT '0', # all
  parents longtext NOT NULL, # pro
  listtitle varchar(256) NOT NULL DEFAULT '', # pro # research
  imagelist longtext NOT NULL, # pro # research
  liststyle longtext NOT NULL, # pro # research
  hide_related tinyint(1) NOT NULL DEFAULT '0', # pro # labs # research
  hide_related_section tinyint(1) NOT NULL DEFAULT '0', # pro # labs # research
  templatefields longtext NOT NULL, # all
  files longtext NOT NULL, # labs
  link1 varchar(256) NOT NULL DEFAULT '', # labs
  link2 varchar(256) NOT NULL DEFAULT '', # labs
  link3 varchar(256) NOT NULL DEFAULT '', # labs
  hero longtext NOT NULL, # labs
  templateselect varchar(256) NOT NULL DEFAULT '', # labs
  template varchar(256) DEFAULT '', # him
  image longtext NOT NULL, # him
  PRIMARY KEY (id)
);

# DROP TABLE bolt_homepage;
CREATE TABLE IF NOT EXISTS bolt_homepage (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  bannerimage longtext NOT NULL, # labs # pro # research
  bannerlink varchar(256) NOT NULL DEFAULT '', # labs # pro # research
  bannerlink_select longtext NOT NULL, # pro
  bannertext longtext NOT NULL, # labs # pro # research
  brandcolour longtext NOT NULL, # labs # pro # research
  brandlocation longtext NOT NULL, # labs # pro # research
  brandopacity longtext NOT NULL, # labs # pro # research
  callout_1 longtext NOT NULL, # labs # pro # research
  callout_2 longtext NOT NULL, # labs # pro # research
  callout_3 longtext NOT NULL, # labs # pro # research
  callout_4 longtext NOT NULL, # pro
  callout_5 longtext NOT NULL, # pro
  callout_6 longtext NOT NULL, # pro # research
  flag_colour_1 longtext NOT NULL, # labs
  flag_colour_2 longtext NOT NULL, # labs
  flag_colour_3 longtext NOT NULL, # labs
  flag_label_1 varchar(256) NOT NULL DEFAULT '', # labs
  flag_label_2 varchar(256) NOT NULL DEFAULT '', # labs
  flag_label_3 varchar(256) NOT NULL DEFAULT '', # labs
  imageattribution varchar(256) NOT NULL DEFAULT '', # labs # pro # research
  imagelicense longtext NOT NULL, # labs # pro # research
  latest_image_1 longtext NOT NULL, # labs
  latest_image_2 longtext NOT NULL, # labs
  latest_image_3 longtext NOT NULL, # labs
  latest_teaser_1 longtext NOT NULL, # labs
  latest_teaser_2 longtext NOT NULL, # labs
  latest_teaser_3 longtext NOT NULL, # labs
  latest_title_1 varchar(256) NOT NULL DEFAULT '', # labs
  latest_title_2 varchar(256) NOT NULL DEFAULT '', # labs
  latest_title_3 varchar(256) NOT NULL DEFAULT '', # labs
  latest_url_1 varchar(256) NOT NULL DEFAULT '', # labs
  latest_url_2 varchar(256) NOT NULL DEFAULT '', # labs
  latest_url_3 varchar(256) NOT NULL DEFAULT '', # labs
  subtitle longtext NOT NULL, # labs # pro # research
  templatefields longtext NOT NULL, # labs # pro # research
  title varchar(256) NOT NULL DEFAULT '', # labs # pro # research
  use_manual_1 tinyint(1) NOT NULL DEFAULT '0', # labs
  use_manual_2 tinyint(1) NOT NULL DEFAULT '0', # labs
  use_manual_3 tinyint(1) NOT NULL DEFAULT '0', # labs
  PRIMARY KEY (id)
);

-- blocks and resources --

# DROP TABLE bolt_footers;
CREATE TABLE IF NOT EXISTS bolt_footers (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  image longtext NOT NULL, # him # labs # pro # research
  linklist_left longtext NOT NULL, # labs # pro # research # him
  linklist_other longtext NOT NULL, # labs # pro # research # him
  linklist_right longtext NOT NULL, # labs # pro # research # him
  mission longtext NOT NULL, # labs # pro # research # him
  socialmedia longtext NOT NULL, # labs # pro # research # him
  templatefields longtext NOT NULL, # him # labs # pro # research
  title varchar(256) DEFAULT '', # him # labs # pro # research
  PRIMARY KEY (id)
);

# DROP TABLE bolt_resources;
CREATE TABLE IF NOT EXISTS bolt_resources (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  body longtext, # him
  cssclass varchar(256) DEFAULT '', # him
  cssid varchar(256) DEFAULT '', # him
  htmllink varchar(256) DEFAULT '', # him
  image longtext NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  weight int(11) NOT NULL DEFAULT '0', # him
  PRIMARY KEY (id)
);

-- heritage in motion specific --

# DROP TABLE bolt_himcomments;
CREATE TABLE IF NOT EXISTS bolt_himcomments (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  comment longtext, # him
  entryid varchar(256) DEFAULT '', # him
  judgeid varchar(256) DEFAULT '', # him
  judgename varchar(256) DEFAULT '', # him
  templatefields longtext NOT NULL, # him
  PRIMARY KEY (id)
);

# DROP TABLE bolt_himeditions;
CREATE TABLE IF NOT EXISTS bolt_himeditions (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  body longtext, # him
  edition_menu tinyint(1) NOT NULL DEFAULT '0', # him
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  image longtext NOT NULL, # him
  intro longtext, # him
  structure_parent longtext, # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him
  submission_closed tinyint(1) NOT NULL DEFAULT '0', # him
  submission_cost varchar(256) DEFAULT '', # him
  submission_deadline datetime DEFAULT NULL, # him
  submission_start datetime DEFAULT NULL, # him
  teaser longtext, # him
  teaser_image longtext NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  PRIMARY KEY (id)
);

# DROP TABLE bolt_himentries;
CREATE TABLE IF NOT EXISTS bolt_himentries (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  body longtext NOT NULL, # him
  clienttags varchar(256) DEFAULT '', # him
  credits longtext, # him
  description longtext, # him
  email varchar(256) DEFAULT '', # him
  image longtext, # him
  licence longtext, # him
  name varchar(256) DEFAULT '', # him
  projecturl varchar(256) DEFAULT '', # him
  summary longtext, # him
  teaser longtext NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  transaction_id varchar(256) DEFAULT '', # him
  upload_1 longtext, # him
  upload_2 longtext, # him
  upload_3 longtext, # him
  upload_4 longtext, # him
  upload_5 longtext, # him
  upload_6 longtext, # him
  upload_7 longtext, # him
  upload_8 longtext, # him
  upload_images longtext NOT NULL, # him
  upload_thumb longtext, # him
  userid varchar(256) DEFAULT '', # him
  video longtext, # him
  videodownloadlocation varchar(256) DEFAULT '', # him
  videodownloadstatus varchar(256) DEFAULT '', # him
  videolink varchar(256) DEFAULT '', # him
  PRIMARY KEY (id)
);

# DROP TABLE bolt_himvotes;
CREATE TABLE IF NOT EXISTS bolt_himvotes (
  id int(11) NOT NULL AUTO_INCREMENT, # all
  slug varchar(128) NOT NULL, # all
  datecreated datetime NOT NULL, # all
  datechanged datetime NOT NULL, # all
  datepublish datetime DEFAULT NULL, # all
  datedepublish datetime DEFAULT NULL, # all
  username varchar(32) DEFAULT '', # all
  ownerid int(11) DEFAULT NULL, # all
  status varchar(32) NOT NULL, # all
  subsite varchar(32) NOT NULL, # all [ content is either 'pro', 'labs', 'research' or 'him' ]
  subsite_id int(11) NOT NULL, # all [ intermediary ID used for importing - remove after import ]
  entryid varchar(256) DEFAULT '', # him
  judgeid varchar(256) DEFAULT '', # him
  judgename varchar(256) DEFAULT '', # him
  templatefields longtext NOT NULL, # him
  vote double NOT NULL DEFAULT '0', # him
  PRIMARY KEY (id)
);
