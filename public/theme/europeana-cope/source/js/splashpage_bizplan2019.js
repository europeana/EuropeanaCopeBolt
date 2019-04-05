// Splashpage BIZ PLAN 2019 (Annual Report)

var article = $('.splashpage-bizplan2019 .wheel article');
var section = $('.splashpage-bizplan2019 .wheel-section');
var handle = $('.splashpage-bizplan2019 .wheel article .handle');
var anchor = $('.splashpage-bizplan2019 .wheel article a');

article
    .on('mouseenter touchend', function(e){
        $(this).addClass('highlight');
        $(this).find('.center').show();

        article.stop();
        $(this).show();

        article.not( $(this) ).find('.center').fadeOut({
            duration: 200,
            queue: false
        });

        article.not( $(this) ).removeClass('highlight');
        $('#maincenter').hide();

        e.preventDefault();
        e.stopPropagation();
        // return false;

        // console.log('going in!');

    })
    .on('mouseleave', function(){  // not triggered on touch
        $(this).removeClass('highlight');
        $(this).find('.center').hide();
        $('#maincenter').show();

        article.stop().fadeIn({ duration: 0 });
        // console.log('... and leaving.');
    });


anchor.on('click touchend', function(e) {
    window.location = $(this).attr('href');
    e.preventDefault();
    e.stopPropagation();
    return false;
});

//reset all als erbuiten geklikt
section.on('click touchend',function(){
    article.removeClass('highlight');
    article.find('.center').hide();
    $('#maincenter').show();

    article.stop().fadeIn({ duration: 0 });

    // console.log('reset all the things');
});
