//  https://github.com/heyimjuani/minRead
/*
 *  modified by patrick tettenborn
 *  16.09.2014
 *  + set label configurable
 *  + add else-clause to settings.archive to avoid text flickering
*/

(function($) {

    $.fn.minRead = function( options ) {
        var settings = $.extend({}, $.fn.minRead.defaults, options);
        return this.each( function() {
            var element = $(this);
            if (settings.archive) {
                var articleLink = element.find(settings.anchor);
                var articleUrl = articleLink.attr("href");
                $.get(articleUrl, function(data){
                    var text = $(data).find(settings.archiveText).text();
                    var archiveTime = calculateTime(text, settings);
                    element.find(settings.where).text(archiveTime + settings.label);
                });
            }
            else {
                var time = calculateTime(element.text(), settings);
                element.parent().find(settings.where).text(time + settings.label);
            }
        });
    };
    function calculateTime(text, settings) {
    // return Math.ceil(text.split(' ').length / settings.wordsPerMinute) || 1;
    return Math.ceil(text.split(/\s+/g).length / settings.wordsPerMinute) || 1;
    }

    $.fn.minRead.defaults = {
        where   : ".min-read",
        wordsPerMinute  : 180,
        archive : false,
        archiveText : ".text",
        anchor : ".article-link",
        label: " min read"
    };

})(jQuery);