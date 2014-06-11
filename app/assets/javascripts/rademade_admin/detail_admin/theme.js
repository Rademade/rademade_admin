$(function(){  
    
    function setupTheme() {

        var $menu = $("#sidebar-nav");

        // sidebar menu dropdown toggle
        $("#dashboard-menu .dropdown-toggle").click(function (e) {
            e.preventDefault();
            var $item = $(this).parent();
            $item.toggleClass("active");
            if ($item.hasClass("active")) {
                $item.find(".submenu").slideDown("fast");
            } else {
                $item.find(".submenu").slideUp("fast");
            }
        });


        // mobile side-menu slide toggler
        $("body").click(function () {
            if ($(this).hasClass("menu")) {
                $(this).removeClass("menu");
            }
        });

        $menu.click(function (e) {
            e.stopPropagation();
        });

        $("#menu-toggler").click(function (e) {
            e.stopPropagation();
            $("body").toggleClass("menu");
        });

        $(window).resize(function () {
            $(this).width() > 769 && $("body.menu").removeClass("menu")
        });


        // build all tooltips from data-attributes
        $("[data-toggle='tooltip']").each(function (index, el) {
            $(el).tooltip({
                placement: $(this).data("placement") || 'top'
            });
        });


        // quirk to fix dark skin sidebar menu because of B3 border-box
        if ($menu.height() > $(".content").height()) {
            $("html").addClass("small");
        }
    }

    $(document).on('ready page:load', setupTheme);
});