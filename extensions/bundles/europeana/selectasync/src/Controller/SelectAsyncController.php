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
    private $default_types;
    private $default_fields;
    private $default_person_fields;

    /**
     * Initiate the controller with Bolt Application instance and extension config.
     *
     * @param array $config
     */
    public function __construct(\Bolt\Application $app, array $config)
    {
        $this->app = $app;
        $this->config = $config;
        $this->default_types = ['pages', 'posts', 'data', 'projects', 'events', 'persons', 'resources'];
        $this->default_fields = ['id', 'title', 'status'];
        $this->default_person_fields = ['id', 'first_name', 'last_name', 'email', 'status'];
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

        // /selectasync/type/{type,type,..}
        $ctr->get('/load', [$this, 'selectAsyncUrlLoad'])
        ->bind('select-async-load');

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
        $hasaccess = $this->checkAccess();
        if(!$hasaccess) {
            return $this->noAccess();
        }
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
     * Handles GET requests on /selectasync/type/{type} and return with json.
     *
     * @param Request $request
     * @param $id
     *
     * @return JsonResponse
     */
    public function selectAsyncUrlWithType(Request $request, $type)
    {
        $hasaccess = $this->checkAccess();
        if(!$hasaccess) {
            return $this->noAccess();
        }
        $results = [];
        $message = '';
        $status = 'ok';
        $fields = null;

        $search = $request->query->get('search');
        if(empty($search)) {
            return $this->noAccess('No search given');
        }
        $fieldstring = $request->query->get('fields');
        if(!empty($fieldstring)) {
          $fields = explode(',', $fieldstring);
        }
        if(!in_array($type, $this->default_types)) {
            // illegal type
            return $this->noAccess('Not valid type');
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
        $hasaccess = $this->checkAccess();
        if(!$hasaccess) {
            return $this->noAccess();
        }
        $results = [];
        $message = '';
        $status = 'ok';
        $fields = null;

        $search = $request->query->get('search');
        if(empty($search)) {
            return $this->noAccess('No search given');
        }
        $fieldstring = $request->query->get('fields');
        if(!empty($fieldstring)) {
            $fields = explode(',', $fieldstring);
        }
        $types = explode(',', $types);
        foreach($types as $type) {
            if(!in_array($type, $this->default_types)) {
                // illegal type
                return $this->noAccess('Not valid type');
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
     * Handles GET requests on /selectasync/load and return with json.
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    public function selectAsyncUrlLoad(Request $request)
    {
        $hasaccess = $this->checkAccess();
        if(!$hasaccess) {
            return $this->noAccess();
        }
        $results = [];
        $message = '';
        $status = 'ok';
        $fields = null;

        $ids = $request->query->get('ids');
        if(empty($ids)) {
            return $this->noAccess('No ids given');
        }
        if (!array_filter($ids, 'is_numeric')) {
            return $this->noAccess('Not all ids are numerical');
        }

        $type = $request->query->get('type');
        if(empty($type)) {
            return $this->noAccess('No type given');
        }
        $fieldstring = $request->query->get('fields');
        if(!empty($fieldstring)) {
            $fields = explode(',', $fieldstring);
        }
        if(!in_array($type, $this->default_types)) {
          // illegal type
            return $this->noAccess('Not valid type');
        }

        $results[$type] = $this->selectRecordsByTypeIds($type, $ids, $fields);

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
     * Search the database for records in a type
     * @param        $type
     * @param string $search
     * @param null   $fields
     *
     * @return array
     */
    private function selectRecordsByType($type, $search = '', $fields = null) {

        $search = '%'.trim($search).'%';

        if(empty($fields)) {
            $fields = $this->default_fields;
        }

        $repo = $this->app['storage']->getRepository($type);
        $qb = $repo->createQueryBuilder();

        switch ($type) {
            case 'persons':
                $qb->select($this->default_person_fields);
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

    /**
     * Fetch a few given records in a type
     * @param        $type
     * @param string|array $ids
     * @param null   $fields
     *
     * @return array
     */
    private function selectRecordsByTypeIds($type, $ids, $fields = null) {

        if(empty($fields)) {
            $fields = $this->default_fields;
        }

        if(!empty($ids) && !is_array($ids)) {
            //$ids = explode(',', $ids);
            $ids = json_decode($ids);
        }

        $repo = $this->app['storage']->getRepository($type);
        $qb = $repo->createQueryBuilder();

        switch ($type) {
            case 'persons':
                $qb->select($this->default_person_fields);
                $qb->where(
                    $qb->expr()->in('id', $ids)
                );
                break;
            default:
                $qb->select($fields);
                $qb->where(
                    $qb->expr()->in('id', $ids)
                );
                break;
        }

        $entries = $qb->execute()->fetchAll();

        return $entries;
    }
    /**
     * Check if a client is logged in and has access to the path
     * Or basically - has the role editor
     *
     * @return bool
     */
    private function checkAccess()
    {
       $users = $this->app['users'];
       //dump($users);
       $hasaccess = $users->isAllowed('roles:editor');
       //dump($hasaccess);
       return $hasaccess;
    }

    /**
     * Drops a user to the no access message
     *
     * @return JsonResponse
     */
    private function noAccess($message = 'No access')
    {
        $status = 'error';

        $jsonResponse = new JsonResponse();

        $jsonResponse->setData([
            'message' => $message,
            'status' => $status
        ]);

        return $jsonResponse;
    }
}
