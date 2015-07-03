module Admin::InvitationsHelper

  def invitation_attendance_label(invitation)
    css = invitation.attending ? "success" : "danger"
    attendance = invitation.attending ? "Attending" : "Not attending"

    haml_tag :div, class: "label label-#{css}" do
      haml_concat attendance
    end
  end
end
