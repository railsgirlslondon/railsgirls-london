module EventHelper

  def event_application_button_text(event)
    event.registrations_open? ? "Applications are open until #{I18n.l(event.registration_deadline)}" : "Applications are now closed, but you can join the waiting list"
  end

  def accept_reject_invitation_link(event, registration)
    if registration.selection_state.eql? "accepted"
      path = admin_event_registration_attendance_path(event, registration)
      link_to "Decline", path, method: :delete, class: "btn btn-error"
    else
      path = admin_event_registration_attendance_path(event, registration)
      link_to "Accept", path, method: :post, class: "btn btn-success"
    end
  end

  def registration_selection_state(registration)
    if registration.member
      content_tag :div, "member", class: "label label-info"
    else
      content_tag :div, registration.selection_state, class: "label label-success"
    end
  end

  def allow_feedback? event
    event.ends_on+3.months > Date.today
  end
end
