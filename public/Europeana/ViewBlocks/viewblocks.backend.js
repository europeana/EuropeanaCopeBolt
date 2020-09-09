jQuery.fn.extend(
    {
        loadViewBlock: function() {
            //console.log('initializing viewblock', $(this));
            $(this).addClass('viewblocks');

            // prepare display according to current settings
            $(this)
                .compressSwitcher()
                .masterSwitcher()
                .templateSwitcher()
                .sourceSwitcher();

            $('.fileselectbuttongroup:not(.hiddenbutton)').each(function() {
                // console.log('uploadbutton hider', $(this));
                $(this).children('.fileinput-button').each(function() {
                    $(this).hide();
                });
                $(this).addClass('hiddenbutton');
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
                .sourceSwitcher();

            $('.fileselectbuttongroup:not(.hiddenbutton)').each(function() {
                // console.log('uploadbutton hider', $(this));
                $(this).children('.fileinput-button').each(function() {
                    $(this).hide();
                });
                $(this).addClass('hiddenbutton');
            });
        },
        compressSwitcher: function() {
            var viewblock = $(this);
            var viewblockheader = viewblock.find('.panel-heading .row .text-right');
            var titleblock = viewblock.find('.titletoggle');
            $(titleblock).parents('.repeater-field').addClass('titletoggleblock');

            //console.log('hi' , viewblock);
            $(viewblockheader)
                //.children('.panel-heading')
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
            var imageattribution = viewblock.find('input.attribution-group, select[name*="attribution"]');
            var filefield = viewblock.find('input[name*="singlefile"]');
            var fileslistpathfield = viewblock.find('input[name*="fileslistpath"]');
            var modulelinkfields = viewblock.find('input.modulemorelink');

            if(templatevalue === 'body' || templatevalue === 'collapsedcontent') {
                bodyblock.parents('.repeater-field').show();
                sourceselect.parents('.repeater-field').hide();
                orderselect.parents('.repeater-field').hide();
                iconfield.parents('.repeater-field').hide();
                imagefield.parents('.repeater-field').hide();
                imageattribution.parents('.repeater-field').hide();
                filefield.parents('.repeater-field').hide();
                fileslistpathfield.parents('.repeater-field').hide();
                modulelinkfields.parents('.repeater-field').hide();
            } else if(templatevalue === 'listingnews') {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').show();
                orderselect.parents('.repeater-field').show();
                iconfield.parents('.repeater-field').hide();
                imagefield.parents('.repeater-field').hide();
                imageattribution.parents('.repeater-field').hide();
                filefield.parents('.repeater-field').hide();
                fileslistpathfield.parents('.repeater-field').hide();
                modulelinkfields.parents('.repeater-field').show();
            } else if(templatevalue === 'streamercolumn') {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').hide();
                orderselect.parents('.repeater-field').show();
                iconfield.parents('.repeater-field').show();
                imagefield.parents('.repeater-field').hide();
                imageattribution.parents('.repeater-field').hide();
                filefield.parents('.repeater-field').hide();
                fileslistpathfield.parents('.repeater-field').hide();
                modulelinkfields.parents('.repeater-field').show();
            } else if(templatevalue === 'image' || templatevalue === 'image_full') {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').hide();
                orderselect.parents('.repeater-field').hide();
                iconfield.parents('.repeater-field').hide();
                imagefield.parents('.repeater-field').show();
                imageattribution.parents('.repeater-field').show();
                filefield.parents('.repeater-field').hide();
                fileslistpathfield.parents('.repeater-field').hide();
                modulelinkfields.parents('.repeater-field').hide();
            } else if(templatevalue === 'filecontent') {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').hide();
                orderselect.parents('.repeater-field').hide();
                iconfield.parents('.repeater-field').hide();
                imagefield.parents('.repeater-field').hide();
                imageattribution.parents('.repeater-field').hide();
                filefield.parents('.repeater-field').show();
                fileslistpathfield.parents('.repeater-field').hide();
                modulelinkfields.parents('.repeater-field').hide();
            } else if(templatevalue === 'fileslisting') {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').hide();
                orderselect.parents('.repeater-field').hide();
                iconfield.parents('.repeater-field').hide();
                imagefield.parents('.repeater-field').hide();
                imageattribution.parents('.repeater-field').hide();
                filefield.parents('.repeater-field').hide();
                fileslistpathfield.parents('.repeater-field').show();
                modulelinkfields.parents('.repeater-field').hide();
            } else {
                bodyblock.parents('.repeater-field').hide();
                sourceselect.parents('.repeater-field').show();
                orderselect.parents('.repeater-field').show();
                iconfield.parents('.repeater-field').hide();
                imagefield.parents('.repeater-field').hide();
                imageattribution.parents('.repeater-field').hide();
                filefield.parents('.repeater-field').hide();
                fileslistpathfield.parents('.repeater-field').hide();
                modulelinkfields.parents('.repeater-field').hide();
            }

            //console.log('templatesSwitcher triggered', templatevalue);
            return viewblock;
        },
        sourceSwitcher: function() {
            var viewblock = $(this);

            if(!viewblock.hasClass('master-switch-enabled')) {
                return viewblock;
            }
            var templatevalue = viewblock.data('templatevalue');

            // switch the current ordering (selected items, latest, alphabetical etc.)
            var orderselect = viewblock.find('select[name*="ordering"]');
            var ordervalue = orderselect.val();
            viewblock.data('ordervalue', ordervalue);

            // select a content type for the source
            var sourceselect = viewblock.find('select[name*="sources"]');
            var sourcevalue = sourceselect.val();
            viewblock.data('sourcevalue', sourcevalue);
            var parentblock = sourceselect.parents('.panel.viewblocks');

            // dependent blocks for this switcher

            // current selected content filter
            var selectedfilter = parentblock.find('select[name*="filter"]');

            // current selected content items
            var selectedct = parentblock.find('.ajaxselector[name*="selected"], select[name*="selected"]');

            // selected amount (not for ordervalue == selected)
            var selectedamount = viewblock.find('input[name*="override_amount"]');

            // selected category (only for ordervalue == *category)
            var categoryblock = viewblock.find('input[name*="basecategory"]');
            var marketblock = viewblock.find('input[name*="basemarket"]');

            // selected category (only for ordervalue == *tag)
            var tagblock = viewblock.find('input[name*="basetag"]');

            // console.log('sourceSwitcher triggered', {
            //     'templatevalue': ordervalue,
            //     'order': ordervalue,
            //     'source': sourcevalue
            // } );

            if(templatevalue === 'body' || templatevalue === 'filecontent' || templatevalue === 'fileslisting' || templatevalue === 'image' || templatevalue === 'collapsedcontent') {
                console.log('hiding source, order, amount, selector, category and tags');
                sourceselect.parents('.repeater-field').hide();
                selectedamount.parents('.repeater-field').hide();
                tagblock.parents('.repeater-field').hide();
                categoryblock.parents('.repeater-field').hide();
                marketblock.parents('.repeater-field').hide();
                selectedfilter.parents('.repeater-field').hide();
                selectedct.parents('.repeater-field').hide();
            } else {
                sourceselect.parents('.repeater-field').show();
                orderselect.parents('.repeater-field').show();

                if(ordervalue !== 'specified') {
                    // hide all source selector
                    $(selectedct).each(function() {
                        $(this).parents('.repeater-field').hide();
                    });

                    // loop through all options to only show the current filter selector
                    for (var fi = 0; fi < selectedfilter.length; fi++) {
                        var currentfilter = $(selectedfilter[fi]);
                        var filtername = currentfilter.attr('name') ? currentfilter.attr('name') : false;
                        var parentfilterset = $(currentfilter.parents('.repeater-field'));
                        parentfilterset.hide();
                        if (filtername.indexOf(sourcevalue) !== -1) {
                            // console.log('enable filter', sourcevalue, 'filtername', filtername);
                            parentfilterset.show();
                        }
                    }
                }

                if(ordervalue === 'tag' || ordervalue === 'tag_unpaged') {
                    tagblock.parents('.repeater-field').show();
                    categoryblock.parents('.repeater-field').hide();
                    marketblock.parents('.repeater-field').hide();
                    selectedamount.parents('.repeater-field').show();
                } else if(ordervalue === 'category' || ordervalue === 'category_unpaged') {
                    tagblock.parents('.repeater-field').hide();
                    categoryblock.parents('.repeater-field').show();
                    marketblock.parents('.repeater-field').hide();
                    selectedamount.parents('.repeater-field').show();
                } else if(ordervalue === 'market' || ordervalue === 'market_unpaged') {
                    tagblock.parents('.repeater-field').hide();
                    categoryblock.parents('.repeater-field').hide();
                    marketblock.parents('.repeater-field').show();
                    selectedamount.parents('.repeater-field').show();
                } else if(ordervalue === 'calendar' || ordervalue === 'calendar_upcoming' || ordervalue === 'calendar_archive') {
                    sourceselect.parents('.repeater-field').show();
                    tagblock.parents('.repeater-field').show();
                    categoryblock.parents('.repeater-field').show();
                    marketblock.parents('.repeater-field').hide();
                    selectedamount.parents('.repeater-field').show();
                } else if(ordervalue === 'specified') {
                    tagblock.parents('.repeater-field').hide();
                    categoryblock.parents('.repeater-field').hide();
                    marketblock.parents('.repeater-field').hide();
                    selectedamount.parents('.repeater-field').hide();
                    // hide all filters
                    $(selectedfilter).each(function() {
                        $(this).parents('.repeater-field').hide();
                    });
                    // loop through all options to only show the current source selector
                    for (var ct = 0; ct < selectedct.length; ct++) {
                        var currentct = $(selectedct[ct]);
                        var ctname = currentct.attr('name') ? currentct.attr('name') : false;
                        var parentfieldset = $(currentct.parents('.repeater-field'));
                        parentfieldset.hide();
                        if (ctname.indexOf(sourcevalue) !== -1) {
                            console.log('enable', sourcevalue, 'ctname', ctname);
                            parentfieldset.show();
                        }
                    }
                } else {
                    tagblock.parents('.repeater-field').hide();
                    categoryblock.parents('.repeater-field').hide();
                    marketblock.parents('.repeater-field').hide();
                    selectedamount.parents('.repeater-field').show();
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

    $('.repeater-slot .repeater-group, .tab-pane').onAvailable(
        function() {
            //console.log('initializing viewblock for initial fields');
            $(this).each(function() {
                $(this).find('input.attribution-group, select[name*="attribution"]').parents('.repeater-field').addClass('image-attribution');
              $(this).find('input.image-attribution-group, select[name*="attribution"]').parents('.tab-pane div[data-bolt-fieldset]').addClass('image-attribution');
            });
        }
    );

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

    // show the repeater if there is only one
    var repeaters = $('fieldset.bolt-field-repeater div.repeater-group');
    if(repeaters.length === 1) {
        //console.log('show all repeaters because there is only one', repeaters.length, repeaters);
        $('a.titletogglebutton.btn-info').each(function() { $(this).click(); });
    }

    $('.bolt-field-repeater').on('click', '.add-button, .duplicate-button', function() {
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
        // add highlight subs to the collapsible block
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

        // OLD DROPBOX BUTTON
        // $(this).append($('<a>').attr({
        //     'href': 'https://www.dropbox.com',
        //     'target': '_blank'
        // }).addClass('btn btn-primary btn-sm').html('<i class="fa fa-dropbox"></i> Upload files'));

        const oembed = $('<button>').attr({
            'class': 'btn btn-tertiary btn-sm'
        }).html('<i class="fa fa-window-restore"></i> oEmbed');

        $(this).append(oembed);

        oembed.click(function(e){
            e.preventDefault();
            const form = $("<form>");

            form.attr({
                'data-action-preview': 'https://oembedjs-test.eanadev.org/',
                'data-method-preview': 'GET',
                'data-action-ok': '/admin/oembed/upload',
                'data-method-ok': 'POST',
            });

            const url = $("<div>").attr({
               'class': 'form-group'
            })
                .append($('<label>').text('Link'))
                .append($('<input>').attr({'name': 'url', 'type': 'url', 'class': 'form-control'}));
            form.append(url);

            const dimensions = $("<div>").attr({'class': 'row'});
            const width = $("<div>").attr({
                'class': 'form-group col-xs-6',
            })
                .append($('<label>').text('Width'))
                .append($('<input>').attr({'name': 'maxwidth', 'type': 'number', 'class': 'form-control'}))
                .append($('<small>').attr({'class': 'form-text text-muted'}).text('Optional'));
            dimensions.append(width);

            const height = $("<div>").attr({
                'class': 'form-group col-xs-6',
            })
                .append($('<label>').text('Height'))
                .append($('<input>').attr({'name': 'maxheight', 'type': 'number', 'class': 'form-control'}))
                .append($('<small>').attr({'class': 'form-text text-muted'}).text('Optional'));
            dimensions.append(height);

            form.append(dimensions);

            const preview = $("<div>").attr({'class': 'oembed-preview'})
                .append($('<label>').text('Preview'))
                .append($("<img>").attr({'class': 'oembed-thumbnail img-thumbnail'}))
                .append($("<input>").attr({'type': 'hidden', 'class': 'oembed-thumbnail-name'}))
                .hide();
            form.append(preview);

            const dialog = bootbox.confirm(form, function(result) {
                if (result) {
                    const field = $(e.target).closest('.elm-dropzone');
                    handleOembedOK(form, field);
                }
            });

            form.find(':input').change({ dialog }, fetchOembedThumbnail);

            dialog.find('[data-bb-handler="confirm"]').prop('disabled', true);
        });

        function fetchOembedThumbnail(e) {
            const form = $(e.target).closest('form');

            $.ajax({
                type: form.attr('data-method-preview'),
                url: form.attr('data-action-preview'),
                data: form.serialize(),
                success: function(response) {
                    form.find('.oembed-preview')
                        .show()
                        .find('.oembed-thumbnail')
                        .attr({'src': response.thumbnail_url});
                    form.find('.oembed-thumbnail-name').val(response.title + response.author_name + response.thumbnail_width);
                    e.data.dialog.find('[data-bb-handler="confirm"]').prop('disabled', false);
                },
                failure: function(response) {
                    console.log(response);
                }
            });
        }

        function handleOembedOK(form, field) {
            $.ajax({
                type: form.attr('data-method-ok'),
                url: form.attr('data-action-ok'),
                data: {
                    'url': form.find('.oembed-thumbnail').attr('src'),
                    'name': form.find('.oembed-thumbnail-name').val(),
                },
                success: function(response) {
                    field.find('.image-attribution-group').val(response.url);
                    field.find('.image-attribution-group').attr('changeWithoutSelection', false);
                    field.find('img').attr('src', response.preview);
                },
                failure: function(response) {
                    console.log(response);
                }
            });
        }

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
