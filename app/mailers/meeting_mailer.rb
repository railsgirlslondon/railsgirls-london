class MeetingMailer < ActionMailer::Base

  helper :email

  include Extentions::MailerHelper

  def invite meeting, registration, invitation
    setup meeting, registration, invitation

    subject = "Rails Girls #{@meeting.city_name} - You are invited to Weeklies (#{@meeting.date.to_formatted_s(:long_ordinal)})"
    send_email(subject)
  end

  def confirm_attendance meeting, registration, invitation
    setup(meeting, registration, invitation)

    subject = "RG#{meeting.city_name.slice(0)} - You are confirmed for #{meeting.name} #{meeting.date}"
    send_email(subject)
  end

  private

  def setup meeting, registration, invitation
    @registration = registration
    @invitation = invitation
    @member = invitation.member
    @meeting = meeting
    @city = meeting.city

    super()
  end
end
