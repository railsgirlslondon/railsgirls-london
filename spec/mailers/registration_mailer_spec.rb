require "spec_helper"

describe RegistrationMailer do

  it "sends an email when an application is received" do
    event = Fabricate(:event)
    registration = Fabricate(:registration)

    RegistrationMailer.application_received(event, registration).deliver
    ActionMailer::Base.deliveries.last.From.to_s.should == "Rails Girls #{event.city.name} <#{event.city.email}>"
    ActionMailer::Base.deliveries.last.To.to_s.should == registration.email
    ActionMailer::Base.deliveries.last.subject.to_s.should include event.dates
    ActionMailer::Base.deliveries.last.body.encoded.should include registration.first_name
    ActionMailer::Base.deliveries.last.body.encoded.should include event.dates
  end

  it "sends an email when an applicant is accepted", wip: true do
    event = Fabricate(:event)
    registration = Fabricate(:registration)

    subject= "You're invited to Rails Girls #{event.city_name} (#{event.dates})"

    RegistrationMailer.application_accepted(event, registration).deliver

    ActionMailer::Base.deliveries.last.From.to_s.should == "Rails Girls #{event.city.name} <#{event.city.email}>"
    ActionMailer::Base.deliveries.last.To.to_s.should == registration.email
    ActionMailer::Base.deliveries.last.subject.should eq subject
    ActionMailer::Base.deliveries.last.body.encoded.should include registration.first_name
    ActionMailer::Base.deliveries.last.body.encoded.should include event.dates
  end

  it "sends an email when an applicant is rejected" do
    event = Fabricate(:event)
    registration = Fabricate(:registration)

    subject= "Regarding Rails Girls #{event.city_name} (#{event.dates})"

    RegistrationMailer.application_rejected(event, registration).deliver

    ActionMailer::Base.deliveries.last.From.to_s.should == "Rails Girls #{event.city.name} <#{event.city.email}>"
    ActionMailer::Base.deliveries.last.To.to_s.should == registration.email
    ActionMailer::Base.deliveries.last.subject.should eq subject
    ActionMailer::Base.deliveries.last.body.encoded.should include registration.first_name
    ActionMailer::Base.deliveries.last.body.encoded.should include event.dates
  end
end
