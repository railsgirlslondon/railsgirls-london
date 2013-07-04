class RegistrationMailer < ActionMailer::Base

  helper :email

  include Extentions::MailerHelper

  def application_received(event, registration)
    setup event, registration

    subject = "Thanks for applying to Rails Girls #{@event.city_name} #{@event.dates}"

    send_email(subject)
  end

  def application_accepted(event, registration)
    setup event, registration

    subject = "You're invited to Rails Girls #{@event.city_name} (#{@event.dates})"

    send_email(subject)
  end

  def application_rejected(event, registration)
    setup event, registration

    subject = "Regarding Rails Girls #{@event.city_name} (#{@event.dates})"

    send_email(subject)
  end

  def application_invited_to_weeklies(event, registration)
    setup event, registration

    subject = "Rails Girls #{@event.city_name} - You are invited to Weeklies"

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
