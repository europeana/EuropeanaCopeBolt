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
            plugin.europeanaMenuHideInactive();
            plugin.europeanaMenuWatermark();

            //_europeanaMenu_private_method();
        };

        // clone the top level entries and add them to the dom
        plugin.europeanaMenuAddToplevelClone = function() {
            // add a new ul element
            var clonedMenu = $('<ul>').attr({
                'class': 'backlinks play-menu',
                'id': 'backlinks'
            });
            $element.find('> li:not(.home)').each(
                function() {
                    // add menu link and classes to a new li element
                    clonedMenu.append(
                        $('<li>')
                            .addClass($(this).attr('class'))
                            .append($(this).children('a').clone())
                    );
                    $(this).addClass('toplevel');
                }
            );

            // move the first element to the end
            $element.find('> li.home').each(
                function() {
                    // add menu link and classes to a new li element
                    clonedMenu.append(
                        $('<li>')
                            .addClass($(this).attr('class'))
                            .append($(this).children('a').clone())
                    );
                    $(this).addClass('toplevel');
                }
            );

            // add everything to the dom
            $element.after(clonedMenu);
        };

        // hide all incactive items
        plugin.europeanaMenuHideInactive = function() {
            if(!$element.find('li.home').hasClass('active')) {
                $element.find('> li').each(
                    function() {
                        if(!$element.data('hasActiveLink') && !$(this).hasClass('active')) {
                            //console.log('we dont have an active page');
                            $(this).find('ul.sub-menu').hide();
                        } else if(!$(this).hasClass('active')) {
                            //console.log('we have an active page', $element.data('hasActiveLink'));
                            $(this).hide();
                        }
                    }
                );
            } else {
                //console.log('were on the homepage');
                $element.find('ul.sub-menu').hide();
            }
        };

        // show we were here
        plugin.europeanaMenuWatermark = function() {
            // code goes here
            $element.addClass(plugin.settings.extraclass);
            // console.log('inside public plugin', element, $element);
        };

        var _europeanaMenu_private_method = function() {
            // code goes here
            // console.log('inside private plugin', element, $element);
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

    $.fn.clearActivePath = function() {
        return this.each(function() {
            // get the parent links
            $('li').removeClass('active');
        });
    };

    $.fn.findActivePath = function() {
        return this.each(function() {
            // get the parent links
            var activeLink = $(this).find('.active');
            // console.log(activeLink.length);
            // add active class to all parent items
            if(activeLink.length>0) {
                $(this).data('hasActiveLink', true);
                $(activeLink).parents('li').addClass('active');
            }
        });
    };

}(jQuery, window, document));

$(document).ready(function() {
    // attach the plugin to an element
    $('#playmenu').findActivePath().europeanaMenu({
        'extraclass': 'has-europeana-menu'
    });

    $('.play-menu .sub-menu a').each(function() {
        $(this).bind(
            'click touchend',
            function(e) {
                e.preventDefault();
                var target = $(this).attr('href');
                var title = $(this).text();
                var currentLi = $(this).parent();

                $('.play-menu').clearActivePath('active');
                // move selected item to top of menu
                currentLi.addClass('active');
                $('.play-menu').findActivePath('active');

                console.log('clicked link', target, title);

                // load the new page with ajax
                $('div.canvas').load(
                    target + ' div.canvas > *',
                    function( response, status, xhr ) {
                        if ( status == "error" ) {
                            var msg = "Sorry but there was an error: ";
                            $('div.canvas main').html($('<div>').text( msg + xhr.status + " " + xhr.statusText ));
                        }
                    }
                );
                // add url to history
                history.pushState(null, title, target);
                document.title = title;
            }
        );
    });
    //$('#playmenu').data('europeanaMenu').europeanaMenuWatermark();
    // get the value of a property
    //$('#playmenu').data('europeanaMenu').settings.foo;
});

