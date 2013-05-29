require 'spec_helper'

describe EventsController do
  describe "GET #show" do
    Given(:city) { City.create! name: "London" }
    Given(:event) do
      Event.create! city_id: city.id, description: Faker::Lorem.sentence, starts_on: Time.now, ends_on: Time.now
    end

    When { get :show, id: event.to_param, city_id: city.to_param }
    Then { expect(response).to render_template(:show) }
    And  { expect(assigns(:city)).to eq(city)}
  end
end
