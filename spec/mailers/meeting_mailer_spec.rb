require "spec_helper"

describe MeetingMailer do
  it "sends an invitation email" do
    meeting = Fabricate(:meeting)
    sponsor = Fabricate(:sponsor_with_address)
    Fabricate(:hosting, sponsor: sponsor, sponsorable: meeting)
    invitation = Fabricate(:invitation, invitable: meeting)

    subject = "Rails Girls #{meeting.city_name} - You are invited to Weeklies"

    MeetingMailer.invite(meeting, invitation.member, invitation).deliver

    ActionMailer::Base.deliveries.last.From.to_s.should == "Rails Girls #{meeting.city.name} <#{meeting.city.email}>"
    ActionMailer::Base.deliveries.last.To.to_s.should == invitation.member.email
    ActionMailer::Base.deliveries.last.subject.should eq subject
    ActionMailer::Base.deliveries.last.body.encoded.should include invitation.member.first_name
    ActionMailer::Base.deliveries.last.body.encoded.should include invitation.member.first_name
    ActionMailer::Base.deliveries.last.body.encoded.should include invitation_url(invitation)
  end
end
