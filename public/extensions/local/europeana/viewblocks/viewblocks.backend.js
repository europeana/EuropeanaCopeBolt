jQuery.fn.extend(
    {
        loadViewBlock: function() {
            console.log('initializing viewblock', this);
            $(this).addClass('viewblocks');
            $(this).
            return this;
        },
        onAvailable: function(fn){
            var sel = this.selector;
            var timer;
            var self = this;
            if (this.length > 0) {
                fn.call(this);
            }
            else {
                timer = setInterval(function(){
                    if ($(sel).length > 0) {
                        fn.call($(sel));
                        clearInterval(timer);
                    }
                },50);
            }
        }
    }
);


jQuery(document).ready(function($) {
    console.log('viewblocks js start');

    $('.repeater-slot .repeater-group').onAvailable(
        function() {
            //console.log('initializing viewblock for initial fields');
            $(this).loadViewBlock();
        }
    );
    $('.repeater-add button').on('click', function() {
        //console.log('a repeater is added');
        setTimeout(
            function() {
                $('.repeater-slot .repeater-group:not(.viewblocks)').onAvailable(
                    function() {
                        //console.log('initializing viewblock for new fields');
                        $(this).loadViewBlock();
                    }
                );
            },
            200
        );
    });

    console.log('viewblocks js loaded');
});
