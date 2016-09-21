CREATE DATABASE IF NOT EXISTS test_europeana_research DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE test_europeana_research;

DROP TABLE bolt_blogposts;
CREATE TABLE IF NOT EXISTS bolt_blogposts (
  id int(11) NOT NULL AUTO_INCREMENT, # research
  slug varchar(128) NOT NULL, # research
  datecreated datetime NOT NULL, # research
  datechanged datetime NOT NULL, # research
  datepublish datetime DEFAULT NULL, # research
  datedepublish datetime DEFAULT NULL, # research
  username varchar(32) DEFAULT '', # research
  ownerid int(11) DEFAULT NULL, # research
  status varchar(32) NOT NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  body longtext NOT NULL, # research
  image longtext NOT NULL, # research
  attachments longtext NOT NULL, # research
  templatefields longtext NOT NULL, # research
  structure_parent longtext NOT NULL, # research
  structure_sortorder int(11) NOT NULL DEFAULT '0', # research
  PRIMARY KEY (id)
);

DROP TABLE bolt_collections;
CREATE TABLE IF NOT EXISTS bolt_collections (
  id int(11) NOT NULL AUTO_INCREMENT, # research
  slug varchar(128) NOT NULL, # research
  datecreated datetime NOT NULL, # research
  datechanged datetime NOT NULL, # research
  datepublish datetime DEFAULT NULL, # research
  datedepublish datetime DEFAULT NULL, # research
  username varchar(32) DEFAULT '', # research
  ownerid int(11) DEFAULT NULL, # research
  status varchar(32) NOT NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  intro longtext NOT NULL, # research
  teaser longtext NOT NULL, # research
  body longtext NOT NULL, # research
  teaser_image longtext NOT NULL, # research
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # research
  hide_list tinyint(1) NOT NULL DEFAULT '0', # research
  filelist_files longtext NOT NULL, # research
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # research
  hide_related tinyint(1) NOT NULL DEFAULT '0', # research
  hide_related_section tinyint(1) NOT NULL DEFAULT '0', # research
  listtitle varchar(256) NOT NULL DEFAULT '', # research
  imagelist longtext NOT NULL, # research
  liststyle longtext NOT NULL, # research
  support_navigation longtext NOT NULL, # research
  source varchar(256) NOT NULL DEFAULT '', # research
  source_url varchar(256) NOT NULL DEFAULT '', # research
  templatefields longtext NOT NULL, # research
  structure_parent longtext NOT NULL, # research
  structure_sortorder int(11) NOT NULL DEFAULT '0', # research
  PRIMARY KEY (id)
);

DROP TABLE bolt_data;
CREATE TABLE IF NOT EXISTS bolt_data (
  id int(11) NOT NULL AUTO_INCREMENT, # research
  slug varchar(128) NOT NULL, # research
  datecreated datetime NOT NULL, # research
  datechanged datetime NOT NULL, # research
  datepublish datetime DEFAULT NULL, # research
  datedepublish datetime DEFAULT NULL, # research
  templatefields longtext NOT NULL, # research
  username varchar(32) DEFAULT '', # research
  ownerid int(11) DEFAULT NULL, # research
  status varchar(32) NOT NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  intro longtext NOT NULL, # research
  teaser longtext NOT NULL, # research
  body longtext NOT NULL, # research
  image longtext NOT NULL, # research
  provided_by varchar(256) NOT NULL DEFAULT '', # research
  provided_by_link varchar(256) NOT NULL DEFAULT '', # research
  portallink varchar(256) NOT NULL DEFAULT '', # research
  apiconsolelink varchar(256) NOT NULL DEFAULT '', # research
  itemtype varchar(256) NOT NULL DEFAULT '', # research
  language_coverage varchar(256) NOT NULL DEFAULT '', # research
  subjects varchar(256) NOT NULL DEFAULT '', # research
  spatial_coverage varchar(256) NOT NULL DEFAULT '', # research
  country varchar(256) NOT NULL DEFAULT '', # research
  time_coverage varchar(256) NOT NULL DEFAULT '', # research
  contact_name varchar(256) NOT NULL DEFAULT '', # research
  contact_email varchar(256) NOT NULL DEFAULT '', # research
  PRIMARY KEY (id)
);

DROP TABLE bolt_footers;
CREATE TABLE IF NOT EXISTS bolt_footers (
  id int(11) NOT NULL AUTO_INCREMENT, # research
  slug varchar(128) NOT NULL, # research
  datecreated datetime NOT NULL, # research
  datechanged datetime NOT NULL, # research
  datepublish datetime DEFAULT NULL, # research
  datedepublish datetime DEFAULT NULL, # research
  username varchar(32) DEFAULT '', # research
  ownerid int(11) DEFAULT NULL, # research
  status varchar(32) NOT NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  image longtext NOT NULL, # research
  socialmedia longtext NOT NULL, # research
  linklist_left longtext NOT NULL, # research
  linklist_right longtext NOT NULL, # research
  mission longtext NOT NULL, # research
  linklist_other longtext NOT NULL, # research
  templatefields longtext NOT NULL, # research
  PRIMARY KEY (id)
);

DROP TABLE bolt_homepage;
CREATE TABLE IF NOT EXISTS bolt_homepage (
  id int(11) NOT NULL AUTO_INCREMENT, # research
  slug varchar(128) NOT NULL, # research
  datecreated datetime NOT NULL, # research
  datechanged datetime NOT NULL, # research
  datepublish datetime DEFAULT NULL, # research
  datedepublish datetime DEFAULT NULL, # research
  username varchar(32) DEFAULT '', # research
  ownerid int(11) DEFAULT NULL, # research
  status varchar(32) NOT NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  bannerimage longtext NOT NULL, # research
  imageattribution varchar(256) NOT NULL DEFAULT '', # research
  imagelicense longtext NOT NULL, # research
  brandcolour longtext NOT NULL, # research
  brandopacity longtext NOT NULL, # research
  brandlocation longtext NOT NULL, # research
  bannertext longtext NOT NULL, # research
  bannerlink varchar(256) NOT NULL DEFAULT '', # research
  subtitle longtext NOT NULL, # research
  callout_1 longtext NOT NULL, # research
  callout_2 longtext NOT NULL, # research
  callout_3 longtext NOT NULL, # research
  callout_6 longtext NOT NULL, # research
  templatefields longtext NOT NULL, # research
  PRIMARY KEY (id)
);

DROP TABLE bolt_locations;
CREATE TABLE IF NOT EXISTS bolt_locations (
  id int(11) NOT NULL AUTO_INCREMENT, # research
  slug varchar(128) NOT NULL, # research
  datecreated datetime NOT NULL, # research
  datechanged datetime NOT NULL, # research
  datepublish datetime DEFAULT NULL, # research
  datedepublish datetime DEFAULT NULL, # research
  username varchar(32) DEFAULT '', # research
  ownerid int(11) DEFAULT NULL, # research
  status varchar(32) NOT NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  geolocation longtext NOT NULL, # research
  europeana_place tinyint(1) NOT NULL DEFAULT '0', # research
  europeana_office tinyint(1) NOT NULL DEFAULT '0', # research
  templatefields longtext NOT NULL, # research
  PRIMARY KEY (id)
);

DROP TABLE bolt_pages;
CREATE TABLE IF NOT EXISTS bolt_pages (
  id int(11) NOT NULL AUTO_INCREMENT, # research
  slug varchar(128) NOT NULL, # research
  datecreated datetime NOT NULL, # research
  datechanged datetime NOT NULL, # research
  datepublish datetime DEFAULT NULL, # research
  datedepublish datetime DEFAULT NULL, # research
  username varchar(32) DEFAULT '', # research
  ownerid int(11) DEFAULT NULL, # research
  status varchar(32) NOT NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  intro longtext NOT NULL, # research
  teaser longtext NOT NULL, # research
  body longtext NOT NULL, # research
  teaser_image longtext NOT NULL, # research
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # research
  hide_list tinyint(1) NOT NULL DEFAULT '0', # research
  filelist_files longtext NOT NULL, # research
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # research
  hide_related tinyint(1) NOT NULL DEFAULT '0', # research
  hide_related_section tinyint(1) NOT NULL DEFAULT '0', # research
  listtitle varchar(256) NOT NULL DEFAULT '', # research
  imagelist longtext NOT NULL, # research
  liststyle longtext NOT NULL, # research
  support_navigation longtext NOT NULL, # research
  templatefields longtext NOT NULL, # research
  structure_parent longtext NOT NULL, # research
  structure_sortorder int(11) NOT NULL DEFAULT '0', # research
  PRIMARY KEY (id)
);

DROP TABLE bolt_persons;
CREATE TABLE IF NOT EXISTS bolt_persons (
  id int(11) NOT NULL AUTO_INCREMENT, # research
  slug varchar(128) NOT NULL, # research
  datecreated datetime NOT NULL, # research
  datechanged datetime NOT NULL, # research
  datepublish datetime DEFAULT NULL, # research
  datedepublish datetime DEFAULT NULL, # research
  username varchar(32) DEFAULT '', # research
  ownerid int(11) DEFAULT NULL, # research
  status varchar(32) NOT NULL, # research
  first_name varchar(256) NOT NULL DEFAULT '', # research
  last_name varchar(256) NOT NULL DEFAULT '', # research
  company varchar(256) NOT NULL DEFAULT '', # research
  company_url varchar(256) NOT NULL DEFAULT '', # research
  job_title varchar(256) NOT NULL DEFAULT '', # research
  department longtext NOT NULL, # research
  team longtext NOT NULL, # research
  introduction longtext NOT NULL, # research
  image longtext NOT NULL, # research
  email varchar(256) NOT NULL DEFAULT '', # research
  secondary_email varchar(256) NOT NULL DEFAULT '', # research
  telephone_number varchar(256) NOT NULL DEFAULT '', # research
  other_number varchar(256) NOT NULL DEFAULT '', # research
  linkedin varchar(256) NOT NULL DEFAULT '', # research
  twitter varchar(256) NOT NULL DEFAULT '', # research
  skype varchar(256) NOT NULL DEFAULT '', # research
  other_links_1 varchar(256) NOT NULL DEFAULT '', # research
  other_links_2 varchar(256) NOT NULL DEFAULT '', # research
  other_links_3 varchar(256) NOT NULL DEFAULT '', # research
  contact_blogpost tinyint(1) NOT NULL DEFAULT '0', # research
  contact_event tinyint(1) NOT NULL DEFAULT '0', # research
  contact_job tinyint(1) NOT NULL DEFAULT '0', # research
  contact_person tinyint(1) NOT NULL DEFAULT '0', # research
  contact_publication tinyint(1) NOT NULL DEFAULT '0', # research
  contact_pressrelease tinyint(1) NOT NULL DEFAULT '0', # research
  contact_taskforce tinyint(1) NOT NULL DEFAULT '0', # research
  contact_tag tinyint(1) NOT NULL DEFAULT '0', # research
  contact_collection tinyint(1) NOT NULL DEFAULT '0', # research
  templatefields longtext NOT NULL, # research
  structure_parent longtext NOT NULL, # research
  structure_sortorder int(11) NOT NULL DEFAULT '0', # research
  PRIMARY KEY (id)
);

DROP TABLE bolt_structures;
CREATE TABLE IF NOT EXISTS bolt_structures (
  id int(11) NOT NULL AUTO_INCREMENT, # research
  slug varchar(128) NOT NULL, # research
  datecreated datetime NOT NULL, # research
  datechanged datetime NOT NULL, # research
  datepublish datetime DEFAULT NULL, # research
  datedepublish datetime DEFAULT NULL, # research
  username varchar(32) DEFAULT '', # research
  ownerid int(11) DEFAULT NULL, # research
  status varchar(32) NOT NULL, # research
  title varchar(256) NOT NULL DEFAULT '', # research
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # research
  teaser longtext NOT NULL, # research
  image longtext NOT NULL, # research
  template varchar(256) NOT NULL DEFAULT '', # research
  content longtext NOT NULL, # research
  subclass longtext NOT NULL, # research
  footer longtext NOT NULL, # research
  date_start date DEFAULT NULL, # research
  date_end date DEFAULT NULL, # research
  templatefields longtext NOT NULL, # research
  structure_parent longtext NOT NULL, # research
  structure_sortorder int(11) NOT NULL DEFAULT '0', # research
  PRIMARY KEY (id)
);
