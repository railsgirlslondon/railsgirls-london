require "spec_helper"

describe MeetingMailer do
  let(:meeting) { Fabricate(:meeting) }
  let(:sponsor) { Fabricate(:sponsor_with_address) }
  let!(:hosting) { Fabricate(:hosting, sponsor: sponsor, sponsorable: meeting) }
  let(:invitation) { Fabricate(:invitation, invitable: meeting) }

  shared_examples_for "a meeting email" do
    let(:email) { ActionMailer::Base.deliveries.last }

    it "should contain content common to all meeting emails" do
      expect(email.subject).to eq(subject)
      expect(email.From.to_s).to eq("Rails Girls #{meeting.city.name} <#{meeting.city.email}>")

      expect(email.to).to  include(invitation.invitee.email)
      expect(html_body).to include(invitation.invitee.first_name)
      expect(html_body).to include(invitation.invitee.first_name)
      expect(html_body).to include(invitation_url(invitation))
    end
  end

  context "invitations" do
    let(:subject) {
      "Rails Girls #{meeting.city_name} - You are invited to Weeklies (#{meeting.date.to_formatted_s(:long_ordinal)})"
    }

    before do
      MeetingMailer.invite(meeting, invitation.invitee, invitation).deliver
    end

    it "sends an invitation email" do
      expect(html_body).to include(unsubscribe_url(invitation.invitee.uuid))
    end

    include_examples "a meeting email"
  end

  context "attendance confirmation" do
    let(:subject) {
      "RG#{meeting.city_name.slice(0)} - You are confirmed for #{meeting.name} #{meeting.date}"
    }

    before do
      MeetingMailer.confirm_attendance(meeting, invitation.invitee, invitation).deliver
    end

    it_behaves_like "a meeting email"
  end


  def html_body
    ActionMailer::Base.deliveries.last.html_part.body
  end
end
