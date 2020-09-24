<?php

namespace Bolt\Extension\TwoKings\Oembed;

use Bolt\Asset\File\JavaScript;
use Bolt\Controller\Zone;
use Bolt\Extension\SimpleExtension;

/**
 * An extension for custom oembed service.
 *
 * @author Lodewijk Evers <ivo@twokings.nl>
 */
class OembedExtension extends SimpleExtension
{
    /**
     * {@inheritdoc}
     */
    protected function registerBackendControllers()
    {
        return [
            '/oembed' => new UploadController(),
        ];
    }
}

