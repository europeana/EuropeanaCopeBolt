
$( document ).ready(function() {


    //  init jQuery plugin "minRead"
    //  https://github.com/heyimjuani/minRead


    //  check for read-time item
    if ( !$(".read-time").length ) return;

    var options = {
        where: ".read-time",                // where the "x min read" will be inserted. Defaults to ".min-read"
        wordsPerMinute  : 180,              // this is the avg adults can read on a screen, acording to wikipedia
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


    // Add inline anchors to quicklinks
    if( $('a.in-page-anchor').is('*') ) {
        // if there are in page anchors, add a link to each of them in the quicklinks navigation
        $('a.in-page-anchor').each(function() {
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
        // remove the blank placeholder link if quicklinks were added
        $('.in-page-blank-link').detach();
    }
});

