require "spec_helper"

describe AdminMailer do
  let(:invitation) { Fabricate(:event_invitation) }

  it "sends an notification email" do
    @email_subject = "RSVP from #{invitation.invitee.name}"

    AdminMailer.notify(invitation).deliver
    expect(html_body).to include(invitation.invitee.name)
  end


  after(:each) do
    ActionMailer::Base.deliveries.last.subject.should eq @email_subject
    ActionMailer::Base.deliveries.last.to.first.to_s.should == invitation.invitable.city.email
  end

  def html_body
    ActionMailer::Base.deliveries.last.body.parts.first.body
  end
end
