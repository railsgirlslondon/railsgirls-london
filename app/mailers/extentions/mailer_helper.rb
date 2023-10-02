module Extentions
  module MailerHelper

    def default_email_address
      Rails.application.config.default_email_address
    end

    private

    def mail_args(subject, participant_email)
      { :from => default_email_address,
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
