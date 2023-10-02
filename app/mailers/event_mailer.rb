class EventMailer < ActionMailer::Base

  helper :email

  include Extentions::MailerHelper

  def invite event, registration, invitation
    setup event, registration, invitation

    subject = "You are invited to the Rails Girls London workshop on the #{event.dates}"
    send_email(subject, registration.email)
  end

  def confirm_attendance event, registration, invitation
    setup(event, registration, invitation)

    subject = "RGL - You are confirmed for #{event.title} #{event.dates}"

    IcalAttachment::Event::TYPES_OF_EVENTS.each { |e| attach_ical_file(event, e) }

    send_email(subject, registration.email)
  end

  def coaches_instruction event, coach
    setup_for_coaches event, coach

    subject = "Coaches instructions for RAILS GIRLS LONDON on #{event.dates}"
    send_email(subject, coach.email)
  end

  def welcome_coaches event, coach
    setup_for_coaches event, coach

    subject = "Rails Girls London - 8/9 November 2019!"
    send_email(subject, coach.email)
  end

  def welcome_message event, registration
    setup_for_welcome_message event, registration

    subject = "Rails Girls London - 8/9 November 2019!"
    send_email(subject, registration.email)
  end

  def invitation_reminder event, registration, invitation
    setup event, registration, invitation

    subject = "Rails Girls London - Please RSVP your attendance"
    send_email(subject, registration.email)
  end

  def ask_for_feedback event, participant
    setup_for_feedback event, participant
    subject = "Rails Girls London - Feedback"
    send_email(subject, participant.email)
  end

  def confirm_feedback event, registration, invitation
    setup event, registration, invitation

    subject = "RGL - Thank you for your feedback for #{@event.title} #{@event.dates}!"
    send_email(subject, registration.email)
  end

  private

  def attach_ical_file event, type_of_event
    ical_file = IcalAttachment::Event.new(event).to_temp_file(type_of_event)
    attachments["#{event.title}-#{type_of_event}.ics"] = ical_file.read
  ensure
    ical_file.close!
  end

  def setup event, registration, invitation
    @registration = registration
    @invitation = invitation
    @invitee = invitation.invitee
    @event = event
  end

  def setup_for_coaches event, coach
    @coach = coach
    @event = event
  end

  def setup_for_feedback event, registration
    @event = event
    @registration = registration
  end

  def setup_for_welcome_message event, registration
    @event = event
    @registration = registration
    load_attachments
  end
end
