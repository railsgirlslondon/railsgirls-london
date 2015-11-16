function scrollNav() {
  $('.nav a, #apply-student-btn').click(function() {
    $(".active").removeClass("active");
    $(this).closest('li').addClass("active");
    var theClass = $(this).attr("class");
    $('.'+theClass).parent('li').addClass('active');
    $('html, body').stop().animate({
        scrollTop: $( $(this).attr('href') ).offset().top - 50
    }, 400);
    return false;
  });
  $('.scrollTop a').scrollTop();
}

$(document).ready(scrollNav);
$(document).on('page:load', scrollNav);
