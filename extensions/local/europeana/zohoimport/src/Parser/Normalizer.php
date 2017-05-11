<?php

namespace Bolt\Extension\Europeana\ZohoImport\Parser;

use Bolt\Extension\Europeana\ZohoImport\ZohoImport;
use SimpleXMLElement;
use mjohnson\utility\TypeConverter as TypeConverter;

class Normalizer
{
  private $data;
  private $filedata;
  private $config;
  private $debug_mode;

  function __construct($data, $filedata, $config) {
    $this->data = $data;
    $this->filedata = $filedata;
    $this->config = $config;
    $this->debug_mode = $this->config['debug_mode'];
  }

  /**
   * Parse a string into a usable php structure
   */
  public function normalizeInput($name)
  {
    if($this->config['source']['type'] == 'json') {
      $this->normalizeFromZohoJson($name);
    } elseif($this->config['source']['type'] == 'plainjson') {
      $this->normalizeFromJson($name);
    } elseif($this->config['source']['type'] == 'xml') {
      $this->normalizeFromXml($name);
    } elseif($this->config['source']['type'] == 'simplexml') {
      // this returns an array of simplexml objects for the nodes in the root
      // it is unused
      $this->normalizeFromSimpleXML($name);
    } else {
      $logmessage = 'Error occurred during normalize: ' . $name . ' - ' . $this->config['source']['type'];
      $this->logger('info', $logmessage, 'zohoimport');
    }

    return $this->data;
    // dump($this->resourcedata[$name]);
  }

  /**
   * Parse a nice json string into a usable php structure
   */
  private function normalizeFromJson($name)
  {
    $doc = json_decode($this->filedata[$name]);

    $items = TypeConverter::toArray($doc);

    // get down into the root element
    $root = $this->config['target']['mapping']['root'];
    $elements = explode('\.', $root);

    foreach($elements as $elm) {
      $items = $items[$elm];
    }

    // Modify deep nested json objects
    $test = reset($items);
    if(!TypeConverter::isArray($test)) {
      foreach($items as $value) {
        $value = TypeConverter::toArray($value);
        $value = $this->convertNulls($value);
        $values[] = $value;
        unset($value);
      }
      $items = $values;
    }
    $this->data[$name] = $items;
    return $doc;
  }

  /**
   * Parse a json string into a usable php structure
   */
  private function normalizeFromZohoJson($name)
  {
    $doc = json_decode($this->filedata[$name]);

    if(empty($doc)) {
      if($this->debug_mode) {
        dump('empty $doc');
        dump($doc);
      }
      die();
    }

    if($this->config['on_console']) {
      $on_console = $this->config['on_console'];
    } else {
      $on_console = false;
    }

    $items = TypeConverter::toArray($doc);

    // get down into the root element
    $root = $config['target']['mapping']['root'];
    $elements = explode('\.', $root);
    if($elements[0] == 'response' && !$items['response']) {
      array_shift($elements);
    }

    if(array_key_exists('nodata', $items['response']) && is_array($items['response']['nodata'])) {
      $this->data[$name] = 'nodata';
      return $doc;
    }

    foreach($elements as $elm) {
      $items = $items[$elm];
    }

    if(empty($items)) {
      if($this->debug_mode) {
        dump('empty $items');
        dump($doc);
        dump($items);
      }
      die();
    }

    // Modify deep nested json objects
    $test = reset($items);
    if(!is_array($test)) {
      foreach($items as $rawzohoitem) {
        if(isset($rawzohoitem->FL) && is_array($rawzohoitem->FL)) {
          $currentrow = $rawzohoitem->FL;
          foreach($currentrow as $rowitem) {
            $outrow[$rowitem->val] = $rowitem->content;
          }
        }

        $outrows[] = $outrow;
        unset($outrow);
      }
    }

    $this->data[$name] = $outrows;
    return $doc;
  }


  /**
   * Parse an xml string into a usable php structure
   */
  private function normalizeFromXml($name)
  {
    $doc = new SimpleXMLElement($this->filedata[$name]);

    $items = TypeConverter::xmlToArray($doc, TypeConverter::XML_MERGE);

    // get down into the root element
    $root = $this->config['target']['mapping']['root'];
    $elements = explode('/', str_replace('//', '', $root));
    if($elements[0] == 'response' && !$items['response']) {
      array_shift($elements);
    }

    if(array_key_exists('nodata', $items['response']) && is_array($items['response']['nodata'])) {
      $this->data[$name] = 'nodata';
      return $doc;
    }

    foreach($elements as $elm) {
      $items = $items[$elm];
    }

    $items = $this->flattenZOHO($items);

    $this->data[$name] = $items;
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
   */
  private function flattenZOHO($inarray) {
    $test = reset($inarray);
    $outarray = [];
    if(array_key_exists('FL', $test)) {
      foreach($inarray as $row) {
        $outrow = null;
        foreach($row['FL'] as $fk => $fv) {
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
   * UNUSED
   */
  private function normalizeFromSimpleXML($name, $input = '')
  {
    $doc = new SimpleXMLElement($this->filedata[$name]);
    $root = $this->config['target']['mapping']['root'];
    $items = $doc->xpath($root);
    $this->data[$name] = $items;
    return $doc;
  }

  public function convertNulls($array) {
    foreach($array as $key => $value) {
      if ($value === null) {
        $array[$key] = '';
      }
    }
    return $array;
  }


}
