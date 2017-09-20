<?php

namespace Bolt\Extension\TwoKings\FeaturedItems;

use Bolt\Events\StorageEvent;
use Bolt\Events\StorageEvents;


/**
 * An extension for managing featured items.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class FeaturedItemsListener
{
  private $app;
  private $config;

  public function __construct(\Bolt\Application $app, $config) {
    $this->app = $app;
    $this->config = $config;
  }

  /**
   * StorageEvent::PRE_SAVE event callback.
   *
   * @param StorageEvent $event
   */
  public function onItemSave(StorageEvent $event)
  {
    // Do something with the event.
    $itemtype = $event->getContentType();

    if($this->isContentTypeFeatured($itemtype)) {
      $itemcontent = $event->getContent();
      $currenttypeconfig = $this->config['contenttypes'][$itemtype];

      $itemid = $itemcontent->get('id');
      $itemfeaturedstatus = $itemcontent->get('featured');

      // TODO: remove debug dump
      dump($itemtype, $itemid, $itemfeaturedstatus, $currenttypeconfig);

      if($itemfeaturedstatus == 1) {
        $this->depublishOtherItems($currenttypeconfig, $itemid);
      }
    }
    // TODO: remove the die() statement
    die();
  }

  /**
   * Unset featured flag for other items
   *
   * @param $currenttypeconfig
   * @param $itemid
   */
  function depublishOtherItems($currenttypeconfig, $itemid) {
    $contenttype = $this->app->get('contenttypes');

    dump($contenttype);
    if($currenttypeconfig['maxfeatured'] == 0) {
      return;
    } elseif($currenttypeconfig['maxfeatured'] == 1) {
      // don't use the native bolt item save, because that will trigger the storage save event again
      // get content type table from bolt
      // get the field from the config
      // assume the row identifier field is named id
      $query = 'UPDATE %contentype SET %featured = 0 WHERE id != %itemid';

    } else {
      // TODO: handle greater than one
      dump('nope');
    }
  }

  /**
   * Check if the current type has an active configuration for featured items
   *
   * @param $type
   *
   * @return bool
   */
  function isContentTypeFeatured($type) {
    foreach($this->config['contenttypes'] as $key => $values) {
      if($type == $key && $values['hasfeatured'] === true) {
        return true;
      }
    }
    return false;
  }
}
