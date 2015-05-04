require "spec_helper"

describe Admin::SponsorshipsController, :type => :controller do

  before do
    sign_in
  end

  describe "PUT #update" do
    context "when sponsor does not have a full address" do
      let!(:event) { Fabricate(:event) }
      let!(:sponsor) { Fabricate(:sponsor) }
      let!(:sponsorship) do
        Sponsorship.create! sponsorable_type: 'Event', sponsorable_id: event.id, sponsor: sponsor
      end

      before do
        request.env['HTTP_REFERER'] = "#{request_host}#{admin_sponsor_path(sponsor)}"
        put :update, id: sponsorship.id, sponsorship: {host: true}
      end

      specify { expect(response).to redirect_to :back }
      specify { expect(flash.now[:error]).to eq("Host must have full address") }
    end
  end

  private

  def request_host
    request.protocol + request.host
  end
end
