module EventHelper

  def render_event_partial
    render partial: "#{@event.city.slug}#{@event.id}" rescue ""
  end

  def accept_reject_invitation_link(event, registration)
    if registration.attending?
      path = admin_event_registration_attendance_path(@event, registration)
      link_to "Decline", path, method: :delete, class: "btn btn-error"
    else
      path = admin_event_registration_attendance_path(@event, registration)
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
end
