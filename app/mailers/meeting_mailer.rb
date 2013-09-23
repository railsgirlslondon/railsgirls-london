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

    attach_ical_file(meeting)

    send_email(subject)
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
    @city = meeting.city

    super()
  end
end
