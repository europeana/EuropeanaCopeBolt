<?php

namespace Bolt\Extension\Europeana\ZohoImport;

use Bolt\Extension\SimpleExtension;
use Bolt\Menu\MenuEntry;
use Pimple as Container;
use Bolt\Extension\Europeana\ZohoImport\Provider\ZohoImportServiceProvider;

/**
 * ZohoImport extension class.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class ZohoImportExtension extends SimpleExtension
{
  /**
   * {@inheritdoc}
   */
  protected function registerBackendControllers()
  {
    return [
      '/extend/zohoimport' => new Controller\Backend(),
    ];
  }

  /**
   * {@inheritdoc}
   */
  public function getServiceProviders()
  {
    return [
      $this,
      new ZohoImportServiceProvider($this->getConfig())
    ];
  }

  /**
   * {@inheritdoc}
   */
  protected function registerMenuEntries()
  {
    $menu = new MenuEntry('zohoimport-menu', 'zohoimport');
    $menu->setLabel('ZOHO import')
      ->setIcon('fa:users')
      ->setPermission('settings')
    ;

    return [
      $menu,
    ];
  }

  /**
   * {@inheritdoc}
   */
  protected function registerNutCommands(Container $container)
  {
    return [
      new Console\ZohoImportCommand($container),
    ];
  }

  /**
   * {@inheritdoc}
   */
  protected function registerTwigPaths()
  {
    return ['templates'];
  }

  /**
   * {@inheritdoc}
   */
  protected function getDefaultConfig()
  {
    return [
      'debug_mode' => 'false',
      'image_path' => 'zoho_images',
      'image_downloads' => true,
      'remotes' => [
        'atom_feed_example' => [
          'enabled' => false,
          'source' => [
            'url' => 'http://example.com/atom',
            'getparams' => [
              'authtoken' => 'a-itis-a-me-a-mario',
              'scope' => 'test',
              'test' => 'test'
            ],
            'type' => 'xml'
          ],
          'target' => [
            'contenttype' => 'partners',
            'defaults' => [
              'new' => 'published',
              'updated' => 'published',
              'removed' => 'unpublished',
              'fields' => []
            ],
            'mapping' => [
              'root' => '//feed/entry/id',
              'fields' => [
                'id' => 'guid',
                'last_modified' => 'updated',
                'title' => 'title',
                'body' => 'item',
                'type' => 'category::term'
              ]
            ]
          ]
        ]
      ]
    ];
  }
}

