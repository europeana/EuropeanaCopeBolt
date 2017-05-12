<?php

namespace Bolt\Extension\Europeana\ZohoImport\Parser;

class FileFetcher
{
  private $filedata;
  private $remote_request_counter;
  private $app;
  private $errormessage;

  public function __construct($app) {
    $this->app = $app;
    $this->remote_request_counter = 0;
    $this->errormessage = false;
  }

  /**
   * Check if the resource is a local file or a remote file and fetch it
   */
  public function fetchAnyResource($name, $enabled)
  {
    if($enabled['on_console']) {
      $on_console = $enabled['on_console'];
    } else {
      $on_console = false;
    }

    if(array_key_exists('file', $enabled['source'])) {
      $source = __DIR__."/".$enabled['source']['file'];
      if(file_exists($source)) {
        $this->fetchLocalResource($name, $source);
      }
    } else {
      $source = $enabled['source']['url'];

      if(array_key_exists('getparams', $enabled['source']) && !empty($enabled['source']['getparams'])) {
        $gkeys = [];
        foreach((array) $enabled['source']['getparams'] as $gkey => $gvalue) {
          $gkeys[] = $gkey ."=" . urlencode($gvalue);
        }
        $source .= "?" . join('&', $gkeys);
      }

      if($on_console) {
        echo 'fetching: ' . $name . ' - ' . $source . "\n";
      }

      $this->fetchRemoteResource($name, $source);
    }
    return $this->filedata;
  }

  /**
   * Fetch a local file resource
   */
  private function fetchLocalResource($name, $url) {
    try {
      $data = file_get_contents($url);
      $this->filedata[$name] = $data;
    } catch (RequestException $e) {
      $this->errormessage = 'Error occurred during fetch: ' . $e->getMessage();
    }
  }

  /**
   * Fetch a remote url resource
   */
  private function fetchRemoteResource($name, $url) {
    $curlOptions = array('CURLOPT_CONNECTTIMEOUT' => 5);
    // Set cURL proxy options if there's a proxy
    if ($this->app['config']->get('general/httpProxy')) {
      $curlOptions['CURLOPT_PROXY'] = $this->app['config']->get('general/httpProxy/host');
      $curlOptions['CURLOPT_PROXYTYPE'] = 'CURLPROXY_HTTP';
      $curlOptions['CURLOPT_PROXYUSERPWD'] = $this->app['config']->get('general/httpProxy/user') . ':' . $this->app['config']->get('general/httpProxy/password');
    }

    try {
      if (!isset($this->app['deprecated.php']) || $this->app['deprecated.php']) {
        $data = $this->app['guzzle.client']->get($url, null, $curlOptions)->send()->getBody(true);
      } else {
        $data = $this->app['guzzle.client']->get($url, array(), $curlOptions)->getBody(true);
      }

      $this->countRemoteRequest('image'); // count remote requests to determine if we hit a limit yet

      $this->filedata[$name] = $data;
    } catch (RequestException $e) {
      $this->errormessage = 'Error occurred during fetch: ' . $e->getMessage();
      // make sure we can use this key later
      $this->filedata[$name] = false;
    }
  }

  /**
   * increment remote request counter
   */
  public function countRemoteRequest($name = 'unknown') {
    $this->remote_request_counter++;
  }

  public function remoteRequestCount($name = 'unknown') {
    return $this->remote_request_counter;
  }

  public function errors() {
    return $this->errormessage;
  }
}
