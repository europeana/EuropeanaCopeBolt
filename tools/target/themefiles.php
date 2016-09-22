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

foreach($content_types as $type => table) {

  echo "cp listing.twig listing_" . $type . ".twig\n";
  echo "cp record.twig record_" . str_replace('s.twig', '.twig', $type. '.twig') . "\n";
}
