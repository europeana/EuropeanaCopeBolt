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
    $backendCss = new Stylesheet();
    $backendCss->setFileName('viewblocks.backend.css')->setZone(Zone::BACKEND)->setPriority(10);

    $backendJs = new JavaScript();
    $backendJs->setFileName('viewblocks.backend.js')->setZone(Zone::BACKEND)->setPriority(15);


    $assets = [
      $backendCss,
      $backendJs,
    ];
    return $assets;
  }
}
