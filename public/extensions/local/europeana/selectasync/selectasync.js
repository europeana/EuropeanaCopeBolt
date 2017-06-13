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

        console.log('selectasync dataclasses', $(this).data());

        var datakeys = $(this).val();
        datavalues = [];
        if(datakeys) {
            datakeys = JSON.parse(datakeys);
            datakeys.forEach(function(e) {
                datavalues.push({ id: e, text: 'item '+ e});
            });
            console.log('selectasync for ' + $(this).attr('name'), datakeys, datavalues);
        } else {
            console.log('selectasync for ' + $(this).attr('name') + ' is empty');
        }

        var options = { create: true, sortfield: 'text', options: datavalues, items: datakeys };

        var newoptions = {
            valueField: '/admin/selectasync/types/',
            labelField: 'name',
            searchField: 'name',
            create: false,
            contenttype: $(this).data('contenttype'),
            contentfields: $(this).data('contentfields'),
            contentkey: $(this).data('contentkey'),
            datavalues: datavalues,
            datakeys: datakeys,
            render: {
                option: function(item, escape) {
                    console.log('render results', item, escape);
                    return item;
                }
            },
            load: function(query, callback) {
                if (!query.length) return callback();
                console.log('load function', query, callback, this);
                $.ajax({
                    url: '/admin/selectasync/type/' + this.settings.contenttype,
                    type: 'GET',
                    dataType: "json",
                    data: {
                        search: query,
                        fields: this.settings.contentfields.join(',')
                    },
                    error: function() {
                        callback();
                    },
                    success: function(result) {
                        console.log(result);
                    }
                });
            }
        };
        console.log('selectize initialization', newoptions, $(this).data());
        $(this).selectize(newoptions);
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
