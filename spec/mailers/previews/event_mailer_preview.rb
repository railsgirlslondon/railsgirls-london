class EventMailerPreview < ActionMailer::Preview

  def coaches_instruction
    event = Event.next_event
    coach = event.coaches.first
    EventMailer.coaches_instruction(event, coach)
  end

  def invitation_reminder
    event = Event.next_event
    invitation = event.invitations.pending_response.first
    registration = invitation.invitee
    EventMailer.invitation_reminder(event, registration, invitation)
  end


end
