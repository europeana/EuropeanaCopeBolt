ZOHO Import
===========

This extension will load external resources from ZOHO CRM and pare the data into records for Bolt.

## How to use

To use this extension it needs to be placed in the `extensions/local/europeana/zohoimport` directory of your bolt extension.

What resources will be loaded can be configured in the `zohoimport.europeana.yml` in the extension configuration directory.

When everything is configured an overview can be displayed with the following nut command: `php app/nut zoho:import`

When everything is configured the import can be performed with the following nut command: `php app/nut zoho:import full`

If an import has stalled, failed or was otherwise aborted the import can be continued with the following nut command: `php app/nut zoho:import full --fast-forward=5`

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

For more info <a href="https://www.zoho.com/crm/help/api/">ZOHO API documentation</a>

Note, the version 1.0 API is deprecated, the V2.0 api should be used soon: <a href="https://www.zoho.com/crm/help/api/v2/">ZOHO API V2 documentation</a>


## API limits

Check the api limits on the <a href="https://crm.zoho.com/crm/ShowSetup.do?tab=devSpace&subTab=api&action=developerapi">ZOHO CRM API top usage</a> or the <a href="https://crm.zoho.com/crm/ShowSetup.do?tab=devSpace&subTab=api&action=topUsage">ZOHO CRM API </a> page.


https://crm.zoho.com/crm/private/json/Accounts/searchRecords?authtoken=e95153d23c8b0d4a5eb5c885531f2d6b&scope=crmapi&criteria=((Organisation%20role:Accredited%20Aggregator)AND(Aggregator:Active))
