$(document).ready(function () {
    var menu = $('ul.play-menu');
    $('ul.play-menu .sub-menu').hide();
    $('ul.play-menu .is-dropdown-submenu-parent').bind(
        'mouseover mouseout touchend',
        function(e) {
            e.preventDefault();
            //console.log(this);
            // move selected item to top of menu
            // hide all other menu items on same level
            // show submenu items
            $(this).children('.sub-menu').toggle();
        }
    );
});
