class CoachRegistrationMailer < ActionMailer::Base

  helper :email

  include Extentions::MailerHelper

  def coach_application_received(event, registration)
    setup event, registration

    subject = "Thanks for applying to Rails Girls London #{@event.dates}"

    send_email(subject, registration.email)
  end

  def coach_accepted(event, registration)
    setup event, registration

    subject = "You are invited to coach at Rails Girls London #{@event.dates}"

    send_email(subject, registration.email)
  end

  private

  def setup event, registration
    @registration = registration
    @event = event

    super()
  end
end
