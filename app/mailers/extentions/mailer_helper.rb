module Extentions
  module MailerHelper

    private

    def setup
      load_attachments
    end

    def setup_for_coaches
      load_attachments
    end

    def email_name
      "Rails Girls London <railsgirlslondon@gmail.com>"
    end

    def load_attachments
      [
        "rails_girls_london_logo.png",
        "king_.png",
        "carwow_.png",
        "teespring.jpg",
        "monzo.png",
        "heroku.png",
        # "twitter.png",
        # "facebook.png",
        # "github.png",
        # "gplus.png",
        "honeycomb.png",
        "mongodb.jpg",
        "friday_logo.png",
        "zendesk_logo.jpg",
        "google_logo.jpg"
      ].each do |image|
        attachments.inline[image] = File.read("#{Rails.root.to_s}/app/assets/images/#{image}")
      end
    end

    def mail_args(subject, participant_email)
      { :from => email_name,
        :to => participant_email,
        :subject => subject }
    end

    def send_email(subject, participant_email, options={})

      options = {layout_view: "mailer"}.merge(options)
      mail(mail_args(subject, participant_email)) do |format|
        format.html { render :layout => options[:layout_view] }
      end
    end
  end
end
