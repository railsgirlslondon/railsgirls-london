require 'spec_helper'

describe EventsController do
  describe "GET #show" do
    Given(:city) { City.create! name: "London" }
    Given(:event) { Event.create! city_id: city.id, description: Faker::Lorem.sentence }

    When { get :show, id: event.to_param, city_id: city.to_param }
    Then { expect(response).to render_template(:show) }
    And  { expect(assigns(:city)).to eq(city)}
  end
end
