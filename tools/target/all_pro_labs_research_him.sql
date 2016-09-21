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
