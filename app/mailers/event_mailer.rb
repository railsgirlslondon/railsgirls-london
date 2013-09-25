class EventMailer < ActionMailer::Base

  helper :email

  include Extentions::MailerHelper

  def invite event, registration, invitation
    setup event, registration, invitation

    subject = "You are invited to the Rails Girls #{event.city_name} workshop on the #{event.dates}"
    send_email(subject)
  end

  def confirm_attendance event, registration, invitation
    setup(event, registration, invitation)

    subject = "RG#{event.city_name.slice(0)} - You are confirmed for #{event.title} #{event.dates}"

    attach_ical_file(event)

    send_email(subject)
  end

  def invitation_reminder event, registration, invitation
    setup event, registration, invitation

    subject = "Reminder:: Please RSVP for the Rails Girls #{event.city_name} workshop on the #{event.dates}"
    send_email(subject)
  end

  private

  def attach_ical_file event
    ical_file = IcalAttachment::Event.new(event).to_temp_file
    attachments["#{event.title}-#{event.starts_on}.ics"] = ical_file.read
  ensure
    ical_file.close!
  end

  def setup event, registration, invitation
    @registration = registration
    @invitation = invitation
    @invitee = invitation.invitee
    @event = event
    @city = event.city

    super()
  end
end
