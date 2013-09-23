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
    send_email(subject)
  end

  private

  def setup event, registration, invitation
    @registration = registration
    @invitation = invitation
    @invitee = invitation.invitee
    @event = event
    @city = event.city

    super()
  end
end
