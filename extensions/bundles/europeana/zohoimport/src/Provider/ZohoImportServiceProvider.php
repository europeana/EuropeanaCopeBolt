<?php

namespace Bolt\Extension\Europeana\ZohoImport\Provider;

use Bolt\Extension\Europeana\ZohoImport\Downloader\ZohoImportDownloader;
use Bolt\Extension\Europeana\ZohoImport\Parser\Normalizer;
use Silex\Application;
use Silex\ServiceProviderInterface;
use Bolt\Extension\Europeana\ZohoImport\ZohoImport;
use Bolt\Extension\Europeana\ZohoImport\Parser\FileFetcher;
use Bolt\Extension\Europeana\ZohoImport\Logger\ZohoImportLogger;

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
        $app['zohoimport.downloader'] = $app->share(
            function ($app) {
                return new ZohoImportDownloader($app);
            }
        );
        $app['zohoimport.logger'] = $app->share(
            function ($app) {
                return new ZohoImportLogger($app);
            }
        );
        $app['zohoimport.filefetcher'] = $app->share(
            function ($app) {
                return new FileFetcher($app);
            }
        );
        $app['zohoimport.normalizer'] = $app->share(
            function ($app) {
                return new Normalizer($app);
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
