class MeetingMailer < ActionMailer::Base

  helper :email

  def invite meeting, registration
    setup meeting, registration

    subject = "Rails Girls #{@meeting.city_name} - You are invited to Weeklies"
    email_with_name = "Rails Girls #{@meeting.city.name} <#{@meeting.city.email}>"

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

  def setup meeting, registration
    @registration = registration
    @meeting = meeting
    @city = meeting.city

    load_attachments
  end

end
