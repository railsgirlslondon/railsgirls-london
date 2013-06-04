class RegistrationMailer < ActionMailer::Base

  helper :email

  def application_received event, registration, host
    @registration = registration
    @event = event
    @city = event.city
    @host = host

    load_attachments

    subject = "Thanks for applying to Rails Girls #{@event.city.name} #{@event.title}"
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
end
