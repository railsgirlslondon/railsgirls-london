require "spec_helper"

describe AdminMailer do
  let! (:event) { Fabricate(:event) }
  let! (:sponsor) { Fabricate(:sponsor_with_address) }
  let! (:hosting) { Fabricate(:hosting, sponsor: sponsor, sponsorable: event) }
  let! (:registration) { Fabricate(:registration, event: event) }

  let(:invitation) { Fabricate(:event_invitation, invitable: event, invitee: registration) }

  it "sends an notification email" do
    pending("fix this one")
    @email_subject = "RSVP from #{invitation.invitee.name}"

    AdminMailer.notify(invitation).deliver_now
    expect(html_body).to include(invitation.invitee.name)
  end


  after(:each) do
    expect(ActionMailer::Base.deliveries.last.subject).to eq @email_subject
    expect(ActionMailer::Base.deliveries.last.to.first.to_s).to eq("railsgirlslondon@gmail.com")
  end

  def html_body
    ActionMailer::Base.deliveries.last.body.parts.first.body
  end
end
