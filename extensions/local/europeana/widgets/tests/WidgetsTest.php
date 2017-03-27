<?php

namespace Bolt\Extension\Europeana\Widgets\Tests;

use Bolt\Tests\BoltUnitTest;
use Bolt\Extension\Europeana\Widgets\Extension;

/**
 * Ensure that the Widgets extension loads correctly.
 *
 */
class WidgetsTest extends BoltUnitTest
{
    public function testExtensionRegister()
    {
        $app = $this->getApp();
        $extension = new Extension($app);
        $app['extensions']->register( $extension );
        $name = $extension->getName();
        $this->assertSame($name, 'Widgets');
        $this->assertSame($extension, $app["extensions.$name"]);
    }
}
