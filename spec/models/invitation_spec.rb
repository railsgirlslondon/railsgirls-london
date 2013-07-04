require 'spec_helper'

describe Invitation, wip: true do
  let(:meeting) { Fabricate(:meeting, available_slots: 1) }
  let(:member) { Fabricate(:member) }
  let!(:hosting) { Fabricate(:hosting, sponsorable: meeting) }
  let(:invitation) { Fabricate(:invitation, invitable: meeting) }

  context "scopes" do

    let!(:attending) { 3.times.map { Fabricate(:accepted_invitation, invitable: meeting) } }
    let!(:no_reponse) { 2.times.map { Fabricate(:invitation, invitable: meeting) } }
    let!(:waiting_list) { 5.times.map { Fabricate(:waiting_invitation, invitable: meeting) } }

    it "#accepted" do
      meeting.invitations.accepted.should eq attending
    end

    it "#waiting_list" do
      meeting.invitations.waiting_list.should eq waiting_list
    end
  end

  context "hooks" do
    it "#after_create" do
      Invitation.any_instance.should_receive(:send_invitation)

      Invitation.create! member: member, invitable: meeting
    end

    context "#after_update" do
      let(:invitation) { Fabricate(:invitation, invitable: meeting, attending: true) }

      context "attendance is false", wip: true do
        it "processess the waiting list" do
          other_invitation = Fabricate(:invitation, invitable: meeting, waiting_list: true)

          invitation.invitable.should_receive(:process_waiting_list)

          invitation.update_attribute(:attending, false)
        end
      end

      context "attendance is true and waiting_list is false", wip: true do
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
      invitation.invitable.should_receive(:email).with(:invite, invitation.member, invitation)

      invitation.send_invitation
    end

    it "#send_attendance_confirmation" do
      invitation.invitable.should_receive(:email).with(:confirm_attendance, invitation.member, invitation)

      invitation.send_confirmation
    end
  end
end
