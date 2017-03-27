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
  'persons' => 'bolt_persons',
  'publications' => 'bolt_publications',
  'resources' => 'bolt_resources',
  'structures' => 'bolt_structures',
  'taskforces' => 'bolt_taskforces'
];

foreach($content_types as $type => $table) {
  echo "cp _banner_default.twig _banner_" . $type . ".twig\n";
  echo "cp _title_default.twig _title_" . $type . ".twig\n";
  echo "cp _teaser_default.twig _teaser_" . $type . ".twig\n";
  echo "cp _detail_default.twig _detail_" . $type . ".twig\n";
  #echo "cp listing.twig listing_" . $type . ".twig\n";
  #echo "cp record.twig record_" . str_replace('s.twig', '.twig', $type. '.twig') . "\n";
}
