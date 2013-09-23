module Extentions
  module MailerHelper

    private

    def setup
      content_type =  "text/html"
      load_attachments
    end

    def email_name
      "Rails Girls #{@city.name} <#{@city.email}>"
    end

    def load_attachments
      %w{london-girl.png railsgirls-heart.png  railsgirls-london.png twitter.png github.png facebook.png gplus.png}.each do |image|
        attachments.inline[image] = File.read("#{Rails.root.to_s}/app/assets/images/#{image}")
      end
    end

    def mail_args(subject)
      { :from => email_name,
        :to => @registration.email,
        :subject => subject }
    end

    def send_email subject, layout="mailer"
      mail(mail_args(subject)) do |format|
        format.html { render :layout => layout }
      end
    end
  end
end
