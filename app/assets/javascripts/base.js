$(document).ready(function() {
    var offset = 220;
    var duration = 500;
    $(window).scroll(function() {
        if ($(this).scrollTop() > offset) {
            $('.back_to_top').fadeIn(duration);
        } else {
            $('.back_to_top').fadeOut(duration);
        }
    });
});
