require 'spec_helper'

describe Invitation, wip: true do
  let(:meeting) { Fabricate(:meeting) }
  let(:member) { Fabricate(:member) }
  let!(:hosting) { Fabricate(:hosting, sponsorable: meeting) }
  let(:invitation) { Fabricate(:invitation, invitable: meeting) }

  context "hooks" do
    it "#after_create" do
      Invitation.any_instance.should_receive(:send_invitation)

      Invitation.create! member: member, invitable: meeting
    end
  end

  context "methods" do
    it "#send_invitation" do
      invitation.invitable.should_receive(:email).with(:invite, invitation.member)

      invitation.send_invitation
    end
  end
end
