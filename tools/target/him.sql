CREATE DATABASE IF NOT EXISTS test_europeana_him DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE test_europeana_him;

DROP TABLE bolt_blogposts;
CREATE TABLE IF NOT EXISTS bolt_blogposts (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  intro longtext, # him
  body longtext, # him
  image longtext NOT NULL, # him
  attachments longtext NOT NULL, # him
  teaser longtext, # him
  teaser_image longtext NOT NULL, # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him
  structure_parent longtext, # him
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  author longtext, # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_events;
CREATE TABLE IF NOT EXISTS bolt_events (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  intro longtext, # him
  image longtext NOT NULL, # him
  body longtext, # him
  teaser longtext, # him
  teaser_image longtext NOT NULL, # him
  start_event datetime DEFAULT NULL, # him
  unconfirmed_start tinyint(1) NOT NULL DEFAULT '0', # him
  end_event datetime DEFAULT NULL, # him
  unconfirmed_end tinyint(1) NOT NULL DEFAULT '0', # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him
  structure_parent longtext, # him
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_footers;
CREATE TABLE IF NOT EXISTS bolt_footers (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  image longtext NOT NULL, # him
  socialmedia longtext, # him
  linklist_left longtext, # him
  linklist_right longtext, # him
  mission longtext, # him
  linklist_other longtext, # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_himcomments;
CREATE TABLE IF NOT EXISTS bolt_himcomments (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  entryid varchar(256) DEFAULT '', # him
  judgeid varchar(256) DEFAULT '', # him
  judgename varchar(256) DEFAULT '', # him
  comment longtext, # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_himeditions;
CREATE TABLE IF NOT EXISTS bolt_himeditions (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  intro longtext, # him
  image longtext NOT NULL, # him
  body longtext, # him
  teaser longtext, # him
  teaser_image longtext NOT NULL, # him
  submission_deadline datetime DEFAULT NULL, # him
  submission_start datetime DEFAULT NULL, # him
  submission_closed tinyint(1) NOT NULL DEFAULT '0', # him
  edition_menu tinyint(1) NOT NULL DEFAULT '0', # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him
  structure_parent longtext, # him
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  submission_cost varchar(256) DEFAULT '', # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_himentries;
CREATE TABLE IF NOT EXISTS bolt_himentries (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  teaser longtext NOT NULL, # him
  body longtext NOT NULL, # him
  image longtext, # him
  video longtext, # him
  userid varchar(256) DEFAULT '', # him
  name varchar(256) DEFAULT '', # him
  email varchar(256) DEFAULT '', # him
  description longtext, # him
  videolink varchar(256) DEFAULT '', # him
  videodownloadstatus varchar(256) DEFAULT '', # him
  videodownloadlocation varchar(256) DEFAULT '', # him
  projecturl varchar(256) DEFAULT '', # him
  licence longtext, # him
  upload_thumb longtext, # him
  upload_1 longtext, # him
  upload_2 longtext, # him
  upload_3 longtext, # him
  upload_4 longtext, # him
  upload_5 longtext, # him
  upload_6 longtext, # him
  upload_7 longtext, # him
  upload_8 longtext, # him
  clienttags varchar(256) DEFAULT '', # him
  summary longtext, # him
  credits longtext, # him
  upload_images longtext NOT NULL, # him
  transaction_id varchar(256) DEFAULT '', # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_himvotes;
CREATE TABLE IF NOT EXISTS bolt_himvotes (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  entryid varchar(256) DEFAULT '', # him
  judgeid varchar(256) DEFAULT '', # him
  judgename varchar(256) DEFAULT '', # him
  vote double NOT NULL DEFAULT '0', # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_pages;
CREATE TABLE IF NOT EXISTS bolt_pages (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  intro longtext, # him
  teaser longtext, # him
  body longtext, # him
  teaser_image longtext NOT NULL, # him
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  template varchar(256) DEFAULT '', # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him
  structure_parent longtext, # him
  image longtext NOT NULL, # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_persons;
CREATE TABLE IF NOT EXISTS bolt_persons (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  first_name varchar(256) DEFAULT '', # him
  last_name varchar(256) DEFAULT '', # him
  job_title varchar(256) DEFAULT '', # him
  introduction longtext, # him
  image longtext NOT NULL, # him
  email varchar(256) DEFAULT '', # him
  linkedin varchar(256) DEFAULT '', # him
  twitter varchar(256) DEFAULT '', # him
  skype varchar(256) DEFAULT '', # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him
  structure_parent longtext, # him
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  phone varchar(256) DEFAULT '', # him
  team longtext, # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_pressreleases;
CREATE TABLE IF NOT EXISTS bolt_pressreleases (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  intro longtext, # him
  image longtext NOT NULL, # him
  body longtext, # him
  author varchar(256) DEFAULT '', # him
  teaser longtext, # him
  teaser_image longtext NOT NULL, # him
  attachments longtext NOT NULL, # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him
  structure_parent longtext, # him
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_resources;
CREATE TABLE IF NOT EXISTS bolt_resources (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  image longtext NOT NULL, # him
  body longtext, # him
  htmllink varchar(256) DEFAULT '', # him
  weight int(11) NOT NULL DEFAULT '0', # him
  cssclass varchar(256) DEFAULT '', # him
  cssid varchar(256) DEFAULT '', # him
  PRIMARY KEY (id)
);

DROP TABLE bolt_structures;
CREATE TABLE IF NOT EXISTS bolt_structures (
  id int(11) NOT NULL AUTO_INCREMENT, # him
  slug varchar(128) NOT NULL, # him
  datecreated datetime NOT NULL, # him
  datechanged datetime NOT NULL, # him
  datepublish datetime DEFAULT NULL, # him
  datedepublish datetime DEFAULT NULL, # him
  username varchar(32) DEFAULT '', # him
  ownerid int(11) DEFAULT NULL, # him
  status varchar(32) NOT NULL, # him
  templatefields longtext NOT NULL, # him
  title varchar(256) DEFAULT '', # him
  intro longtext, # him
  body longtext, # him
  image longtext NOT NULL, # him
  suffix longtext, # him
  teaser longtext, # him
  teaser_image longtext NOT NULL, # him
  structure_sortorder int(11) NOT NULL DEFAULT '0', # him
  structure_parent longtext, # him
  hide_list tinyint(1) NOT NULL DEFAULT '0', # him
  template varchar(256) DEFAULT '', # him
  default_content longtext, # him
  PRIMARY KEY (id)
);
