/**
 * jQuery Europeana Menu plugin
 *
 * Based on
 * http://learn.jquery.com/plugins/basic-plugin-creation/
 * https://jqueryboilerplate.com/
 * https://css-tricks.com/snippets/jquery/jquery-plugin-template/
 * http://stefangabos.ro/jquery/jquery-plugin-boilerplate-revisited/
 */

;(function($, window, document, undefined) {
    $.europeanaMenu = function(element, options) {
        var plugin = this;

        plugin.settings = {};

        var $element = $(element), element = element;

        plugin.init = function() {
            plugin.settings = $.extend({}, $.europeanaMenu.defaultOptions, options);
            // code goes here
            plugin.europeanaMenuAddToplevelClone();
            plugin.europeanaMenuWatermark();

            //_europeanaMenu_private_method();
        };

        // clone the top level entries and add them to the dom
        plugin.europeanaMenuAddToplevelClone = function() {
            var clonedMenu = $('<ul>').attr({
                'class': 'clone play-menu',
                'id': 'toplevelclone'
            });
            $element.find('> li').each(function() {
                $(this).addClass('toplevel');
                clonedMenu.append($('<li>').addClass($(this).attr('class')).append($(this).children('a').clone()));
            });
            var firstItem = clonedMenu.first().detach();
            clonedMenu.append(firstItem);
            $element.after(clonedMenu);
        };

        // show we were here
        plugin.europeanaMenuWatermark = function() {
            // code goes here
            $element.addClass(plugin.settings.extraclass);

            console.log('inside public plugin', element, $element);
        };

        var _europeanaMenu_private_method = function() {
            // code goes here
            console.log('inside private plugin', element, $element);
        };

        plugin.init();
    };

    $.europeanaMenu.defaultOptions = {
        extraclass: 'has-menu',
        onMenuChange: function() {},
        onMenuLoad: function() {}
    };

    $.fn.europeanaMenu = function(options) {
        return this.each(function() {
            if (undefined == $(this).data('europeanaMenu')) {
                var plugin = new $.europeanaMenu(this, options);
                $(this).data('europeanaMenu', plugin);

                // do stuff
            }
        });
    };

    $.fn.findActivePath = function() {
        // get the parent links
        var activeLink = $(this).find('.active');
        // add active class to all parent items
        $(activeLink).parents('li').addClass('active');
    };

}(jQuery, window, document));

$(document).ready(function() {
    // attach the plugin to an element
    $('ul.main-menu').europeanaMenu({
        'extraclass': 'has-europeana-menu'
    }).findActivePath();

    //$('ul.play-menu').data('europeanaMenu').europeanaMenuWatermark();
    // get the value of a property
    //$('ul.play-menu').data('europeanaMenu').settings.foo;
});
