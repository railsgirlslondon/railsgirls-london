require 'spec_helper'

describe Invitation do
  let(:meeting) { Fabricate(:meeting, available_slots: 1) }
  let(:invitee) { Fabricate(:member) }
  let!(:hosting) { Fabricate(:hosting, sponsorable: meeting) }
  let(:invitation) { Fabricate(:invitation, invitable: meeting) }

  it { should callback(:generate_token).before(:create) }
  it { should callback(:send_invitation).after(:create) }
  it { should callback(:give_away_spot).after(:update) }
  it { should callback(:send_confirmation).after(:update) }

  context "scopes" do

    let!(:attending) { 3.times.map { Fabricate(:accepted_invitation, invitable: meeting) }.reverse }
    let!(:no_response) { 2.times.map { Fabricate(:invitation, invitable: meeting) } }
    let!(:waiting_list) { 5.times.map { Fabricate(:waiting_invitation, invitable: meeting) } }

    it "#accepted" do
      meeting.invitations.accepted.should eq attending
    end

    it "#waiting_list" do
      #we dont currently have meetings
      # meeting.invitations.waiting_list.should eq waiting_list
    end

    it "#pending_response" do
      meeting.invitations.pending_response.should eq no_response.reverse
    end
  end

  context "hooks" do
    it "#after_create" do
      Invitation.any_instance.should_receive(:send_invitation)

      Invitation.create! invitee: invitee, invitable: meeting
    end

    context "#after_update" do
      let(:invitation) { Fabricate(:invitation, invitable: meeting, attending: true) }

      context "attendance is false" do
        it "processess the waiting list" do
          other_invitation = Fabricate(:invitation, invitable: meeting, waiting_list: true)

          invitation.invitable.should_receive(:process_waiting_list)

          invitation.update_attribute(:attending, false)
        end
      end

      context "attendance is true and waiting_list is false" do
        let(:invitation) { Fabricate(:invitation, invitable: meeting, waiting_list: true) }

        it "sends a confirmation email" do
          invitation.should_receive(:send_confirmation)

          invitation.update_attributes(attending: true, waiting_list: false)
        end
      end
    end
  end

  context "methods" do
    it "#send_invitation" do
      invitation.invitable.should_receive(:email).with(:invite, invitation.invitee, invitation)

      invitation.send_invitation
    end

    it "#send_attendance_confirmation" do
      invitation.invitable.should_receive(:email).with(:confirm_attendance, invitation.invitee, invitation)

      invitation.send_confirmation
    end

    it "#send_reminder" do
      invitation.invitable.should_receive(:email).with(:invitation_reminder, invitation.invitee, invitation)

      invitation.send_reminder
    end
  end
end
