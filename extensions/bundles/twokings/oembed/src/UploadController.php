<?php

namespace Bolt\Extension\TwoKings\Oembed;

use Bolt\Application;
use Bolt\Configuration\Composer;
use Bolt\Controller\Backend\Upload;
use Bolt\Controller\Base;
use Bolt\Routing\ControllerCollection;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\FileBag;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class UploadController extends Base
{
    protected function addRoutes(\Silex\ControllerCollection $c)
    {
        $c->match('/upload', [$this, 'uploadThumbnail']);
    }

    /**
     * @param Application $app
     * @param Request     $request
     *
     * @return Response
     */
    public function uploadThumbnail(Application $app, Request $request)
    {
        $url = $request->get('url');
        $name = $request->get('name');

        // This should be fixed. The oEmbed thumbnail should return the correct extension...
        $extension = 'jpg';

        $filesPath = $app['resources']->getPath('files');

        $dateFolder = (string) date("Y-m");

        $fullPath = $filesPath . DIRECTORY_SEPARATOR . $dateFolder . DIRECTORY_SEPARATOR ;

        if (!is_dir($fullPath)) {
            mkdir($fullPath);
        }

        $file = file_get_contents($url);
        file_put_contents($fullPath . $name . '.' . $extension, $file);

        // To generate the correct thumbnail
        $thumbsUrl = '/thumbs/200x150b/';

        return JsonResponse::create([
            'url' => $name . '.' . $extension,
            'preview' => $thumbsUrl . $dateFolder . '/' . $name . '.' . $extension
        ]);
    }
}
