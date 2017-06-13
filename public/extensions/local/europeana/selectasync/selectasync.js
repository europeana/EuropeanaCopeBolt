/***** Your javascript can go below here ******/
jQuery(document).ready(function($) {
    var $selectors = [];

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
        var newname = $(this).attr('name');
        newname = newname.replace('modules', 'ajaxselector');
        newname = newname.replace(']', '').replace('[', '-');
        newname = newname.replace(']', '').replace('[', '-');
        $(this).after(
            $('<select>').attr({
                'name': newname,
                'id': newname
            }).data({
                'target': $(this).attr('name')
            }).css({
                'width': '100%',
                'min-height': '2em'
            }).addClass('selectizer')
        );
        $(this).hide();
        // console.log('initialized selectasync:', newname);
        // console.log('selectasync parent:', $(this));
        // console.log('selectasync dataclasses:', $(this).data());
    });

    $('.selectizer').each(function() {
        // console.log('selectasync element:', $(this).attr('class'), $(this));
        var target = $('input[name="'+ $(this).data('target') + '"]');
        var datakeys = $(target).val();
        // console.log('selectasync element:', element, target, datakeys);
        datavalues = [];
        if(datakeys && isJson(datakeys)) {
            datakeys = JSON.parse(datakeys);
            console.log('datakeys from json', datakeys);
            datakeys.forEach(function(e) {
                datavalues.push({ id: e, title: 'item '+ e});
            });
            // preload options
            $.ajax({
                url: '/admin/selectasync/load/',
                type: 'GET',
                dataType: "json",
                data: {
                    ids: datakeys,
                    fields: target.settings.contentfields.join(',')
                },
                error: function(data) {
                    console.log('error', data);
                },
                success: function(data) {
                    data.results.forEach(function(current) {
                        datavalues.push(current);
                    });
                    console.log('result data', data.results, data);
                }
            });
            console.log('selectasync for ' + $(this).attr('name'), datakeys, datavalues);
        } else if(datakeys && !isJson(datakeys)) {
            datakeys = datakeys.split(',');
            console.log('datakeys from string', datakeys);
            $.ajax({
                url: '/admin/selectasync/load/',
                type: 'GET',
                dataType: "json",
                data: {
                    ids: datakeys,
                    fields: target.settings.contentfields.join(',')
                },
                error: function(data) {
                    console.log('error', data);
                },
                success: function(data) {
                    data.results.forEach(function(current) {
                        datavalues.push(current);
                    });
                    console.log('result data', data.results, data);
                }
            });
            console.log('selectasync for ' + $(this).attr('name'), datakeys, datavalues);
        } else {
            // console.log('selectasync for ' + $(this).attr('name') + ' is empty');
        }
        // console.log('target data', $(target).data());
        var options = {
            contentselector: $(target).attr('name'),
            contenttype: $(target).data('contenttype'),
            contentfields: $(target).data('contentfields'),
            contentkey: $(target).data('contentkey'),
            valuefield: 'id',
            labelField: 'title',
            searchField: ['title'],
            delimiter: ',',
            maxItems: null,
            create: false,
            options: datavalues,
            items: datakeys,
            render: {
                item: function(item, escape) {
                    console.log('render items', item, escape);
                    return '<div class="item">' +
                        (item.title ? '<span class="title">' + escape(item.title) + '</span>' : '') +
                        (item.status ? '<span class="status">' + escape(item.status) + '</span>' : '') +
                        '</div>';
                },
                option: function(item, escape) {
                    console.log('render options', item, escape);
                    return '<div class="option">' +
                        (item.title ? '<span class="title">' + escape(item.title) + '</span>' : '-no title-') +
                        (item.status ? '<span class="status">' + escape(item.status) + '</span>' : '') +
                        '</div>';
                }
            },
            load: function(query, callback) {
                if (!query.length) return callback();
                var settings = this.settings;
                console.log('load ajax content for:', settings.contentselector, 'with search term:', query);
                $.ajax({
                    url: '/admin/selectasync/type/' + settings.contenttype,
                    type: 'GET',
                    dataType: "json",
                    data: {
                        search: query,
                        fields: settings.contentfields.join(','),
                        type: settings.contenttype
                    },
                    error: function() {
                        callback();
                    },
                    success: function(data) {
                        callback(data.results[data.type]);
                    }
                });
            }
        };
        // console.log('selectize initialization', options, $(this).data());
        $selectors.push($(this).selectize(options));
        console.log('selectize initialization for:', $(this).attr('name'), $(target).attr('name'));
    });

    console.log('all selectors', $selectors);
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
