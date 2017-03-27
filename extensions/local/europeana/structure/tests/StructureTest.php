<?php

namespace Bolt\Extension\Europeana\Structure\Tests;

use Bolt\Tests\BoltUnitTest;
use Bolt\Extension\Europeana\Structure\Extension;

/**
 * Ensure that the Structure extension loads correctly.
 *
 */
class StructureTest extends BoltUnitTest
{
    public function testExtensionRegister()
    {
        $app = $this->getApp();
        $extension = new Extension($app);
        $app['extensions']->register( $extension );
        $name = $extension->getName();
        $this->assertSame($name, 'Structure');
        $this->assertSame($extension, $app["extensions.$name"]);
    }
}
