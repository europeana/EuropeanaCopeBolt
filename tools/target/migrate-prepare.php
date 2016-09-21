<?php
$content_types = [
  'apps' => 'bolt_apps',
  'blogposts' => 'bolt_blogposts',
  'collections' => 'bolt_collections',
  'data' => 'bolt_data',
  'documentation' => 'bolt_documentation',
  'events' => 'bolt_events',
  'footers' => 'bolt_footers',
  'himcomments' => 'bolt_himcomments',
  'himeditions' => 'bolt_himeditions',
  'himentries' => 'bolt_himentries',
  'himvotes' => 'bolt_himvotes',
  'homepage' => 'bolt_homepage',
  'jobs' => 'bolt_jobs',
  'locations' => 'bolt_locations',
  'pages' => 'bolt_pages',
  'pressreleases' => 'bolt_pressreleases',
  'projects' => 'bolt_projects',
  'publications' => 'bolt_publications',
  'resources' => 'bolt_resources',
  'structures' => 'bolt_structures',
  'taskforces' => 'bolt_taskforces'
];

foreach ($content_types as $ctype => $table) {
  $query['relations_from'][] = "UPDATE bolt_relations r 
  SET r.from_id = (
    SELECT x.id 
    FROM $table x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.from_contenttype = '$ctype'
  );\n";

  $query['relations_to'][] = "UPDATE bolt_relations r 
  SET r.to_id = (
    SELECT x.id 
    FROM $table x 
    JOIN bolt_relations y ON x.subsite_id = y.from_id
    WHERE x.subsite = y.subsite
    AND y.to_contenttype = '$ctype'
  );\n";
}
foreach ($content_types as $ctype => $table) {
  $query['taxonomy'][] = "UPDATE bolt_taxonomy t 
  SET t.content_id = (
    SELECT x.id 
    FROM $table x 
    JOIN bolt_taxonomy y ON x.subsite_id = y.content_id
    WHERE x.subsite = y.subsite
    AND y.contenttype = '$ctype'
  );\n";
}

$query['cleanup'][] = "ALTER TABLE bolt_relations DROP subsite;\n";
$query['cleanup'][] = "ALTER TABLE bolt_taxonomy DROP subsite;\n";
$query['cleanup_id'][] = "ALTER TABLE bolt_relations DROP subsite_id;\n";
$query['cleanup_id'][] = "ALTER TABLE bolt_taxonomy DROP subsite_id;\n";

foreach ($content_types as $ctype => $table) {
    $query['cleanup_id'][] = "ALTER TABLE $table DROP subsite_id;\n"; 
}

foreach ($query as $group => $queries) {
    echo "-- queries for $group\n";
    foreach ($queries as $doit) {
        echo $doit;
    }

}
