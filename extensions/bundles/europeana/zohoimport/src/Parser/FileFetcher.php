<?php

namespace Bolt\Extension\Europeana\ZohoImport\Parser;

use GuzzleHttp\Exception\RequestException;

class FileFetcher
{
    private $app;
    private $latestfile;
    private $remote_request_counter;
    private $errormessage;

    public function __construct($app)
    {
        $this->app = $app;
        $this->remote_request_counter = 0;
        $this->errormessage = false;
    }

    /**
     * Check if the resource is a local file or a remote file and fetch it
     */
    public function fetchAnyResource($enabled)
    {

        if (isset($enabled['source']['file'])) {
            $source = __DIR__."/".$enabled['source']['file'];
            $this->app['zohoimport']->logger('debug', 'fetching local file: ' . $source, 'zohoimport');
            if (file_exists($source)) {
                $this->fetchLocalResource($source);
            }
        } else {
            $source = $enabled['source']['url'];

            if (array_key_exists('getparams', $enabled['source']) && !empty($enabled['source']['getparams'])) {
                $gkeys = [];
                foreach ((array) $enabled['source']['getparams'] as $gkey => $gvalue) {
                    $gkeys[] = $gkey ."=" . urlencode($gvalue);
                }
                $source .= "?" . join('&', $gkeys);
            }
            $this->app['zohoimport']->logger('info', 'fetching remote file: ' . $source, 'zohoimport');
            $this->fetchRemoteResource($source);
        }
        return true;
    }

    /**
     * Fetch a local file resource
     */
    private function fetchLocalResource($url)
    {
        try {
            $data = file_get_contents($url);
            $this->latestfile = $data;
        } catch (RequestException $e) {
            $this->errormessage = 'Error occurred during local fetch: ' . $e->getMessage();
            $this->latestfile = false;
        }
    }

    /**
     * Fetch a remote url resource
     */
    public function fetchRemoteResource($url)
    {
        // $curlOptions = array('CURLOPT_CONNECTTIMEOUT' => 5);
        // Set cURL proxy options if there's a proxy
        if ($this->app['config']->get('general/httpProxy')) {
            $curlOptions['CURLOPT_PROXY'] = $this->app['config']->get('general/httpProxy/host');
            $curlOptions['CURLOPT_PROXYTYPE'] = 'CURLPROXY_HTTP';
            $curlOptions['CURLOPT_PROXYUSERPWD'] = $this->app['config']->get('general/httpProxy/user') . ':' . $this->app['config']->get('general/httpProxy/password');
        }

        // When token has expired reauthenticate
        if($this->app['zohoimport.oauth']->getExpiresInDatetime() <= new \DateTime('now')){
            echo "oAuthToken has expired. Reauthenticate";
            $this->app['zohoimport.oauth']->authenticate();
        }

        $curlOptions['headers'] = [
            'Authorization' => 'Zoho-oauthtoken ' . $this->app['zohoimport.oauth']->getOAuthToken()
        ];

        try {
            if (!isset($this->app['deprecated.php']) || $this->app['deprecated.php']) {
                $data = $this->app['guzzle.client']->request('GET', $url, $curlOptions)->getBody(true)->getContents();
            } else {
                $data = $this->app['guzzle.client']->request('GET', $url, $curlOptions)->getBody(true)->getContents();
            }

            $this->countRemoteRequest(); // count remote requests to determine if we hit a limit yet
            $this->latestfile = $data;
        } catch (RequestException $e) {
            $this->errormessage = 'Error occurred during remote fetch: ' . $e->getMessage();
            $this->latestfile = false;
        }

        return true;
    }

    /**
     * increment remote request counter
     */
    public function countRemoteRequest()
    {
        $this->remote_request_counter++;
    }

    public function remoteRequestCount()
    {
        return $this->remote_request_counter;
    }

    public function latestFile()
    {
        return $this->latestfile;
    }

    public function errors()
    {
        return $this->errormessage;
    }
}
