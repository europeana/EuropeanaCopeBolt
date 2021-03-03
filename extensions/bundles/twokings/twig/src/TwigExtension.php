<?php

namespace Bolt\Extension\Twokings\Twig;

use Bolt\Extension\SimpleExtension;

/**
 * An extension that adds useful twig functions an filters..
 *
 * @author Ivo Valchev <ivo@twokings.nl>
 */
class TwigExtension extends SimpleExtension
{
    /**
     * {@inheritdoc}
     */
    protected function registerTwigFilters()
    {
        return [
            'is_string' => 'isString',
        ];
    }

    public function isString($variable)
    {
        return is_string($variable);
    }
}
