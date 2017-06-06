/***** Your javascript can go below here ******/
jQuery(document).ready(function($) {
    $('.ajaxselector').each(function(element) {
        console.log('selectasync element:', element, $(this));
    });
});
