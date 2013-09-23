require "spec_helper"

describe EventMailer do
  let(:event) { Fabricate(:event) }
  let(:sponsor) { Fabricate(:sponsor_with_address) }
  let!(:hosting) { Fabricate(:hosting, sponsor: sponsor, sponsorable: event) }
  let(:invitation) { Fabricate(:invitation, invitable: event) }

  it "sends an invitation email" do
    @email_subject = "You are invited to the Rails Girls #{event.city_name} workshop on the #{event.dates}"

    EventMailer.invite(event, invitation.invitee, invitation).deliver
    expect(html_body).to include(invitation.invitee.first_name)
    expect(html_body).to include(invitation_url(invitation))
  end

  it "sends a confirmation email when an attendee accepts the invitation" do
    @email_subject = "RG#{event.city_name.slice(0)} - You are confirmed for #{event.title} #{event.dates}"

    EventMailer.confirm_attendance(event, invitation.invitee, invitation).deliver
    expect(html_body).to include(invitation.invitee.first_name)
  end

  after(:each) do
    ActionMailer::Base.deliveries.last.subject.should eq @email_subject
    ActionMailer::Base.deliveries.last.From.to_s.should == "Rails Girls #{event.city_name} <#{event.city.email}>"
    ActionMailer::Base.deliveries.last.To.to_s.should == invitation.invitee.email
    expect(html_body).to include(invitation.invitee.first_name)
    expect(html_body).to include(invitation.invitee.first_name)
  end

  def html_body
    ActionMailer::Base.deliveries.last.body.parts.first.body
  end
end
