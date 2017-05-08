$(document).ready(function () {
    var menu = $('ul.play-menu');
    $(menu).findActivePath();
});

$.fn.findActivePath = function() {
    // get the parent links
    var activeLink = $(this).find('.active');
    // add active class to all parent items
    $(activeLink).parents('li').addClass('active');
};

