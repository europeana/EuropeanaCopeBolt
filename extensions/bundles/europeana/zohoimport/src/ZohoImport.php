<?php

namespace Bolt\Extension\Europeana\ZohoImport;

use Exception;
use Symfony\Component\HttpFoundation\File\File;

class ZohoImport
{
    private $app;
    private $config;
    private $connection;
    private $ffwd;
    private $ffwdsource;
    private $resourcedata;
    private $filedata;
    private $enabledsources;
    private $debug_mode;
    private $remote_request_counter;
    private $currentrecord;
    private $emptyrecord;
    private $workingtype;
    private $workingrepository;
    private $on_console;
    private $consoleoutput;
    private $lastbatchtime;
    private $lastbatchmem;
    private $endcondition = false;

    public function __construct($app)
    {
        // set variables that are needed later
        $this->app = $app;
        $this->config = $this->app['zohoimport.config'];
        $this->debug_mode = $this->config['debug_mode'];
        $this->remote_request_counter = 0;
        $this->connection = $this->app['db'];
    }

    /**
     * @param $ffwd
     */
    public function setFfwd($ffwd, $ffwdsource = null)
    {
        if ($ffwd > 0) {
            // pesky off by ones in the steps
            $ffwd = $ffwd - 1;
            $this->ffwd = $ffwd;

            $this->setFfwdSource($ffwdsource);
        }
    }
    /**
     * @param $ffwd
     */
    public function setFfwdSource($ffwdsource)
    {
        if ($ffwdsource !== null) {
            $this->ffwdsource = $ffwdsource;
        } else {
            $this->getEnabledSources();
            $firstconfig = reset($this->enabledsources);
            $this->ffwdsource = $firstconfig['target']['contenttype'];
        }
    }

    /**
     * Run the importer (with debug stuff for development)
     *
     * @param bool $on_console
     * @param null $output
     *
     * @return null
     */
    public function importJob($on_console = false, $output = null)
    {
        if ($on_console) {
            $this->on_console = $on_console;
            $this->consoleoutput = $output;
        }

        $this->getEnabledSources();

        $this->remote_request_counter = 0;
        $starttime = time();
        $batchdate = date('Y-m-d H:i:s', $starttime);
        $this->lastbatchmem = round((memory_get_peak_usage() / 1024) / 1024);
        $this->lastbatchtime = time();

        $logmessage = 'started import at ' . $batchdate;
        $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

        //Authenticate before starting import of resources
        $this->app['zohoimport.oauth']->authenticate();

        foreach ($this->enabledsources as $name => $config) {
            $this->workingtype = $config['target']['contenttype'];

            // if ffwdsource is set and not the one in this loop iteration
            // continue with the next loop iteration
            if (isset($this->ffwdsource) && $this->ffwdsource === $this->workingtype) {
                $logmessage = $name . ' - ffwd content type to import is: ' . $this->workingtype;
                $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
            } else if (isset($this->ffwdsource) && $this->ffwdsource !== $this->workingtype) {
                $logmessage = $name . ' - ffwd skipping content type: ' . $this->workingtype;
                $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

                continue;
            }

            // test if image downloads should be activated
            if ($this->config['image_downloads'] !== true) {
                $logmessage = $name . ' - importing extra images is disabled';
                $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
            }

            // initialize content repository
            $this->workingrepository = $this->app['storage']->getRepository($this->workingtype);
            // initialize empty record for cloning
            $this->emptyrecord = $this->workingrepository->create();

            $logmessage = $name . ' - started import - batch: ' . $batchdate . ' - '
                . $config['source']['type'];
            $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

            if (isset($config['source']['loopparams'])) {
                // the import has paging so lets use that
                $this->endcondition = false;
                $looper = 1; // just a counter to see how far we are
                $localconfig = $config;

                $counter = $config['source']['loopparams']['counter'];
                $stepper = $config['source']['loopparams']['stepper'];
                $start = $config['source']['loopparams']['start'];
                $size = $config['source']['loopparams']['size'];
                $localconfig['source']['getparams'][$counter] = $start;
                $localconfig['source']['getparams'][$stepper] = $size;
                if ($this->ffwd !== null && $this->ffwd >= 1) {
                    $looper = $this->ffwd + 1;
                    $previousbatchdate = $this->getLastImportDate($localconfig);
                    $starttime = strtotime($previousbatchdate);
                    $batchdate = $previousbatchdate;
                    $batchdate = $previousbatchdate;
                    $logmessage = $name . ' - fast forward to '
                        . $looper . '. - batch: ' . $batchdate . ' - '
                        . $config['source']['type'];
                    $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
                    $start = ($this->ffwd * $size) + 1;
                    $end = ($this->ffwd * $size) + $size;
                    $localconfig['source']['getparams'][$counter] = $start;
                    $localconfig['source']['getparams'][$stepper] = $end;
                }
                $numrecords = 0;

                $localconfig['on_console'] = $on_console;

                while ($this->endcondition === false) {
                    $logmessage = $name . ' - step ' . $looper
                        . ': ' . $localconfig['source']['getparams'][$counter]
                        . ' - ' . $localconfig['source']['getparams'][$stepper] . ' starting.';
                    $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

                    $this->fileFetcher($localconfig);
                    $this->fileNormalizer($localconfig);

                    if ($looper > 100) {
                        $this->endcondition = true;

                        $logmessage = $name . ' -  limit reached - 100 iterations are a bit much, please try to modify this import';
                        $this->app['zohoimport.logger']->logger('warning', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
                    } elseif ($this->resourcedata == 'nodata') {
                        $this->endcondition = true;

                        $logmessage = $name . ' - found end of data for import';
                        $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
                    } else {
                        $numrecords += count($this->resourcedata);
                        $this->saveRecords($name, $localconfig);

                        $time_usage = time();
                        $deltatime = $time_usage - $this->lastbatchtime;
                        $memory_usage = round((memory_get_peak_usage() / 1024) / 1024);
                        $deltamem = $memory_usage - $this->lastbatchmem;
                        $logmessage = $name . ' - step ' . $looper . ": " . $localconfig['source']['getparams'][$counter] . ' - ' . $localconfig['source']['getparams'][$stepper] . ' completed. [total ' . $memory_usage . ' MB] [delta ' . $deltamem . ' MB] [time ' . $deltatime . ' sec]';
                        $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

                        $this->lastbatchtime = time();
                        $this->lastbatchmem = $memory_usage;
                        // run garbage collection
                        gc_collect_cycles();
                    }

                    // get the last index and add the size to it
                    $localconfig['source']['getparams'][$counter] = $localconfig['source']['getparams'][$counter] + $size;
                    $localconfig['source']['getparams'][$stepper] = $localconfig['source']['getparams'][$stepper] + $size;

                    $looper++;
                }

                $logmessage = $name . ' - imported ~ ' . $numrecords . ' records from paged resource..';
                $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
            } elseif (isset($config['source']['files'])) {
                // the import has file paging so lets import every file at once
                $localconfig = $config;
                $numrecords = 0;

                foreach ($config['source']['files'] as $file) {
                    $localconfig['source']['file'] = $file;

                    $logmessage = $name . ' - loading resource from file: ' . $file;
                    $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

                    $this->fileFetcher($localconfig);

                    $this->fileNormalizer($localconfig);

                    $numrecords += count($this->resourcedata);
                    if ($this->resourcedata != 'nodata') {
                        $this->saveRecords($name, $localconfig);
                    }
                }


                $logmessage = $name . ' - imported ' . $numrecords . ' records from files resource..';
                $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
            } else {
                if ($config['source']['pagination'] === true) {
                    $pageNumber = 0;
                    $numrecords = 0;

                    if ($this->ffwd !== null && $this->ffwd >= 1) {
                        $pageNumber = $this->ffwd;
                    }

                    // We don't know how many pages there are but attempt to fetch data of page 1 at least.
                    // If there are more pages save fetch and save that data too.
                    do {
                        $pageNumber++;

                        $this->setLastImportDate('Importing from page ' . $pageNumber . ' - ' . $batchdate);

                        $config['source']['getparams']['page'] = $pageNumber;
                        $this->fileFetcher($config);
                        $this->fileNormalizer($config);

                        $canPaginate = json_decode($this->app['zohoimport.filefetcher']->latestFile())->info->more_records;

                        if ($this->resourcedata != 'nodata') {
                            $this->saveRecords($name, $config);
                        }

                        $numrecords = $numrecords + count($this->resourcedata);
                    } while ($canPaginate);

                    $logmessage = $name . ' - imported ' . $numrecords . ' records from paginated resource..';
                    $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
                } else {
                    $this->app['zohoimport.filefetcher']->fetchAnyResource($config);
                    $this->fileFetcher($config);
                    $this->fileNormalizer($config);

                    $numrecords = count($this->resourcedata);
                    if ($this->resourcedata != 'nodata') {
                        $this->saveRecords($name, $config);
                    }

                    $logmessage = $name . ' - imported ' . $numrecords . ' records from short resource..';
                    $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
                }
            }

            if($name != 'zoho_json_remote_orgs'){
                $this->depublishRemovedRecords($name, $config, $batchdate);
            } else {
                $this->depublishRemovedOrganisationsRecords($name, $config, $batchdate);
            }

            $logmessage = $name . ' - completed import';

            $this->setLastImportDate($batchdate);

            $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

            // clear some memory;
            unset($this->resourcedata);
            unset($this->filedata);
        }

        $endtime = time();
        $batchendtime = date('Y-m-d H:i:s', $endtime);
        $batchdelta = $endtime - $starttime;
        $this->remote_request_counter = $this->app['zohoimport.filefetcher']->remoteRequestCount();

        $messages[] = 'depublished removed records..';
        $messages[] = 'finished import at ' . $batchendtime;
        $messages[] = 'the import did ' . $this->remote_request_counter . " remote requests.";
        $messages[] = 'import took ~ ' . $batchdelta . " seconds - including broken batches";
        foreach ($messages as $logmessage) {
            $this->app['zohoimport.logger']->logger('info', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
        }
        unset($messages);
        return $output;
    }

    /**
     * Overview page
     *
     * @param bool $on_console
     * @param null $output
     *
     * @return null|string
     */
    public function zohoImportOverview($on_console = false, $output = null)
    {
        $config = $this->config;

        $messages = [];
        foreach ($config['remotes'] as $remotekey => $remote) {
            if ($remote['enabled']) {
                $localconfig = $remote;
                // show date of last import
                $lastimportdate = $this->getLastImportDate($localconfig);
                // show number of published items
                $num_published_records = $this->getPublishedRecords($localconfig);
                // show number of unpublished items
                $num_unpublished_records = $this->getUnpublishedRecords($localconfig);

                $table = [
                    'head' => [ 'Import', 'amount' ],
                    'data' => [
                        [ 'last run', $lastimportdate ],
                        //[ 'items', $num_imported_items ],
                        //[ 'remote requests', $num_remote_request ],
                        [ 'published records', $num_published_records ],
                        [ 'unpublished records', $num_unpublished_records ]
                    ]
                ];
                $rowoutput = $tableoutput = '';
                foreach ($table['head'] as $cell) {
                    $rowoutput .= '<th>' . $cell . ' </th>';
                }
                $tableoutput .= '<tr>'.$rowoutput."</tr>\n";
                foreach ($table['data'] as $key => $row) {
                    $rowoutput = '';
                    foreach ($row as $cell) {
                        $rowoutput .= '<td>' . $cell . ' </td>';
                    }
                    $tableoutput .= '<tr>'.$rowoutput."</tr>\n";
                }
                $messages[$remotekey] = '<h3>remote: '.$remotekey.'</h3>
                    <table class="table-striped dashboardlisting">'.$tableoutput."</table>\n";
            }
        }

        if ($on_console === true && $output !== null) {
            return null;
        } else {
            return join('', $messages);
        }
    }

    /**
     * @param \stdClass $record
     * @param string $property
     * @return mixed
     */
    private function getPropertyOfRecord(\stdClass $record, $property)
    {

        if (strpos($property, '->') === false) {
            if($record === null){
                return null;
            }
            return $record->{$property};
        }

        $property = explode('->', $property);

        $tempval = $record->{$property[0]};
        if ($tempval !== null)
        {
            return $this->getPropertyOfRecord($tempval, $property[1]);
        }
    }

    /**
     * Save the record for each row
     *
     * @param $name
     * @param $config
     */
    private function saveRecords($name, $config)
    {
        $starttime = time();
        $date = date('Y-m-d H:i:s', $starttime);

        if (isset($config['on_console']) && !empty($config['on_console'])) {
            $on_console = $config['on_console'];
        } else {
            $on_console = false;
        }
        $this->currentrecord = false;

        foreach ($this->resourcedata as $inputrecord) {
            $uid = $config['target']['mapping']['fields']['uid'];

            unset($this->currentrecord);
            unset($items);

            // check existing
            $this->currentrecord = $this->workingrepository->findOneBy(
                ['uid' => $inputrecord->{$uid}]
            );

            if (!$this->currentrecord) {
                $existing_id = false;

                $logmessage = $name
                    . ' - preparing a new record: ' . $inputrecord->{$uid};
                $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

                $this->currentrecord = clone $this->emptyrecord;

                $items['status'] = $config['target']['defaults']['new'];
                // update datecreated, may be redundant, but lets do it anyway
                $items['datecreated'] = $date;
                // update datechanged, may be redundant, but lets do it anyway
                $items['datechanged'] = $date;
            } else {
                $existing_id = $this->currentrecord->getId();

                $logmessage = $name
                    . ' - updating record from remote source page: ' . $config['source']['getparams']['page'];
                $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

                $logmessage = $name
                    . ' - updating existing record: ' . $inputrecord->{$uid};
                $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

                $items['status'] = $config['target']['defaults']['updated'];

                // update datechanged, may be redundant, but lets do it anyway
                $items['datechanged'] = $date;
            }

            // update the new values
            foreach ($config['target']['mapping']['fields'] as $key => $value) {

                $var = $this->getPropertyOfRecord($inputrecord, $value);

                if (is_array($var)) {
                    $var = implode(';', $var);
                }
                // if zoho returns a text with double linebreaks
                // split the text up into paragraphs
                if (strpos($var, "\n\n") !== false) {
                    $var = "<p>" . str_replace("\n\n", "</p><p>", $var) . "</p>";
                }
                // if single linebreaks are left, convert them to <br>
                if (strpos($var, "\n") !== false) {
                    $var = str_replace("\n", "<br>", $var);
                }

                if($key == 'image' && empty($var))
                {
                    $items[$key] = "[]";
                }

                $items[$key] = $var;
            }

            // add default field values from config
            if (!empty($config['target']['defaults']['fields'])) {
                foreach ($config['target']['defaults']['fields'] as $defaultfield => $defaultvalue) {
                    $items[$defaultfield] = $defaultvalue;
                }
            }

            if (array_key_exists('hookafterload', $config['target']) && is_array($config['target']['hookafterload'])) {
                foreach ($config['target']['hookafterload'] as $key => $hookparams) {
                    if ($on_console && $key == 'image') {
                        $hookparams['on_console'] = true;
                    }

                    if (!array_key_exists($key, $items) || empty($items[$key])) {
                        // it is a new value for the $items
                        $callbackname = $hookparams['callback'];
                        $tempvalue = $this->app['zohoimport.downloader']->$callbackname($inputrecord, $this->currentrecord, $hookparams, $on_console, $this->consoleoutput);

                        if ($tempvalue) {
                            // set the new value only if there is a result for the callback
                            $logmessage = $name . ' - hookafterload new value ' . $key;
                            if (is_string($tempvalue)) {
                                $logmessage .= ' - ' . $tempvalue;
                            }
                            $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
                            $items[$key] = $tempvalue;
                        }
                    } else {
                        // it is an existing value for the items
                        $tempvalue = $this->$hookparams['callback']($inputrecord, $this->currentrecord, $hookparams);

                        // set the new value if it is different
                        if ($tempvalue != $items[$key]) {
                            $logmessage = $name . ' - hookafterload existing value ' . $key;
                            if (is_string($tempvalue)) {
                                $logmessage .= ' - ' . $tempvalue;
                            }
                            $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
                            $items[$key] = $tempvalue;
                        }
                    }
                    $logmessage = $name . ' - hookafterload refreshing local value ' . $key;
                    $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
                    // check existing
                    $this->currentrecord = $this->workingrepository->findOneBy(
                        ['uid' => $inputrecord->{$uid}]
                    );

                    if (!$this->currentrecord) {
                        $existing_id = false;

                        $logmessage = $name
                            . ' - preparing a new record in hookafterload: ' . $inputrecord->{$uid};
                        $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

                        $this->currentrecord = clone $this->emptyrecord;

                        $items['status'] = $config['target']['defaults']['new'];
                        // update datecreated, may be redundant, but lets do it anyway
                        $items['datecreated'] = $date;
                        // update datechanged, may be redundant, but lets do it anyway
                        $items['datechanged'] = $date;
                    } else {
                        $existing_id = $this->currentrecord->getId();

                        $logmessage = $name
                            . ' - updating existing record in hookafterload: ' . $inputrecord->{$uid};
                        $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

                        $items['status'] = $config['target']['defaults']['updated'];

                        // update datechanged, may be redundant, but lets do it anyway
                        $items['datechanged'] = $date;
                    }
                }
            }

            // if a record has the hide on pro flag set - depublish it by default
            if (array_key_exists('hide_on_pro', $items) && $items['hide_on_pro'] === true) {
                $items['status'] = 'held';
                $logmessage = $name
                    . ' - hiding record on pro: ' . $existing_id . ' - ' . $inputrecord->{$uid};
                $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
            }

            $sanitize = true;
            if ($sanitize) {
                $items['structure_sortorder'] = 0;
                $items['hide_list'] = 0;
                $items['hide_related'] = 0;
                $items['support_navigation'] = 0;
                // clean up some variables for inserting
                if (!empty($items['first_name']) || !empty($items['last_name'])) {
                    $items['slug'] = $this->app['slugify']->slugify($items['first_name'] . " " . $items['last_name']);
                } elseif (!empty($items['name'])) {
                    $items['slug'] = $this->app['slugify']->slugify($items['name']);
                } elseif (!empty($items['title']) || !empty($items['locationtitle'])) {
                    $items['slug'] = $this->app['slugify']->slugify($items['title'] . "-" . $items['locationtitle']);
                } else {
                    $items['slug'] = $this->app['slugify']->slugify($items['uid']);
                }

                if (!empty($items['network_participation'])) {
                    $items['network_participation'] = explode(";", $items['network_participation']);
                }

                if (!empty($items['org_role'])) {
                    $items['org_role'] = explode(";", $items['org_role']);
                }


                if (!empty($items['community'])) {
                    $items['community'] = explode(";", $items['community']);
                }

                if (!empty($items['twitter'])) {
                    if (stristr($items['twitter'], 'http://twitter.com/')) {
                        $items['twitter'] = str_replace('http://twitter.com/', 'https://twitter.com/', $items['twitter']);
                    } elseif (!stristr($items['twitter'], 'https://twitter.com/')) {
                        $items['twitter'] = 'https://twitter.com/' . trim($items['twitter']);
                    }
                }
            }


            // Store the data array into the record
            // reset the existing id if it was there before
            if ($existing_id) {
                $items['id'] = $existing_id;
            }
            if ($this->currentrecord && is_array($items)) {
                $this->currentrecord->setValues($items);
            } else {
                $logmessage = $name
                    . ' - Sorry, the import can not save an empty record: ' . $existing_id . ' - ' . $inputrecord->{$uid} . ' exiting import.';
                $this->app['zohoimport.logger']->logger('warning', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);
                throw new Exception($logmessage);
            }


            $this->currentrecord->setDateChanged($date);

            $logmessage = $name
                . ' - storing record: ' . $existing_id . ' - ' . $inputrecord->{$uid} . ' on: ' . $date;
            $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $this->consoleoutput);

            // save relations for after the save because the save action will try to invert it partially
            $relations = [];
            $tmprel = [];
            if ($this->currentrecord->relation) {
                foreach ($this->currentrecord->relation as $relation) {
                    $relation_id_before = $relation->getId();
                    $tmprel = [
                        'from_contenttype' => $relation->from_contenttype,
                        'from_id' => $relation->from_id,
                        'to_contenttype' => $relation->to_contenttype,
                        'to_id' => $relation->to_id
                    ];
                    $relations[$relation_id_before] = $tmprel;
                }
            }

            if($this->currentrecord->get('image') == ""){
                $this->currentrecord->set('image', []);
            }

            // use storage engine entity manager
            $this->app['storage']->save($this->currentrecord);

            // update the broken relations after the save so everything is correct again
            if (!empty($relations)) {
                foreach ($relations as $relation_id => $relation) {
                    $res = $this->app['db']->update('bolt_relations', $relation, array('id' => $relation_id));
                }
            }
            $relations = [];
            $tmprel = [];

            // make the things smaller for the memory footprint
            $inputrecord = null;
            $items = null;
            $this->currentrecord = null;
        }
    }

    /**
     * Depublish all records in a contenttype if they are not present in the current feed
     *
     * @param $name
     * @param $config
     * @param $date
     *
     * @return bool
     */
    private function depublishRemovedRecords($name, $config, $date)
    {
        $logmessage = $name . ' - depublishing all removed records on date: ' . $date;
        $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $this->on_console, $this->consoleoutput);

        $contenttype = $config['target']['contenttype'];
        $unpublished_status = $config['target']['defaults']['removed'];

        $prefix = $this->app['config']->get('general/database/prefix');
        $tablename = $prefix . $contenttype;

        // dont depublish records that are already depublished
        $query = "UPDATE $tablename SET status = :status WHERE datechanged < :datechanged AND status != :status";
        $stmt = $this->connection->prepare($query);
        $stmt->bindValue('status', $unpublished_status);
        $stmt->bindValue('datechanged', $date);
        $res = $stmt->execute();

        return true;
    }

    /**
     * Depublish all records in Organisations contenttype if they are not present in the current feed
     * and keep the Sponsor type Organisation published.
     * Organisation of type Sponsor has org_role empty.
     *
     * @param $name
     * @param $config
     * @param $date
     *
     * @return bool
     */
    private function depublishRemovedOrganisationsRecords($name, $config, $date)
    {
        $logmessage = $name . ' - depublishing all removed Organisations records on date: ' . $date;
        $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $this->on_console, $this->consoleoutput);

        $contenttype = $config['target']['contenttype'];
        $unpublished_status = $config['target']['defaults']['removed'];

        $prefix = $this->app['config']->get('general/database/prefix');
        $tablename = $prefix . $contenttype;

        // dont depublish records that are already depublished
        $query = "UPDATE $tablename SET status = :status WHERE datechanged < :datechanged AND status != :status AND org_role != ''";
        $stmt = $this->connection->prepare($query);
        $stmt->bindValue('status', $unpublished_status);
        $stmt->bindValue('datechanged', $date);
        $res = $stmt->execute();

        return true;
    }

    /**
     * setLastImportDate saves the last successfull import to the current start of the batch
     */
    private function setLastImportDate($timestamp)
    {
        // save the timestamp to the 'app/config/extensions/zohoimport_lock_local.yml' file
        $filesystem = $this->app['filesystem']->getFilesystem('extensions_config');
        $path = 'zohoimport_lock_local.yml';
        $file = $filesystem->getFile($path);
        if ($file->exists($path)) {
            $filesystem->put($path, $timestamp);
        } else {
            $filesystem->write($path, $timestamp);
        }
    }

    /**
     * getLastImportDate
     *
     * @param $config
     *
     * @return mixed
     */
    private function getLastImportDate($config = false)
    {
        // save the timestamp to the 'app/config/extensions/zohoimport_lock_local.yml' file
        $timestamp = null;
        $filesystem = $this->app['filesystem']->getFilesystem('extensions_config');
        $path = 'zohoimport_lock_local.yml';
        $file = $filesystem->getFile($path);
        if ($file->exists($path)) {
            $timestamp = $filesystem->read($path);
        } else {
            $timestamp = date('Y-m-d H:i:s', time());
        }

        return $timestamp;
    }


    /**
     * getPublishedRecords
     *
     * @param $config
     *
     * @return mixed
     */
    private function getPublishedRecords($config)
    {
        $contenttype = $config['target']['contenttype'];
        $prefix = $this->app['config']->get('general/database/prefix');
        $tablename = $prefix . $contenttype;
        $query = "SELECT count(id) as published FROM $tablename WHERE status = 'published'";
        $stmt = $this->connection->prepare($query);
        $res = $stmt->execute();
        $result = $stmt->fetch();
        return $result['published'];
    }

    /**
     * getUnpublishedRecords
     *
     * @param $config
     *
     * @return mixed
     */
    private function getUnpublishedRecords($config)
    {
        $contenttype = $config['target']['contenttype'];
        $prefix = $this->app['config']->get('general/database/prefix');
        $tablename = $prefix . $contenttype;
        $query = "SELECT count(id) as unpublished FROM $tablename WHERE status <> 'published'";
        $stmt = $this->connection->prepare($query);
        $res = $stmt->execute();
        $result = $stmt->fetch();
        return $result['unpublished'];
    }

    public function deleteImportedRelations($parent_organisation, $parent_type, $target_type) {
        // clear contacts for ACCOUNTID

        $deletesql = "DELETE FROM bolt_relations WHERE from_id = :parent_organisation AND from_contenttype = :parent_type AND to_contenttype = :target_type";

        $deletevalues = [
            "parent_organisation" => $parent_organisation,
            "parent_type" => $parent_type,
            "target_type" => $target_type
        ];

        $stmt = $this->connection->prepare($deletesql);

        foreach($deletevalues as $label => $value) {
            $stmt->bindValue($label, $value);
        }

        $deleted = $stmt->execute();

        $logmessage = $parent_organisation . ' - refreshing relations for current organisation id: ' . $parent_organisation . ' [' . $deleted . ']';
        $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $this->on_console, $this->consoleoutput);

        return $deleted;
    }

    /**
     * Read resources from config
     *
     * @param bool $name
     *
     * @return array|bool|mixed
     */
    private function getEnabledSources($name = false)
    {
        // only load it if it's empty
        if (empty($this->enabled)) {
            $this->enabledsources = [];

            foreach ($this->config['remotes'] as $key => $source) {
                if ($source['enabled'] === true) {
                    $this->enabledsources[$key] = $source;
                }
            }
        }

        if ($name!==false) {
            if (!empty($this->enabledsources[$name])) {
                return $this->enabledsources[$name];
            } else {
                return false;
            }
        }

        return $this->enabledsources;
    }

    /**
     * Magically fetch a remote resource
     *
     * @param $localconfig
     */
    private function fileFetcher($localconfig)
    {
        $this->app['zohoimport.filefetcher']->fetchAnyResource($localconfig);
        $this->filedata = $this->app['zohoimport.filefetcher']->latestFile();

        if ($errormessage = $this->app['zohoimport.filefetcher']->errors()) {
            $this->app['zohoimport.logger']->logger('error', $errormessage, 'zohoimport', null, $this->on_console, $this->consoleoutput);
        }
    }

    /**
     * Magically normalize a file structure to an array of records
     *
     * @param $localconfig
     */
    private function fileNormalizer($localconfig)
    {
        $this->resourcedata = $this->app['zohoimport.normalizer']->normalizeInput($localconfig, $this->app['zohoimport.filefetcher']->latestFile());
    }
}