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

    $('ul.play-menu .active').css({'background-color':'#fc0'});
});

$(window).load(function () {
    $("ul.play-menu > a").click(function() {
        if (!$(this).hasClass("active")) {
            $("ul.play-menu").unbind('mouseleave');
            $("ul.play-menu .level-1").hide();
            var el = $(this);
            el.addClass("hover");
            $("ul.play-menu > a.active").fadeOut("fast", function() {
                var prev = $(this)
                prev.removeClass('active');
                container_pos = $(".navigation").offset()
                button_pos = el.offset()
                el.animate({ top: container_pos.top - button_pos.top }, 500, function() {
                    el.addClass("active").removeClass("hover").css("top", 0);
                    if (el.attr("href").length > 1 && el.attr("href") != "#") {
                        $(".navigation > a:not(.active)").hide();
                        $(el.attr("href")).slideDown("slow");
                    } else {
                        prev.fadeIn("fast");
                    }
                });
            });
        }

    });

    $(".navigation .back").hover(
        function () {
            var el = $(this)
            $(".navigation .second_level").hide();
            $(".navigation > a").show();
            $(".navigation").hover(function() {}, function() {
                $(this).unbind('mouseleave');
                $(".navigation > a:visible:not(.active)").hide();
                el.closest(".second_level").show();
            });

        });
});
