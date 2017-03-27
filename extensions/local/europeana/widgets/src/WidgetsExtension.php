<?php

namespace Bolt\Extension\Europeana\Widgets;

use Bolt\Asset\File\JavaScript;
use Bolt\Asset\File\Stylesheet;
use Bolt\Controller\Zone;
use Bolt\Events\StorageEvent;
use Bolt\Events\StorageEvents;
use Bolt\Extension\SimpleExtension;
use Bolt\Extension\Europeana\Widgets\Controller\WidgetsController;
use Bolt\Extension\Europeana\Widgets\Listener\StorageEventListener;
use Bolt\Menu\MenuEntry;
use Silex\ControllerCollection;
use Symfony\Component\EventDispatcher\EventDispatcherInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Widgets extension class.
 *
 * @author Your Name <you@example.com>
 */
class WidgetsExtension extends SimpleExtension
{
    /**
     * {@inheritdoc}
     */
    public function registerFields()
    {
        /*
         * Custom Field Types:
         * You are not limited to the field types that are provided by Bolt.
         * It's really easy to create your own.
         *
         * This example is just a simple text field to show you
         * how to store and retrieve data.
         *
         * See also the documentation page for more information and a more complex example.
         * https://docs.bolt.cm/extensions/customfields
         */

        return [
            new Field\WidgetsField(),
        ];
    }

    /**
     * {@inheritdoc}
     */
    protected function subscribe(EventDispatcherInterface $dispatcher)
    {
        /*
         * Event Listener:
         *
         * Did you know that Bolt fires events based on backend actions? Now you know! :)
         *
         * Let's register listeners for all 4 storage events.
         *
         * The first listener will be an inline function, the three other ones will be in a separate class.
         * See also the documentation page:
         * https://docs.bolt.cm/extensions/essentials#adding-storage-events
         */

        $dispatcher->addListener(StorageEvents::PRE_SAVE, [$this, 'onPreSave']);

        $storageEventListener = new StorageEventListener($this->getContainer(), $this->getConfig());
        $dispatcher->addListener(StorageEvents::POST_SAVE, [$storageEventListener, 'onPostSave']);
        $dispatcher->addListener(StorageEvents::PRE_DELETE, [$storageEventListener, 'onPreDelete']);
        $dispatcher->addListener(StorageEvents::POST_DELETE, [$storageEventListener, 'onPostDelete']);
    }

    /**
     * Handles PRE_SAVE storage event
     *
     * @param StorageEvent $event
     */
    public function onPreSave(StorageEvent $event)
    {
        // The ContentType of the record being saved
        $contenttype = $event->getContentType();

        // The record being saved
        $record = $event->getContent();

        // A flag to tell if the record was created, updated or deleted,
        // for more information see the page in the documentation
        $created = $event->isCreate();

        // Do whatever you want with this data
        // See page in the documentation for a logging example
    }

    /**
     * {@inheritdoc}
     */
    protected function registerAssets()
    {
        return [
            // Web assets that will be loaded in the frontend
            new Stylesheet('widgets.css'),
            new JavaScript('widgets.js'),
            // Web assets that will be loaded in the backend
            (new Stylesheet('widgets.backend.css'))->setZone(Zone::BACKEND),
            (new JavaScript('widgets.backend.js'))->setZone(Zone::BACKEND),
        ];
    }

    /**
     * {@inheritdoc}
     */
    protected function registerTwigPaths()
    {
        return ['templates'];
    }

    /**
     * {@inheritdoc}
     */
    protected function registerTwigFunctions()
    {
        return [
            'widgets' => 'widgetsTwig',
        ];
    }

    /**
     * The callback function when {{ my_twig_function() }} is used in a template.
     *
     * @return string
     */
    public function widgetsTwig()
    {
        $context = [
            'something' => mt_rand(),
        ];

        return $this->renderTemplate('widgets.twig', $context);
    }

    /**
     * {@inheritdoc}
     *
     * Extending the backend menu:
     *
     * You can provide new Backend sites with their own menu option and template.
     *
     * Here we will add a new route to the system and register the menu option in the backend.
     *
     * You'll find the new menu option under "Extras".
     */
    protected function registerMenuEntries()
    {
        /*
         * Define a menu entry object and register it:
         *   - Route http://example.com/bolt/extend/widgets-backend-page-route
         *   - Menu label 'MyExtension Admin'
         *   - Menu icon a Font Awesome small child
         *   - Required Bolt permissions 'settings'
         */
        $adminMenuEntry = (new MenuEntry('widgets-backend-page', 'widgets-backend-page-route'))
            ->setLabel('Widgets Admin')
            ->setIcon('fa:child')
            ->setPermission('settings')
        ;

        return [$adminMenuEntry];
    }

    /**
     * {@inheritdoc}
     *
     * Mount the ExampleController class to all routes that match '/example/url/*'
     *
     * To see specific bindings between route and controller method see 'connect()'
     * function in the ExampleController class.
     */
    protected function registerFrontendControllers()
    {
        $app = $this->getContainer();
        $config = $this->getConfig();

        return [
            '/widgets/url' => new WidgetsController($config),
        ];
    }

    /**
     * {@inheritdoc}
     *
     * This first route will be handled in this extension class,
     * then we switch to an extra controller class for the routes.
     */
    protected function registerFrontendRoutes(ControllerCollection $collection)
    {
        $collection->match('/widgets/url', [$this, 'routeWidgetsUrl']);
    }

    /**
     * Handles GET requests on the /example/url route.
     *
     * @param Request $request
     *
     * @return Response
     */
    public function routeWidgetsUrl(Request $request)
    {
        $response = new Response('Hello, Bolt!', Response::HTTP_OK);

        return $response;
    }

    /**
     * {@inheritdoc}
     */
    protected function registerBackendControllers()
    {
        return [];
    }

    /**
     * {@inheritdoc}
     */
    protected function registerBackendRoutes(ControllerCollection $collection)
    {
        $collection->match('/extend/widgets-backend-page-route', [$this, 'widgetsBackendPage']);
    }

    /**
     * Handles GET requests on /bolt/widgets-backend-page and return a template.
     *
     * @param Request $request
     *
     * @return string
     */
    public function widgetsBackendPage(Request $request)
    {
        return $this->renderTemplate('widgets_backend_site.twig', ['title' => 'My Custom Page']);
    }
}
