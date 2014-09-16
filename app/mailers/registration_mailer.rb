class RegistrationMailer < ActionMailer::Base

  helper :email

  include Extentions::MailerHelper

  def application_received(event, registration)
    setup event, registration

    subject = "Thanks for applying to Rails Girls #{@event.city_name} #{@event.dates}"

    send_email(subject)
  end

  private

  def setup event, registration
    @registration = registration
    @event = event
    @city = event.city

    super()
  end
end
