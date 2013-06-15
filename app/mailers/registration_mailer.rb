class RegistrationMailer < ActionMailer::Base

  helper :email

  def application_received event, registration
    setup event, registration

    subject = "Thanks for applying to Rails Girls #{@event.city_name} #{@event.dates}"
    email_with_name = "Rails Girls #{@event.city_name} <#{@event.city.email}>"

    content_type =  "text/html"

    mail(from: email_with_name, to: @registration.email, subject: subject) do |format|
      format.html { render :layout => 'mailer' }
    end
  end

  def application_accepted event, registration
    setup event, registration

    subject = "You're invited to Rails Girls #{@event.city_name} (#{@event.dates})"
    email_with_name = "Rails Girls #{@event.city.name} <#{@event.city.email}>"

    content_type =  "text/html"

    mail(from: email_with_name, to: @registration.email, subject: subject) do |format|
      format.html { render :layout => 'mailer' }
    end
  end

  def application_rejected event, registration
    setup event, registration

    subject = "Regarding Rails Girls #{@event.city_name} (#{@event.dates})"
    email_with_name = "Rails Girls #{@event.city.name} <#{@event.city.email}>"

    content_type =  "text/html"

    mail(from: email_with_name, to: @registration.email, subject: subject) do |format|
      format.html { render :layout => 'mailer' }
    end
  end

  private

  def load_attachments
    %w{london-girl.png railsgirls-heart.png  railsgirls-london.png twitter.png github.png facebook.png gplus.png}.each do |image|
      attachments.inline[image] = File.read("#{Rails.root.to_s}/app/assets/images/#{image}")
    end
  end

  def setup event, registration
    @registration = registration
    @event = event
    @city = event.city

    load_attachments
  end

end
