CREATE DATABASE  IF NOT EXISTS test_europeana_pro DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE test_europeana_pro;

DROP TABLE bolt_pages;
CREATE TABLE IF NOT EXISTS bolt_pages (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  parent longtext NOT NULL, # pro
  position longtext NOT NULL, # pro
  contacts longtext NOT NULL, # pro
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # pro
  teaser longtext NOT NULL, # pro
  body longtext NOT NULL, # pro
  teaser_image longtext NOT NULL, # pro
  show_page tinyint(1) NOT NULL DEFAULT '0', # pro
  support_navigation longtext NOT NULL, # pro
  filelist_files longtext NOT NULL, # pro
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # pro
  intro longtext NOT NULL, # pro
  hide_list tinyint(1) NOT NULL DEFAULT '0', # pro
  parents longtext NOT NULL, # pro
  listtitle varchar(256) NOT NULL DEFAULT '', # pro
  imagelist longtext NOT NULL, # pro
  liststyle longtext NOT NULL, # pro
  hide_related tinyint(1) NOT NULL DEFAULT '0', # pro
  hide_related_section tinyint(1) NOT NULL DEFAULT '0', # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  structure_parent longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_persons;
CREATE TABLE IF NOT EXISTS bolt_persons (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  first_name varchar(256) NOT NULL DEFAULT '', # pro
  last_name varchar(256) NOT NULL DEFAULT '', # pro
  checkbox_europeana tinyint(1) NOT NULL DEFAULT '0', # pro
  checkbox_network tinyint(1) NOT NULL DEFAULT '0', # pro
  company varchar(256) NOT NULL DEFAULT '', # pro
  company_url varchar(256) NOT NULL DEFAULT '', # pro
  job_title varchar(256) NOT NULL DEFAULT '', # pro
  team longtext NOT NULL, # pro
  introduction longtext NOT NULL, # pro
  image longtext NOT NULL, # pro
  email varchar(256) NOT NULL DEFAULT '', # pro
  secondary_email varchar(256) NOT NULL DEFAULT '', # pro
  telephone_number varchar(256) NOT NULL DEFAULT '', # pro
  other_number varchar(256) NOT NULL DEFAULT '', # pro
  linkedin varchar(256) NOT NULL DEFAULT '', # pro
  twitter varchar(256) NOT NULL DEFAULT '', # pro
  skype varchar(256) NOT NULL DEFAULT '', # pro
  other_links_1 varchar(256) NOT NULL DEFAULT '', # pro
  other_links_2 varchar(256) NOT NULL DEFAULT '', # pro
  other_links_3 varchar(256) NOT NULL DEFAULT '', # pro
  checkbox_chief tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_blog tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_event tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_job tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_staff tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_publication tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_aggregator tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_tech tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_network tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_member tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_blogpost tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_pressrelease tinyint(1) NOT NULL DEFAULT '0', # pro
  department longtext NOT NULL, # pro
  contact_taskforce tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_tag tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_person tinyint(1) NOT NULL DEFAULT '0', # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  structure_parent longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_network;
CREATE TABLE IF NOT EXISTS bolt_network (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  first_name varchar(256) NOT NULL DEFAULT '', # pro
  last_name varchar(256) NOT NULL DEFAULT '', # pro
  company varchar(256) NOT NULL DEFAULT '', # pro
  company_url varchar(256) NOT NULL DEFAULT '', # pro
  job_title varchar(256) NOT NULL DEFAULT '', # pro
  department longtext NOT NULL, # pro
  team longtext NOT NULL, # pro
  introduction longtext NOT NULL, # pro
  image longtext NOT NULL, # pro
  email varchar(256) NOT NULL DEFAULT '', # pro
  secondary_email varchar(256) NOT NULL DEFAULT '', # pro
  telephone_number varchar(256) NOT NULL DEFAULT '', # pro
  other_number varchar(256) NOT NULL DEFAULT '', # pro
  linkedin varchar(256) NOT NULL DEFAULT '', # pro
  twitter varchar(256) NOT NULL DEFAULT '', # pro
  skype varchar(256) NOT NULL DEFAULT '', # pro
  other_links_1 varchar(256) NOT NULL DEFAULT '', # pro
  other_links_2 varchar(256) NOT NULL DEFAULT '', # pro
  other_links_3 varchar(256) NOT NULL DEFAULT '', # pro
  contact_blogpost tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_event tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_job tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_person tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_publication tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_pressrelease tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_taskforce tinyint(1) NOT NULL DEFAULT '0', # pro
  contact_tag tinyint(1) NOT NULL DEFAULT '0', # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  structure_parent longtext NOT NULL, # pro
  uid varchar(256) NOT NULL DEFAULT '', # pro
  network_participation longtext NOT NULL, # pro
  community longtext NOT NULL, # pro
  community_role varchar(256) NOT NULL DEFAULT '', # pro
  europeana_id varchar(256) NOT NULL DEFAULT '', # pro
  author_uid varchar(256) NOT NULL DEFAULT '', # pro
  author_name varchar(256) NOT NULL DEFAULT '', # pro
  modified_uid varchar(256) NOT NULL DEFAULT '', # pro
  modified_name varchar(256) NOT NULL DEFAULT '', # pro
  latime varchar(256) NOT NULL DEFAULT '', # pro
  account_uid varchar(256) NOT NULL DEFAULT '', # pro
  account_name varchar(256) NOT NULL DEFAULT '', # pro
  public_email varchar(256) NOT NULL DEFAULT '', # pro
  public_phone varchar(256) NOT NULL DEFAULT '', # pro
  statutes_read longtext NOT NULL, # pro
  statutes_agree longtext NOT NULL, # pro
  public_photo longtext NOT NULL, # pro
  europeana_tech longtext NOT NULL, # pro
  sector varchar(256) NOT NULL DEFAULT '', # pro
  country varchar(256) NOT NULL DEFAULT '', # pro
  description longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  candidacy_teaser longtext NOT NULL, # pro
  candidacy_intro longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_blogposts;
CREATE TABLE IF NOT EXISTS bolt_blogposts (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  teaser longtext NOT NULL, # pro
  body longtext NOT NULL, # pro
  attachments longtext NOT NULL, # pro
  parents longtext NOT NULL, # pro
  originalurl varchar(256) NOT NULL DEFAULT '', # pro
  image longtext NOT NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  structure_parent longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_events;
CREATE TABLE IF NOT EXISTS bolt_events (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  start_event datetime DEFAULT NULL, # pro
  unconfirmed_start tinyint(1) NOT NULL DEFAULT '0', # pro
  end_event datetime DEFAULT NULL, # pro
  unconfirmed_end tinyint(1) NOT NULL DEFAULT '0', # pro
  teaser longtext NOT NULL, # pro
  body longtext NOT NULL, # pro
  file varchar(256) NOT NULL DEFAULT '', # pro
  teaser_image longtext NOT NULL, # pro
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # pro
  filelist longtext NOT NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  support_navigation longtext NOT NULL, # pro
  structure_parent longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_jobs;
CREATE TABLE IF NOT EXISTS bolt_jobs (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
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

DROP TABLE bolt_pressreleases;
CREATE TABLE IF NOT EXISTS bolt_pressreleases (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  subtitle longtext NOT NULL, # pro
  body longtext NOT NULL, # pro
  isbn varchar(256) NOT NULL DEFAULT '', # pro
  filelist longtext NOT NULL, # pro
  image longtext NOT NULL, # pro
  parents longtext NOT NULL, # pro
  introduction longtext NOT NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  structure_parent longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_publications;
CREATE TABLE IF NOT EXISTS bolt_publications (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
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

DROP TABLE bolt_projects;
CREATE TABLE IF NOT EXISTS bolt_projects (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  subtitle varchar(256) NOT NULL DEFAULT '', # pro
  date_start date DEFAULT NULL, # pro
  date_end date DEFAULT NULL, # pro
  teaser longtext NOT NULL, # pro
  intro longtext NOT NULL, # pro
  body longtext NOT NULL, # pro
  url varchar(256) NOT NULL DEFAULT '', # pro
  logo longtext NOT NULL, # pro
  filelist longtext NOT NULL, # pro
  structure_parent longtext NOT NULL, # pro
  filelist_downloads varchar(256) NOT NULL DEFAULT '', # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_taskforces;
CREATE TABLE IF NOT EXISTS bolt_taskforces (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
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

DROP TABLE bolt_locations;
CREATE TABLE IF NOT EXISTS bolt_locations (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  geolocation longtext NOT NULL, # pro
  europeana_place tinyint(1) NOT NULL DEFAULT '0', # pro
  europeana_office tinyint(1) NOT NULL DEFAULT '0', # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_structures;
CREATE TABLE IF NOT EXISTS bolt_structures (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  selectfield longtext NOT NULL, # pro
  contacts longtext NOT NULL, # pro
  secondary_mail tinyint(1) NOT NULL DEFAULT '0', # pro
  intro varchar(256) NOT NULL DEFAULT '', # pro
  image longtext NOT NULL, # pro
  template varchar(256) NOT NULL DEFAULT '', # pro
  parent longtext NOT NULL, # pro
  teaser longtext NOT NULL, # pro
  position longtext NOT NULL, # pro
  children longtext NOT NULL, # pro
  subclass longtext NOT NULL, # pro
  content longtext NOT NULL, # pro
  footer longtext NOT NULL, # pro
  date_start date DEFAULT NULL, # pro
  date_end date DEFAULT NULL, # pro
  structure_sortorder int(11) NOT NULL DEFAULT '0', # pro
  structure_parent longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  body longtext NOT NULL, # pro
  suffix longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_homepage;
CREATE TABLE IF NOT EXISTS bolt_homepage (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  bannerimage longtext NOT NULL, # pro
  bannertext longtext NOT NULL, # pro
  bannerlink_select longtext NOT NULL, # pro
  bannerlink varchar(256) NOT NULL DEFAULT '', # pro
  subtitle longtext NOT NULL, # pro
  callout_1 longtext NOT NULL, # pro
  callout_2 longtext NOT NULL, # pro
  callout_3 longtext NOT NULL, # pro
  callout_4 longtext NOT NULL, # pro
  callout_5 longtext NOT NULL, # pro
  callout_6 longtext NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  imageattribution varchar(256) NOT NULL DEFAULT '', # pro
  imagelicense longtext NOT NULL, # pro
  brandcolour longtext NOT NULL, # pro
  brandopacity longtext NOT NULL, # pro
  brandlocation longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);

DROP TABLE bolt_footers;
CREATE TABLE IF NOT EXISTS bolt_footers (
  id int(11) NOT NULL AUTO_INCREMENT, # pro
  slug varchar(128) NOT NULL, # pro
  datecreated datetime NOT NULL, # pro
  datechanged datetime NOT NULL, # pro
  datepublish datetime DEFAULT NULL, # pro
  datedepublish datetime DEFAULT NULL, # pro
  username varchar(32) DEFAULT '', # pro
  ownerid int(11) DEFAULT NULL, # pro
  status varchar(32) NOT NULL, # pro
  title varchar(256) NOT NULL DEFAULT '', # pro
  image longtext NOT NULL, # pro
  socialmedia longtext NOT NULL, # pro
  linklist_left longtext NOT NULL, # pro
  linklist_right longtext NOT NULL, # pro
  mission longtext NOT NULL, # pro
  linklist_other longtext NOT NULL, # pro
  templatefields longtext NOT NULL, # pro
  PRIMARY KEY (id)
);
