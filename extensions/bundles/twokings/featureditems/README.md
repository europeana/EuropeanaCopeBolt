# Bolt featured items extension

This extension provides event handlers for managing a chosen amount of featured items in bolt.

This is useful if you want to have sticky items on top of your listings, but you want to enforce
a maximum amount of promoted posts for the editors of the site.

You can set a field for each content type to manage the promoted status.
The key `hasfeatured` toggles if the content type has a featured item
The key `maxfeatured` manages the amount
The key `field` sets which field in the content type will be sued to set the featured flag

```
# Default configuration for featureditems extension
contenttypes:
    pages:
        hasfeatured: false      # this is the default
        maxfeatured: 1          # you may also have more than one
        field: featured         # the field in the content type that will be used as flag
    events:
        hasfeatured: true
        maxfeatured: 1
        field: featured
```
