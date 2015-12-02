;(function($) {
  // Hide the "Add a note..." link and show the text area.
  var reveal_note_area = function(el) {
    var $parent_form = $(el).closest("form");
    $(".add-note", $parent_form).addClass("hidden");
    $('textarea', $parent_form).removeClass("hidden");
  };

  // Filter the rows of the table down to just those that contain search_term in the name.
  var filter_attendees = function(search_term) {
    $("table.attendees tr").each(function(i, row) {
      if ($("td.name", row).text().toLowerCase().indexOf(search_term.toLowerCase()) >= 0) {
        $(row).removeClass("hidden");
      } else {
        $(row).addClass("hidden");
      }
    });
  };

  // Attach listener to document.ready DOM event.
  $(function() {
    $(".add-note").on('click', function(ev) {
      ev.preventDefault();
      console.log(ev);
      reveal_note_area(ev.target);
    });

    $(".attendance-filter").on('keyup', function(ev) {
      filter_attendees($(ev.target).val());
    });
  });
})($);
