<?php

namespace Bolt\Extension\TwoKings\FeaturedItems;

use Bolt\Events\StorageEvent;
use Bolt\Events\StorageEvents;
use Bolt\Extension\SimpleExtension;
use Symfony\Component\EventDispatcher\EventDispatcherInterface;

/**
 * An extension for managing featured items.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class FeaturedItemsExtension extends SimpleExtension
{

  /**
   * @param \Symfony\Component\EventDispatcher\EventDispatcherInterface $dispatcher
   */
  protected function subscribe(EventDispatcherInterface $dispatcher) {
    $config = $this->getConfig();
    $app = $this->getContainer();
    $featuredItems = new FeaturedItemsListener($app, $config);
    $dispatcher->addListener(
      StorageEvents::PRE_SAVE,
      [$featuredItems, 'onItemSave']
    );
  }

  /**
   * {@inheritdoc}
   */
  protected function getDefaultConfig()
  {
    return [
      'contenttypes' => [
        'pages' => [
          'hasfeatured' => false, // this is the default
          'maxfeatured' => 1,     // you may also have more than one
          'field' => 'featured'   // the field in the content type that will be used as flag
        ],
        'events' => [
          'hasfeatured' => true,
          'maxfeatured' => 1,
          'field' => 'featured'
        ]
      ]
    ];
  }
}

