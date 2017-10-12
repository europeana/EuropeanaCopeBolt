<?php

namespace Bolt\Extension\Europeana\ZohoImport\Console;

use Bolt\Nut\BaseCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Nut command for the ZohoImport extension.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class ZohoImportCommand extends BaseCommand
{
    protected function configure()
    {
        $this
        ->setName('zoho:import')
        ->setDescription('Import contacts from ZOHO')
        ->addArgument(
            'type',
            InputArgument::OPTIONAL,
            'What type of import should be done: test, full, update, imageonly. Defaults to test'
        )
        ->addOption(
            'summary',
            null,
            InputOption::VALUE_NONE,
            'Display final summary output after update.'
        )
        ->addOption(
            'fast-forward',
            null,
            InputOption::VALUE_REQUIRED,
            'Jump to step X in the import process - only works in full or update. Defaults to empty.'
        )
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $type = $input->getArgument('type');

        switch ($type) {
            case 'full':
                $text = 'Running full import';
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
                $type = 'test';
                break;
        }
        $output->writeln("<info>" . $text . "</info>");

        if ($input->getOption('fast-forward')) {
            $ffwd = $input->getOption('fast-forward');
            $output->writeln("<info>fast forwarding to: " . $ffwd . "</info>");
            $this->app['zohoimport']->setFfwd($ffwd);
        }

        if ($type == 'full') {
            //$on_console = true;
            //$text .= $this->app['extensions.ZohoImport']->importJob($on_console);
            $this->app['zohoimport']->importJob(true, $output);
        } elseif ($type == 'update') {
            // do stuff
        } elseif ($type == 'imageonly') {
            // do stuff
        } else {
            // do stuff
            $text = "\n" . strip_tags(
                str_replace(
                    '<tr>',
                    "\n<tr>",
                    str_replace(
                        '</td><td>',
                        ': </td><td>',
                        $this->app['zohoimport']->zohoImportOverview(true, $output)
                    )
                )
            );
            $output->writeln($text);
        }

        if ($input->getOption('summary')) {
            $text = sprintf("<comment>Imported %d contacts</comment>", $num);
            $output->writeln($text);
        }
    }
}
