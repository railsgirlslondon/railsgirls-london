class EventMailerPreview < ActionMailer::Preview

  def application_received
    event = Event.next_event
    registration = Registration.find(945)
    RegistrationMailer.application_received(event, registration)
  end

  def coach_application_received
    event = Event.next_event
    registration = CoachRegistration.find(1)
    CoachRegistrationMailer.coach_application_received(event, registration)
  end

  def coach_accepted
    event = Event.next_event
    registration = CoachRegistration.find(1)
    CoachRegistrationMailer.coach_accepted(event, registration)
  end

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

  def welcome_coaches
    event = Event.next_event
    coach = event.coaches.first
    EventMailer.send(:welcome_coaches, event, coach)
  end

  def welcome_message
    event = Event.next_event
    student = event.attending_students.first.invitation
    EventMailer.send(:welcome_message, event, student.invitee)
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
    event = Event.find(12)
    registration = Registration.find(945)
    EventMailer.ask_for_feedback(event, registration)
  end
end
