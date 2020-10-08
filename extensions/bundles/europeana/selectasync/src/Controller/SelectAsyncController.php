<?php

namespace Bolt\Extension\Europeana\SelectAsync\Controller;

use Bolt\Filesystem\Manager;
use Bolt\Filesystem\Exception\FileNotFoundException;
use League\Flysystem\Exception;
use Silex\Application;
use Silex\ControllerCollection;
use Silex\ControllerProviderInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Controller class.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class SelectAsyncController implements ControllerProviderInterface
{
    /** @var array The extension's configuration parameters */
    private $app;
    private $config;
    private $default_types;
    private $default_fields;
    private $default_person_fields;
    private $directory_tree;

    /**
     * Constructor.
     * Initiate the controller with Bolt Application instance and extension config.
     *
     * @param \Bolt\Application $app
     * @param array             $config
     */
    public function __construct(\Bolt\Application $app, array $config)
    {
        $this->app = $app;
        $this->config = $config;
        $this->default_types = ['pages', 'posts', 'data', 'projects', 'events', 'persons', 'resources', 'jobs', 'organisations'];
        $this->default_fields = ['id', 'title', 'status'];
        $this->default_person_fields = ['id', 'first_name', 'last_name', 'email', 'status'];
        $this->default_job_fields = ['id', 'position', 'status'];
        $this->default_organisation_fields = ['id', 'name', 'status'];
        $this->directory_tree = [];
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

        // /selectasync/
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

        // /selectasync/categories/
        $ctr->get('/categories', [$this, 'selectAsyncCategories'])
            ->bind('select-async-categories');

        // /selectasync/categories/{type}
        $ctr->get('/categories/{type}', [$this, 'selectAsyncCategoriesType'])
            ->bind('select-async-categories-type');

        // /selectasync/directories
        $ctr->get('/directories', [$this, 'selectAsyncDirectories'])
            ->bind('select-async-directories');

        return $ctr;
    }

    /**
     * Handles GET requests on /selectasync/categories
     *
     * @param Request $request
     *
     * @return Response
     */
    public function selectAsyncCategories(Request $request)
    {
        $hasaccess = $this->checkAccess();
        if (!$hasaccess) {
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
     * Handles GET requests on /selectasync/categories/{type} and return with json.
     *
     * @param \Symfony\Component\HttpFoundation\Request $request
     * @param                                           $type
     *
     * @return \Symfony\Component\HttpFoundation\JsonResponse
     */
    public function selectAsyncCategoriesType(Request $request, $type)
    {
        $hasaccess = $this->checkAccess();
        if (!$hasaccess) {
            return $this->noAccess();
        }
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
     * Handles GET requests on /selectasync/directories
     *
     * @param Request $request
     *
     * @return Response
     */
    public function selectAsyncDirectories(Request $request)
    {
        $hasaccess = $this->checkAccess();
        if (!$hasaccess) {
            return $this->noAccess();
        }
        $type = 'directorylist';
        $message = '';
        $status = 'ok';

        $search = $request->query->get('search');
        if (empty($search)) {
            $search = '';
        }

        $filesystem = $this->app['filesystem'];
        $this->selectAsyncRecursiveDirTree($filesystem, 'files', $search);

        // dump('results', $this->directory_tree);
        $jsonResponse = new JsonResponse();

        $jsonResponse->setData([
            'query' => $request->query->all(),
            'type' => $type,
            'message' => $message,
            'status' => $status,
            'results' => $this->directory_tree
        ]);

        return $jsonResponse;
    }

    /**
     * Return a list of directories and subdirectories
     * TODO: Test if this scales up to a a few thousand files
     *
     * @param \Bolt\Filesystem\Manager $filesystem
     * @param                          $root
     * @param                          $search
     */
    private function selectAsyncRecursiveDirTree(Manager $filesystem, $root, $search)
    {
        $files = $filesystem->getFilesystem($root);
        $contents = $files->listContents(null, true);

        foreach ($contents as $fileobject) {
            $skip = false;

            // try to access the file - and if it fails just skip it
            // this prevents directories with broken filenames from appearing
            try {
                $fileobject->getType();
            } catch (FileNotFoundException $e) {
                $skip = true;
            }

            if (!$skip) {
                if ($fileobject->isDir() === true) {
                    if (!empty($search)) {
                        if (stristr($fileobject->getPath(), $search)) {
                            array_push(
                                $this->directory_tree,
                                [
                                    'id'    => $fileobject->getPath(),
                                    'title' => $fileobject->getPath()
                                ]
                            );
                        }
                    } else {
                        array_push(
                            $this->directory_tree,
                            [
                                'id'    => $fileobject->getPath(),
                                'title' => $fileobject->getPath()
                            ]
                        );
                    }
                    //array_push($this->directory_tree, $fileobject);
                }
            }
        }
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
        if (!$hasaccess) {
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
     * @param \Symfony\Component\HttpFoundation\Request $request
     * @param                                           $type
     *
     * @return \Symfony\Component\HttpFoundation\JsonResponse
     */
    public function selectAsyncUrlWithType(Request $request, $type)
    {
        $hasaccess = $this->checkAccess($type);
        if (!$hasaccess) {
            return $this->noAccess('No access to this type.');
        }
        $results = [];
        $message = '';
        $status = 'ok';
        $fields = null;

        $search = $request->query->get('search');
        if (empty($search)) {
            return $this->noAccess('No search given');
        }
        $fieldstring = $request->query->get('fields');
        if (!empty($fieldstring)) {
            $fields = explode(',', $fieldstring);
        }
        if (!in_array($type, $this->default_types)) {
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
     * @param \Symfony\Component\HttpFoundation\Request $request
     * @param                                           $types
     *
     * @return \Symfony\Component\HttpFoundation\JsonResponse
     */
    public function selectAsyncUrlWithTypes(Request $request, $types)
    {
        $hasaccess = $this->checkAccess($types);
        if (!$hasaccess) {
            return $this->noAccess('No access to these types.');
        }
        $results = [];
        $message = '';
        $status = 'ok';
        $fields = null;

        $search = $request->query->get('search');
        if (empty($search)) {
            return $this->noAccess('No search given');
        }
        $fieldstring = $request->query->get('fields');
        if (!empty($fieldstring)) {
            $fields = explode(',', $fieldstring);
        }
        $types = explode(',', $types);
        foreach ($types as $type) {
            if (!in_array($type, $this->default_types)) {
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
        if (!$hasaccess) {
            return $this->noAccess();
        }
        $results = [];
        $message = '';
        $status = 'ok';
        $fields = null;

        $ids = $request->query->get('ids');
        if (empty($ids)) {
            return $this->noAccess('No ids given');
        }
        if (!array_filter($ids, 'is_numeric')) {
            return $this->noAccess('Not all ids are numerical');
        }

        $type = $request->query->get('type');
        if (empty($type)) {
            return $this->noAccess('No type given');
        }
        $hasaccess = $this->checkAccess($type);
        if (!$hasaccess) {
            return $this->noAccess('No load access to this type.');
        }
        $fieldstring = $request->query->get('fields');
        if (!empty($fieldstring)) {
            $fields = explode(',', $fieldstring);
        }
        if (!in_array($type, $this->default_types)) {
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
    private function selectRecordsByType($type, $search = '', $fields = null)
    {

        $search = '%'.trim($search).'%';

        if (empty($fields)) {
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
            case 'organisations':
                $qb->select($fields);
                $qb->where(
                  $qb->expr()->orX(
                    $qb->expr()->like('name', $qb->createNamedParameter($search)),
                    $qb->expr()->like('name_alt1', $qb->createNamedParameter($search)),
                    $qb->expr()->like('name_alt2', $qb->createNamedParameter($search)),
                    $qb->expr()->like('acronym', $qb->createNamedParameter($search)),
                    $qb->expr()->like('city', $qb->createNamedParameter($search)),
                    $qb->expr()->like('country', $qb->createNamedParameter($search))
                  )
                );
                $qb->orderBy('datepublish', 'DESC');
                break;
            case 'jobs':
                $qb->select($fields);
                $qb->where(
                    $qb->expr()->like('position', $qb->createNamedParameter($search))
                );
                $qb->orderBy('datepublish', 'DESC');
                break;
            default:
                $qb->select($fields);
                $qb->where(
                    $qb->expr()->like('title', $qb->createNamedParameter($search))
                );
                $qb->orderBy('datepublish', 'DESC');
                break;
        }

        $qb->setMaxResults(50);

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
    private function selectRecordsByTypeIds($type, $ids, $fields = null)
    {

        if (empty($fields)) {
            $fields = $this->default_fields;
        }

        if (!empty($ids) && !is_array($ids)) {
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
            case 'jobs':
                $qb->select($this->default_job_fields);
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
     * Check if a client is logged in and has access to the content type
     * TODO: double check if type is a valid contenttype
     *
     * @param string $type
     *
     * @return bool
     */
    private function checkAccess($type = 'all')
    {
        $users = $this->app['users'];
        // dump('check access', $users);

        if ($type=='all') {
            $contentquery = 'contentaction';
        } elseif (is_array($type)) {
            $contentquery = '';
            foreach ($type as $typeval) {
                $contentquery .= 'contenttype:' . $typeval . ':view or contenttype:' . $typeval . ':edit';
            }
        } elseif (is_string($type)) {
            $contentquery = 'contenttype:' . $type . ':view or contenttype:' . $type . ':edit';
        } else {
            $contentquery = 'dashboard';
        }

        $hasaccess = $users->isAllowed($contentquery);

        // dump('check access', $contentquery, $hasaccess);
        return $hasaccess;
    }

    /**
     * Drops a user to the no access message
     *
     * @param string $message
     *
     * @return \Symfony\Component\HttpFoundation\JsonResponse
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
