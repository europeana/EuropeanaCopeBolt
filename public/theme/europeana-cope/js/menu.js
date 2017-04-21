$(document).ready(function () {
    var menu = $('ul.play-menu');

    $(menu).findActivePath();
    $('ul.play-menu .sub-menu').hide();
    $('ul.play-menu li.is-parent > a').bind(
        'click touchend',
        function(e) {
            e.preventDefault();
            var target = $(this).attr('href');
            var title = $(this).text();
            var currentLi = $(this).parent();

            // hide all not current items in top-level
            $('ul.play-menu > li').removeClass('backlevel').removeClass('current').removeClass('active').children('.sub-menu').hide();


            // move selected item to top of menu
            currentLi.addClass('current').addClass('active').findActivePath();


            // hide all other menu items on same level
            $('ul.play-menu > li:not(.current):not(.secondary)').addClass('backlevel');

            // show submenu items
            currentLi.children('.sub-menu').show();

            console.log('clicked link', target, title, currentLi, this, $(this));

            // load the new page with ajax
            //$('div.canvas').showSpinner();
            $('div.canvas').load(target + ' div.canvas > *');
            //$('div.canvas').hideSpinner();
            // add url to history
            history.pushState(null, title , target);
            document.title = title;

        }
    );
});

$.fn.findActivePath = function() {
    // get the parent links
    var activeLink = $(this).find('.active');
    // add active class to all parent items
    $(activeLink).parents('li').addClass('active');
    // open all submenu's in parent tree
    console.log('findActivPath for', this, activeLink, $('li.active'));

};

