
$( document ).ready(function() {

    $('html').removeClass('no-js').addClass('js');

    //console.log("This JS file is engaged, captain. permission to fly?");

    /**
    * vars
    */

    // Breakpoints, make same as base.css!!! In ems
    var breakSmall = 6.25; // 100
    var breakMedium = 24; // 384
    var breakLarge = 47.9375; // 767
    var breakXlarge = 80; // 1280
    var breakWide = 90; // 1440
    var breakXwide = 100; // 1600
    // var breakXxwide = 100; // 1600
    // var breakRUinsane = 115;

    // custom breakpoints for menu, set to optimize menu
    var breakMenuFull = 60; //960

    var resizeId;

    var windowWidth = viewportSize.getWidth(); //replaces buggy and unreliable $(window).width();
    // assume base font size is 16px
    var windowWidthEms = ((viewportSize.getWidth()) / 16);

    //console.log(windowWidthEms);

    /**
     * initial checks for page setup. Checks the viewport width and does some
     * actions for the UI based on screen size
     */

    preLoadChecks();

    /**
     * do some checks when window is resized
     */
    $(window).resize(function() {
            clearTimeout(resizeId);
            resizeId = setTimeout(preLoadChecks, 20);
    });



    /**
    * off-canvas menu on mobile
    */

    $('.menu-toggle').on( "click", function(e) {
        e.preventDefault();
        var nav = $("nav.main-menu");
        var headerHeight = $('header').height();
        var windowHeight = (viewportSize.getHeight())
        var fullHeight = ($('body').height())-headerHeight;
        var iconmenu = $('svg.icon-menu', this);
        var iconclose = $('svg.icon-delete', this);

        if ( nav.hasClass('is-overlay') ){
            // Doe dicht
            iconclose.fadeOut('fast');
            iconmenu.fadeIn('fast');
            //inschuiven menu

            nav.animate({
                left: "-235"
            }, 100, function() {
            // Animation complete.
            });
            nav.removeClass('is-overlay');


        } else {
            // Doe open
            nav.addClass('is-overlay').css({
                'top': headerHeight,
                'min-height': windowHeight,
                'height': fullHeight });
            iconclose.fadeIn('fast');
            iconmenu.fadeOut('fast');
            //inschuiven menu

            nav.animate({
                left: '+=235'
            }, 100, function() {
            // Animation complete.
            });
        }

    });


    /**
    * submit sortform on click of icon
    */

    $('#sortbar button').hide();

    $('#sortbar input[type=radio]').on('change', function() {
        // console.log('KLIKKERDIEKLIK');
        $('#sortbar').submit();
    });




    /**
    * show searchform on mobile
    */

    $('.search-toggle').on( "click", function(e) {
        e.preventDefault();

        var search = $('header .searchform')
        var nav = $("nav.main-menu");

        if (search.hasClass('is-open')) {
            //doe dicht
            search.slideUp().removeClass('is-open');

            if (nav.hasClass('is-overlay')){
                nav.animate({
                    top: '-=71'
                });
            }

        } else {
            //doe open
            search.slideDown().addClass('is-open');

            if (nav.hasClass('is-overlay')) {
                console.log('is-overlay');
                nav.animate({
                    top: '+=71'
                });
            }
        }
    });


    /**
    * Show 'back to top' button on scroll up
    */

    var previousScroll = 0;
    headerHeight = $('#header').height();

    $(window).scroll(function() {
        var currentScroll = $(this).scrollTop();
        // console.log(currentScroll + " and " + previousScroll + " and " + headerHeight);

        if(currentScroll > headerHeight) {
            if (currentScroll > previousScroll) {
                // console.log('GOING DOWN!')
                $('#backtotop').removeClass('fixed');
                $('#backtotop').fadeOut('slow');

            } else {
                // console.log('GOING UP!')
                $('#backtotop').addClass('fixed');
                $('#backtotop').fadeIn('slow');
            }
        } else {
             $('#backtotop').removeClass('fixed');
        }
        previousScroll = currentScroll;
    });

    $('#backtotop').on( "click", function(e) {
        e.preventDefault();
        $('html, body').animate({scrollTop: '0px'}, 300);
        $(this).blur();
        $(this).trigger('touchend');

    });




    //  init jQuery plugin "minRead"
    //  https://github.com/heyimjuani/minRead

    //  check for read-time item
    if ( $(".read-time").length ) {

        var options = {
            where: ".read-time",                // where the "x min read" will be inserted. Defaults to ".min-read"
            wordsPerMinute  : 180,              // this is the avg adults can read on a screen, acording to wikipedia
            archive: true,                      // set to true if trying to fetch read time from another page. "false" by default
            archiveText: ".main-column",        // if archive: true, time will be calteaserlated using text on div specified here. Defaults to ".text"
            anchor: "h2 a",             // external article anchor class. Defaults to ".article-link"
            label: " minutes to read"
        };

        //  init for list views
        $(".teaser").minRead(options);

        //  init for page view with disabled "archive" function
        options.archive = 0;
        $(".main-column").minRead(options);
    }

    // Add inline anchors to quicklinks
    if( $('a.in-page-anchor').is('*') ) {
        // if there are in page anchors, add a link to each of them in the quicklinks navigation

        $('a.in-page-anchor').each(function() {
            $('.quicklinks ul').append(
                $('<li>').append(
                    $('<a>').text(
                        $(this).data('anchor-title')).attr(
                            {
                                'href': '#' + $(this).attr('name')
                            }
                        )
                )
            );
        });
        // remove the blank placeholder link if quicklinks were added
        $('.in-page-blank-link').detach();
    }



    /**
    * Open en close filelistings
    *
    */

    $('.can-expand').hide();

    $('.expand-toggle').on('click', function(e) {
        e.preventDefault();

        var sublist = $(this).find('.can-expand');

        if (sublist.length == 0) {
            // if no sublist found, we open the main collapse-content
            var sublist = $('section.file-browser ul.mainlist');
        }


        if ( sublist.hasClass('expanded') ) {
            $(this).removeClass('expand-toggle-open')
            sublist.removeClass('expanded').slideUp('fast');

        }else {
            sublist.addClass('expanded').slideDown();
            $(this).addClass('expand-toggle-open');
            // setTimeout(function() {
            //     $(this).addClass('expand-toggle-open2');
            //     console.log('tiktok');
            // }, 1100 );

        }


    })


    /**
     * Merge streamer colums into the first
     * Only works with 3 or 2 streamer columns per page.
     */
    var streamers = $('section.catstreamcontainer');
    if( $(streamers).is('*') ) {
        var amount = $(streamers).length;
        var first = $(streamers[0]).find('section.catstream');
        var mainwrap = $(streamers[0]).find('.inner-wrap');
        //console.log('first streamer column', first, mainwrap);
        if (amount > 1) {
            $(first).addClass('catstream-index1');
            var second = $(streamers[1]).find('section.catstream').detach();

            //console.log('second streamer', second);
            $(mainwrap).append($(second).addClass('catstream-index2'));
            $(streamers[1]).detach();
            if (amount > 2) {
                var third = $(streamers[2]).find('section.catstream').detach();
                //console.log('third streamer', third);
                $(mainwrap).append($(third).addClass('catstream-index3'));
                $(streamers[2]).detach();
                $(first).addClass('third');
                $(second).addClass('third');
                $(third).addClass('third');
            } else {
                $(first).addClass('half');
                $(second).addClass('half');
            }
        }
    }

    /**
         * preloadchecks function
         * checks viewport width and does some hides and show, and moves elements
         * based on design at viewport width
         */
    function preLoadChecks() {
        // update window width
        windowWidth = viewportSize.getWidth(); // $(window).width();
        windowWidthEms = (viewportSize.getWidth()) / 16;

        // if ( windowWidthEms > BREAKPOINT ) {
        // } else {
        // };


        if ( windowWidthEms < breakMenuFull ) {
            $('header .searchform').hide();
        }

        if ( windowWidthEms >= breakMenuFull ) {
            //remove all leftover inline styles from mobile view;
            $('nav.main-menu').removeAttr('style').removeClass('is-overlay');

            $('header .searchform').removeAttr('style');
        };


        if ( windowWidthEms >= breakLarge ) {

            /**
             * Only stick when page anchors are present.
             */
            if( $('a.in-page-anchor').is('*') ) {
                console.log('stickt u maar!');
                $('#topbar').stick_in_parent();
            }

        }



    };

});


