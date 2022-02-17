<?php

namespace Bolt\Extension\Europeana\ZohoImport\Logger;

class ZohoImportLogger
{
    private $app;

    public function __construct($app)
    {
        // set variables that are needed later
        $this->app = $app;
    }

    /**
     * Add messages to the bolt log
     * @param        $type
     * @param        $message
     * @param string $event
     * @param null   $context
     */
    public function logger($type, $message, $event = 'zoho', $context = null, $on_console = false, $consoleoutput = null)
    {

        // show verbose things on console
        if ($on_console) {
            $this->writeconsole($message, $type, $consoleoutput);
        }

        switch ($type) {
            case 'error':
                $this->app['logger.system']->error($message, [
                    'event' => $event,
                    'context' => $context
                ]);
                break;
            case 'warning':
                $this->app['logger.system']->warning($message, [
                    'event' => $event,
                    'context' => $context
                ]);
                break;
            case 'debug':
                $this->app['logger.system']->debug($message, [
                    'event' => $event,
                    'context' => $context
                ]);
                break;
            case 'info':
            default:
                $this->app['logger.system']->info($message, [
                    'event' => $event,
                    'context' => $context
                ]);
                break;
        }
    }


    /**
     * @param $message
     *
     * @param      $message
     * @param null $type
     */
    public function writeconsole($message, $type = null, $consoleoutput)
    {
        if (!empty($type) && in_array($type, ['info', 'error'])) {
            $message = sprintf('<%s>%s</%s>', $type, $message, $type);
        } elseif (in_array($type, ['warning', 'comment'])) {
            $message = sprintf('<comment>%s</comment>', $message);
        } else {
            $message = sprintf('<fg=cyan;bg=default>%s</>', $message);
        }

        if ($consoleoutput != null && (!($consoleoutput->isVerbose() || $consoleoutput->isVeryVerbose()))
            && $type == 'debug') {
            // skip all debug messages if not -v or -vv
            return;
        }

        if($consoleoutput != null) {
            $consoleoutput->writeln($message);
        }
    }
}