require "spec_helper"

describe MeetingMailer do
  it "sends an invitation email" do
    meeting = Fabricate(:meeting)
    member = Fabricate(:registration)

    subject = "Rails Girls #{meeting.city_name} - You are invited to Weeklies"

    RegistrationMailer.application_invited_to_weeklies(meeting, member).deliver

    ActionMailer::Base.deliveries.last.From.to_s.should == "Rails Girls #{meeting.city.name} <#{meeting.city.email}>"
    ActionMailer::Base.deliveries.last.To.to_s.should == member.email
    ActionMailer::Base.deliveries.last.subject.should eq subject
    ActionMailer::Base.deliveries.last.body.encoded.should include member.first_name
  end
end
