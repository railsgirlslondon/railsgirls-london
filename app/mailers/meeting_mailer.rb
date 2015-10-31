class MeetingMailer < ActionMailer::Base

  helper :email

  include Extentions::MailerHelper

  def invite meeting, registration, invitation
    setup meeting, registration, invitation
    subject = "Rails Girls London - You are invited to Weeklies (#{@meeting.date.to_formatted_s(:long_ordinal)})"
    send_email(subject, registration.email)
  end

  def confirm_attendance meeting, registration, invitation
    setup(meeting, registration, invitation)

    subject = "RGL - You are confirmed for #{meeting.name} #{meeting.date}"

    attach_ical_file(meeting)

    send_email(subject, registration.email)
  end

  private

  def attach_ical_file meeting
    ical_file = IcalAttachment::Meeting.new(meeting).to_temp_file
    attachments["#{meeting.name}-#{meeting.date}.ics"] = ical_file.read
  ensure
    ical_file.close!
  end

  def setup meeting, registration, invitation
    @registration = registration
    @invitation = invitation
    @member = invitation.invitee
    @meeting = meeting

    super()
  end
end
