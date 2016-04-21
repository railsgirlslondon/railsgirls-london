require "spec_helper"

describe RegistrationMailer do

  it "sends an email when an application is received" do
    event = Fabricate(:event)
    registration = Fabricate(:registration)

    RegistrationMailer.application_received(event, registration).deliver_now
    expect(ActionMailer::Base.deliveries.last.From.to_s).to eq("Rails Girls London <railsgirlslondon@gmail.com>")
    expect(ActionMailer::Base.deliveries.last.To.to_s).to eq(registration.email)
    expect(ActionMailer::Base.deliveries.last.subject.to_s).to include event.dates
    expect(ActionMailer::Base.deliveries.last.body.encoded).to include registration.first_name
    expect(ActionMailer::Base.deliveries.last.body.encoded).to include event.dates
  end

end
