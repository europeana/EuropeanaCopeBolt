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
  private $config;

  public function __construct($config) {
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
  }

  /**
   * StorageEvent::POST_SAVE event callback.
   *
   * @param StorageEvent $event
   */
  public function onItemSaved(StorageEvent $event)
  {
    // Do something with the event.
  }

}
