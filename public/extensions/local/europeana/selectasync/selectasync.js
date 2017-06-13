/***** Your javascript can go below here ******/
jQuery(document).ready(function($) {

    $('.ajaxselector').each(function(element) {
        //console.log('selectasync element:', element, $(this).attr('class'));

        var dataclasses = $(this).attr('class').split(/\s/);
        $(this).css({width: '100%'});
        $(this).data('contenttype',
            dataclasses.find(findCT).split('-').pop());
        $(this).data('contentfields',
            dataclasses.find(findFields).replace('fields-','').split('--'));
        $(this).data('contentkey',
            dataclasses.find(findKey).split('-').pop());

        //console.log('selectasync dataclasses', $(this).data());

        var datakeys = $(this).val();
        datavalues = [];
        if(datakeys) {
            datakeys = JSON.parse(datakeys);
            console.log('datakeys', datakeys);
            datakeys.forEach(function(e) {
                datavalues.push({ id: e, text: 'item '+ e});
            });
            $.ajax({
                url: '/admin/selectasync/load/',
                type: 'GET',
                dataType: "json",
                data: {
                    ids: datakeys,
                    fields: this.settings.contentfields.join(',')
                },
                error: function(data) {
                    console.log('error', data);
                },
                success: function(data) {
                    console.log('result data', data.results, data);
                }
            });
            console.log('selectasync for ' + $(this).attr('name'), datakeys, datavalues);
        } else {
            // console.log('selectasync for ' + $(this).attr('name') + ' is empty');
        }

        var options = {
            valueField: '/admin/selectasync/',
            labelField: 'name',
            searchField: 'name',
            create: false,
            contenttype: $(this).data('contenttype'),
            contentfields: $(this).data('contentfields'),
            contentkey: $(this).data('contentkey'),
            options: datavalues,
            items: datakeys,
            render: {
                item: function(item, escape) {
                    console.log('render items', item, escape);
                    return '<div>' +
                        (item.id ? '<span class="id">' + escape(item.id) + '</span>' : '') +
                        (item.title ? '<span class="title">' + escape(item.title) + '</span>' : '') +
                        (item.status ? '<span class="status">' + escape(item.status) + '</span>' : '') +
                        '</div>';
                },
                option: function(item, escape) {
                    console.log('render options', item, escape);
                    return '<div>' +
                        (item.id ? '<span class="id">' + escape(item.id) + '</span>' : '') +
                        (item.title ? '<span class="title">' + escape(item.title) + '</span>' : '') +
                        (item.status ? '<span class="status">' + escape(item.status) + '</span>' : '') +
                        '</div>';
                }
            },
            load: function(query, callback) {
                if (!query.length) return callback();
                var config = this.settings;
                //console.log('load function', query, config);
                $.ajax({
                    url: '/admin/selectasync/type/' + config.contenttype,
                    type: 'GET',
                    dataType: "json",
                    data: {
                        search: query,
                        fields: config.contentfields.join(',')
                    },
                    error: function() {
                        callback();
                    },
                    success: function(data) {
                        //console.log('result data from load function - callback:', callback, 'results:', data.results[data.type], 'data:', data);
                        var results = data.results[data.type];
                        var items = results.map(function(x) {
                            return { value: x.id, text: x.title };
                        });
                        //console.log('result items', items);
                        callback(items);
                    }
                });
            }
        };
        // console.log('selectize initialization', options, $(this).data());
        $(this).selectize(options);
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
