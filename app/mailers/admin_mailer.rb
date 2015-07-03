class AdminMailer < ActionMailer::Base
  default from: 'railsgirlslondon@gmail.com'
  helper :email

  include Extentions::MailerHelper

  def notify invitation
    setup invitation

    subject = "RSVP from #{invitation.invitee.name}"
    content_type =  "text/html"

    send_email(subject, "admin_mailer")
  end

  private

  def mail_args(subject)
    { to: @city.email,
      subject: subject }
  end

    def load_attachments
      %w{railsgirls-heart.png  railsgirls-london.png}.each do |image|
        attachments.inline[image] = File.read("#{Rails.root.to_s}/app/assets/images/#{image}")
      end
    end

  def setup invitation
    @invitation = invitation
    @city = invitation.invitable.city

    super()
  end
end
