jQuery.fn.extend(
    {
        loadViewBlock: function() {
            //console.log('initializing viewblock', $(this));
            $(this).addClass('viewblocks');

            // prepare display according to current settings
            $(this)
                .masterSwitcher()
                .templateSwitcher()
                .orderSwitcher()
                .filterSwitcher()
                .sourceSwitcher();

            // add change handlers to block
            $(this).on('change', this.callChanges);

            return this;
        },
        callChanges: function() {
            //console.log('changes called', $(this));
            $(this)
                .masterSwitcher()
                .templateSwitcher()
                .orderSwitcher()
                .filterSwitcher()
                .sourceSwitcher();
        },
        masterSwitcher: function() {
            var viewblock = $(this);
            var masterswitch = viewblock.find('select[name*="enabled"]');
            $(masterswitch).parents('.repeater-field').addClass('masterswitch');

            var mastervalue = masterswitch.val();
            if(mastervalue === 'enabled') {
                viewblock.addClass('master-switch-enabled');
                viewblock.find('.repeater-field:not(.masterswitch)').show();
            } else {
                viewblock.removeClass('master-switch-enabled');
                viewblock.find('.repeater-field:not(.masterswitch)').hide();
            }
            console.log('masterSwitcher triggered');
            return viewblock;
        },
        templateSwitcher: function() {
            var viewblock = $(this);

            if(!viewblock.hasClass('master-switch-enabled')) {
                return viewblock;
            }

            // main block for this switcher
            var templateselect = viewblock.find('select[name*="templates"]');
            var templatevalue = templateselect.val();
            viewblock.data('templatevalue', templatevalue);

            // dependent blocks for this switcher
            var bodyblock = viewblock.find('textarea[name*="body"]');
            var sourceselect = viewblock.find('select[name*="sources"]');
            var orderselect = viewblock.find('select[name*="ordering"]');

            if(templatevalue === 'body') {
                bodyblock.parents('.repeater-field').show();
                sourceselect.parents('.repeater-field').hide();
                orderselect.parents('.repeater-field').hide();
            } else {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').show();
                orderselect.parents('.repeater-field').show();
            }

            console.log('templatesSwitcher triggered', viewblock.data('templatevalue'));
            return viewblock;
        },
        orderSwitcher: function() {
            var viewblock = $(this);

            if(!viewblock.hasClass('master-switch-enabled')) {
                return viewblock;
            }

            // main block for this switcher
            var orderselect = viewblock.find('select[name*="ordering"]');
            var ordervalue = orderselect.val();
            viewblock.data('ordervalue', ordervalue);

            // dependent blocks for this switcher
            var categoryblock = viewblock.find('input[name*="basecategory"]');
            var tagblock = viewblock.find('input[name*="basetag"]');

            if(ordervalue === 'tag' || ordervalue === 'tag_unpaged') {
                tagblock.parents('.repeater-field').show();
                categoryblock.parents('.repeater-field').hide();
            } else if(ordervalue === 'category' || ordervalue === 'category_unpaged') {
                tagblock.parents('.repeater-field').hide();
                categoryblock.parents('.repeater-field').show();
            } else {
                tagblock.parents('.repeater-field').hide();
                categoryblock.parents('.repeater-field').hide();
            }

            console.log('orderSwitcher triggered', viewblock.data('ordervalue'));
            return viewblock;
        },
        filterSwitcher: function() {
            var viewblock = $(this);

            if(!viewblock.hasClass('master-switch-enabled')) {
                return viewblock;
            }

            var sourceselect = viewblock.find('select[name*="sources"]');
            var sourcevalue = sourceselect.val();
            viewblock.data('sourcevalue', sourcevalue);

            // main block for this switcher
            var orderselect = viewblock.find('select[name*="ordering"]');
            var ordervalue = orderselect.val();
            viewblock.data('ordervalue', ordervalue);

            // dependent blocks for this switcher
            var parentblock = sourceselect.parents('.panel.viewblocks');
            var selectedamount = parentblock.find('input[name*="override_amount"]');

            var selectedfilter = parentblock.find('select[name*="filter"]');
            var filteramount = selectedfilter.length;

            //console.log('filterSwitcher content types', sourceselect, sourcevalue, parentblock, ordervalue, orderselect, selectedfilter, filteramount);

            var templatevalue = viewblock.data('templatevalue');
            // if(templatevalue === 'body') {
            //     sourceselect.parents('.repeater-field').hide();
            //     selectedamount.parents('.repeater-field').hide();
            // } else {
            //     sourceselect.parents('.repeater-field').show();
            // }

            var orderingvalue = viewblock.data('ordervalue');
            // if(orderingvalue === 'specified') {
            //     selectedamount.parents('.repeater-field').hide();
            // } else {
            //     selectedamount.parents('.repeater-field').show();
            // }

            // loop through all options to hide the filter selector
            for (var ct = 0; ct < filteramount; ct++) {
                var currentfilter = $(selectedfilter[ct]);
                var filtername = currentfilter.attr('name') ? currentfilter.attr('name') : false;
                var parentfilterset = $(currentfilter.parents('.repeater-field'));
                parentfilterset.hide();
                if (filtername.indexOf(sourcevalue) != -1
                    && templatevalue !== 'body'
                    && orderingvalue !== 'specified') {
                    //console.log('enable', sourcevalue, 'filtername', filtername);
                    parentfilterset.show();
                }
            }
            return viewblock;
        },
        sourceSwitcher: function() {
            var viewblock = $(this);

            if(!viewblock.hasClass('master-switch-enabled')) {
                return viewblock;
            }

            // main block for this switcher
            var sourceselect = viewblock.find('select[name*="sources"]');
            var newvalue = sourceselect.val();
            viewblock.data('sourcevalue', newvalue);
            //console.log('sourceSwitcher triggered', newvalue, sourceselect);

            // dependent blocks for this switcher
            var parentblock = sourceselect.parents('.panel.viewblocks');
            var selectedamount = parentblock.find('input[name*="override_amount"]');
            var selectedct = parentblock.find('select[name*="selected"]');
            var amount =  selectedct.length;
            //console.log('selected content types', sourceselect, newvalue, parentblock, selectedct, amount);

            var templatevalue = viewblock.data('templatevalue');
            if(templatevalue === 'body') {
                sourceselect.parents('.repeater-field').hide();
                selectedamount.parents('.repeater-field').hide();
            } else {
                sourceselect.parents('.repeater-field').show();
            }

            var orderingvalue = viewblock.data('ordervalue');
            if(orderingvalue === 'specified') {
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
                    && orderingvalue === 'specified') {
                    //console.log('enable', newvalue, 'ctname', ctname);
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
