$(document).ready(function () {
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

    const getWindowEmWidth = () => { return  viewportSize.getWidth() / 16 };
    //console.log(windowWidthEms);

    var hasCookie = getCookie('epro_cookieconsent');

    /**
     * initial checks for page setup. Checks the viewport width and does some
     * actions for the UI based on screen size
     */
    preLoadChecks();

    /**
     * do some checks when window is resized
     */
    $(window).resize(function () {
        clearTimeout(resizeId);
        resizeId = setTimeout(preLoadChecks, 20);
        if (getWindowEmWidth() < breakLarge) {
            handleMobileMenu();
        }
    });

    /**
     * MOBILE MENU HANDLING
     */
    let mobileMenuState = 'collapsed';

    const flipMobileMenuState = () => {
        if (mobileMenuState === 'collapsed') {
            mobileMenuState = 'expanded';
        } else if (mobileMenuState === 'expanded') {
            mobileMenuState = 'collapsed';
        }
    };

    const handleMobileMenu = () => {
        var nav = $("nav.main-menu");
        var headerHeight = $('header').height();
        var windowHeight = (viewportSize.getHeight())
        var fullHeight = ($('body').height()) - headerHeight;
        var iconmenu = $('svg.icon-menu', this);
        var iconclose = $('svg.icon-delete', this);
        var toggleButton = $('button.menu-toggle');


        offsetHeight = headerHeight;


        if (mobileMenuState === 'collapsed') {
            // Doe dicht
            iconclose.hide();
            iconmenu.fadeIn('fast');
            toggleButton.attr('aria-expanded', false);

            //inschuiven menu
            nav.animate({
                left: "-235"
            }, 100, function () {
                // Animation complete.
            });
            nav.removeClass('is-overlay');
            nav.delay(100).hide(0);

        } else if (mobileMenuState === 'expanded') {
            // Doe open
            nav.show();
            nav.addClass('is-overlay').css({
                'top': 0,
                'min-height': windowHeight,
                'height': fullHeight
            });
            iconmenu.hide();
            iconclose.fadeIn('fast');
            toggleButton.attr('aria-expanded', true)

            //inschuiven menu
            nav.animate({
                left: '0'
            }, 100, function () {
                // Animation complete.
            });
        }
    };

    /**
     * off-canvas menu on mobile
     */
    $('.menu-toggle').on("click", function (e) {
        e.preventDefault();
        flipMobileMenuState();
        handleMobileMenu();
    });

    /**
     * end of mobile menu handling
     */

    /**
     * breadcrumbs / history path
     */

    // NOTE: breadcrumbs build, but client decided not to implement (yet). Here for reference.
    breadcrumbStateSaver(document.location.href, document.title);
    showBreadCrumb();


    /**
     * submit sortform on click of fields
     */
    $('#sortbar button').hide();
    $('#sortbar input').on('change', function () {
        // console.log('KLIKKERDIEKLIK');
        $('#sortbar').submit();
    });

    /**
     * show searchform on mobile
     */
    $('.search-toggle').on("click", function (e) {
        e.preventDefault();

        var search = $('#headersearch');
        var nav = $("nav.main-menu");

        if (search.hasClass('is-open')) {
            //doe dicht
            search.slideUp('fast').removeClass('is-open');
            $(this).attr('aria-expanded', false);


            if (nav.hasClass('is-overlay')) {
                nav.animate({
                    top: '-=71'
                });
            }
        } else {
            //doe open
            // search.slideDown('fast').addClass('is-open');

            search.slideDown('fast', function () {
                    $(this).css({
                        display: "flex"
                    })
                }
            ).addClass('is-open');

            $(this).attr('aria-expanded', true);

            if (nav.hasClass('is-overlay')) {

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
    $(window).scroll(function () {
        var currentScroll = $(this).scrollTop();
        // console.log(currentScroll + " and " + previousScroll + " and " + headerHeight);

        if (currentScroll > headerHeight) {
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

    $('#backtotop').on("click", function (e) {
        e.preventDefault();
        $('html, body').animate({scrollTop: '0px'}, 300);
        $(this).blur();
        $(this).trigger('touchend');
    });

    //  init jQuery plugin "minRead"
    //  https://github.com/heyimjuani/minRead

    //  check for read-time item
    if ($(".read-time").length) {

        var options = {
            where: ".read-time",                // where the "x min read" will be inserted. Defaults to ".min-read"
            wordsPerMinute: 180,              // this is the avg adults can read on a screen, acording to wikipedia
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
    if ($('a.in-page-anchor').is('*')) {
        // if there are in page anchors, add a link to each of them in the quicklinks navigation
        $('.quicklinks').show();

        $('a.in-page-anchor').each(function () {
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

    $('.quicklinks a').on('click', function() {
        $('.quicklinks a').removeAttr('aria-current');
        $(this).attr('aria-current', true);
    })

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
    $('.expand-toggle').on('click', function (e) {
        e.preventDefault();
        e.stopPropagation();

        var $this = $(this);

        // For this case, only pick the direct children, in case of (multiple)
        // nested `.expand-toggle` elements.
        var $sublist = $this.find('> .can-expand');

        var $buttonText = $this.find('span');

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
            $this.attr('aria-expanded', false);
            $buttonText.text('Expand all folders');
            $sublist.removeClass('expanded').slideUp('fast');
        } else {
            $sublist.addClass('expanded').slideDown();
            $this.addClass('expand-toggle-open');
            $this.attr('aria-expanded', true);
            $buttonText.text('Collapse all folders');
        }
    });

    /**
     * Open en close image attribution
     */
    $('button.image-info').on('mouseenter focus', function (e) {
        $(this).siblings('dl').addClass('expanded');
        $(this).attr('aria-expanded', true);
    });

    $(document).on('keyup', function (e) {
        const licenseAttributions = $('.license-attribution dl').not('.always-expanded');
        attributionPopup = $(e.target).siblings().first();
        if (e.key === 'Escape' && licenseAttributions.length > 0) {
            licenseAttributions.removeClass('expanded');
            licenseAttributions.each(function() {
                $(this).parent().find('.image-info').attr('aria-expanded', false);
                attributionPopup.attr('aria-expanded', false);
                attributionPopup.removeClass('expanded')
            });
        }

        if (e.key === 'Enter') {
            if(attributionPopup.attr('class') != 'expanded') {
                licenseAttributions.each(function() {
                    $(this).parent().find('.image-info').attr('aria-expanded', true);
                    attributionPopup.addClass('expanded')
                });
                attributionPopup.addClass('expanded')
            } else {
                licenseAttributions.removeClass('expanded');
                licenseAttributions.each(function() {
                    $(this).parent().find('.image-info').attr('aria-expanded', false);
                    attributionPopup.removeClass('expanded')
                });
            }
        }
    });

    $('.license-attribution dl').not('.always-expanded').on('mouseleave focusout', function (e) {
        $(this).removeClass('expanded');
        $(this).parent().find('.image-info').attr('aria-expanded', false);
    });

    /**
     * Open en close filters
     */
    $('.toggle-filter').on('click', function (e) {
        e.preventDefault();

        $('.filter-container').toggleClass('expanded');
    });

    $('.chapter-toggle').on('click', function (e) {
        e.preventDefault();

        var chapter = $(this).attr('data-slug');
        // console.log(chapter);

        // toggle filterlists
        $(this).parent('li').toggleClass('current');
        $('.chapter-toggle').not('.chapter-toggle-' + chapter).parent('li').removeClass('current');

        $('#filters-' + chapter).toggleClass('current');
        $('.filters-chapter').not('#filters-' + chapter).removeClass('current');
    });


    /**
     * TILES
     */

    $(".tile").on('mouseover', function (e) {
        $(this).find(".tile-front").hide();
        $(this).find(".tile-back").fadeIn();
        // console.log('OVER');
    });

    $(".tile").on('mouseleave', function (e) {
        $(".tile-back").stop().hide();
        $(this).find(".tile-front").fadeIn();
        // console.log('... en uit');
    });

    $(".tile-back").on("click", function() {
        var dataAttr = $(this).attr('data-url');

        if (typeof dataAttr !== 'undefined' && dataAttr !== false) {
            window.location.href = dataAttr;
        }
    });


    /**
     * FILTER
     *
     * data-bind
     *
     * Binds one input's value (a) to another (b).
     * When a changes, b is updated accordingly.
     * Currently used for filter, because (a) needs to be in a different
     * place in the HTML than (b). (a) is used for display, and (b) is used
     * for posting the form.
     */
    $("[data-bind]").on('change', function () {
        var b = updateDataBind(null, this);
        // trigger the change event manually
        // because changes from code do not trigger
        // the 'change' event by default.
        b.trigger('change');
    });

    // Set initial values
    $.each($("[data-bind]"), updateDataBind);

    function updateDataBind(index, elem) {
        var b = $($(elem).attr('data-bind'));
        b.attr('name', $(elem).attr('name'));
        b.val($(elem).val());

        return b;
    }

    /**
     * Merge streamer colums into the first
     * Only works with 3 or 2 streamer columns per page.
     */
    var streamers = $('section.catstreamcontainer');
    if ($(streamers).is('*')) {
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
    // console.log(registerlink);

    if (registerlink && $('body').hasClass('splashpage')) {
        var ticketbutton = $('<a>').text('Buy tickets').attr({
            'href': registerlink,
            'class': 'button outline header-action'
        });

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

        if (windowWidthEms < breakLarge) { // less then 767
            $(".sticky-header").trigger("sticky_kit:detach");
            // console.log(windowWidthEms, breakLarge, 'A')
        } else {
            // set filters outside list for desktop.
            // NOTE: Anke is lazy and has not coded for the edgecase where a Large window is resized to < Large.
            // hardly ever occurs. If happens, slap Anke and fix it yourself.
            $('.filters-chapter').appendTo('.filter-container');

        }


        if (windowWidthEms < breakMenuFull) { // less then 960
            // $('#headersearch').hide();

            if ($('#headersearch input').is(":focus")) {
                // resize is probably bc of upsliding keyboard; so no touching this element (breaks in android)
            } else {
                $('#headersearch').appendTo('header'); // put it back, if coming from large
            }

            // $('#topbar').stick_in_parent({
            //     offset_top: 64
            // });

            // $('#mainmenu').stick_in_parent({
            //     offset_top: 64
            // });


        } else {
            //remove all leftover inline styles from mobile view;
            $('nav.main-menu').removeAttr('style').removeClass('is-overlay');
            $('#headersearch').removeAttr('style');
            // stick it _in_ the header
            $('#headersearch').appendTo('.headercontainer');


            //  $('#mainmenu').stick_in_parent({
            //      offset_top: 75
            //  });

            // set sticky topbar
            //  $('#topbar').stick_in_parent({
            //     offset_top: 75
            // });
            $('.sticky-header').stick_in_parent();
        }

    }

});


function setCookie(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function eraseCookie(name) {
    document.cookie = name + '=; Max-Age=-99999999;';
}


// NOTE: breadcrumbs build, but client decided not to implement (yet). Here for reference.
//breadcrumbs -> https://stackoverflow.com/questions/18998797/create-breadcrumbs-dynamically-on-client-side-using-javascript
function bindEventToNavigation() {
    $.each($("#primary-menu li a"), function (index, element) {
        $(element).click(function (event) {
            breadcrumbStateSaver($(this).attr('href'), $(this).text());
            showBreadCrumb();
        });
    });
}

function breadcrumbStateSaver(link, text) {
    if (typeof (Storage) != "undefined") {
        text = text.split('|')[0];
        var items = [];
        if (sessionStorage.breadcrumb) {
            items = JSON.parse(sessionStorage.breadcrumb);
        }
        items.push("<a href='" + link + "'>" + text + "</a>");
        sessionStorage.breadcrumb = JSON.stringify(items);
    }
}

function showBreadCrumb() {
    var breadcrumbs = JSON.parse(sessionStorage.breadcrumb);
    $("#breadcrumbs").html(breadcrumbs.slice(-4, -1).join(' &raquo; '));
}

var waitForEl = function (selector, callback) {
    if (jQuery(selector).length) {
        callback();
    } else {
        setTimeout(function () {
            waitForEl(selector, callback);
        }, 100);
    }
};

// Scroll listing events or news with pagination into view

$(document).ready(function() {
    var paginationTarget = getCookie("pagination_target");
    
    checkCookie()

    function setCookie(cname, cvalue) {
        document.cookie = cname + "=" + cvalue + ";";
    }


    $('.listingnews-paginator.pagination a').on('click', function(e){
        let sectionClass = $(this).parents('section').attr('id');
        setCookie("pagination_target", sectionClass);
    });


    function checkCookie() {
        if (paginationTarget != "") {
            $("#" + paginationTarget)[0].scrollIntoView({
                behavior: "smooth", // or "auto" or "instant"
                block: "end" // or "end"
            });
        }
    }

    function getCookie(cname) {
        let name = cname + "=";
        let decodedCookie = decodeURIComponent(document.cookie);
        let ca = decodedCookie.split(';');
        for(let i = 0; i <ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
});
