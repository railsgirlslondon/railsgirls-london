require "spec_helper"

describe EventMailer do
  let(:event) { Fabricate(:event) }
  let(:sponsor) { Fabricate(:sponsor_with_address) }
  let!(:hosting) { Fabricate(:hosting, sponsor: sponsor, sponsorable: event) }
  let(:invitation) { Fabricate(:invitation, invitable: event) }

  shared_examples_for "an event email" do
    let(:email) { ActionMailer::Base.deliveries.last }

    it "should contain content common to all event emails" do
      expect(email.subject).to eq(subject)
      expect(email.From.to_s).to eq("Rails Girls #{event.city_name} <#{event.city.email}>")

      expect(email.to).to  include(invitation.invitee.email)
      expect(html_body).to include(invitation.invitee.first_name)
      expect(html_body).to include(invitation.invitee.first_name)
    end
  end

  context "invitation email" do
    let(:subject) {
        "You are invited to the Rails Girls #{event.city_name} workshop on the #{event.dates}"
    }

    before do
      EventMailer.invite(event, invitation.invitee, invitation).deliver
    end

    it "sends an invitation email" do
      expect(html_body).to include(invitation.invitee.first_name)
      expect(html_body).to include(invitation_url(invitation))
    end

    include_examples "an event email"
  end

  context "invitation_reminder email" do
    let(:subject) {
        "Reminder:: Please RSVP for the Rails Girls #{event.city_name} workshop on the #{event.dates}"
    }

    before do
      EventMailer.invitation_reminder(event, invitation.invitee, invitation).deliver
    end

    it "sends an invitation reminder email" do
      expect(html_body).to include(invitation.invitee.first_name)
      expect(html_body).to include(invitation_url(invitation))
    end

    include_examples "an event email"
  end

  context "confirmation email" do
    let(:subject) {
      "RG#{event.city_name.slice(0)} - You are confirmed for #{event.title} #{event.dates}"
    }

    before do
      EventMailer.confirm_attendance(event, invitation.invitee, invitation).deliver
    end

    it "sends a confirmation email when an attendee accepts the invitation" do
      expect(html_body).to include(invitation.invitee.first_name)
    end

    it_behaves_like "an event email"
  end


  def html_body
    ActionMailer::Base.deliveries.last.html_part.body
  end
end
