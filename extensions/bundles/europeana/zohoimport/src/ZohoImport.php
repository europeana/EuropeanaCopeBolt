<?php

namespace Bolt\Extension\Europeana\ZohoImport;

use Symfony\Component\HttpFoundation\File\File;

class ZohoImport
{
    private $app;
    private $config;
    private $resourcedata;
    private $filedata;
    private $enabledsources;
    private $debug_mode;
    private $remote_request_counter;
    private $currentrecord;
    private $emptyrecord;
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
        //dump($this->config);
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

        foreach ($this->enabledsources as $name => $config) {
            if ($this->config['image_downloads'] !== true) {
                $logmessage = $name . ' - importing extra images is disabled';
                $this->logger('info', $logmessage, 'zohoimport');
            }

            // initialize content repository
            $this->workingrepository = $this->app['storage']->getRepository($config['target']['contenttype']);
            // initialize empty record for cloning
            $this->emptyrecord = $this->workingrepository->create();

            $logmessage = $name . ' - started import - batch: '. $batchdate . ' - '
            . $config['source']['type'];
            $this->logger('info', $logmessage, 'zohoimport');

            if (is_array($config['source']['loopparams'])) {
                // the import has paging so lets use that
                $this->endcondition = false;
                $localconfig = $config;

                $counter = $config['source']['loopparams']['counter'];
                $stepper = $config['source']['loopparams']['stepper'];
                $start = $config['source']['loopparams']['start'];
                $size = $config['source']['loopparams']['size'];
                $localconfig['source']['getparams'][$counter] = $start;
                $localconfig['source']['getparams'][$stepper] = $size;
                $looper = 1; // just a counter to see how far we are
                $numrecords = 0;

                $localconfig['on_console'] = $on_console;

                while ($this->endcondition === false) {
                    //$logmessage = $name . ' - step ' . $looper
                    //. ': ' . $localconfig['source']['getparams'][$counter]
                    //. ' - ' . $localconfig['source']['getparams'][$stepper] . ' starting.';
                    //$this->logger('info', $logmessage, 'zohoimport');

                    $this->fileFetcher($localconfig);

                    $this->fileNormalizer($localconfig);

                    if ($looper > 100) {
                        $this->endcondition = true;

                        $logmessage = $name . ' -  limit reached - 100 iterations are a bit much, please try to modify this import';
                        $this->logger('warning', $logmessage, 'zohoimport');
                    } elseif ($this->resourcedata=='nodata') {
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
            } elseif ($config['source']['files']) {
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
                // the import has no paging so lets import everything at once
                $this->fileFetcher($config);

                $this->fileNormalizer($config);

                $numrecords = count($this->resourcedata);
                if ($this->resourcedata!='nodata') {
                    $this->saveRecords($name, $config);
                }

                $logmessage = $name . ' - imported '. $numrecords .' records from short resource..';
                $this->logger('info', $logmessage, 'zohoimport');
            }
            $this->depublishRemovedRecords($name, $config, $batchdate);

            $logmessage = $name . ' - completed import';
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
        $messages[] = 'import took ~ ' . $batchdelta . " seconds";
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
        //dump($config);
        foreach ($config['remotes'] as $remotekey => $remote) {
            //dump($remotekey, $remote);
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
        //dump($this->app);

        if($on_console === true && $output !== null) {
          foreach($messages as $text) {
            $output->writeln(strip_tags(str_replace('</td>', "\t|\t</td>", $text)));
          }
          return null;
        } else {
          return join('', $messages);
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

        if ($config['on_console']) {
            $on_console = $config['on_console'];
        } else {
            $on_console = false;
        }
        $this->currentrecord = false;

        foreach ($this->resourcedata as $inputrecord) {
            $uid = $config['target']['mapping']['fields']['uid'];

            unset($this->currentrecord);
            unset($items);

            //dump('checking:'. $inputrecord[$uid] );
            // check existing
            $this->currentrecord = $this->workingrepository->findOneBy(
                ['uid' => $inputrecord[$uid]]
            );

            if (!$this->currentrecord) {
                  $existing_id = false;

                  $logmessage = $name
                    . ' - preparing a new record: ' . $inputrecord[$uid];
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
                    . ' - updating existing record: ' . $inputrecord[$uid];
                  $this->logger('debug', $logmessage, 'zohoimport');

                  $items['status'] = $config['target']['defaults']['updated'];

                  // update datechanged, may be redundant, but lets do it anyway
                  $items['datechanged'] = $date;
            }

            // update the new values
            foreach ($config['target']['mapping']['fields'] as $key => $value) {
                // make sure empty values are written
                if (!array_key_exists($value, $inputrecord) && $key != 'id') {
                    $this->currentrecord->$value = '';
                    $inputrecord[$value] = '';
                }
                $items[$key] = $inputrecord[$value];
            }

            // add default field values from config
            if (!empty($config['target']['defaults']['fields'])) {
                foreach ($config['target']['defaults']['fields'] as $defaultfield => $defaultvalue) {
                    $items[$defaultfield] = $defaultvalue;
                }
            }

            if (array_key_exists('hookafterload', $config['target']) && is_array($config['target']['hookafterload'])) {

                foreach ($config['target']['hookafterload'] as $key => $hookparams) {
                    //dump('intheloop: '. $key);
                    if ($on_console && $key == 'image') {
                        //echo "hookafterload: ". $key . " - " .$hookparams['callback'] . " | check for: '" . $inputrecord['public_photo'] . "' - " . $inputrecord['source_url'] . "\n";

                        $hookparams['on_console'] = true;
                    }

                    if (!array_key_exists($key, $items) || empty($items[$key])) {
                        // it is a new value for the $items
                        $callbackname = $hookparams['callback'];
                        $tempvalue = $this->$callbackname($inputrecord, $this->currentrecord, $hookparams);

                        if ($tempvalue) {
                           // set the new value only if there is a result for the callback
                           $logmessage = $name
                             . ' hookafterload new value ' . $key . ': '. $tempvalue;
                           $this->logger('debug', $logmessage, 'zohoimport');
                           $items[$key] = $tempvalue;
                        }
                    } else {
                        // it is an existing value for the items
                        $tempvalue = $this->$hookparams['callback']($inputrecord, $this->currentrecord, $hookparams);

                        // set the new value if it is different
                        if ($tempvalue != $items[$key]) {
                            $logmessage = $name
                              . ' hookafterload existing value ' . $key . ': '. $tempvalue;
                            $this->logger('debug', $logmessage, 'zohoimport');
                            $items[$key] = $tempvalue;
                        }
                    }
                }
            }

            //dump('sanitaiton please');
            $sanitize = true;
            if ($sanitize) {
                  $items['structure_sortorder'] = 0;
                  $items['hide_list'] = 0;
                  $items['hide_related'] = 0;
                  $items['support_navigation'] = 0;
                  // clean up some variables for inserting
                if (!empty($items['first_name']) || !empty($items['last_name'])) {
                    $items['slug'] = $this->app['slugify']->slugify($items['first_name'] ." ". $items['last_name']);
                } elseif (!empty($items['title']) || !empty($items['locationtitle'])) {
                    $items['slug'] = $this->app['slugify']->slugify($items['title'] ."-". $items['locationtitle']);
                }

                if (!empty($items['network_participation'])) {
                    $items['network_participation'] = explode(";", $items['network_participation']);
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
            if($existing_id) {
              $items['id'] = $existing_id;
            }
            $this->currentrecord->setValues($items);
            $this->currentrecord->setDateChanged($date);

            $logmessage = $name
              . ' - storing record: ' . $existing_id . ' - ' . $inputrecord[$uid] . ' on: ' . $date;
            $this->logger('debug', $logmessage, 'zohoimport');

            // use storage engine
            $this->app['storage']->save($this->currentrecord);

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

        //dump($config);

        $contenttype = $config['target']['contenttype'];
        $unpublished_status = $config['target']['defaults']['removed'];

        $prefix = $this->app['config']->get('general/database/prefix');
        $tablename = $prefix . $contenttype;

        // dont depublish records that are already depublished
        $query = "UPDATE $tablename SET status = :status WHERE datechanged < :datechanged AND status != :status";
        $stmt = $this->app['db']->prepare($query);
        $stmt->bindValue('status', $unpublished_status);
        $stmt->bindValue('datechanged', $date);
        $res = $stmt->execute();

        //dump($res);
        return true;
    }


  /**
   * getLastImportDate
   *
   * @param $config
   *
   * @return mixed
   */
    private function getLastImportDate($config)
    {
        $contenttype = $config['target']['contenttype'];
        $prefix = $this->app['config']->get('general/database/prefix');
        $tablename = $prefix . $contenttype;
        $query = "SELECT max(datechanged) as maxdate FROM $tablename";
        $stmt = $this->app['db']->prepare($query);
        $res = $stmt->execute();
        $result = $stmt->fetch();
        return $result['maxdate'];
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
        $stmt = $this->app['db']->prepare($query);
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
        $stmt = $this->app['db']->prepare($query);
        $res = $stmt->execute();
        $result = $stmt->fetch();
        return $result['unpublished'];
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
            //$logmessage = "download not enabled: " . $this->config['image_downloads'];
            //$this->logger('debug', $logmessage, 'zohoimport');
            return false;
        }

        //prepare url
        if (array_key_exists($params['source_field'], $source_record) && !empty($source_record[$params['source_field']])) {
            $params['name'] = $source_record[$params['source_field']];
            $params['source_url'] = str_replace($params['source_field'], $params['name'], $params['source_url']);
        } else {
            $logmessage = "downloadZohoPhotoFromURL has bad config";
            $this->logger('error', $logmessage, 'zohoimport');
        }

        // only fetch photos from contacts that need it
        if (array_key_exists("Show photo on europeana site", $source_record) && $source_record["Show photo on europeana site"] == 'true') {
            $logmessage = 'show public photo from: ' . $params['source_url'];
            $this->logger('debug', $logmessage, 'zohoimport');
        } elseif ($source_record["Show photo on europeana site"] == false || $source_record["Show photo on europeana site"] == 'false') {
            //$logmessage = 'no remote photo needed for: ' . $params['source_url'];
            //$this->logger('debug', $logmessage, 'zohoimport');
            return false;
        } else {
            //$logmessage = 'no public photo at: ' . $params['source_url'];
            //$this->logger('debug', $logmessage, 'zohoimport');
            return false;
        }

        // prevent hammering the limits of zoho by only fetching images after minimum of 36 hours
        //dump('here?');
        $existing_image = $target_record->get('image');
        //dump('there! ', $existing_image);

        if (empty($existing_image)) {
            $existing_image['file'] = $params['name'] . '.png';
        }

        if(!is_array($existing_image)) {
          $existing_image_tmp = json_decode($existing_image);
          if(is_array($existing_image_tmp)) {
            $existing_image['file'] = $existing_image_tmp['file'];
            $existing_image['title'] = $existing_image_tmp['title'];
          } elseif (property_exists($existing_image_tmp, 'file')) {
            //dump('maybe fail', $existing_image, $existing_image_tmp);
            $existing_image_array['file'] = $existing_image_tmp->file;
            $existing_image_array['title'] = $existing_image_tmp->title;
            //dump('maybe fail after', $existing_image_array);
            $existing_image = $existing_image_array;
          } else {
            $logmessage = "downloading image has failed, " . $existing_image . ' - '. $existing_image_tmp;
            $this->logger('error', $logmessage, 'zohoimport');
            return null;
          }
        }
        //dump('there again! ', $existing_image);

        if ($existing_image && array_key_exists('file', $existing_image)) {
            $existing_image_path = $this->app['paths']['filespath'] . '/'. $existing_image['file'];
            if (file_exists($existing_image_path)) {
                //$existing_file = new File($existing_image_path);
                //dump($existing_file);
                //$existing_image_info['type'] = exif_imagetype($existing_image_path);
                //$existing_image_info['gisz'] = getimagesize($existing_image_path);
                //$existing_image_info['mime'] = image_type_to_mime_type($existing_image_info['type']);
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
            $logmessage = "fetching remote image for: " . $params['name'] .' - url: '. $params['source_url'] ;
            $this->logger('info', $logmessage, 'zohoimport');

            // really fetch the file
            $this->filedata = $this->app['zohoimport.filefetcher']->fetchRemoteResource($params['source_url']);

            // no file
            if (empty($this->filedata[$params['name']])) {
                $logmessage = "empty image: ". $params['source_url'] ;
                $this->logger('error', $logmessage, 'zohoimport');
                return false;
            }

            // no valid image
            if (stristr($this->filedata[$params['name']], 'No photo attached to this record id')) {
                unset($this->filedata[$params['name']]);

                $logmessage = 'no remote photo found for:' . $params['name'] . ' at url: ' . $params['source_url'];
                $this->logger('error', $logmessage, 'zohoimport');
                return false;
            }

            $image['size'] = file_put_contents($image['tmpname'], $this->filedata[$params['name']]);

            unset($this->filedata[$params['name']]);
        } else {
            // there was a tempfile already
            // it will be cleaned up soon
            $logmessage = 'dangling tempfile for:' . $params['name'] . ' - it will be cleaned up soon';
            $this->logger('info', $logmessage, 'zohoimport');
        }

        $image['type'] = exif_imagetype($image['tmpname']);
        $image['gisz'] = getimagesize($image['tmpname']);
        $image['mime'] = image_type_to_mime_type($image['type']);

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
    private function fileNormalizer($localconfig) {
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
