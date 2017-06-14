/***** Your javascript can go below here ******/
jQuery(document).ready(function($) {

    $('.ajaxselector').each(function() {
        //console.log('selectasync element:', $(this).attr('class'), $(this));

        var dataclasses = $(this).attr('class').split(/\s/);
        $(this).css({width: '100%'});
        $(this).data(
            'contenttype',
            dataclasses.find(findCT).split('-').pop()
        );
        $(this).data(
            'contentfields',
            dataclasses.find(findFields).replace('fields-', '').split('--')
        );
        $(this).data(
            'contentkey',
            dataclasses.find(findKey).split('-').pop()
        );
        divname = 'visible_' + $(this).attr('name');
        // make a placeholder with working stuff
        divname = divname.replace('modules', '');
        divname = divname.replace(']', '').replace('[', '_');
        divname = divname.replace(']', '').replace('[', '_');
        divname = divname.replace('__', '_');
        $(this).after(
            $('<div>').attr({
                'name': divname,
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
                    activate: function( event, ui ) {
                        console.log('sorting activate');
                    },
                    deactivate: function( event, ui ) {
                        console.log('deactivate');
                        reCalculateIds($(this));
                    },
                    change: function( event, ui ) {
                        console.log('change');
                    },
                    create: function( event, ui ) {
                        console.log('sortcreate');
                    }
                })
        );
    });

    $('div.selectasync-placeholder').each(function() {

        // console.log('selectasync element:', $(this).attr('class'), $(this));
        var target = $('#' + $(this).data('target'));
        var placeholder = $(this);
        var datakeys = $(target).val();
        // console.log('selectasync element:', target, target.data(), datakeys);
        datavalues = [];
        if(datakeys && isJson(datakeys)) {
            datakeys = JSON.parse(datakeys);
        } else if(datakeys && !isJson(datakeys)) {
            datakeys = datakeys.split(',');
        } else {
            // console.log('selectasync for ' + $(this).attr('name') + ' is empty');
            datakeys = [];
            return null;
        }
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
                                    $('<span>')
                                        .text(title)
                                        .addClass('btn btn-info btn-xs')
                                )
                                .append(
                                    $('<span>')
                                        .attr({'aria-label':"Close"})
                                        .addClass('btn btn-warning btn-xs')
                                        .html('<span aria-hidden="true">&times;</span>')
                                        .on('click', function() {
                                            var removable = $(this).parent();
                                            var sorter = $(this).parent().parent();

                                            console.log('remove element', $(removable), 'from', sorter, sorter.attr('id'));
                                            // remove from visible list
                                            $(removable).remove();
                                            // remove from items
                                            reCalculateIds(sorter);
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
            }
        });
        console.log('selectasync initialization for:', $(this).attr('name'), $(target).attr('name'));
    });
});

function findCT(keys) {
    return keys.match('ct-');
}
function findFields(keys) {
    return keys.match('fields-');
}
function findKey(keys) {
    return keys.match('key-');
}
function isJson(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}
function reCalculateIds(item) {
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
