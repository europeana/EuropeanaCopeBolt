Select Async Extension
======================

This extension sets up an async route for faux select fields

### Installation

### Routes

This extension adds several routes to the system.

`/selectasync` returns a status in JSON.

`/selectasync/type/{type}` returns the given type as JSON.

`/selectasync/type/{type}?search=bar&fields=id,title,status` performs a search within the {type} and returns the fields in JSON.

`/selectasync/types/{type,type,..}` returns the given types as JSON.

`/selectasync/types/{type,type,..}?search=bar&fields=id,title,status` performs a search for each type within the {types} and returns the fields in JSON.
