
$( document ).ready(function() {


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
    * Return of the header on scroll up
    */
    // ^AW - Uitgezet omdat gedrag niet duidelijk is in combinatie met openklappend menu waar je ook doorheen moet scrollen.

    // var previousScroll = 0;
    // headerOrgOffset = $('#header').offset().top;

    // $(window).scroll(function() {
    //     var currentScroll = $(this).scrollTop();
    //     // console.log(currentScroll + " and " + previousScroll + " and " + headerOrgOffset);
    //     if(currentScroll > headerOrgOffset) {
    //         if (currentScroll > previousScroll) {
    //             console.log('GOING DOWN!')
    //             // $('#header').fadeOut();
    //             $('#header').animate({
    //             top: '-82'
    //             }, 50, function() {
    //             // Animation complete.
    //             });
    //         } else {
    //             console.log('GOING UP!')
    //             $('#header').addClass('fixed');
    //             $('#header').animate({
    //             top: '0'
    //             }, 50, function() {
    //             // Animation complete.
    //             });
    //         }
    //     } else {
    //          $('#header').removeClass('fixed');
    //     }
    //     previousScroll = currentScroll;
    // });


    //  init jQuery plugin "minRead"
    //  https://github.com/heyimjuani/minRead

    //  check for read-time item
    if ( !$(".read-time").length ) return;

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

    };

});


