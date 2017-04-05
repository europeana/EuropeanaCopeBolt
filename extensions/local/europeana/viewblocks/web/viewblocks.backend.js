jQuery.fn.extend(
    {
        loadViewBlock: function() {
            console.log('initializing viewblock', $(this));
            $(this).addClass('viewblocks');

            // prepare display according to current settings
            $(this)
                .templateSwitcher()
                .orderSwitcher()
                .sourceSwitcher();

            // add change handlers to block
            $(this).on('change', this.callChanges);

            return this;
        },
        callChanges: function() {
            console.log('changes called', $(this));
            $(this)
                .templateSwitcher()
                .orderSwitcher()
                .sourceSwitcher();
        },
        templateSwitcher: function() {
            var viewblock = $(this);
            var templateselect = viewblock.find('select[name*="templates"]');
            var bodyblock = viewblock.find('textarea[name*="body"]');
            var newvalue = templateselect.val();
            viewblock.data('templatevalue', newvalue);
            if(newvalue == 'body') {
                bodyblock.parents('.repeater-field').show();
            } else {
                bodyblock.parents('.repeater-field').hide();
            }
            console.log('templatesSwitcher triggered', viewblock.data('templatevalue'));
            return viewblock;
        },
        orderSwitcher: function() {
            var viewblock = $(this);
            var orderselect = viewblock.find('select[name*="ordering"]');
            var templatevalue = viewblock.data('templatevalue');
            //console.log('templatevalue', templatevalue);
            if(templatevalue == 'body') {
                orderselect.parents('.repeater-field').hide();
            } else {
                orderselect.parents('.repeater-field').show();
            }
            var newvalue = orderselect.val();
            viewblock.data('ordervalue', newvalue);
            console.log('orderSwitcher triggered', viewblock.data('ordervalue'));
            return viewblock;
        },
        sourceSwitcher: function() {
            var viewblock = $(this);
            var sourceselect = viewblock.find('select[name*="sources"]');
            var newvalue = sourceselect.val();
            viewblock.data('sourcevalue', newvalue);
            //console.log('sourceSwitcher triggered', newvalue, sourceselect);
            var parentblock = sourceselect.parents('.panel.viewblocks');
            var selectedamount = parentblock.find('input[name*="override_amount"]');
            var selectedct = parentblock.find('select[name*="selected"]');
            var amount =  selectedct.length;
            //console.log('selected content types', sourceselect, newvalue, parentblock, selectedct, amount);

            var templatevalue = viewblock.data('templatevalue');
            if(templatevalue == 'body') {
                sourceselect.parents('.repeater-field').hide();
                selectedamount.parents('.repeater-field').hide();
            } else {
                sourceselect.parents('.repeater-field').show();
            }

            var orderingvalue = viewblock.data('ordervalue');
            if(orderingvalue == 'specified') {
                selectedamount.parents('.repeater-field').hide();
            } else {
                selectedamount.parents('.repeater-field').show();
            }

            // loop through all options to hide the source selector
            for (var ct = 0; ct < amount; ct++) {
                var currentct = $(selectedct[ct]);
                var ctname = currentct.attr('name') ? currentct.attr('name') : false;
                var parentfieldset = $(currentct.parents('.repeater-field'));
                parentfieldset.hide();
                if (ctname.indexOf(newvalue) != -1
                    && templatevalue !== 'body'
                    && orderingvalue == 'specified') {
                    console.log('enable', newvalue, 'ctname', ctname);
                    parentfieldset.show();
                }
            }
            return viewblock;
        },
        onAvailable: function(fn){
            var sel = this.selector;
            var timer;
            var self = this;
            if (this.length > 0) {
                fn.call(this);
            }
            else {
                timer = setInterval(function(){
                    if ($(sel).length > 0) {
                        fn.call($(sel));
                        clearInterval(timer);
                    }
                },50);
            }
        }
    }
);


jQuery(document).ready(function($) {
    console.log('viewblocks js start');

    $('.repeater-slot .repeater-group').onAvailable(
        function() {
            //console.log('initializing viewblock for initial fields');
            $(this).each(function() {
                console.log('initializing viewblocks for new field', $(this));
                $(this).loadViewBlock();
            });
        }
    );
    $('.repeater-add button').on('click', function() {
        //console.log('a repeater is added');
        setTimeout(
            function() {
                $('.repeater-slot .repeater-group:not(.viewblocks)').onAvailable(
                    function() {
                        console.log('initializing viewblocks for new fields', $(this));
                        $(this).loadViewBlock();
                    }
                );
            },
            200
        );
    });

    console.log('viewblocks js loaded');
});
