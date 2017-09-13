<?php

namespace Bolt\Extension\Europeana\SelectAsync;

use Bolt\Asset\File\JavaScript;
use Bolt\Asset\File\Stylesheet;
use Bolt\Controller\Zone;
use Bolt\Extension\SimpleExtension;
use Bolt\Extension\Europeana\SelectAsync\Controller\SelectAsyncController;

/**
 * ExtensionName extension class.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class SelectAsyncExtension extends SimpleExtension
{
    private $app;
    private $config;

    /**
     * {@inheritdoc}
     */
    protected function registerAssets()
    {
        return [
            // Web assets that will be loaded in the backend
            (new Stylesheet('selectasync.css'))->setZone(Zone::BACKEND),
            (new JavaScript('selectasync.js'))->setLate(true)->setZone(Zone::BACKEND),
        ];
    }

    /**
     * {@inheritdoc}
     */
    protected function registerBackendControllers()
    {
        $this->app = $this->getContainer();
        $this->config = $this->getConfig();

        return [
            '/selectasync' => new SelectAsyncController($this->app, $this->config),
        ];
    }
}
