class RegistrationMailer < ActionMailer::Base

  helper :email

  def application_received event, registration, host
    @registration = registration
    @event = event
    @city = event.city
    @host = host
    subject = "Thanks for applying to Rails Girls #{@event.city.name} #{@event.title}"
    email_with_name = "Rails Girls #{@event.city.name} <#{@event.city.email}>"

    mail(from: email_with_name, to: @registration.email, subject: subject) do |format|
      format.html { render :layout => 'mailer' }
    end
  end

end
