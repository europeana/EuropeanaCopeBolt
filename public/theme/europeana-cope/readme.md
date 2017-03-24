Bolt europeana-cope Theme
=========================

File Structure
--------------

These are the most important files, included in this theme.

```
.
├── css/
│   ├── maintenance.css      - Minimal stylesheet for maintenance mode.
│   └── simple.css           - Minimal stylesheet for nromal mode.
├── images/                  - Image files for this theme are put here.
├── js/                      - Javascript files for this theme are put here.
├── partials/
│   ├── _aside.twig          - Partial for the sidebar.
│   ├── _footer.twig         - Partial for the footer below every page.
│   ├── _header.twig         - Partial for the header banner with the site title.
│   ├── _master.twig         - Twig template, that is uses to 'extend' all pages (See 'template inheritance')
│   ├── _menu.twig           - Partial with macro for rendering the drop-down menu.
│   ├── _pager.twig          - Partial for rendering listing pagers.
│   ├── _record_footer.twig  - Partial with meta-information below a page or entry.
│   ├── _record_*.twig       - Partials with snippets of code for in detail displays of a record
│   ├── _taxonomy_links.twig - Partial with macro for rendering the taxonomy links
│   ├── _topbar.twig         - Partial containing the top menu bar
│   └── _view_*.twig         - Partials with delegation logic for templates in the views folder
├── views/                   - Several view templates that are called from partials_view_*.twig
├── index.twig               - Template used for 'home'
├── listing.twig             - Template used for 'listings', like `/pages` or `/category/movies`
├── maintenance_default.twig - Template used for the maintenance page
├── notfound.twig            - Template used for the '404 not found' pages
├── page.twig                - Template used for single record pages, like `/page/lorem-ipsum`
├── readme.md                - This file. :-)
├── record.twig              - Generic template used for single record pages, that don't have a specific template set.
├── search.twig              - Template used for listing search results.
└── theme.yml                - Theme-specific configuration.
```
