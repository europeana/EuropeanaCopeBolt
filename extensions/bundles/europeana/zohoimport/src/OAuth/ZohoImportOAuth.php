<?php

namespace Bolt\Extension\Europeana\ZohoImport\OAuth;

use DateInterval;
use zcrmsdk\crm\setup\restclient\ZCRMRestClient;
use zcrmsdk\oauth\ZohoOAuth;

class ZohoImportOAuth
{
    private $app;
    private $oAuthConfiguration;
    private $oAuthToken;
    private $oAuthTokenExpiresInDatetime;
    /**
     * ZohoImportOAuth constructor.
     * @param $app
     */
    public function __construct($app, $oAuthConfiguration)
    {
        $this->app = $app;
        $this->oAuthConfiguration = $oAuthConfiguration;
    }

    public function authenticate($oAuthConfiguration)
    {
        $authenticatedDateTime = new \DateTime('now');

        // Token expires in 1 hour
        $this->oAuthTokenExpiresInDatetime = $authenticatedDateTime->add(new \DateInterval('PT1H'));

        $extensionsDir = $this->app['path_resolver']->resolve('extensions');
        $this->oAuthConfiguration['token_persistence_path'] = $extensionsDir . $this->oAuthConfiguration['token_persistence_path'];

        ZCRMRestClient::initialize($this->oAuthConfiguration);
        $oAuthClient = ZohoOAuth::getClientInstance();
        $refreshToken = $this->oAuthConfiguration['refresh_token'];
        $userIdentifier = $this->oAuthConfiguration['current_user_email'];
        $oAuthTokens = $oAuthClient->generateAccessTokenFromRefreshToken($refreshToken, $userIdentifier);
        $this->oAuthToken = $oAuthClient->getAccessToken($userIdentifier);
    }

    public function getExpiresInDatetime(){
        return $this->oAuthTokenExpiresInDatetime;
    }

    private function setOAuthToken($oAuthToken)
    {
        $this->oAuthToken = $oAuthToken;
    }

    public function getOAuthToken()
    {
        return $this->oAuthToken;
    }
}