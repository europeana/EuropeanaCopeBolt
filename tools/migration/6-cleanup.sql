# 6-cleanup
DROP TABLE IF EXISTS bolt_applications;
DROP TABLE IF EXISTS bolt_apps;
DROP TABLE IF EXISTS bolt_collections;
DROP TABLE IF EXISTS bolt_documentation;
DROP TABLE IF EXISTS bolt_footers;
DROP TABLE IF EXISTS bolt_himcomments;
DROP TABLE IF EXISTS bolt_himeditions;
DROP TABLE IF EXISTS bolt_himentries;
DROP TABLE IF EXISTS bolt_himvotes;
DROP TABLE IF EXISTS bolt_landingpages;
DROP TABLE IF EXISTS bolt_locations;
DROP TABLE IF EXISTS bolt_pressreleases;
DROP TABLE IF EXISTS bolt_publications;
DROP TABLE IF EXISTS bolt_structures;
DROP TABLE IF EXISTS bolt_taskforces;

TRUNCATE bolt_blogposts;
TRUNCATE bolt_blogevents;
