class EventMailerPreview < ActionMailer::Preview

  def coaches_instruction
    event = Event.upcoming.first
    coach = event.coaches.first
    EventMailer.coaches_instruction(event, coach)
  end

  def invitation_reminder
    event = Event.upcoming.first
    invitation = event.invitations.pending_response.first
    registration = invitation.invitee
    EventMailer.invitation_reminder(event, registration, invitation)
  end


end
