function scrollNav() {
  var scrollButtons = $('.navbar-nav li, #apply-student-btn')

  function hashFromButton(button) {
    var link = $(button).find("a[href]");
    var href = link.attr("href");
    return href.substr(href.indexOf("#"));
  }

  function setActiveButton(buttonEl) {
    scrollButtons.removeClass("active");
    $(buttonEl).addClass("active");
  }

  scrollButtons.click(function() {
    setActiveButton(this);

    var hash = hashFromButton(this);

    $('html, body').stop().animate({
      scrollTop: $( hash ).offset().top - 50
    }, 400);

    return false;
  });

  if (window.location.hash) {
    var currentButtons = jQuery.grep(scrollButtons, function(button) {
      return hashFromButton(button) == window.location.hash;
    });

    if (currentButtons.length) {
      setActiveButton(currentButtons[0]);
    }
  }

  $('.scrollTop a').scrollTop();
}

$(document).ready(scrollNav);
$(document).on('page:load', scrollNav);
