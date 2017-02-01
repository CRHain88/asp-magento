require(['jquery'], function($) {
    //<![CDATA[
        $(document).ready(function () {
            $('.ves-megamenu li').hover(function () {
                $('.nav-sections').addClass('hover-sctions');
            }, function () {
                $('.nav-sections').removeClass('hover-sctions');
            });
        });
    //]]>
});
