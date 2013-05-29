require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    context "when there is more than one city" do
      Given!(:city1) { City.create! name: "one city" }
      Given!(:city2) { City.create! name: "two city" }

      When { get 'index' }

      Then { expect(response).to render_template(:index) }
      And { expect(assigns(:cities)).to match_array([city1, city2]) }
    end

    context "when there is only one city" do
      Given!(:city) { City.create! name: "A single city" }

      When { get 'index' }

      Then { response.should redirect_to(city_path(city)) }
    end
  end

end
