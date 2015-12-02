;(function($) {
  // Hide the "Add a note..." link and show the text area.
  var reveal_note_area = function(el) {
    var $parent_form = $(el).closest("form");
    $(".add-note", $parent_form).addClass("hidden");
    $('textarea', $parent_form).removeClass("hidden");
  };

  // Attach listener to document.ready DOM event.
  $(function() {
    $(".add-note").on('click', function(ev) {
      ev.preventDefault();
      console.log(ev);
      reveal_note_area(ev.target);
    });
  });
})($);
