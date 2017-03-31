jQuery(document).ready(function($) {
    console.log('viewblocks js loaded');
    $('.viewblocks select').each(function() {
        $(this).on('change', function() {
            var currentvalue = $(this).val();

            var currentkey = $(this).attr('id');
            // console.log('the changed element', currentkey);

            var parent = $(this).parents('fieldset.viewblocks');
            // the currenttext is the current value
            var currenttext = $(parent).find('.visiblevalues .current-value');
            // the invisible text is the original value
            // var incurrenttext = $(parent).find('.visiblevalues .before-value');

            var field, key, subkey = currentkey;
            var match = currentkey.replace(']', '').split('[');
            if(match) {
                field = match[0] ? match[0] : currentkey;
                key = match[1] ? match[1] : null;
                subkey = match[2] ? match[2] : null;
            }
            console.log('field:', field, 'key:', key, 'subkey:', subkey, '- set to:', currentvalue);

            var newvalue, oldvalue;
            oldvalue = $(currenttext).text();
            if(oldvalue !== '') { newvalue = JSON.parse(oldvalue); } else { newvalue = ''; }
            newvalue[key] = currentvalue;

            currenttext.text(JSON.stringify(newvalue));
        });
    });
});
