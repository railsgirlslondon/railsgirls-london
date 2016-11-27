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

  def newsletter
  end

  def invite
    event = Event.find(8)
    registration = Registration.find(945)
    invitation = Invitation.find(1540)
    EventMailer.invite(event, registration, invitation)
  end

  def ask_for_feedback
    event = Event.find(8)
    registration = Registration.find(945)
    EventMailer.ask_for_feedback(event, registration)
  end
end
