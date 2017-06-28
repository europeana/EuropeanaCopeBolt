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
                .sourceSwitcher()
                .compressSwitcher();

            $('.fileselectbuttongroup').each(function() {
                // console.log('uploadbutton hider', $(this));
                $(this).children('.fileinput-button').each(function() {
                    $(this).hide();
                });
            });

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
            //console.log('masterSwitcher triggered');
            return viewblock;
        },
        compressSwitcher: function() {
            var viewblock = $(this);
            var titleblock = viewblock.find('.titletoggle');
            $(titleblock).parents('.repeater-field').addClass('titletoggleblock');

            //console.log(viewblock);
            $(viewblock)
                .children('.panel-heading')
                .append($('<a>')
                    .attr({
                        'title': 'Compress the form for this module'
                    })
                    .html('<i class="fa fa-compress"></i>')
                    .addClass('btn btn-default btn-sm titletogglebutton')
                    .on('click', function(element) {
                        var titleviewblock = $(this).parents(".repeater-group");
                        //console.log('clicked toggle', $(this), element, titleviewblock);
                        if($(titleviewblock).hasClass('showonlytitle')) {
                            $(this).removeClass('btn-info')
                                .addClass('btn-default')
                                .attr({
                                    'title': 'Compress the form for this module'
                                })
                                .html('<i class="fa fa-compress"></i>');
                            $(titleviewblock).removeClass('showonlytitle');
                        } else {
                            $(this).addClass('btn-info')
                                .removeClass('btn-default')
                                .attr({
                                    'title': 'Expand the form for this module'
                                })
                                .html('<i class="fa fa-expand"></i>');
                            $(titleviewblock).addClass('showonlytitle');
                        }
                    })
                );
            //console.log('titleswitcher loading');
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
            var iconfield = viewblock.find('input[name*="icon"]');
            var imagefield = viewblock.find('input[name*="image"]');

            if(templatevalue === 'body' || templatevalue === 'collapsedcontent') {
                bodyblock.parents('.repeater-field').show();
                sourceselect.parents('.repeater-field').hide();
                orderselect.parents('.repeater-field').hide();
                iconfield.parents('.repeater-field').hide();
                imagefield.parents('.repeater-field').hide();
            } else if(templatevalue === 'streamercolumn') {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').hide();
                orderselect.parents('.repeater-field').show();
                iconfield.parents('.repeater-field').show();
                imagefield.parents('.repeater-field').hide();
            } else if(templatevalue === 'image') {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').hide();
                orderselect.parents('.repeater-field').hide();
                iconfield.parents('.repeater-field').hide();
                imagefield.parents('.repeater-field').show();
            } else {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').show();
                orderselect.parents('.repeater-field').show();
                iconfield.parents('.repeater-field').hide();
                imagefield.parents('.repeater-field').hide();
            }

            //console.log('templatesSwitcher triggered', viewblock.data('templatevalue'));
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
            var selectedamount = viewblock.find('input[name*="override_amount"]');

            if(ordervalue === 'tag' || ordervalue === 'tag_unpaged') {
                tagblock.parents('.repeater-field').show();
                categoryblock.parents('.repeater-field').hide();
                selectedamount.parents('.repeater-field').show();
            } else if(ordervalue === 'category' || ordervalue === 'category_unpaged') {
                tagblock.parents('.repeater-field').hide();
                categoryblock.parents('.repeater-field').show();
                selectedamount.parents('.repeater-field').show();
            } else if(ordervalue === 'specified') {
                tagblock.parents('.repeater-field').hide();
                categoryblock.parents('.repeater-field').hide();
                selectedamount.parents('.repeater-field').hide();
            } else {
                tagblock.parents('.repeater-field').hide();
                categoryblock.parents('.repeater-field').hide();
                selectedamount.parents('.repeater-field').show();
            }

            //console.log('orderSwitcher triggered', viewblock.data('ordervalue'));
            return viewblock;
        },
        filterSwitcher: function() {
            var viewblock = $(this);

            if(!viewblock.hasClass('master-switch-enabled')) {
                return viewblock;
            }

            var templatevalue = viewblock.data('templatevalue');

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

            // if(templatevalue === 'body' || templatevalue === 'image' || templatevalue === 'collapsedcontent') {
            //     sourceselect.parents('.repeater-field').hide();
            //     selectedamount.parents('.repeater-field').hide();
            //     orderselect.parents('.repeater-field').hide();
            //     console.log('hello', templatevalue);
            // }

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
                if (filtername.indexOf(sourcevalue) !== -1
                    && templatevalue !== 'body'
                    && templatevalue !== 'image'
                    && templatevalue !== 'collapsedcontent'
                    && ordervalue !== 'specified') {
                    // console.log('enable', sourcevalue, 'filtername', filtername);
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
            var selectedct = parentblock.find('.ajaxselector[name*="selected"], select[name*="selected"]');
            var amount =  selectedct.length;
            //console.log('selected content types', sourceselect, newvalue, parentblock, selectedct, amount);

            var templatevalue = viewblock.data('templatevalue');
            if(templatevalue === 'body' || templatevalue === 'image' || templatevalue === 'collapsedcontent') {
                sourceselect.parents('.repeater-field').hide();
                selectedamount.parents('.repeater-field').hide();
            } else {
                sourceselect.parents('.repeater-field').show();
            }

            var ordervalue = viewblock.data('ordervalue');

            // loop through all options to hide the source selector
            for (var ct = 0; ct < amount; ct++) {
                var currentct = $(selectedct[ct]);
                var ctname = currentct.attr('name') ? currentct.attr('name') : false;
                var parentfieldset = $(currentct.parents('.repeater-field'));
                parentfieldset.hide();
                if (ctname.indexOf(newvalue) !== -1
                    && templatevalue !== 'body'
                    && templatevalue !== 'image'
                    && templatevalue !== 'collapsedcontent'
                    && ordervalue !== 'specified') {
                    //console.log('enable', newvalue, 'ctname', ctname);
                    parentfieldset.show();
                }
            }
            return viewblock;
        },
        highlightSwitcher: function() {
            var highlightswitch = $('#pagetype');
            var highlightvalue = highlightswitch.val();
            if(highlightvalue === 'landingpage') {
                $('#highlightblock').show();
            } else {
                $('#highlightblock').hide();
            }
            //console.log('highlightSwitcher triggered', highlightvalue);
            return highlightswitch;
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
    //console.log('viewblocks js start');

    $('.repeater-slot .repeater-group').onAvailable(
        function() {
            //console.log('initializing viewblock for initial fields');
            $(this).each(function() {
                //console.log('initializing viewblocks for new field', $(this));
                $(this).loadViewBlock();
            });
        }
    );
    $('a.titletogglebutton').each(function() { $(this).click(); });

    var repeaterblock = $('fieldset.bolt-field-repeater > label');
    //console.log('repeater block', repeaterblock);
    $(repeaterblock)
        .after(
            $('<a>')
                .attr({
                    'title': 'Expand all modules'
                })
                .html('<i class="fa fa-expand"></i> Expand All')
                .addClass('btn btn-info btn-sm titletoggleallbutton pull-right')
                .on('click', function(element) {
                    //console.log('clicked toggle all', $(this), element, titleviewblock);
                    if($(this).hasClass('btn-default')) {
                        $(this).removeClass('btn-default')
                            .addClass('btn-info')
                            .attr({
                                'title': 'Compress all modules'
                            })
                            .html('<i class="fa fa-expand"></i> Expand All');
                        $('a.titletogglebutton.btn-default').each(function() { $(this).click(); });
                    } else {
                        $(this).addClass('btn-default')
                            .removeClass('btn-info')
                            .attr({
                                'title': 'Expand all modules'
                            })
                            .html('<i class="fa fa-compress"></i> Close all');
                        $('a.titletogglebutton.btn-info').each(function() { $(this).click(); });
                    }
                })
        );

    $('.repeater-add button, button.duplicate-button').on('click', function() {
        //console.log('a repeater is added');
        setTimeout(
            function() {
                $('.repeater-slot .repeater-group:not(.viewblocks)').onAvailable(
                    function() {
                        //console.log('initializing viewblocks for new fields', $(this));
                        $(this).loadViewBlock();
                    }
                );
            },
            200
        );
    });

    console.log('viewblocks js loaded');
    // add a collapsing block for the highlight bar in the back-end
    if( $('#pagetype').is('*') ) {
        var subs = $('<div>').attr({
            'id': 'highlightblock',
            'class': 'highlightblock'
        });
        subs.append($('#highlighttitle').parents('div[data-bolt-fieldset]'));
        subs.append($('#highlightsources').parents('div[data-bolt-fieldset]'));
        subs.append($('#highlightsubtype').parents('div[data-bolt-fieldset]'));
        subs.append($('#highlightcategory').parents('div[data-bolt-fieldset]'));
        subs.append($('#highlightlink').parents('div[data-bolt-fieldset]'));
        // console.log(subs);
        $('#pagetype').parents('div[data-bolt-fieldset]').after(subs);
        $('#pagetype').onAvailable(
            function() {
                //console.log('initializing highlightSwitcher for initial fields');
                $(this).each(function() {
                    //console.log('initializing highlightSwitcher for new field', $(this));
                    $(this).highlightSwitcher();
                });
            }
        );
        $('#pagetype').on('change', function() {
            $(this).highlightSwitcher();
        });
    }

    console.log('highlightswitcher js loaded');

    $('.fileselectbuttongroup').each(function() {
        // console.log('uploadbutton hider', $(this));
        $(this).children('.fileinput-button').each(function() {
            $(this).hide();
        });
        $(this).append($('<a>').attr({
            'href': 'https://www.dropbox.com',
            'target': '_blank'
        }).addClass('btn btn-primary btn-sm').html('<i class="fa fa-dropbox"></i> Upload files'));
    });

    console.log('uploadbuttons js loaded');

    // prepare modal dialog for cheatsheet
    var VB_cheatsheet = $('<div>')
        .addClass("modal fade bd-example-modal-lg")
        .attr({
            'id': "VB_cheatsheet",
            'tabindex': "-1",
            'role': "dialog",
            'aria-labelledby': "VB_cheatsheet",
            'aria-hidden': "true"
        })
        .append(
            $('<div>')
                .addClass("modal-dialog modal-lg")
                .attr({
                    'role': 'document'
                })
                .append(
                    $('<div>')
                        .addClass("modal-content")
                        .append(
                            $('<div>')
                                .addClass('modal-header')
                                .html('<b class="modal-title"><i class="fa fa-comment-o" aria-hidden="true"></i> Template cheatsheet</b><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>')
                        )
                        .append(
                            $('<div>')
                                .addClass('modal-body')
                                .html('<div class="container-fluid"><div class="row"><div class="col-md-4 col-sm-4"><span>Test</span></div><div class="col-md-8 col-sm-8"><p>This is the cheatsheet.</p></div></div></div>')
                        )
                        .append(
                            $('<div>')
                                .addClass('modal-footer')
                                .html('<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>')
                        )
                )
        );
    $('body').append(VB_cheatsheet);

    // Fill modal with content from link href
    $("#VB_cheatsheet").find(".modal-body")
        .load('/Europeana/ViewBlocks/cheatsheet.html #container');

    // add cheatsheetpopup
    $('a.cheatsheet:not(.haspopup)').each(function() {
        $(this).on('click', function() {
            $('#VB_cheatsheet').modal('show');
            console.log('showing cheatsheet');
        });
        $(this).addClass('haspopup');
    });
    console.log('cheatsheet js loaded');
});
