<?php

namespace Bolt\Extension\Europeana\ApiLogin;

use Bolt\Extension\SimpleExtension;

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
    }

    if($this->posted && $this->valid_input) {
      $temp = $this->dispatchRemoteRequest();
      //dump($temp);
      if($temp->success == true) {
        $html = $this->renderTemplate($template_thanks, array(
          'config' => $this->config
        ));
        $this->app['logger.system']->info('Created API key.', array('event' => 'ApiKeyHelper'));
      } else {
        $html = "<p>There was an error requesting an API key. Please try again later.</p>";
        // dump('dispatchRemoteRequest did something wrong');
        // dump($temp);
        $this->app['logger.system']->error('Failed to create an API key', array('event' => 'ApiKeyHelper'));
      }
    } else {
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
      // dump('recaptcha result');
      // dump($recaptcharesult->success);
      if($recaptcharesult->success != true || $recaptcharesult->success != 'true') {
        // dump('recaptcha failed');
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
      $this->valid_input = false;
      return $this->valid_input;
    } else {
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
    //dump('start dispatchRecaptchaRequest');
    // dump($postvars);

    $checkvars = [];

    $ch = curl_init();
    $request_url = $this->config['recaptcha']['remoteurl'];
    //dump($request_url);

    $checkvars['secret'] = $this->config['recaptcha']['secret'];
    $checkvars['response'] = $postvars['g-recaptcha-response'];

    $remote_ip = $this->app['request']->server->get('REMOTE_ADDR');
    $forwarded_ip = $this->app['request']->server->get('HTTP_X_FORWARDED_FOR');

    if(!empty($forwarded_ip) && $remote_ip != $forwarded_ip) {
      $checkvars['remoteip'] = $forwarded_ip;
    } else {
      $checkvars['remoteip'] = $remote_ip;
    }
    // dump($checkvars);

    // format fields for curl request
    $fields_count = 0;
    foreach($checkvars as $key=>$value) {
      $fields_arr[] = $key.'='.$value;
      $fields_count++;
    }
    $fields_string = join('&', $fields_arr);

    curl_setopt($ch, CURLOPT_URL,            $request_url );
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1 );
    curl_setopt($ch, CURLOPT_HEADER,         false );
    curl_setopt($ch, CURLOPT_POST,           $fields_count );
    curl_setopt($ch, CURLOPT_POSTFIELDS,     $fields_string );
    // dump($ch);

    $returnvalue = curl_exec($ch);
    //dump($returnvalue);
    $returnvaluej = json_decode($returnvalue);
    //dump($returnvaluej);
    //dump('end dispatchRecaptchaRequest');
    return $returnvaluej;
  }

  /**
   * Call the remote request with curl
   */
  protected function dispatchRemoteRequest()
  {
    // dump('start dispatchRemoteRequest');

    $ch = curl_init();
    $request_url = 'http://'. $this->config['credentials']['fields']['j_username'] .':'. $this->config['credentials']['fields']['j_password'] .'@www.europeana.eu/api/admin/apikey';
    // dump($request_url);

    $postvars = $this->app['request']->request->all();

    $valid_keys = ['email', 'firstName', 'lastName', 'company'];
    foreach ($postvars as $key => $value) {
      if (in_array($key, $valid_keys)) {
        $sendvars[$key] = $value;
      }
    }

    // dump($sendvars);

    curl_setopt($ch, CURLOPT_URL,            $request_url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1 );
    curl_setopt($ch, CURLOPT_HEADER,         false );
    curl_setopt($ch, CURLOPT_POST,           1 );
    curl_setopt($ch, CURLOPT_POSTFIELDS,     json_encode($sendvars, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES) );
    curl_setopt($ch, CURLOPT_HTTPHEADER,     array('Content-Type: application/json'));
    //dump($ch);

    $returnvalue = curl_exec($ch);
    // dump($returnvalue);
    // dump('end dispatchRemoteRequest');
    return json_decode($returnvalue);
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
