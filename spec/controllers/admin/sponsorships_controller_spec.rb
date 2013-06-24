require "spec_helper"

describe Admin::SponsorshipsController do
  describe "PUT #update" do
    context "when sponsor does not have a full address" do
      let!(:event) { Fabricate(:event) }
      let!(:sponsor) { Fabricate(:sponsor) }
      let!(:sponsorship) do
        Sponsorship.create! sponsorable_type: 'Event', sponsorable_id: event.id, sponsor: sponsor
      end

      before { put :update, id: sponsorship.id, sponsorship: {host: true} }

      specify { expect(flash.now[:error]).to eq("Host must have full address") }
    end
  end
end
