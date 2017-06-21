<?php

namespace Bolt\Extension\Europeana\ZohoImport\Provider;

use Silex\Application;
use Silex\ServiceProviderInterface;
use Bolt\Extension\Europeana\ZohoImport\ZohoImport;

/**
 * ZohoImport service provider.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class ZohoImportServiceProvider implements ServiceProviderInterface
{
  /** @var array */
  private $config;

  /**
   * Constructor.
   *
   * @param array $config
   */
  public function __construct(array $config)
  {
    $this->config = $config;
  }

  /**
   * {@inheritdoc}
   */
  public function register(Application $app)
  {
    $app['zohoimport'] = $app->share(
      function ($app) {
        return new ZohoImport($app);
      }
    );
    $app['zohoimport.config'] = $app->share(
      function () {
        return $this->config;
      }
    );
  }

  /**
   * {@inheritdoc}
   */
  public function boot(Application $app)
  {
  }
}
