<?php
$content_types = [
  'apps' => 'bolt_applications',
  'blogposts' => 'bolt_blogposts',
  'collections' => 'bolt_collections',
  'data' => 'bolt_data',
  'documentation' => 'bolt_documentation',
  'events' => 'bolt_events',
  'footers' => 'bolt_footers',
  'homepage' => 'bolt_homepage',
  'jobs' => 'bolt_jobs',
  'locations' => 'bolt_locations',
  'pages' => 'bolt_pages',
  'pressreleases' => 'bolt_pressreleases',
  'projects' => 'bolt_projects',
  'persons' => 'bolt_persons',
  'publications' => 'bolt_publications',
  'resources' => 'bolt_resources',
  'structures' => 'bolt_structures',
  'taskforces' => 'bolt_taskforces'
];

$query['intro'][] = "USE europeana_cope;\n";

foreach ($content_types as $ctype => $table) {
  $query['relations_from'][] = "UPDATE bolt_relations r, $table x SET r.from_id = x.id WHERE x.subsite_id = r.from_id AND x.subsite = r.subsite AND r.from_contenttype = '$ctype';\n";

  $query['relations_to'][] = "UPDATE bolt_relations r, $table x SET r.to_id = x.id WHERE x.subsite_id = r.to_id AND x.subsite = r.subsite AND r.to_contenttype = '$ctype';\n";
}

foreach ($content_types as $ctype => $table) {
  $query['taxonomy'][] = "UPDATE bolt_taxonomy t, $table c SET t.content_id = c.id WHERE c.subsite_id = t.content_id AND c.subsite = t.subsite AND t.contenttype = '$ctype';\n";
}

// set username
foreach ($content_types as $ctype => $table) {
  $query['usernames'][] = "UPDATE $table c, bolt_users u SET c.username = u.username WHERE u.subsite_id = c.ownerid AND c.subsite = u.subsite;\n";
}

// remove duplicate users by username

$query['user_dedupe'][] = "UPDATE bolt_users u, bolt_users u2
SET
  u.username = concat('dupe-', u.subsite, '-', u.subsite_id, '-', u.username),
  u.email = concat('dupe-', u.subsite, '-', u.subsite_id, '-', u.email)
WHERE
  u.id <> u2.id
  AND u.username = u2.username
  AND u.id > u2.id;
";

$query['user_dedupe'][] = "UPDATE bolt_users u, bolt_users u2
SET
  u.email = concat('dupe-', u.email)
WHERE
  u.id <> u2.id
  AND u.email = u2.email
  AND u.id > u2.id;
";

$query['user_dedupe'][] = "DELETE FROM bolt_users WHERE username like 'dupe-%';\n";

// set userid
foreach ($content_types as $ctype => $table) {
  $query['user_id'][] = "UPDATE $table c, bolt_users u SET c.ownerid = u.id WHERE c.username = u.username;\n";
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
