ZOHO Import
===========

This extension will load external resources from ZOHO CRM and pare the data into records for Bolt.

## How to use

To use this extension it needs to be placed in the `extensions/local/europeana/zohoimport` directory of your bolt extension.

What resources will be loaded can be configured in the `zohoimport.europeana.yml` in the extension configuration directory.

When everything is configured the import can be performed with the following nut command: `php app/nut zoho:import`

## More information

Pulling data from the CRM into the CMS will require a custom extension for Bolt.
What this extension has to do is quite similar for all the three User Stories it applies to.

For example, #2 would do the following:
- It will run via a Cronjob. (once a night? once every hour? depending on how much changes will be expected)
- It fetches all Network Members from the CRM via the REST API.
 - It then iterates over all these items, comparing them with what we have in the corresponding Bolt table:
   - If it's a new item, create a new record in Bolt with this data
   - If it's an existing item, update some/all of the fields with the data fetched from the CRM
   - If there is a new photo, that photo will be fetched from ZOHO
- Finally, delete (or unpublish) items that are no longer present in the CRM.

For more info <a href="https://www.zoho.com/crm/help/api/api-methods.html">ZOHO API documentation</a>