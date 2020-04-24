<?php

namespace Bolt\Extension\Europeana\ZohoImport;

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
        $this->logger('info', $logmessage, 'zohoimport');

        //Authenticate before starting import of resources
        $this->app['zohoimport.oauth']->authenticate();

        foreach ($this->enabledsources as $name => $config) {
            $this->workingtype = $config['target']['contenttype'];

            // if ffwdsource is set and not the one in this loop iteration
            // continue with the next loop iteration
            if(isset($this->ffwdsource) && $this->ffwdsource === $this->workingtype) {
              $logmessage = $name . ' - ffwd content type to import is: '. $this->workingtype;
              $this->logger('info', $logmessage, 'zohoimport');
            } else if (isset($this->ffwdsource) && $this->ffwdsource !== $this->workingtype) {
              $logmessage = $name . ' - ffwd skipping content type: '. $this->workingtype;
              $this->logger('info', $logmessage, 'zohoimport');

              continue;
            }

            // test if image downloads should be activated
            if ($this->config['image_downloads'] !== true) {
                $logmessage = $name . ' - importing extra images is disabled';
                $this->logger('info', $logmessage, 'zohoimport');
            }

            // initialize content repository
            $this->workingrepository = $this->app['storage']->getRepository($this->workingtype);
            // initialize empty record for cloning
            $this->emptyrecord = $this->workingrepository->create();

            $logmessage = $name . ' - started import - batch: '. $batchdate . ' - '
            . $config['source']['type'];
            $this->logger('info', $logmessage, 'zohoimport');

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
                if ($this->ffwd != null && $this->ffwd >= 1) {
                    // TODO: fast forward to step $this->ffwd
                    $looper = $this->ffwd +1;
                    $previousbatchdate = $this->getLastImportDate($localconfig);
                    $starttime = strtotime($previousbatchdate);
                    $batchdate = $previousbatchdate;
                    $batchdate = $previousbatchdate;
                    $logmessage = $name . ' - fast forward to '
                        . $looper . '. - batch: '. $batchdate . ' - '
                        . $config['source']['type'];
                    $this->logger('info', $logmessage, 'zohoimport');
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
                    $this->logger('info', $logmessage, 'zohoimport');

                    $this->fileFetcher($localconfig);

                    $this->fileNormalizer($localconfig);

                    if ($looper > 100) {
                        $this->endcondition = true;

                        $logmessage = $name . ' -  limit reached - 100 iterations are a bit much, please try to modify this import';
                        $this->logger('warning', $logmessage, 'zohoimport');
                    } elseif ($this->resourcedata == 'nodata') {
                        $this->endcondition = true;

                        $logmessage = $name . ' - found end of data for import';
                        $this->logger('info', $logmessage, 'zohoimport');
                    } else {
                        $numrecords += count($this->resourcedata);
                        $this->saveRecords($name, $localconfig);

                        $time_usage = time();
                        $deltatime = $time_usage - $this->lastbatchtime;
                        $memory_usage = round((memory_get_peak_usage() / 1024) / 1024);
                        $deltamem = $memory_usage - $this->lastbatchmem;
                        $logmessage = $name . ' - step '. $looper. ": " . $localconfig['source']['getparams'][$counter]. ' - '. $localconfig['source']['getparams'][$stepper].' completed. [total '. $memory_usage .' MB] [delta '.$deltamem.' MB] [time '. $deltatime . ' sec]';
                        $this->logger('info', $logmessage, 'zohoimport');

                        $this->lastbatchtime = time();
                        $this->lastbatchmem = $memory_usage;
                        // run garbage collection
                        gc_collect_cycles();
                    }

                    // get the last index
                    // and add the size to it
                    $localconfig['source']['getparams'][$counter] = $localconfig['source']['getparams'][$counter] + $size;
                    $localconfig['source']['getparams'][$stepper] = $localconfig['source']['getparams'][$stepper] + $size;

                    $looper++;
                }

                $logmessage = $name . ' - imported ~ '. $numrecords .' records from paged resource..';
                $this->logger('info', $logmessage, 'zohoimport');
            } elseif (isset($config['source']['files'])) {
                // the import has file paging so lets import every file at once
                $localconfig = $config;
                $numrecords = 0;

                foreach ($config['source']['files'] as $file) {
                    $localconfig['source']['file'] = $file;

                    $logmessage = $name . ' - loading resource from file: ' . $file;
                    $this->logger('info', $logmessage, 'zohoimport');

                    $this->fileFetcher($localconfig);

                    $this->fileNormalizer($localconfig);

                    $numrecords += count($this->resourcedata);
                    if ($this->resourcedata!='nodata') {
                        $this->saveRecords($name, $localconfig);
                    }
                }


                $logmessage = $name . ' - imported '. $numrecords .' records from files resource..';
                $this->logger('info', $logmessage, 'zohoimport');
            } else {
                if($config['source']['pagination'] === true){
                    $pageNumber = 0;
                    $numrecords = 0;

                    // We don't know how many pages there are but attempt to fetch data of page 1 at least.
                    // If there are more pages save fetch and save that data too.
                    do {
                        $pageNumber++;

                        $config['source']['getparams']['page'] = $pageNumber;
                        $this->fileFetcher($config);
                        $this->fileNormalizer($config);

                        $canPaginate = json_decode($this->app['zohoimport.filefetcher']->latestFile())->info->more_records;

                        if ($this->resourcedata!='nodata') {
                            $this->saveRecords($name, $config);
                        }

                        $numrecords = $numrecords + count($this->resourcedata);
                    }while($canPaginate);

                    $logmessage = $name . ' - imported '. $numrecords .' records from paginated resource..';
                    $this->logger('info', $logmessage, 'zohoimport');
                } else {
                    $this->app['zohoimport.filefetcher']->fetchAnyResource($config);
                    $this->fileFetcher($config);
                    $this->fileNormalizer($config);

                    $numrecords = count($this->resourcedata);
                    if ($this->resourcedata!='nodata') {
                        $this->saveRecords($name, $config);
                    }

                    $logmessage = $name . ' - imported '. $numrecords .' records from short resource..';
                    $this->logger('info', $logmessage, 'zohoimport');
                }
            }

            $this->depublishRemovedRecords($name, $config, $batchdate);

            $logmessage = $name . ' - completed import';

            $this->setLastImportDate($batchdate);

            $this->logger('info', $logmessage, 'zohoimport');

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
            $this->logger('info', $logmessage, 'zohoimport');
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

        // TODO: show number of imported items in last batch
        $num_imported_items = 'n/a';

        // TODO: show number of requests in last batch
        $num_remote_request = 'n/a';

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
    private function getPropertyOfRecord($record, $property)
    {

        if (strpos($property, '->') === false) {
            if($record === null){
                return null;
            }
            return $record->{$property};
        }

        $property = explode('->', $property);

        $tempval = $record->{$property[0]};

        return $this->getPropertyOfRecord($tempval, $property[1]);
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
                $this->logger('debug', $logmessage, 'zohoimport');

                $this->currentrecord = clone $this->emptyrecord;

                $items['status'] = $config['target']['defaults']['new'];
                // update datecreated, may be redundant, but lets do it anyway
                $items['datecreated'] = $date;
                // update datechanged, may be redundant, but lets do it anyway
                $items['datechanged'] = $date;
            } else {
                $existing_id = $this->currentrecord->getId();

                $logmessage = $name
                    . ' - updating existing record: ' . $inputrecord->{$uid};
                $this->logger('debug', $logmessage, 'zohoimport');

                $items['status'] = $config['target']['defaults']['updated'];

                // update datechanged, may be redundant, but lets do it anyway
                $items['datechanged'] = $date;
            }

            // update the new values
            foreach ($config['target']['mapping']['fields'] as $key => $value) {

                $var = $this->getPropertyOfRecord($inputrecord, $value);

                // make sure empty values are written
//                if (!array_key_exists($value, $inputrecord) && $key != 'id') {
//                    $this->currentrecord->$value = '';
//                    $var = '';
//                }
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
                        $tempvalue = $this->$callbackname($inputrecord, $this->currentrecord, $hookparams);

                        if ($tempvalue) {
                            // set the new value only if there is a result for the callback
                            $logmessage = $name . ' - hookafterload new value ' . $key;
                            if (is_string($tempvalue)) {
                                $logmessage .= ' - ' . $tempvalue;
                            }
                            $this->logger('debug', $logmessage, 'zohoimport');
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
                            $this->logger('debug', $logmessage, 'zohoimport');
                            $items[$key] = $tempvalue;
                        }
                    }
                    $logmessage = $name . ' - hookafterload refreshing local value ' . $key;
                    $this->logger('debug', $logmessage, 'zohoimport');
                    // check existing
                    $this->currentrecord = $this->workingrepository->findOneBy(
                        ['uid' => $inputrecord->{$uid}]
                    );

                    if (!$this->currentrecord) {
                        $existing_id = false;

                        $logmessage = $name
                            . ' - preparing a new record in hookafterload: ' . $inputrecord->{$uid};
                        $this->logger('debug', $logmessage, 'zohoimport');

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
                        $this->logger('debug', $logmessage, 'zohoimport');

                        $items['status'] = $config['target']['defaults']['updated'];

                        // update datechanged, may be redundant, but lets do it anyway
                        $items['datechanged'] = $date;
                    }
                }
            }
//            sleep(1);
            // if a record has the hide on pro flag set - depublish it by default
            if (array_key_exists('hide_on_pro', $items) && $items['hide_on_pro'] == true) {
                $items['status'] = 'held';
                $logmessage = $name
                    . ' - hiding record on pro: ' . $existing_id . ' - ' . $inputrecord->{$uid};
                $this->logger('debug', $logmessage, 'zohoimport');
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
                $this->logger('warning', $logmessage, 'zohoimport');
                print_r($items);
                var_dump($this->currentrecord);
                die();
            }


            $this->currentrecord->setDateChanged($date);

            $logmessage = $name
                . ' - storing record: ' . $existing_id . ' - ' . $inputrecord->{$uid} . ' on: ' . $date;
            $this->logger('debug', $logmessage, 'zohoimport');

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
        $this->logger('info', $logmessage, 'zohoimport');

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

    /**
     * HOOKAFTERLOAD: Get related records from ZOHO
     * Save it to the filesystem and return the url
     *
     * @param $source_record
     * @param $target_record
     * @param $params
     *
     * @return mixed
     */
    public function loadZohoRelatedRecords($source_record, $target_record, $params) {

        //prepare url
        if (array_key_exists($params['source_field'], $source_record) && !empty($source_record[$params['source_field']])) {
          $params['name'] = $source_record[$params['source_field']];
          $params['source_url'] = str_replace($params['source_field'], $params['name'], $params['source_url']);
          if ($params['name'] == $params['source_url']) {
              $params['name'] = md5($params['name']);
          }
        } elseif (array_key_exists($params['source_field'], $source_record) && empty($source_record[$params['source_field']])) {
          // empty source value - ignore this field
          $logmessage = "loadZohoRelatedRecords has empty value";
          $this->logger('info', $logmessage, 'zohoimport');
          return false;
        } else {
          $logmessage = "loadZohoRelatedRecords has bad config";
          $this->logger('error', $logmessage, 'zohoimport');
          $logmessage = "source record: " . json_encode($source_record);
          $this->logger('error', $logmessage, 'zohoimport');
          $logmessage = "target record: " . json_encode($target_record);
          $this->logger('error', $logmessage, 'zohoimport');
          $logmessage = "params: " . json_encode($params);
          $this->logger('error', $logmessage, 'zohoimport');
          return false;
        }

        // really fetch the file
        $this->app['zohoimport.filefetcher']->fetchRemoteResource($params['source_url']);
        $relationsdata = $this->app['zohoimport.filefetcher']->latestFile();

        $accountid = $source_record[$params['source_field']];
        $logmessage = $accountid . " - relations data url: ". $params['source_url'] ;
        $this->logger('info', $logmessage, 'zohoimport');

        // no file
        if (empty($relationsdata)) {
            $logmessage = $accountid . " - empty relations data: ". $params['source_url'] ;
            $this->logger('error', $logmessage, 'zohoimport');
            return false;
        }

        // no valid image
        if (stristr($relationsdata, 'No records attached to this record id')
          || stristr($relationsdata, 'Unable to process your request')) {
            $logmessage = $accountid . ' - no remote relations data found for:' . $params['name'] . ' at url: ' . $params['source_url'];
            $this->logger('error', $logmessage, 'zohoimport');
            return false;
        }

        $logmessage = 'TODO: Figure out what to do with the following relations .. ';
        $this->logger('info', $logmessage, 'zohoimport');

        $results = json_decode($relationsdata);

        $localconfig = [];
        $localconfig['source']['type'] = 'json';
        $localconfig['target']['mapping']['root'] = 'response.result.Contacts.row';
        $relationsdatanormalized = $this->app['zohoimport.normalizer']->normalizeInput($localconfig, $relationsdata);

        // double check if there are any records
        if ($relationsdatanormalized == 'nodata') {
          $logmessage = $accountid . ' - loadZohoRelatedRecords result: ' . json_encode($relationsdatanormalized);
          $this->logger('debug', $logmessage, 'zohoimport');
          // no records means return something and get out
          return [];
        }

        // load a repository
        if (!$this->workingrepository) {
            $this->workingrepository = $this->app['storage']->getRepository('organisations');
        }

        if (!$this->currentrecord->id) {
            // check existing
            $this->currentrecord = $this->workingrepository->findOneBy(
              ['uid' => $accountid]
            );
        }

        // load a repository
        $relatedrepository = $this->app['storage']->getRepository('persons');

        // get account from database by ACCOUNTID
        $parent_organisation = $this->currentrecord->id;
        $parent_type = 'organisations';
        $target_type = 'persons';

        // delete existing relations
        $this->deleteImportedRelations($parent_organisation, $parent_type, $target_type);

        foreach($relationsdatanormalized as $contact) {
            $target_person_uid = $contact['CONTACTID'];

            // get contact from database by CONTACTID
            $target_record = $relatedrepository->findOneBy(
              ['uid' => $target_person_uid]
            );

            if ($target_record) {
                $target_record_id = $target_record->id;
                // insert relation into database
                $this->insertImportedRelation($parent_organisation, $parent_type, $target_type, $target_record_id);
            }
        }

        // return the filename for record
        return $results;
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
      $this->logger('debug', $logmessage, 'zohoimport');

      return $deleted;
    }

    public function insertImportedRelation($parent_organisation, $parent_type, $target_type, $target_record_id) {

      $insertsql = "INSERT INTO bolt_relations (from_id, from_contenttype, to_id, to_contenttype) VALUES (:parent_organisation, :parent_type, :target_record_id, :target_type)";

      $insertvalues = [
        "parent_organisation" => $parent_organisation,
        "parent_type" => $parent_type,
        "target_type" => $target_type,
        "target_record_id" => $target_record_id
      ];

      $stmt = $this->connection->prepare($insertsql);

      foreach($insertvalues as $label => $value) {
        $stmt->bindValue($label, $value);
      }

      $inserted = $stmt->execute();

      $logmessage = $parent_organisation . ' - adding related person: ' . $target_record_id . ' == ' . $inserted;
      $this->logger('debug', $logmessage, 'zohoimport');

      return $inserted;
    }

    /**
     * HOOKAFTERLOAD: Get a photo from ZOHO
     * Save it to the filesystem and return the url
     *
     * @param $source_record
     * @param $target_record
     * @param $params
     *
     * @return mixed
     */
    public function downloadZohoPhotoFromURL($source_record, $target_record, $params)
    {

        if ($this->config['image_downloads'] != true) {
            return false;
        }

        //prepare url
        if (property_exists($source_record, $params['source_field']) && !empty($source_record->{$params['source_field']})) {
          $params['name'] = $source_record->{$params['source_field']};
          $params['source_url'] = str_replace(
            $params['source_field'],
            $params['name'],
            $params['source_url']
          );
          if ($params['name'] == $params['source_url']) {
            $params['name'] = md5($params['name']);
          }
        } elseif (property_exists($source_record, $params['source_field']) && empty($source_record->{$params['source_field']})) {
            // empty source value - ignore this field
            $logmessage = "downloadZohoPhotoFromURL has empty value";
            $this->logger('info', $logmessage, 'zohoimport');
            return false;
        } else {
            $logmessage = "downloadZohoPhotoFromURL has bad config";
            $this->logger('error', $logmessage, 'zohoimport');
            $logmessage = "source record: " . json_encode($source_record);
            $this->logger('error', $logmessage, 'zohoimport');
            $logmessage = "target record: " . json_encode($target_record);
            $this->logger('error', $logmessage, 'zohoimport');
            $logmessage = "params: " . json_encode($params);
            $this->logger('error', $logmessage, 'zohoimport');
            return false;
        }

        // only fetch photos from contacts that need it
        // if we're looking at the contacts
        if (property_exists($source_record, "Show_photo_on_europeana_site")) {
          if ($source_record->Show_photo_on_europeana_site == 'true') {
            $logmessage = 'show public photo from: ' . $params['source_url'];
            $this->logger('debug', $logmessage, 'zohoimport');
          } elseif ($source_record->Show_photo_on_europeana_site == FALSE || $source_record->Show_photo_on_europeana_site == 'false') {
            //$logmessage = 'no remote photo needed for: ' . $params['source_url'];
            //$this->logger('debug', $logmessage, 'zohoimport');
            return FALSE;
          } else {
            //$logmessage = 'no public photo at: ' . $params['source_url'];
            //$this->logger('debug', $logmessage, 'zohoimport');
            return FALSE;
          }
        }

        // prevent hammering the limits of zoho by only fetching images after minimum of 36 hours
        $existing_image = $target_record->get('image');

        if (empty($existing_image)) {
            $existing_image = [];
            $existing_image['file'] = $params['name'] . '.png';
        }

        if (!is_array($existing_image)) {
            $existing_image_tmp = json_decode($existing_image);
            if (is_array($existing_image_tmp)) {
                $existing_image['file'] = $existing_image_tmp['file'];
                $existing_image['title'] = $existing_image_tmp['title'];
            } elseif (property_exists($existing_image_tmp, 'file')) {
                $existing_image_array['file'] = $existing_image_tmp->file;
                $existing_image_array['title'] = $existing_image_tmp->title;
                $existing_image = $existing_image_array;
            } else {
                $logmessage = "downloading image has failed, " . $existing_image . ' - '. $existing_image_tmp;
                $this->logger('error', $logmessage, 'zohoimport');
                return null;
            }
        }

        if ($existing_image && array_key_exists('file', $existing_image)) {
            $existing_image_path = $this->app['paths']['filespath'] . '/'. $existing_image['file'];
            if (file_exists($existing_image_path)) {
                $existing_image_age = time() - filemtime($existing_image_path);
                if ($existing_image_age < (60*60*36)) {
                    $logmessage = "existing image is still fresh: " . $existing_image_age . " : " . $existing_image_path;
                    $this->logger('debug', $logmessage, 'zohoimport');
                    return false;
                }
            } else {
                $logmessage = 'no existing photo found in local filesystem for:' . $params['name'];
                $this->logger('debug', $logmessage, 'zohoimport');
            }
        } else {
            $logmessage = 'no existing photo set in record:' . $params['name'];
            $this->logger('debug', $logmessage, 'zohoimport');
        }

        $cachepath = $this->app['paths']['cachepath'];
        $image['tmpname'] = $cachepath . '/'. $params['name'];
        $image['id'] = $params['name'];

        if (!file_exists($image['tmpname'])) {
            $logmessage = "fetched remote image for: " . $params['name'] .' - url: '. $params['source_url'] ;
            $this->logger('info', $logmessage, 'zohoimport');

            // really fetch the file
            $this->app['zohoimport.filefetcher']->fetchRemoteResource($params['source_url']);
            $imagedata = $this->app['zohoimport.filefetcher']->latestFile();

            $imagejsonerror = json_decode($imagedata);
            if (!empty($imagejsonerror) && $imagejsonerror !== false) {
                $logmessage = "remote resource is not an image for: " . $params['name'] .' - url: '. $params['source_url'] ;
                $this->logger('info', $logmessage, 'zohoimport');
                $logmessage = 'downloadZohoPhotoFromURL result: ' . json_encode($imagejsonerror);
                $this->logger('debug', $logmessage, 'zohoimport');
                return false;
            }

            // no file
            if (empty($imagedata)) {
                $logmessage = "empty image: ". $params['source_url'] ;
                $this->logger('error', $logmessage, 'zohoimport');
                return false;
            }

            // no valid image
            if (stristr($imagedata, 'No photo attached to this record id')
                || stristr($imagedata, 'Unable to process your request')) {
                $logmessage = 'no remote photo found for:' . $params['name'] . ' at url: ' . $params['source_url'];
                $this->logger('error', $logmessage, 'zohoimport');
                return false;
            }

            $image['size'] = file_put_contents($image['tmpname'], $imagedata);

            unset($imagedata);
        } else {
            // there was a tempfile already
            // it will be cleaned up soon
            $logmessage = 'dangling tempfile for:' . $params['name'] . ' - it should be cleaned up before the next import [' . $image['tmpname'] .']';
            $this->logger('info', $logmessage, 'zohoimport');
            return false;
        }

        $image['type'] = exif_imagetype($image['tmpname']);
        $image['gisz'] = getimagesize($image['tmpname']);
        $image['mime'] = image_type_to_mime_type($image['type']);

        if (strrchr($params['source_url'], '.') == '.svg'
          || pathinfo(parse_url($params['source_url'])['path'], PATHINFO_EXTENSION) == 'svg'
        ) {
          $image['type'] = 0;
          $image['gisz'] = array(
            'width' => '1',
            'height' => '1',
            'type' => 0,
            'attr' => 'width="1" height="1"'
          );
          $image['mime'] = 'image/svg+xml';
        }

        switch ($image['mime']) {
            case 'image/gif':
                $image['extension'] = '.gif';
                break;
            case 'image/png':
                $image['extension'] = '.png';
                break;
            case 'image/jpg':
                $image['extension'] = '.jpg';
                break;
            case 'image/svg+xml':
                $image['extension'] = '.svg';
                break;
            default:
                $image['extension'] = '.jpg';
                break;
        }
        $image['target_name'] = $image['id'] . $image['extension'];
        $image['target_dbname'] = $this->config['image_path'] . '/' . $image['target_name'];
        $image['target_dir'] = $this->app['paths']['filespath'] . '/' . $this->config['image_path'];
        $image['target_path'] = $image['target_dir'] . '/' . $image['target_name'];

        // move the file to real directory
        $imagefile = new File($image['tmpname']);
        $imagefile->move($image['target_dir'], $image['target_name']);

        unset($imagefile);

        $outimage = array('file' => $image['target_dbname'], 'title' => $image['id']);

        $logmessage = 'photo: ' . json_encode($outimage);
        $this->logger('debug', $logmessage, 'zohoimport');
        // return the filename for record
        return $outimage;
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
            $this->logger('error', $errormessage, 'zohoimport');
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

    /**
     * @param $message
     *
     * @param      $message
     * @param null $type
     */
    public function writeconsole($message, $type = null)
    {
        if (!empty($type) && in_array($type, ['info', 'error'])) {
            $message = sprintf('<%s>%s</%s>', $type, $message, $type);
        } elseif (in_array($type, ['warning', 'comment'])) {
            $message = sprintf('<comment>%s</comment>', $message);
        } else {
            $message = sprintf('<fg=cyan;bg=default>%s</>', $message);
        }

        if (!($this->consoleoutput->isVerbose() || $this->consoleoutput->isVeryVerbose())
        && $type == 'debug') {
            // skip all debug messages if not -v or -vv
            return;
        }
        $this->consoleoutput->writeln($message);
    }

    /**
     * Add messages to the bolt log
     * @param        $type
     * @param        $message
     * @param string $event
     * @param null   $context
     */
    public function logger($type, $message, $event = 'zoho', $context = null)
    {

        // show verbose things on console
        if ($this->on_console) {
            $this->writeconsole($message, $type);
        }

        switch ($type) {
            case 'error':
                $this->app['logger.system']->error($message, [
                'event' => $event,
                'context' => $context
                ]);
                break;
            case 'warning':
                $this->app['logger.system']->warning($message, [
                'event' => $event,
                'context' => $context
                ]);
                break;
            case 'debug':
                $this->app['logger.system']->debug($message, [
                'event' => $event,
                'context' => $context
                ]);
                break;
            case 'info':
            default:
                $this->app['logger.system']->info($message, [
                'event' => $event,
                'context' => $context
                ]);
                break;
        }
    }
}
