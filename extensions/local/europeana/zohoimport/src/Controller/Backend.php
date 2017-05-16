<?php

namespace Bolt\Extension\Europeana\ZohoImport\Controller;

use Silex\Application;
use Silex\ControllerCollection;
use Silex\ControllerProviderInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * The controller for zohoimport routes.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class Backend implements ControllerProviderInterface
{
  /** @var Application */
  protected $app;

  /**
  * {@inheritdoc}
  */
  public function connect(Application $app)
  {
    $this->app = $app;

    /** @var ControllerCollection $ctr */
    $ctr = $app['controllers_factory'];

    $ctr->match('/', [$this, 'callbackZohoImport']);
    $ctr->match('/{type}', [$this, 'callbackZohoImport']);

    return $ctr;
  }

  /**
  * @param Request $request
  * @param string  $type
  *
  * @return Response
  */
  public function callbackZohoImport(Request $request, $type = null)
  {
    $app = $this->app;

    switch ($type) {
      case 'full':
        $text = 'Running full import';
        $text .= "<br>\n" . $app['zohoimport']->importJob();
        break;
      case 'update':
        $text = 'Running update';
        break;
      case 'imageonly':
        $text = 'Running image only import';
        break;
      case 'test':
      default:
        $text = 'Running test import';
        $text .= "<br>\n" . $app['zohoimport']->zohoImportOverview();
        $type = 'test';
        break;
    }
    $app['zohoimport']->logger('info', $text, 'zoho-backend-'.$type, $request);

    $html = $app['twig']->render('overview.twig', [
      'title' => 'ZOHO Import overview',
      'text' => $text,
      'zohoconfig' => $app['zohoimport.config']
    ]);

    return $html;
  }

}