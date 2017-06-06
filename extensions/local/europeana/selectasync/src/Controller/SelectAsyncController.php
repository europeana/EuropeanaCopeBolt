<?php

namespace Bolt\Extension\Europeana\SelectAsync\Controller;

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
class SelectAsyncController implements ControllerProviderInterface
{
    /** @var array The extension's configuration parameters */
    private $app;
    private $config;

    /**
     * Initiate the controller with Bolt Application instance and extension config.
     *
     * @param array $config
     */
    public function __construct(\Bolt\Application $app, array $config)
    {
        $this->app = $app;
        $this->config = $config;
    }

    /**
     * Specify which method handles which route.
     *
     * Base route/path is '/selectasync'
     *
     * @param Application $app An Application instance
     *
     * @return ControllerCollection A ControllerCollection instance
     */
    public function connect(Application $app)
    {
        /** @var $ctr \Silex\ControllerCollection */
        $ctr = $app['controllers_factory'];

        // /selectasync/in/controller
        $ctr->get('/', [$this, 'selectAsyncUrl'])
            ->bind('select-async-url-controller');

        // /selectasync/type/{type}
        $ctr->get('/type/{type}', [$this, 'selectAsyncUrlWithType'])
          ->bind('select-async-url-type');

        // /selectasync/type/{type,type,..}
        $ctr->get('/types/{types}', [$this, 'selectAsyncUrlWithTypes'])
          ->bind('select-async-url-types');

        return $ctr;
    }

    /**
     * Handles GET requests on /selectasync/in/controller
     *
     * @param Request $request
     *
     * @return Response
     */
    public function selectAsyncUrl(Request $request)
    {
        $type = null;
        $results = [];
        $message = 'SelectAsync is working on this path.';
        $status = 'ok';

        $jsonResponse = new JsonResponse();

        $jsonResponse->setData([
            'query' => $request->query->all(),
            'type' => $type,
            'message' => $message,
            'status' => $status,
            'results' => $results
        ]);

        return $jsonResponse;
    }

    /**
     * Handles GET requests on /selectasync/in/controller
     *
     * @param Request $request
     *
     * @return Response
     */
    public function noAccess()
    {
        $message = 'No Access';
        $status = 'error';

        $jsonResponse = new JsonResponse();

        $jsonResponse->setData([
            'message' => $message,
            'status' => $status
        ]);

        return $jsonResponse;
    }

    /**
     * Handles GET requests on /selectasync/type/{type} and return with json.
     *
     * @param Request $request
     * @param $id
     *
     * @return JsonResponse
     */
    public function selectAsyncUrlWithType(Request $request, $type)
    {

        $results = [];
        $message = '';
        $status = 'ok';
        $fields = null;

        $search = $request->query->get('search');
        $fieldstring = $request->query->get('fields');
        if(!empty($fieldstring)) {
          $fields = explode(',', $fieldstring);
        }
        if(!in_array($type, ['pages', 'posts', 'data', 'projects', 'events', 'persons', 'resources'])) {
            // illegal type
            return $this->noAccess();
        }

        $results[$type] = $this->selectRecordsByType($type, $search, $fields);

        $jsonResponse = new JsonResponse();
        $jsonResponse->setData([
            'query' => $request->query->all(),
            'type' => $type,
            'message' => $message,
            'status' => $status,
            'results' => $results
        ]);

        return $jsonResponse;
    }

    /**
     * Handles GET requests on /selectasync/types/{type,type,..} and return with json.
     *
     * @param Request $request
     * @param $id
     *
     * @return JsonResponse
     */
    public function selectAsyncUrlWithTypes(Request $request, $types)
    {

        $results = [];
        $message = '';
        $status = 'ok';
        $fields = null;

        $search = $request->query->get('search');
        $fieldstring = $request->query->get('fields');
        if(!empty($fieldstring)) {
          $fields = explode(',', $fieldstring);
        }
        $types = explode(',', $types);
        foreach($types as $type) {
          if(!in_array($type, ['pages', 'posts', 'data', 'projects', 'events', 'persons', 'resources'])) {
              // illegal type
              return $this->noAccess();
          }
          $results[$type] = $this->selectRecordsByType($type, $search, $fields);
        }

        $jsonResponse = new JsonResponse();
        $jsonResponse->setData([
            'query' => $request->query->all(),
            'types' => $types,
            'message' => $message,
            'status' => $status,
            'results' => $results
        ]);

        return $jsonResponse;
    }

    /**
     * Search the database for records in a type
     * @param        $type
     * @param string $search
     * @param null   $fields
     *
     * @return array
     */
    private function selectRecordsByType($type, $search = '', $fields = null) {

        $search = '%'.trim($search).'%';

        $defaultfields = ['id', 'title', 'status'];
        if(empty($fields)) {
            $fields = $defaultfields;
        }

        $repo = $this->app['storage']->getRepository($type);
        $qb = $repo->createQueryBuilder();

        switch ($type) {
            case 'persons':
                $qb->select(['id', 'first_name', 'last_name', 'email', 'status']);
                $qb->where(
                    $qb->expr()->orX(
                        $qb->expr()->like('first_name', $qb->createNamedParameter($search)),
                        $qb->expr()->like('last_name', $qb->createNamedParameter($search)),
                        $qb->expr()->like('email', $qb->createNamedParameter($search))
                    )
                );
                $qb->orderBy('last_name', 'ASC');
                break;
            default:
                $qb->select($fields);
                $qb->where(
                    $qb->expr()->like('title', $qb->createNamedParameter($search))
                );
                $qb->orderBy('datepublish', 'DESC');
                break;
        }

        $qb->setMaxResults(10);

        $entries = $qb->execute()->fetchAll();

        return $entries;
    }
}
