Europeana ViewBlocks extension
==============================

This extension adds javascript in the europeana site back-end that handles the modules for the landing pages.

If correctly installed the following files exist in the folder
`public/extensions/local/europeana/viewblocks`

- viewsblocks.backend.css
- viewsblocks.backend.js

It requires the following configuration for `contenttypes.yml`.

```yml
landingpages:
  name: Landing pages
  singular_name: Landing page
  slug: landingpages
  singular_slug: landingpages
  fields:
    modules:
      label: Modules
      type: repeater
      separator: true
      fields:
        title:
          type: text
          label: Title (optional)
          info: The title will be shown as title for the block, if the title is empty the block will not have a title either
          placeholder: Optional block title
          variant: inline
        subtitle:
          type: text
          label: Subtitle (optional)
          info: The subtitle is may be one short line of text
          placeholder: Optional short subtitle
          variant: inline
        templates:
          type: select
          default: teasers
          info: Use the template to select how the module will look
          postfix: Use the template to select how the module will look
          values:
            titles:           "Title with a link (_titles.twig)"
            teasers:          "Teaser view (_teasers.twig)"
            listing:          "Listing of records (_listing.twig)"
            details:          "Full details for single items (_details.twig)"
            banners:          "Banner view (_banners.twig)"
            calltoactionform: "Call to action form main page (_calltoactionform.twig)"
            calltoactionlink: "Call to action button main page (_calltoactionlinks.twig)"
            calltoactionblog: "Call to action blog page (_calltoactionblog.twig)"
            body:             "Show only the module body field (_body.twig)"
            # more options can be added here as needed
        body:
          type: html
          label: "Module body (optional)"
          height: 100px
          postfix: "Shown in module blocks as body text"
        ordering:
          type: select
          default: latest
          info: Use the ordering to select how the module will load records
          postfix: Use the ordering to select how the module will load records
          values:
            specified: Select some records below
            latest: The newest records first
            current: Currently relevant (based on start and end date)
            tagged: Records based on on a certain tag
            category: Records based on on a certain category
            alphabetical: Alphabetically ordered
            highlighted: Records based on highlighted flag
            random: A number of random records
        sources:
          type: select
          default: posts
          info: Use this to select what contenttype the module will load
          postfix: Use this to select what contenttype the module will load
          values:
            pages: Pages, Listings, Landingpages, Structures and Collections
            persons: Persons
            posts: Blogposts, Pressreleases, Publications and News
            data: Data, Applications, Documentation
            projects: Projects, Taskforces and Workinggroups
            jobs: Jobs
            events: Events
            resources: Resource blocks
        override_amount:
          type: integer
          label: Amount
          default: 3
          variant: inline
          info: "If this field is set this number will be used as the number of items in the listing"
        selected_pages:
          type: select
          default: ''
          multiple: true
          values: pages/id,title,status
          keys: id
          autocomplete: true
          sortable: true
          label: "Select Pages"
        selected_persons:
          type: select
          default: ''
          multiple: true
          values: persons/id,first_name,last_name,email,status
          keys: id
          autocomplete: true
          sortable: true
          label: "Select Persons"
        selected_posts:
          type: select
          default: ''
          multiple: true
          values: posts/id,title,status
          keys: id
          autocomplete: true
          sortable: true
          label: "Select Posts"
        selected_data:
          type: select
          default: ''
          multiple: true
          values: data/id,title,status
          keys: id
          autocomplete: true
          sortable: true
          label: "Select data"
        selected_projects:
          type: select
          default: ''
          multiple: true
          values: projects/id,title,status
          keys: id
          autocomplete: true
          sortable: true
          label: "Select Projects"
        selected_jobs:
          type: select
          default: ''
          multiple: true
          values: jobs/id,title,status
          keys: id
          autocomplete: true
          sortable: true
          label: "Select Jobs"
        selected_events:
          type: select
          default: ''
          multiple: true
          values: events/id,title,status
          keys: id
          autocomplete: true
          sortable: true
          label: "Select Events"
        selected_resources:
          type: select
          default: ''
          multiple: true
          values: resources/id,title,status
          keys: id
          autocomplete: true
          sortable: true
          label: "Select Resource Blocks"
        override_css_id:
          type: text
          label: DOM ID
          variant: inline
          placeholder: If you need to add a custom css ID you can enter that here
          info: If you need to add a custom css ID you can enter that here
        override_css_class:
          type: text
          label: CSS Class
          variant: inline
          placeholder: If you need to add custom css classes you can enter them here
          info: If you need to add custom css classes you can enter them here
      group: Main
```

