/***** Your javascript can go below here ******/
jQuery(document).ready(function($) {
    $('.ajaxselector').each(function(element) {
        //console.log('selectasync element:', element, $(this).attr('class'));
        var dataclasses = $(this).attr('class').split(/\s/);
        $(this).data('contenttype',
            dataclasses.find(findCT).split('-').pop());
        $(this).data('contentfields',
            dataclasses.find(findFields).replace('fields-','').split('--'));
        $(this).data('contentkey',
            dataclasses.find(findKey).split('-').pop());
        //console.log('dataclasses', $(this).data());
        $(this).select2({
            placeholder: {
                id: '-1', // the value of the option
                text: 'Select from ' + $(this).data('contenttype')
            },
            ajax: {
                url: function (params) {
                    //return '/some/url/' + params.term;
                    return "/bolt/selectasync/" + $(this).data('contenttype');
                },
                dataType: 'json',
                delay: 250,
                data: function (params) {
                    console.log('select2 data', params, $(this));
                    var query = {
                        search: params.term,
                        fields: $(this).data('contentfields'),
                        key: $(this).data('contentkey')
                    };
                    return query;
                },
                processResults: function (data, params) {
                    console.log('select2 processResults', data, params);
                    return {
                        results: data.results
                    };
                },
                cache: true
            },
            escapeMarkup: function (markup) { return markup; },
            minimumInputLength: 2
        });
    });

    /*
    $('.ajaxselector').select2({
        ajax: {
            url: "/bolt/selectasync/"+$(this).data('ct'),
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    search: params.term
                };
            },
            processResults: function (data, params) {
                return {
                    results: data.items
                };
            },
            cache: true
        },
        escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
        minimumInputLength: 2
    });
    */
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
