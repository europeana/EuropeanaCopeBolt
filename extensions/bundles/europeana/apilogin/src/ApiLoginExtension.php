<?php

namespace Bolt\Extension\Europeana\ApiLogin;

use Bolt\Extension\SimpleExtension;
use GuzzleHttp\Exception\RequestException;

/**
 * ExtensionName extension class.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class ApiLoginExtension extends SimpleExtension
{
  private $app;
  private $config;
  private $posted = false;
  private $valid_input = false;
  private $form_errors = array();

  /**
   * {@inheritdoc}
   */
  public function registerTwigFunctions()
  {
    $this->app = $this->getContainer();
    $this->config = $this->getConfig();
    return [
      'apikeyform' => ['showApiKeyForm', ['is_safe' => ['html']]]
    ];
  }

  /**
   * {@inheritdoc}
   */
  protected function registerTwigPaths()
  {
    return [
      'templates' => [
        'position' => 'prepend',
        'namespace' => 'bolt'
      ]
    ];
  }

  /**
   * Twig function to handle the form and the response
   * If the form is posted and correct,
   * a request to the API will be done in the background
   * while a thanks page will be displayed
   *
   * @return \Twig_Markup
   */
  public function showApiKeyForm()
  {
    $currenturl = $this->app['paths']['currenturl'];
    $template_form = $this->config['templates']['apikeyform'];
    $template_thanks = $this->config['templates']['thankspage'];

    if ($this->app['request']->isMethod('POST')) {
      $this->posted = true;
      $postvars = $this->app['request']->request->all();
      $this->validateInput($postvars);
      dump('posted is true', $postvars);
    }

    if($this->posted && $this->valid_input) {
      $results = $this->dispatchRemoteRequest();
      dump('remote request', $results);
      if($results->success == true) {
        dump('dispatchRemoteRequest did something right', $results);
        $html = $this->renderTemplate($template_thanks, array(
          'config' => $this->config
        ));
        $this->app['logger.system']->info('Created API key.', array('event' => 'ApiKeyHelper'));
      } else {
        $html = "<p>There was an error requesting an API key. Please try again later.</p>";
        dump('dispatchRemoteRequest did something wrong', $results);
        $this->app['logger.system']->error('Failed to create an API key', array('event' => 'ApiKeyHelper'));
      }
    } else {
      dump('invalid or not posted', $this);
      // add form error text to display
      if(!empty($this->form_errors)) {
        foreach($this->form_errors as $key => $value) {
          $this->config['form']['fields'][$key]['error'] = $value;
        }
      }
      // keep entered values in display
      foreach($this->config['form']['fields'] as $key => $field) {
        if(!empty($postvars[$key])) {
          $this->config['form']['fields'][$key]['postedValue'] = $postvars[$key];
        } else {
          $this->config['form']['fields'][$key]['postedValue'] = null;
        }
      }
      $html = $this->renderTemplate($template_form, array(
        'config' => $this->config,
        'destination' => $currenturl,
        'fields' => $this->config['form']['fields'],
        'submit' => $this->config['form']['submit'],
      ));
    }

    return new \Twig_Markup($html, 'UTF-8');
  }

  /**
   * Check is all required fields are there
   *
   * @return boolean
   */
  protected function validateInput($postvars = array())
  {
    $has_errors = false;

    if($this->config['recaptcha']['enabled'] == true) {
      // request remote recaptcha
      $recaptcharesult = $this->dispatchRecaptchaRequest($postvars);
      dump('recaptcha result', $recaptcharesult->success);
      if($recaptcharesult->success != true || $recaptcharesult->success != 'true') {
        dump('recaptcha failed');
        $this->valid_input = false;
        $this->form_errors['recaptcha'] = 'Please complete the reCAPTCHA test.';
        $has_errors = true;
      }
    }

    foreach($this->config['form']['fields'] as $key => $field) {
      // test required fields
      if($field['required'] == true && empty($postvars[$key])) {
        $this->valid_input = false;
        $this->form_errors[$key] = str_replace('%label%', $field['label'], $field['placeholder']);
        $has_errors = true;
      }
      // do other tests - if you know what to do
    }

    if($has_errors) {
      dump('validator has errors');
      $this->valid_input = false;
      return $this->valid_input;
    } else {
      dump('validator thinks this is ok');
      $this->valid_input = true;
      return $this->valid_input;
    }
  }

  /**
   * Call the recaptcha remote request with curl
   *
   * @return mixed
   */
  protected function dispatchRecaptchaRequest($postvars)
  {
    $checkvars = [];

    $request_url = $this->config['recaptcha']['remoteurl'];

    $checkvars['secret'] = $this->config['recaptcha']['secret'];
    $checkvars['response'] = $postvars['g-recaptcha-response'];

    $remote_ip = $this->app['request']->server->get('REMOTE_ADDR');
    $forwarded_ip = $this->app['request']->server->get('HTTP_X_FORWARDED_FOR');

    if(!empty($forwarded_ip) && $remote_ip != $forwarded_ip) {
      $checkvars['remoteip'] = $forwarded_ip;
    } else {
      $checkvars['remoteip'] = $remote_ip;
    }
    dump('do dispatchRecaptchaRequest', $postvars, $request_url, $checkvars);

    foreach ($checkvars as $key => $value) {
      $sendvars[$key] = $value;
    }

    try {
      $response = $this->app['guzzle.client']->request('GET', $request_url, ['query' => $sendvars]);
      $returnvalue = $response->getBody()->getContent();
      $returnvaluej = json_decode($returnvalue);
    } catch(RequestException $e) {
      $request = $e->getRequest();
      if ($e->hasResponse()) {
        $returnvalue = $e->getResponse();
        $returnvalue->returnstatus = $returnvalue->getStatusCode();
      }
      dump('error dispatchRemoteRequest', $request, $returnvalue);
      $returnvalue->success = false;
      $returnvaluej = $returnvalue;
    }
    dump('end dispatchRecaptchaRequest', $returnvaluej, $returnvaluej);
    return $returnvaluej;
  }

  /**
   * Call the remote request with curl
   */
  protected function dispatchRemoteRequest()
  {

    $request_url = 'http://'. $this->config['credentials']['fields']['j_username'] .':'. $this->config['credentials']['fields']['j_password'] .'@www.europeana.eu/api/admin/apikey';

    //dump('start dispatchRemoteRequest postvars', $request_url);
    $postvars = $this->app['request']->request->all();
    $valid_keys = ['email', 'firstName', 'lastName', 'company'];
    foreach ($postvars as $key => $value) {
      if (in_array($key, $valid_keys)) {
        $sendvars[$key] = $value;
      }
    }
    //dump('dispatchRemoteRequest sendvars', $sendvars);

    try {
      $response = $this->app['guzzle.client']->request(
        'POST',
        $request_url,
        ['form_params' => $sendvars]
      );
      $returncontent = $response->getBody()->getContent();
      if(is_string($returncontent)) {
        $returnvalue = json_decode($returncontent);
      } else {
        $returnvalue = $returncontent;
      }
      $returnvalue->success = true;
      $returnvalue->returnstatus = $response->getStatusCode();
    } catch(RequestException $e) {
      $request = $e->getRequest();
      if ($e->hasResponse()) {
        $returnvalue = $e->getResponse();
        $returnvalue->returnstatus = $returnvalue->getStatusCode();
      }
      dump('error dispatchRemoteRequest', $request, $returnvalue);
      $returnvalue->success = false;
    }
    // dump('end dispatchRemoteRequest', $returnstatus, $returnvalue);
    return $returnvalue;
  }

  /**
   * Set the defaults for configuration parameters
   *
   * @return array
   */
  protected function getDefaultConfig()
  {
    return array(
      'templates'=> array(
        'apikeyform' => 'apikeyform.twig',
        'thankspage' => 'thankspage.twig',
      ),
      'form' => array(
        'fields'      => array(
          'email' => array(
            'label' => 'Email address',
            'placeholder' => 'Enter your email address',
            'type' => 'email',
            'classes' => '',
            'required' => true,
            'error' => '',
          ),
          'firstName' => array(
            'label' => 'First Name',
            'placeholder' => 'Enter your first name',
            'type' => 'text',
            'classes' => '',
            'required' => true,
            'error' => '',
          ),
          'lastName' => array(
            'label' => 'Last Name',
            'placeholder' => 'Enter your last name',
            'type' => 'text',
            'classes' => '',
            'required' => true,
            'error' => '',
          ),
          'company' => array(
            'label' => 'Organisation',
            'placeholder' => 'Please enter the organization name in English',
            'type' => 'text',
            'classes' => '',
            'required' => false,
            'error' => '',
          ),
        ),
        'submit' => array(
          'label' => 'Request key',
        ),
      ),
      'credentials' => array(
        'base_uri'  => 'http://europeana.eu/api/',
        'login_url' => 'http://europeana.eu/api/login.do',
        'destination' => 'http://europeana.eu/api/apikey',
        'fields' => array(
          'j_username' => null,
          'j_password' => null,
        ),
      ),
    );
  }
}
