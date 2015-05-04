require 'spec_helper'

describe EventsController, :type => :controller do
  describe "GET #show" do
    Given(:city) { Fabricate(:city) }
    Given(:event) { Fabricate(:event, city: city) }

    When { get :show, id: event.to_param, city_id: city.to_param }
    Then { expect(response).to render_template(:show) }
    And  { expect(assigns(:city)).to eq(city)}
  end
end
