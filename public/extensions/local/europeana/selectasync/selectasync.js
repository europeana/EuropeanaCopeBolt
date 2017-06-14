/***** Load selectasync scripts ******/
jQuery(document).ready(function($) {
    SA_loadNewAsyncSelectors();

    $('.bolt-field-repeater').on('click', '.add-button, .duplicate-button', function() {
        SA_loadNewAsyncSelectors();
        console.log('selectasync js refreshed for new repeaters');
    });
    console.log('selectasync js loaded');
});

/* helper to fetch the content type from the css classnames */
function SA_findCT(keys) {
    return keys.match('ct-');
}
/* helper to fetch the fieldnames from the css classnames */
function SA_findFields(keys) {
    return keys.match('fields-');
}
/* helper to fetch the select key field from the css classnames */
function SA_findKey(keys) {
    return keys.match('key-');
}
/* helper to check if a string is a json srting */
function SA_isJson(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}
/**
 * Sets the value of the <input id="x"> to an array of id's
 * where x = the data-target from the given item
 *
 * The array keys are generated from data-id from the children of
 * the given item that have <div class="btn-group" data-id="n">
 *
 * @param item
 */
function SA_reCalculateIds(item) {
    var sortedIDs = [];
    item.children('div.btn-group').each(
        function(index, element) {
            sortedIDs.push($(element).data('id'));
        }
    );
    var target = item.data('target');
    console.log('target', target);
    $('#'+target).val(JSON.stringify(sortedIDs));
}
/**
 * SA_loadNewAsyncSelectors initializes all asyncselectors that don't have the class yet
 *
 * May be called again
 *
 */
function SA_loadNewAsyncSelectors() {
    $('.ajaxselector:not(.ispreloaded)').each(function() {
        //console.log('selectasync element:', $(this).attr('class'), $(this));
        var dataclasses = $(this).attr('class').split(/\s/);
        $(this).css({width: '100%'});
        $(this).data(
            'contenttype',
            dataclasses.find(SA_findCT).split('-').pop()
        );
        $(this).data(
            'contentfields',
            dataclasses.find(SA_findFields).replace('fields-', '').split('--')
        );
        $(this).data(
            'contentkey',
            dataclasses.find(SA_findKey).split('-').pop()
        );
        var divname = 'visible_' + $(this).attr('name');
        // make a placeholder with working stuff
        divname = divname.replace('modules', '');
        divname = divname.replace(']', '').replace('[', '_');
        divname = divname.replace(']', '').replace('[', '_');
        divname = divname.replace('__', '_');
        $(this).after(
            $('<div>').attr({
                'id': divname
            })
                .data({
                    'target': $(this).attr('id')
                })
                .attr({
                    'data-target': $(this).attr('id')
                })
                .addClass('selectasync-placeholder')
                .sortable({
                    forceHelperSize: true,
                    forcePlaceholderSize: true,
                    deactivate: function( ) {
                        SA_reCalculateIds($(this));
                    }
                })
        );
        $(this).addClass('ispreloaded');

        console.log('selectasync initialization for:', $(this).attr('name'));
    });

    $('div.selectasync-placeholder:not(.ispreloaded)').each(function() {

        // console.log('selectasync element:', $(this).attr('class'), $(this));
        var target = $('#' + $(this).data('target'));
        var placeholder = $(this);
        var datakeys = $(target).val();
        // console.log('selectasync element:', target, target.data(), datakeys);
        if(datakeys && SA_isJson(datakeys)) {
            datakeys = JSON.parse(datakeys);
        } else if(datakeys && !SA_isJson(datakeys)) {
            datakeys = datakeys.split(',');
        } else {
            // console.log('empty keys for ' + $(this).attr('name'));
            datakeys = [];
            return null;
        }

        console.log('loading data for selectasync element:', $(this).attr('id'), 'target:', $(this).data('target'));
        // preload options
        $.ajax({
            url: '/admin/selectasync/load/',
            type: 'GET',
            dataType: "json",
            context: placeholder,
            data: {
                ids: datakeys,
                type: target.data('contenttype'),
                fields: target.data('contentfields').join(',')
            },
            error: function(data) {
                console.log('error', data);
            },
            success: function(data) {
                var target = this;
                var unsorted = [];
                // console.log('result data', data.results[data.type], data, datavalues, target);
                if (data.results[data.type]) {
                    data.results[data.type].forEach(function(e, index) {
                        // console.log('adding item', e, 'to', target);
                        // console.log('original sortorder', datakeys);

                        // make sure there is a key
                        var key = (e.id)?e.id:index;
                        // at what position is the key originally
                        var datasort = datakeys.indexOf(key);
                        // make sure there is a title
                        var title = (e.title)?e.title:(e.last_name)?e.first_name + ' ' + e.last_name:'no title';
                        // make sure there is a status
                        var status = (e.status)?e.status:'draft';
                        unsorted.push(
                            $('<div>')
                                .addClass('btn-group')
                                .disableSelection()
                                .data({
                                    'for': key,
                                    'id': key,
                                    'status': status,
                                    'title': title,
                                    'sort': datasort
                                }).attr({
                                'id': 'sortable-'+key,
                                'for': key,
                                'data-for': key,
                                'data-id': key,
                                'data-status': status,
                                'data-title': title,
                                'data-sort': datasort,
                                'title': title
                            })
                                .append(
                                    $('<span>').text(title).addClass('btn btn-info btn-xs')
                                )
                                .append(
                                    $('<span>').attr({'aria-label':"Close"}).addClass('btn btn-warning btn-xs').html('<span aria-hidden="true">&times;</span>')
                                        .on('click', function() {
                                            var removable = $(this).parent();
                                            var sorter = $(this).parent().parent();

                                            // console.log('remove element', $(removable), 'from', sorter, sorter.attr('id'));
                                            // remove from visible list
                                            $(removable).remove();
                                            // remove from items
                                            SA_reCalculateIds(sorter);
                                        })
                                )
                        )
                    });
                }
                // reorder elements
                var orderedElements = unsorted;
                orderedElements.sort(function(a, b) {
                    // convert to integers from strings
                    a = parseInt($(a).data("sort"));
                    b = parseInt($(b).data("sort"));
                    // compare
                    if(a > b) {
                        return 1;
                    } else if(a < b) {
                        return -1;
                    } else {
                        return 0;
                    }
                });
                $(target).append(orderedElements);
                $(placeholder).addClass('ispreloaded');
            }
        });

        // console.log('selectasync load data for:', $(this).attr('name'), $(target).attr('name'));
    });
}
