require "spec_helper"

describe AdminMailer do
  let! (:event) { Fabricate(:event) }
  let! (:sponsor) { Fabricate(:sponsor_with_address) }
  let! (:hosting) { Fabricate(:hosting, sponsor: sponsor, sponsorable: event) }
  let! (:registration) { Fabricate(:registration, event: event) }

  let(:invitation) { Fabricate(:event_invitation, invitable: event, invitee: registration) }

  it "sends an notification email" do
    @email_subject = "RSVP from #{invitation.invitee.name}"

    AdminMailer.notify(invitation).deliver_now
    expect(html_body).to include(invitation.invitee.name)
  end


  after(:each) do
    ActionMailer::Base.deliveries.last.subject.should eq @email_subject
    ActionMailer::Base.deliveries.last.to.first.to_s.should == "railsgirlslondon@gmail.com"
  end

  def html_body
    ActionMailer::Base.deliveries.last.body.parts.first.body
  end
end
