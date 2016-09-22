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
  $query['relations_from'][] = "UPDATE bolt_relations r, $table x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = '$ctype';\n";

  $query['relations_to'][] = "UPDATE bolt_relations r, $table x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = '$ctype';\n";
}

foreach ($content_types as $ctype => $table) {
  $query['taxonomy'][] = "UPDATE bolt_taxonomy t, $table c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = '$ctype';\n";
}

// set username
foreach ($content_types as $ctype => $table) {
  $query['usernames'][] = "UPDATE $table c, bolt_users y SET c.username = y.username WHERE y.id = c.ownerid AND c.subsite = y.subsite;\n";
}

// remove duplicate users by username
$query['user_dedupe'][] = "DELETE FROM bolt_users WHERE id IN ( SELECT u.id FROM bolt_users u, bolt_users u2 WHERE u.id <> u2.id AND u.username = u2.username AND u.id > u2.id );\n";

// set userid
foreach ($content_types as $ctype => $table) {
  $query['user_id'][] = "UPDATE $table c, bolt_users y SET c.ownerid = y.id WHERE c.username = y.username;\n";
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
