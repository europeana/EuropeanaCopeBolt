-- queries for relations_from
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_apps x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'apps'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_blogposts x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'blogposts'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_collections x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'collections'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_data x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'data'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_documentation x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'documentation'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_events x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'events'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_footers x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'footers'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_himcomments x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'himcomments'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_himeditions x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'himeditions'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_himentries x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'himentries'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_himvotes x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'himvotes'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_homepage x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'homepage'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_jobs x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'jobs'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_locations x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'locations'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_pages x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'pages'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_pressreleases x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'pressreleases'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_projects x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'projects'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_publications x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'publications'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_resources x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'resources'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_structures x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'structures'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_taskforces x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'taskforces'
  );
-- queries for relations_to
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_apps x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'apps'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_blogposts x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'blogposts'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_collections x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'collections'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_data x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'data'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_documentation x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'documentation'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_events x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'events'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_footers x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'footers'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_himcomments x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'himcomments'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_himeditions x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'himeditions'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_himentries x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'himentries'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_himvotes x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'himvotes'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_homepage x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'homepage'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_jobs x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'jobs'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_locations x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'locations'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_pages x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'pages'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_pressreleases x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'pressreleases'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_projects x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'projects'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_publications x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'publications'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_resources x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'resources'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_structures x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'structures'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_taskforces x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'taskforces'
  );
-- queries for taxonomy
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_apps x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'apps'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_blogposts x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'blogposts'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_collections x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'collections'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_data x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'data'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_documentation x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'documentation'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_events x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'events'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_footers x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'footers'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_himcomments x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'himcomments'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_himeditions x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'himeditions'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_himentries x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'himentries'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_himvotes x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'himvotes'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_homepage x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'homepage'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_jobs x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'jobs'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_locations x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'locations'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_pages x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'pages'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_pressreleases x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'pressreleases'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_projects x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'projects'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_publications x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'publications'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_resources x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'resources'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_structures x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'structures'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_taskforces x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'taskforces'
  );
-- queries for relations_from
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_apps x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'apps'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_blogposts x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'blogposts'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_collections x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'collections'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_data x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'data'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_documentation x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'documentation'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_events x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'events'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_footers x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'footers'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_himcomments x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'himcomments'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_himeditions x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'himeditions'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_himentries x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'himentries'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_himvotes x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'himvotes'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_homepage x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'homepage'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_jobs x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'jobs'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_locations x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'locations'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_pages x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'pages'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_pressreleases x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'pressreleases'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_projects x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'projects'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_publications x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'publications'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_resources x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'resources'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_structures x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'structures'
  );
UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM bolt_taskforces x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = 'taskforces'
  );
-- queries for relations_to
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_apps x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'apps'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_blogposts x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'blogposts'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_collections x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'collections'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_data x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'data'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_documentation x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'documentation'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_events x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'events'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_footers x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'footers'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_himcomments x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'himcomments'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_himeditions x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'himeditions'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_himentries x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'himentries'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_himvotes x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'himvotes'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_homepage x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'homepage'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_jobs x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'jobs'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_locations x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'locations'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_pages x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'pages'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_pressreleases x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'pressreleases'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_projects x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'projects'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_publications x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'publications'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_resources x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'resources'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_structures x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'structures'
  );
UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM bolt_taskforces x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = 'taskforces'
  );
-- queries for taxonomy
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_apps x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'apps'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_blogposts x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'blogposts'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_collections x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'collections'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_data x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'data'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_documentation x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'documentation'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_events x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'events'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_footers x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'footers'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_himcomments x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'himcomments'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_himeditions x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'himeditions'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_himentries x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'himentries'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_himvotes x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'himvotes'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_homepage x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'homepage'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_jobs x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'jobs'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_locations x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'locations'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_pages x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'pages'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_pressreleases x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'pressreleases'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_projects x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'projects'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_publications x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'publications'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_resources x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'resources'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_structures x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'structures'
  );
UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM bolt_taskforces x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = 'taskforces'
  );
-- queries for cleanup
ALTER TABLE bolt_relations DROP subsite;
ALTER TABLE bolt_taxonomy DROP subsite;
-- queries for cleanup_id
ALTER TABLE bolt_relations DROP subsite_id;
ALTER TABLE bolt_taxonomy DROP subsite_id;
ALTER TABLE bolt_apps DROP subsite_id;
ALTER TABLE bolt_blogposts DROP subsite_id;
ALTER TABLE bolt_collections DROP subsite_id;
ALTER TABLE bolt_data DROP subsite_id;
ALTER TABLE bolt_documentation DROP subsite_id;
ALTER TABLE bolt_events DROP subsite_id;
ALTER TABLE bolt_footers DROP subsite_id;
ALTER TABLE bolt_himcomments DROP subsite_id;
ALTER TABLE bolt_himeditions DROP subsite_id;
ALTER TABLE bolt_himentries DROP subsite_id;
ALTER TABLE bolt_himvotes DROP subsite_id;
ALTER TABLE bolt_homepage DROP subsite_id;
ALTER TABLE bolt_jobs DROP subsite_id;
ALTER TABLE bolt_locations DROP subsite_id;
ALTER TABLE bolt_pages DROP subsite_id;
ALTER TABLE bolt_pressreleases DROP subsite_id;
ALTER TABLE bolt_projects DROP subsite_id;
ALTER TABLE bolt_publications DROP subsite_id;
ALTER TABLE bolt_resources DROP subsite_id;
ALTER TABLE bolt_structures DROP subsite_id;
ALTER TABLE bolt_taskforces DROP subsite_id;
