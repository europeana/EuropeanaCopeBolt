jQuery.fn.extend(
    {
        loadViewBlock: function() {
            // the current textarea
            var currentkey = $(this).attr('id');
            var currentname = $(this).attr('name');

            // the parent of the current textarea - to define the context
            var datasource = $(this).parent();

            // get the values for the selectboxes
            var templates = $(datasource).data('templates')?$(datasource).data('templates'):{};
            var sources = $(datasource).data('sources')?$(datasource).data('sources'):{};
            var ordering = $(datasource).data('ordering')?$(datasource).data('ordering'):{};

            //console.log('intitializing viewblocks field', currentkey, templates, sources, ordering);
            console.log('intitializing viewblocks field', currentkey);

            var templatesselect = $('<select>')
                .attr(templates)
                .attr('data-for', currentname)
                .addClass(templates.class).addClass('col-sm-9 form-control');
            for (var templatekey in templates.values) {
                templatesselect.append($('<option>').attr('value', templatekey).text(templates.values[templatekey]));
            }
            $(templatesselect).changeViewBlockHandler();

            var sourcesselect = $('<select>')
                .attr(sources)
                .attr('data-for', currentname)
                .addClass(sources.class).addClass('col-sm-9 form-control');
            for (var sourcekey in sources.values) {
                sourcesselect.append($('<option>').attr('value', sourcekey).text(sources.values[sourcekey]));
            }
            $(sourcesselect).changeViewBlockHandler();

            var orderingselect = $('<select>')
                .attr(ordering)
                .attr('data-for', currentname)
                .addClass(ordering.class).addClass('col-sm-9 form-control');
            for (var orderkey in ordering.values) {
                orderingselect.append($('<option>').attr('value', orderkey).text(ordering.values[orderkey]));
            }
            $(orderingselect).changeViewBlockHandler();

            // add the selectboxes to the document
            $(datasource).prepend(orderingselect).prepend($('<label>')
                .text(ordering.label)
                .addClass('col-sm-3 control-label'));
            $(datasource).prepend(sourcesselect).prepend($('<label>')
                .text(sources.label)
                .addClass('col-sm-3 control-label'));
            $(datasource).prepend(templatesselect).prepend($('<label>')
                .text(templates.label)
                .addClass('col-sm-3 control-label'));

            return this;
        },
        changeViewBlockHandler: function() {
            $(this).on('change', function() {
                var currentvalue = $(this).val();
                var currentkey = $(this).attr('name');
                var target = $(this).attr('data-for');
                // find the textarea with this name within the current parent
                var field = $(this).parents().find('textarea[name="' + target + '"]');
                // console.log('the changed element', currentkey, $(field).attr('name'));

                var key, subkey = currentkey;
                var match = currentkey.replace(']', '').split('[');
                if(match) {
                    key = match[1] ? match[1] : null;
                    subkey = match[2] ? match[2] : null;
                }
                console.log('field: ', target, ' key:', key, subkey, ' -  set to:', currentvalue);

                var newvalue, oldvalue;
                oldvalue = $(field).val();
                if(oldvalue.trim() != '') {
                    //console.log('not empty', oldvalue);
                    newvalue = JSON.parse(oldvalue);
                } else {
                    //console.log('empty', oldvalue);
                    newvalue = {
                        'templates': null,
                        'sources': null,
                        'ordering': null,
                    };
                }
                newvalue[key] = currentvalue;
                //console.log('newvalue', newvalue);

                $(field).val(JSON.stringify(newvalue));
            });
        }
    }
);


jQuery(document).ready(function($) {
    console.log('viewblocks js loaded');

    $('.viewblocks-field').each( function() {
        console.log('loading each viewblock for normal field', $(this).attr('name'));
        $(this).loadViewBlock();
    } );

    // $('.repeater-field .viewblocks .viewblocks-field').each(function() {
    //     console.log('loading repeater viewblock for repeater field', $(this).attr('name'));
    //     $(this).loadViewBlock();
    // } );


});
