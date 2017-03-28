<?php

namespace Bolt\Extension\Europeana\ViewBlocks\Field;

use Bolt\Field\FieldInterface;

class ViewBlocksField implements FieldInterface
{

  public function getName()
  {
    return 'viewblocks';
  }

  public function getTemplate()
  {
    return '_viewblocks_field.twig';
  }

  public function getStorageType()
  {
    return 'text';
  }

  public function getStorageOptions()
  {
    return ['default' => ''];
  }

}
