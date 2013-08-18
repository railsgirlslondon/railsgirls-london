require 'spec_helper'

describe UnsubscribesController do
  let!(:member) { Fabricate(:member, active: true) }

  describe "POST #create" do
    it "sets the member to inactive" do
      post :create, member_uuid: member.uuid

      member.reload
      expect(member.active).to be_false
    end
  end
end
