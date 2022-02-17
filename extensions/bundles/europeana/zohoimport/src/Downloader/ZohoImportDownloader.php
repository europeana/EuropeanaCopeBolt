<?php

namespace Bolt\Extension\Europeana\ZohoImport\Downloader;

use Symfony\Component\HttpFoundation\File\File;

class ZohoImportDownloader
{
    private $app;
    /**
     * @var mixed
     */
    private $config;

    /**
     * ZohoImportDownloader constructor.
     * @param $app
     */
    public function __construct ($app)
    {
        $this->app = $app;
        $this->config = $this->app['zohoimport.config'];
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
    public function downloadZohoPhotoFromURL($source_record, $target_record, $params, $on_console, $consoleoutput)
    {

        if ($this->config['image_downloads'] !== true) {
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
            $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
            return false;
        } else {
            $logmessage = "downloadZohoPhotoFromURL has bad config";
            $this->app['zohoimport.logger']->logger('error', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
            $logmessage = "source record: " . json_encode($source_record);
            $this->app['zohoimport.logger']->logger('error', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
            $logmessage = "target record: " . json_encode($target_record);
            $this->app['zohoimport.logger']->logger('error', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
            $logmessage = "params: " . json_encode($params);
            $this->app['zohoimport.logger']->logger('error', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
            return false;
        }

        // only fetch photos from contacts that need it
        // if we're looking at the contacts
        if (property_exists($source_record, "Show_photo_on_europeana_site")) {
            if ($source_record->Show_photo_on_europeana_site == 'true') {
                $logmessage = 'show public photo from: ' . $params['source_url'];
                $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
            } elseif ($source_record->Show_photo_on_europeana_site == FALSE || $source_record->Show_photo_on_europeana_site == 'false') {
                return FALSE;
            } else {
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
                $this->app['zohoimport.logger']->logger('error', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
                return null;
            }
        }

        if ($existing_image && array_key_exists('file', $existing_image)) {
            $existing_image_path = $this->app['paths']['filespath'] . '/'. $existing_image['file'];
            if (file_exists($existing_image_path)) {
                $existing_image_age = time() - filemtime($existing_image_path);
                if ($existing_image_age < (60*60*36)) {
                    $logmessage = "existing image is still fresh: " . $existing_image_age . " : " . $existing_image_path;
                    $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
                    return false;
                }
            } else {
                $logmessage = 'no existing photo found in local filesystem for:' . $params['name'];
                $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
            }
        } else {
            $logmessage = 'no existing photo set in record:' . $params['name'];
            $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
        }

        $cachepath = $this->app['paths']['cachepath'];
        $image['tmpname'] = $cachepath . '/'. $params['name'];
        $image['id'] = $params['name'];

        if (!file_exists($image['tmpname'])) {
            $logmessage = "fetched remote image for: " . $params['name'] .' - url: '. $params['source_url'] ;
            $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);

            // really fetch the file
            $this->app['zohoimport.filefetcher']->fetchRemoteResource($params['source_url']);
            $imagedata = $this->app['zohoimport.filefetcher']->latestFile();

            $imagejsonerror = json_decode($imagedata);
            if (!empty($imagejsonerror) && $imagejsonerror !== false) {
                $logmessage = "remote resource is not an image for: " . $params['name'] .' - url: '. $params['source_url'] ;
                $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
                $logmessage = 'downloadZohoPhotoFromURL result: ' . json_encode($imagejsonerror);
                $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
                return false;
            }

            // no file
            if (empty($imagedata)) {
                $logmessage = "empty image: ". $params['source_url'] ;
                $this->app['zohoimport.logger']->logger('error', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
                return false;
            }

            // no valid image
            if (stristr($imagedata, 'No photo attached to this record id')
                || stristr($imagedata, 'Unable to process your request')) {
                $logmessage = 'no remote photo found for:' . $params['name'] . ' at url: ' . $params['source_url'];
                $this->app['zohoimport.logger']->logger('error', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
                return false;
            }

            $image['size'] = file_put_contents($image['tmpname'], $imagedata);

            unset($imagedata);
        } else {
            // there was a tempfile already
            // it will be cleaned up soon
            $logmessage = 'dangling tempfile for:' . $params['name'] . ' - it should be cleaned up before the next import [' . $image['tmpname'] .']';
            $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
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
        $this->app['zohoimport.logger']->logger('debug', $logmessage, 'zohoimport', null, $on_console, $consoleoutput);
        // return the filename for record
        return $outimage;
    }
}
