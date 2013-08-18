require "spec_helper"

describe MeetingMailer do
  let(:meeting) { Fabricate(:meeting) }
  let(:sponsor) { Fabricate(:sponsor_with_address) }
  let!(:hosting) { Fabricate(:hosting, sponsor: sponsor, sponsorable: meeting) }
  let(:invitation) { Fabricate(:invitation, invitable: meeting) }

  it "sends an invitation email" do
    @email_subject = "Rails Girls #{meeting.city_name} - You are invited to Weeklies (#{meeting.date.to_formatted_s(:long_ordinal)})"

    MeetingMailer.invite(meeting, invitation.member, invitation).deliver
    expect(html_body).to include(unsubscribe_url(invitation.member.uuid))
  end

  it "sends an invitation attendance confirmation email" do
    @email_subject = "RG#{meeting.city_name.slice(0)} - You are confirmed for #{meeting.name} #{meeting.date}"

    MeetingMailer.confirm_attendance(meeting, invitation.member, invitation).deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.last.subject.should eq @email_subject
    ActionMailer::Base.deliveries.last.From.to_s.should == "Rails Girls #{meeting.city.name} <#{meeting.city.email}>"
    ActionMailer::Base.deliveries.last.To.to_s.should == invitation.member.email
    expect(html_body).to include(invitation.member.first_name)
    expect(html_body).to include(invitation.member.first_name)
    expect(html_body).to include(invitation_url(invitation))
  end

  def html_body
    ActionMailer::Base.deliveries.last.body.parts.first.body
  end
end
