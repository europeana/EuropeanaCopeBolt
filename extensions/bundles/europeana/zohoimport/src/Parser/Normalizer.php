<?php

namespace Bolt\Extension\Europeana\ZohoImport\Parser;

use SimpleXMLElement;
use mjohnson\utility\TypeConverter as TypeConverter;

class Normalizer
{
    private $app;
    private $data;
    private $config;
    private $debug_mode;

    public function __construct($app)
    {
        $this->app = $app;
        $this->config = $this->app['zohoimport.config'];
        $this->debug_mode = array_key_exists('debug_mode', $this->config)?$this->config['debug_mode']:null;
        require_once (dirname(__DIR__) . '/TypeConverter/TypeConverter.php');
    }

    /**
     * Parse a string into a usable php structure
     *
     * @param $filedata
     *
     * @return mixed
     */
    public function normalizeInput($localconfig, $filedata)
    {
        $this->config = $localconfig;

        if ($this->config['source']['type'] == 'json') {
            $this->normalizeFromZohoJson($filedata);
        } elseif ($this->config['source']['type'] == 'plainjson') {
            $this->normalizeFromJson($filedata);
        } elseif ($this->config['source']['type'] == 'xml') {
            $this->normalizeFromXml($filedata);
        } elseif ($this->config['source']['type'] == 'simplexml') {
            // this returns an array of simplexml objects for the nodes in the root
            // it is unused
            $this->normalizeFromSimpleXML($filedata);
        } else {
            $logmessage = 'Error occurred during normalize: ' . $this->config['source']['type'];
            //$this->logger('info', $logmessage, 'zohoimport');
            dump($logmessage);
            die();
        }

        return $this->data;
    }

    /**
     * Parse a nice json string into a usable php structure
     *
     * @param $filedata
     *
     * @return mixed
     */
    private function normalizeFromJson($filedata)
    {
        $doc = json_decode($filedata);
        $values = [];
        $items = TypeConverter::toArray($doc);

        // get down into the root element
        $root = $this->config['target']['mapping']['root'];
        $elements = explode('.', $root);

        foreach ($elements as $elm) {
            $items = $items[$elm];
        }

        // Modify deep nested json objects
        $test = reset($items);
        if (!TypeConverter::isArray($test)) {
            foreach ($items as $value) {
                $value = TypeConverter::toArray($value);
                $value = $this->convertNulls($value);
                $values[] = $value;
                unset($value);
            }
            $items = $values;
        }
        $this->data = $items;
        return $doc;
    }

    /**
     * Parse a json string into a usable php structure
     *
     * @param $filedata
     *
     * @return mixed
     */
    private function normalizeFromZohoJson($filedata)
    {
        $doc = json_decode($filedata);
        $outrows = $outrow = [];

        if (empty($doc)) {
            if ($this->debug_mode) {
            }
            die();
        }

        $items = TypeConverter::toArray($doc);

        // get down into the root element
        $root = $this->config['target']['mapping']['root'];
        $elements = explode('.', $root);

        if ($elements[0] == 'response' && !$items['data']) {
            array_shift($elements);
        }

        if (array_key_exists('nodata', $items['data']) && is_array($items['data']['nodata'])) {
            $this->data = 'nodata';
            return $doc;
        }

        if (array_key_exists('error', $items['data'])) {
            // we might get an error code https://www.zoho.com/crm/help/api/error-messages.html
            if ($this->debug_mode) {
                dump('error in $items');
                dump($doc);
                dump($items);
            }
            // exit the importer gracefully
            $this->data = 'nodata';
            return $doc;
        }

        foreach ($elements as $elm) {
            if(array_key_exists($elm, $items)) {
                $items = $items[$elm];
            }
        }

        if (empty($items)) {
            if ($this->debug_mode) {
                dump('empty $items');
                dump($doc);
                dump($items);
            }
            // exit the importer gracefully
            $this->data = 'nodata';
            return $doc;
        }

        // Modify deep nested json objects
        // $test = reset($items);
        // //print_r($test);
        // //print_r($items);
        // if (!is_array($test) && !array_key_exists('no', $items)) {
        //     foreach ($items as $rawzohoitem) {
        //         if (isset($rawzohoitem->FL) && is_array($rawzohoitem->FL)) {
        //             $currentrow = $rawzohoitem->FL;
        //             foreach ($currentrow as $rowitem) {
        //                 $outrow[$rowitem->val] = $rowitem->content;
        //             }
        //         }

        //         $outrows[] = $outrow;
        //         unset($outrow);
        //     }
        // } else {
        //   // echo "only one item";
        //   $currentrow = $items['FL'];
        //   // print_r($currentrow);
        //   foreach ($currentrow as $rowitem) {
        //     $outrow[$rowitem->val] = $rowitem->content;
        //   }
        //   $outrows[] = $outrow;
        // }

        $this->data = $items;
        return $this->data;

    }


    /**
     * Parse an xml string into a usable php structure
     *
     * @param $filedata
     *
     * @return mixed
     */
    private function normalizeFromXml($filedata)
    {
        $doc = new SimpleXMLElement($filedata);

        $items = TypeConverter::xmlToArray($doc, TypeConverter::XML_MERGE);

        // get down into the root element
        $root = $this->config['target']['mapping']['root'];
        $elements = explode('/', str_replace('//', '', $root));
        if ($elements[0] == 'response' && !$items['response']) {
            array_shift($elements);
        }

        if (array_key_exists('nodata', $items['response']) && is_array($items['response']['nodata'])) {
            $this->data = 'nodata';
            return $doc;
        }

        foreach ($elements as $elm) {
            $items = $items[$elm];
        }

        $items = $this->flattenZOHO($items);

        $this->data = $items;
        return $doc;
    }

    /**
     * Flatten the array values in a record that comes from ZOHO
     *
     * This specifically gets the key => data pairs
     * in the subkey FL to the top level of a row
     *
     * from
     *   $array[$i]['FL'][$j][val=>'key',(value|content)=>'data']
     * into
     *   $array[$i][key]=data
     *
     * @param $inarray
     *
     * @return array
     */
    private function flattenZOHO($inarray)
    {
        $test = reset($inarray);
        $outarray = [];
        if (array_key_exists('FL', $test)) {
            foreach ($inarray as $row) {
                $outrow = null;
                foreach ($row['FL'] as $fk => $fv) {
                    $outrow[$fv['val']] = $fv['value']?trim($fv['value']):trim($fv['content']);
                }
                $outarray[] = $outrow;
            }
        }

        return $outarray;
    }

    /**
     * Parse an xml string into a usable php structure with simplexml
     *
     * @param $filedata
     *
     * @return \SimpleXMLElement
     */
    private function normalizeFromSimpleXML($filedata)
    {
        $doc = new SimpleXMLElement($filedata);
        $root = $this->config['target']['mapping']['root'];
        $items = $doc->xpath($root);
        $this->data = $items;
        return $doc;
    }

    /**
     * @param $array
     *
     * @return mixed
     */
    public function convertNulls($array)
    {
        foreach ($array as $key => $value) {
            if ($value === null) {
                $array[$key] = '';
            }
        }
        return $array;
    }
}
