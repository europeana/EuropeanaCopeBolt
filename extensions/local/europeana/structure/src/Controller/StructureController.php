<?php

namespace Bolt\Extension\Europeana\Structure\Controller;

use Silex\Application;
use Silex\ControllerCollection;
use Silex\ControllerProviderInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Controller class.
 *
 * @author Your Name <you@example.com>
 */
class StructureController implements ControllerProviderInterface
{
    /** @var array The extension's configuration parameters */
    private $config;

    /**
     * Initiate the controller with Bolt Application instance and extension config.
     *
     * @param array $config
     */
    public function __construct(array $config)
    {
        $this->config = $config;
    }

    /**
     * Specify which method handles which route.
     *
     * Base route/path is '/example/url'
     *
     * @param Application $app An Application instance
     *
     * @return ControllerCollection A ControllerCollection instance
     */
    public function connect(Application $app)
    {
        /** @var $ctr \Silex\ControllerCollection */
        $ctr = $app['controllers_factory'];

        // /example/url/in/controller
        $ctr->get('/in/controller', [$this, 'structureUrl'])
            ->bind('structure-url-controller'); // route name, must be unique(!)

        // /example/url/json
        $ctr->get('/json', [$this, 'structureUrlJson'])
            ->bind('structure-url-json');

        // /example/url/parameter/{id}
        $ctr->get('/parameter/{id}', [$this, 'structureUrlWithParameter'])
            ->bind('structure-url-parameter');

        // /example/url/get-parameter
        $ctr->get('/get-parameter', [$this, 'structureUrlGetParameter'])
            ->bind('structure-url-parameter-get');

        // /example/url/template
        $ctr->get('/template', [$this, 'structureUrlTemplate'])
            ->bind('structure-url-template');

        return $ctr;
    }

    /**
     * Handles GET requests on /example/url/in/controller
     *
     * @param Request $request
     *
     * @return Response
     */
    public function structureUrl(Request $request)
    {
        $response = new Response('Hello, World!', Response::HTTP_OK);

        return $response;
    }

    /**
     * Handles GET requests on /example/url/json and return with json.
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    public function structureUrlJson(Request $request)
    {
        $jsonResponse = new JsonResponse();

        $jsonResponse->setData([
            'message' => 'I am a JSON response, yeah!',
        ]);

        return $jsonResponse;
    }

    /**
     * Handles GET requests on /example/url/parameter/{id} and return with json.
     *
     * @param Request $request
     * @param $id
     *
     * @return JsonResponse
     */
    public function structureUrlWithParameter(Request $request, $id)
    {
        $jsonResponse = new JsonResponse();

        $jsonResponse->setData([
            'id' => $id,
        ]);

        return $jsonResponse;
    }

    /**
     * Handles GET requests on /example/url/get-parameter and return with some data as json.
     * Example: http://localhost/example/url/get-parameter?foo=bar&baz=foo&id=7
     * Works in the same way with POST requests
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    public function structureUrlGetParameter(Request $request)
    {
        $jsonResponse = new JsonResponse();

        $jsonResponse->setData([
            'all' => $request->query->all(), // all GET parameter as key value array
            'id'  => $request->get('id'), // only 'id' GET parameter
        ]);

        return $jsonResponse;
    }

    /**
     * Handles GET requests on /example/url/template and return a template.
     *
     * @param Request $request
     *
     * @return string
     */
    public function structureUrlTemplate(Application $app, Request $request)
    {
        return $app['twig']->render('structure_frontend.twig', ['title' => 'Look at This Nice Template'], []);
    }
}
