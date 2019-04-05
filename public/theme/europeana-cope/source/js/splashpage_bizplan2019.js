// Splashpage 10years

var article = $('.splashpage-bizplan2019 .wheel article');
var section = $('.splashpage-bizplan2019 .wheel-section');
var handle = $('.splashpage-bizplan2019 .wheel article .handle');
var anchor = $('.splashpage-bizplan2019 .wheel article a');

article
    .on('mouseenter touchend', function(e){
        section.addClass('hashighlight');
        $(this).addClass('highlight');
        $(this).find('.center').show();

        article.stop();
        $(this).show();

        article.not( $(this) ).fadeOut({
            duration: 200,
            queue: false
        });
        $('#maincenter').hide();
        // alert('klik');
        e.preventDefault();
        e.stopPropagation();
        // return false;


    })
    .on('mouseleave', function(){
        section.removeClass('hashighlight')
        $(this).removeClass('highlight');
        $(this).find('.center').hide();
        $('#maincenter').show();

        article.stop().fadeIn({ duration: 0 });

    });

// handle.on('touchend', function() {
//     section.addClass('hashighlight');
//     $(this).parent().addClass('highlight');
//     $(this).parent().find('.center').show();
//     section.css("background-color" , $(this).parent().data('bgcolor'));

//     article.stop();
//     $(this).parent().show();

//     article.not( $(this).parent() ).fadeOut({
//         duration: 200,
//         queue: false
//     });
//     // alert('klak');
//     // e.preventDefault();
//     return false;
// });

anchor.on('click touchend', function(e) {
    window.location = $(this).attr('href');
    e.preventDefault();
    e.stopPropagation();
    return false;
});

//reset all als erbuiten geklikt
section.on('click touchend',function(){
    section.removeClass('hashighlight');
    article.removeClass('highlight');
    article.find('.center').hide();
    section.css("background", "");

    article.stop().fadeIn({ duration: 0 });

    // alert('kla0k');
});
