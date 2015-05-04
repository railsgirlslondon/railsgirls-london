require "spec_helper"

describe Admin::CoachingsController, :type => :controller do

  before do
    sign_in
  end

  context "POST #create" do
    let!(:event) { Fabricate(:event) }
    let!(:coach) { Fabricate(:coach) }

    before do
      request.env['HTTP_REFERER'] = "#{request_host}#{admin_coach_path(coach)}"
      post :create, coaching: { coachable_type: 'Event', coachable_id: event.id, coach_id: coach.id }
    end

    specify { expect(response).to redirect_to :back }
    specify { expect(flash.now[:notice]).to eq("#{coach.name} has been assigned to #{event.to_s}.") }
  end

  context "DELETE #destroy" do
    let!(:event) { Fabricate(:event) }
    let!(:coach) { Fabricate(:coach) }
    let!(:coaching) { Fabricate(:event_coaching, coachable_id: event.id, coach_id: coach.id) }

    before do
      request.env['HTTP_REFERER'] = "#{request_host}#{admin_coach_path(coach)}"
      delete :destroy, id: coaching.id
    end

    specify { expect(response).to redirect_to :back }
    specify { expect(flash.now[:notice]).to eq("#{coaching.coach.name} has been removed from #{coaching.coachable.to_s}.".html_safe) }
  end

  private

  def request_host
    request.protocol + request.host
  end
end
