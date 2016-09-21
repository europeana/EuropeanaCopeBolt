CREATE DATABASE IF NOT EXISTS test_europeana_labs DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE test_europeana_labs;

DROP TABLE bolt_apps;
CREATE TABLE IF NOT EXISTS bolt_apps (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  intro longtext NOT NULL, # labs
  teaser longtext NOT NULL, # labs
  body longtext NOT NULL, # labs
  image longtext NOT NULL, # labs
  link1 varchar(256) NOT NULL DEFAULT '', # labs
  link2 varchar(256) NOT NULL DEFAULT '', # labs
  link3 varchar(256) NOT NULL DEFAULT '', # labs
  contact_name varchar(256) NOT NULL DEFAULT '', # labs
  contact_email varchar(256) NOT NULL DEFAULT '', # labs
  contact_website varchar(256) NOT NULL DEFAULT '', # labs
  templatefields longtext NOT NULL, # labs
  hero longtext NOT NULL, # labs
  PRIMARY KEY (id)
);

DROP TABLE bolt_blog;
CREATE TABLE IF NOT EXISTS bolt_blog (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  body longtext NOT NULL, # labs
  image longtext NOT NULL, # labs
  files longtext NOT NULL, # labs
  structure_sortorder int(11) NOT NULL DEFAULT '0', # labs
  templatefields longtext NOT NULL, # labs
  structure_parent longtext NOT NULL, # labs
  hero longtext NOT NULL, # labs
  intro longtext NOT NULL, # labs
  PRIMARY KEY (id)
);

DROP TABLE bolt_data;
CREATE TABLE IF NOT EXISTS bolt_data (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  intro longtext NOT NULL, # labs
  teaser longtext NOT NULL, # labs
  body longtext NOT NULL, # labs
  image longtext NOT NULL, # labs
  provided_by varchar(256) NOT NULL DEFAULT '', # labs
  provided_by_link varchar(256) NOT NULL DEFAULT '', # labs
  portallink varchar(256) NOT NULL DEFAULT '', # labs
  apiconsolelink varchar(256) NOT NULL DEFAULT '', # labs
  contact_name varchar(256) NOT NULL DEFAULT '', # labs
  contact_email varchar(256) NOT NULL DEFAULT '', # labs
  templatefields longtext NOT NULL, # labs
  PRIMARY KEY (id)
);

DROP TABLE bolt_documentation;
CREATE TABLE IF NOT EXISTS bolt_documentation (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
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

DROP TABLE bolt_events;
CREATE TABLE IF NOT EXISTS bolt_events (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  start_event datetime DEFAULT NULL, # labs
  unconfirmed_start tinyint(1) NOT NULL DEFAULT '0', # labs
  end_event datetime DEFAULT NULL, # labs
  unconfirmed_end tinyint(1) NOT NULL DEFAULT '0', # labs
  teaser longtext NOT NULL, # labs
  body longtext NOT NULL, # labs
  teaser_image longtext NOT NULL, # labs
  filelist longtext NOT NULL, # labs
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # labs
  structure_sortorder int(11) NOT NULL DEFAULT '0', # labs
  external_link varchar(256) NOT NULL DEFAULT '', # labs
  templatefields longtext NOT NULL, # labs
  structure_parent longtext NOT NULL, # labs
  PRIMARY KEY (id)
);

DROP TABLE bolt_footers;
CREATE TABLE IF NOT EXISTS bolt_footers (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  image longtext NOT NULL, # labs
  socialmedia longtext NOT NULL, # labs
  linklist_left longtext NOT NULL, # labs
  linklist_right longtext NOT NULL, # labs
  mission longtext NOT NULL, # labs
  linklist_other longtext NOT NULL, # labs
  templatefields longtext NOT NULL, # labs
  PRIMARY KEY (id)
);

DROP TABLE bolt_homepage;
CREATE TABLE IF NOT EXISTS bolt_homepage (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  bannerimage longtext NOT NULL, # labs
  imageattribution varchar(256) NOT NULL DEFAULT '', # labs
  imagelicense longtext NOT NULL, # labs
  brandcolour longtext NOT NULL, # labs
  brandopacity longtext NOT NULL, # labs
  brandlocation longtext NOT NULL, # labs
  bannertext longtext NOT NULL, # labs
  bannerlink varchar(256) NOT NULL DEFAULT '', # labs
  subtitle longtext NOT NULL, # labs
  callout_1 longtext NOT NULL, # labs
  callout_2 longtext NOT NULL, # labs
  callout_3 longtext NOT NULL, # labs
  use_manual_1 tinyint(1) NOT NULL DEFAULT '0', # labs
  flag_colour_1 longtext NOT NULL, # labs
  flag_label_1 varchar(256) NOT NULL DEFAULT '', # labs
  latest_title_1 varchar(256) NOT NULL DEFAULT '', # labs
  latest_teaser_1 longtext NOT NULL, # labs
  latest_image_1 longtext NOT NULL, # labs
  latest_url_1 varchar(256) NOT NULL DEFAULT '', # labs
  use_manual_2 tinyint(1) NOT NULL DEFAULT '0', # labs
  flag_colour_2 longtext NOT NULL, # labs
  flag_label_2 varchar(256) NOT NULL DEFAULT '', # labs
  latest_title_2 varchar(256) NOT NULL DEFAULT '', # labs
  latest_teaser_2 longtext NOT NULL, # labs
  latest_image_2 longtext NOT NULL, # labs
  latest_url_2 varchar(256) NOT NULL DEFAULT '', # labs
  use_manual_3 tinyint(1) NOT NULL DEFAULT '0', # labs
  flag_colour_3 longtext NOT NULL, # labs
  flag_label_3 varchar(256) NOT NULL DEFAULT '', # labs
  latest_title_3 varchar(256) NOT NULL DEFAULT '', # labs
  latest_teaser_3 longtext NOT NULL, # labs
  latest_image_3 longtext NOT NULL, # labs
  latest_url_3 varchar(256) NOT NULL DEFAULT '', # labs
  templatefields longtext NOT NULL, # labs
  PRIMARY KEY (id)
);

DROP TABLE bolt_locations;
CREATE TABLE IF NOT EXISTS bolt_locations (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  geolocation longtext NOT NULL, # labs
  europeana_place tinyint(1) NOT NULL DEFAULT '0', # labs
  europeana_office tinyint(1) NOT NULL DEFAULT '0', # labs
  templatefields longtext NOT NULL, # labs
  PRIMARY KEY (id)
);

DROP TABLE bolt_pages;
CREATE TABLE IF NOT EXISTS bolt_pages (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  intro longtext NOT NULL, # labs
  teaser longtext NOT NULL, # labs
  body longtext NOT NULL, # labs
  teaser_image longtext NOT NULL, # labs
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # labs
  hide_related tinyint(1) NOT NULL DEFAULT '0', # labs
  hide_related_section tinyint(1) NOT NULL DEFAULT '0', # labs
  support_navigation longtext NOT NULL, # labs
  structure_sortorder int(11) NOT NULL DEFAULT '0', # labs
  files longtext NOT NULL, # labs
  link1 varchar(256) NOT NULL DEFAULT '', # labs
  link2 varchar(256) NOT NULL DEFAULT '', # labs
  link3 varchar(256) NOT NULL DEFAULT '', # labs
  templatefields longtext NOT NULL, # labs
  structure_parent longtext NOT NULL, # labs
  hero longtext NOT NULL, # labs
  hide_list tinyint(1) NOT NULL DEFAULT '0', # labs
  templateselect varchar(256) NOT NULL DEFAULT '', # labs
  PRIMARY KEY (id)
);

DROP TABLE bolt_persons;
CREATE TABLE IF NOT EXISTS bolt_persons (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  first_name varchar(256) NOT NULL DEFAULT '', # labs
  last_name varchar(256) NOT NULL DEFAULT '', # labs
  company varchar(256) NOT NULL DEFAULT '', # labs
  company_url varchar(256) NOT NULL DEFAULT '', # labs
  job_title varchar(256) NOT NULL DEFAULT '', # labs
  introduction longtext NOT NULL, # labs
  image longtext NOT NULL, # labs
  email varchar(256) NOT NULL DEFAULT '', # labs
  secondary_email varchar(256) NOT NULL DEFAULT '', # labs
  telephone_number varchar(256) NOT NULL DEFAULT '', # labs
  other_number varchar(256) NOT NULL DEFAULT '', # labs
  linkedin varchar(256) NOT NULL DEFAULT '', # labs
  twitter varchar(256) NOT NULL DEFAULT '', # labs
  skype varchar(256) NOT NULL DEFAULT '', # labs
  other_links_1 varchar(256) NOT NULL DEFAULT '', # labs
  other_links_2 varchar(256) NOT NULL DEFAULT '', # labs
  other_links_3 varchar(256) NOT NULL DEFAULT '', # labs
  contact_blogpost tinyint(1) NOT NULL DEFAULT '0', # labs
  contact_event tinyint(1) NOT NULL DEFAULT '0', # labs
  contact_person tinyint(1) NOT NULL DEFAULT '0', # labs
  contact_tag tinyint(1) NOT NULL DEFAULT '0', # labs
  structure_sortorder int(11) NOT NULL DEFAULT '0', # labs
  templatefields longtext NOT NULL, # labs
  structure_parent longtext NOT NULL, # labs
  PRIMARY KEY (id)
);

DROP TABLE bolt_structures;
CREATE TABLE IF NOT EXISTS bolt_structures (
  id int(11) NOT NULL AUTO_INCREMENT, # labs
  slug varchar(128) NOT NULL, # labs
  datecreated datetime NOT NULL, # labs
  datechanged datetime NOT NULL, # labs
  datepublish datetime DEFAULT NULL, # labs
  datedepublish datetime DEFAULT NULL, # labs
  username varchar(32) DEFAULT '', # labs
  ownerid int(11) DEFAULT NULL, # labs
  status varchar(32) NOT NULL, # labs
  title varchar(256) NOT NULL DEFAULT '', # labs
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # labs
  teaser longtext NOT NULL, # labs
  image longtext NOT NULL, # labs
  template varchar(256) NOT NULL DEFAULT '', # labs
  content longtext NOT NULL, # labs
  subclass longtext NOT NULL, # labs
  footer longtext NOT NULL, # labs
  date_start date DEFAULT NULL, # labs
  date_end date DEFAULT NULL, # labs
  structure_sortorder int(11) NOT NULL DEFAULT '0', # labs
  templatefields longtext NOT NULL, # labs
  structure_parent longtext NOT NULL, # labs
  PRIMARY KEY (id)
);
