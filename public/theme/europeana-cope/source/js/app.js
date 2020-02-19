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
            iconclose.hide();
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
                'height': fullHeight
            });
            iconmenu.hide();
            iconclose.fadeIn('fast');


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

        var search = $('#headersearch');
        var nav = $("nav.main-menu");

        if (search.hasClass('is-open')) {
            //doe dicht
            search.slideUp('fast').removeClass('is-open');

            if (nav.hasClass('is-overlay')){
                nav.animate({
                    top: '-=71'
                });
            }
        } else {
            //doe open
            search.slideDown('fast').addClass('is-open');

            if (nav.hasClass('is-overlay')) {
                console.log('is-overlay');
                nav.animate({
                    top: '+=71'
                });
            }
        }
    });

    /**
     * Cookiebar
     */

    var cookiebar = $('#cookiebar');
    var hasCookie = getCookie('epro_cookieconsent');

    if (!hasCookie){
        cookiebar.show();
        cookiebar.find('button').on('click', function(){
            cookiebar.slideUp('fast');
            cookiebar.fadeOut();
            //set cookie
            setCookie('epro_cookieconsent','1',30);
        });
    }

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
                $('#backtotop').removeClass('fixed').fadeOut('slow');
            } else {
                // console.log('GOING UP!')
                $('#backtotop').addClass('fixed').fadeIn('slow');
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
        $('.quicklinks').show();

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

    }

    /**
     * Open and close filelistings.
     *
     * `e.stopPropagation` is needed because of potential nested folders in
     * `_fileslisting.twig`.
     *
     * See these files that make use of `.expand-toggle`:
     * - html/theme/europeana-cope/modules/_fileslisting.twig
     * - html/theme/europeana-cope/modules/_collapsedcontent.twig
     */
    $('.can-expand').hide();
    $('.expand-toggle').on('click', function(e) {
        e.preventDefault();
        e.stopPropagation();

        var $this = $(this);

        // For this case, only pick the direct children, in case of (multiple)
        // nested `.expand-toggle` elements.
        var $sublist = $this.find('> .can-expand');

        // Otherwise get `$this`'s _uncle_, because of wrappers around `$this`.
        if ($sublist.length === 0) {
            $sublist = $this.parent().next('.can-expand');
        }

        // Otherwise get another one!
        if ($sublist.length === 0) {
            $sublist = $this.parent().find('> .can-expand');
        }

        if ($sublist.hasClass('expanded')) {
            $this.removeClass('expand-toggle-open');
            $sublist.removeClass('expanded').slideUp('fast');

        }
        else {
            $sublist.addClass('expanded').slideDown();
            $this.addClass('expand-toggle-open');
        }
    });

    /**
    * Open en close image attribution
    */
    $('button.image-info').on('mouseenter', function(e){
        $(this).siblings('article').addClass('expanded');
    });

    $('.license-attribution article').not('.always-expanded').on('mouseleave', function(e){
        $(this).removeClass('expanded');
    });

    /**
    * Open en close filters
    */
    $('.toggle-filter').on('click',function(e){
        e.preventDefault();

        $('.filter-container').toggleClass('expanded');
    });

    $('.chapter-toggle').on('click', function(e){
        e.preventDefault();

        var chapter = $(this).attr('data-slug');
        // console.log(chapter);

        // toggle filterlists
        $(this).parent('li').toggleClass('current');
        $('.chapter-toggle').not('.chapter-toggle-'+chapter).parent('li').removeClass('current');

        $('#filters-'+chapter).toggleClass('current');
        $('.filters-chapter').not('#filters-'+chapter).removeClass('current');
    });


    /**
     * TILES
     */

    $(".tile").on('mouseover', function(e){
        $(this).find(".tile-front").hide();
        $(this).find(".tile-back").fadeIn();
        // console.log('OVER');
    });

    $(".tile").on('mouseleave', function(e){
        $(".tile-back").stop().hide();
        $(this).find(".tile-front").fadeIn();
        // console.log('... en uit');
    });

    $('.tile:nth-last-child(2), .tile:nth-last-child(1)').wrapAll('<div class="wrapped" />');



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

    /* Add button to splashpage header _if_ a registerbutton is there. */

    var registerlink = $('.eventregister .button').attr('href');
    console.log(registerlink);

    if (registerlink && $('body').hasClass('splashpage')) {
        var ticketbutton = $('<a>').text('Buy tickets').attr({'href': registerlink, 'class': 'button outline header-action'});

        $('header').append(ticketbutton);
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

        if ( windowWidthEms < breakLarge ) { // less then 767
            $("#topbar").trigger("sticky_kit:detach");
            $("#mainmenu").trigger("sticky_kit:detach");
            $(".sticky-header").trigger("sticky_kit:detach");
            // console.log(windowWidthEms, breakLarge, 'A')
        } else {
            // set filters outside list for desktop.
            // NOTE: Anke is lazy and has not coded for the edgecase where a Large window is resized to < Large.
            // hardly ever occurs. If happens, slap Anke and fix it yourself.
            $('.filters-chapter').appendTo('.filter-container');

        }

        if (( windowWidthEms >= breakLarge ) && ( windowWidthEms < breakMenuFull )) {
            $('#topbar').stick_in_parent({
                offset_top: 64
            });
        }

        if ( windowWidthEms < breakMenuFull ) { // less then 960
            // $('#headersearch').hide();
            $('#headersearch').appendTo('header'); // put it back, if coming from large

        } else {
             //remove all leftover inline styles from mobile view;
             $('nav.main-menu').removeAttr('style').removeClass('is-overlay');
             $('#headersearch').removeAttr('style');
             // stick it _in_ the header
             $('#headersearch').appendTo('.headercontainer');


             // set sticky topbar and menu
             $('#mainmenu').stick_in_parent({
                 offset_top: 75
             });
             $('#topbar').stick_in_parent({
                offset_top: 75
            });
            $('.sticky-header').stick_in_parent();
        }




        // if ( windowWidthEms >= breakLarge ) {
        //     // set filters outside list for desktop.
        //     // NOTE: Anke is lazy and has not coded for the edgecase where a Large window is resized to < Large.
        //     // hardly ever occurs. If happens, slap Anke and fix it yourself.
        //     $('.filters-chapter').appendTo('.filter-container');

        //     $('#topbar').stick_in_parent({
        //         offset_top: 64
        //     });
        // } else {

        // }

        // if ( windowWidthEms < breakMenuFull ) {
        //     $('#headersearch').hide();
        //     $('#headersearch').appendTo('header'); // put it back, if coming from large
        // }

        // if ( windowWidthEms >= breakMenuFull ) {
        //     //remove all leftover inline styles from mobile view;
        //     $('nav.main-menu').removeAttr('style').removeClass('is-overlay');
        //     $('#headersearch').removeAttr('style');
        //     // stick it _in_ the header
        //     $('#headersearch').appendTo('.headercontainer');

        //     // set sticky topbar and menu
        //     $('#mainmenu').stick_in_parent({
        //         offset_top: 75
        //     });

        //     $('.sticky-header').stick_in_parent();

        // } else {
        //    // remove stickyness when window is resized
        //    $("#topbar").trigger("sticky_kit:detach");
        //    $("#mainmenu").trigger("sticky_kit:detach");
        //    $(".sticky-header").trigger("sticky_kit:detach");

        // }


    }

});

function setCookie(name,value,days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days*24*60*60*1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "")  + expires + "; path=/";
}
function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}
function eraseCookie(name) {
    document.cookie = name+'=; Max-Age=-99999999;';
}
