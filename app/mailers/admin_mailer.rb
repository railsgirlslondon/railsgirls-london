class AdminMailer < ActionMailer::Base
  include Extentions::MailerHelper

  default from: default_email_address
  helper :email

  def notify invitation
    setup invitation

    subject = "RSVP from #{invitation.invitee.name}"
    # content_type =  "text/html"

    send_email(subject, default_email_address, layout_view: "admin_mailer")
  end

  private

  def setup invitation
    @invitation = invitation
  end
end
