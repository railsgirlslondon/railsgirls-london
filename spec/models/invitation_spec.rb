require 'spec_helper'

describe Invitation, wip: true do
  let(:meeting) { Fabricate(:meeting) }
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
  end

  context "methods" do
    it "#send_invitation" do
      invitation.invitable.should_receive(:email).with(:invite, invitation.member, invitation)

      invitation.send_invitation
    end
  end
end
