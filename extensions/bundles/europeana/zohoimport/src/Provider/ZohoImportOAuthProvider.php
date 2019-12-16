<?php

namespace Bolt\Extension\Europeana\ZohoImport\Provider;

use Bolt\Extension\Europeana\ZohoImport\OAuth\ZohoImportOAuth;
use Silex\Application;
use Silex\ServiceProviderInterface;

class ZohoImportOAuthProvider implements ServiceProviderInterface
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
        $app['zohoimport.oauth'] = $app->share(
            function ($app) {
                return new ZohoImportOAuth($app, $this->config['oauth']);
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