<?php

namespace Bolt\Extension\Europeana\ViewBlocks;

use Bolt\Asset\File\JavaScript;
use Bolt\Asset\File\Stylesheet;
use Bolt\Controller\Zone;
use Bolt\Extension\SimpleExtension;
use Bolt\Extension\Europeana\ViewBlocks\Field\ViewBlocksField;

/**
 * ViewBlocks extension class.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class ViewBlocksExtension extends SimpleExtension
{
  public function registerFields()
  {
    return [
      new ViewBlocksField(),
    ];
  }

  protected function registerTwigPaths()
  {
    return [
      'templates'
    ];
  }

  protected function registerAssets()
  {
    return [
      (new Stylesheet('web/viewblocks.backend.css'))->setZone(Zone::BACKEND),
      (new JavaScript('web/viewblocks.backend.js'))->setZone(Zone::BACKEND),
    ];
  }
}
