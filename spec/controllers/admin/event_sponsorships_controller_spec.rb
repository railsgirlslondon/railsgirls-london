require "spec_helper"

describe Admin::EventSponsorshipsController do
  describe "PUT #update" do 
    context "when sponsor does not have a full address" do
      let!(:event) { Fabricate(:event) } 
      let!(:sponsor) { Fabricate(:sponsor) }
      let!(:event_sponsorship) do 
        EventSponsorship.create! event: event, sponsor: sponsor
      end

      before { put :update, id: event_sponsorship.id, event_sponsorship: {host: true} }

      specify { expect(flash.now[:error]).to eq("Host must have full address") }
    end
  end
end