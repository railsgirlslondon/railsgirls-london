require 'spec_helper'
describe CitiesController do

  describe "GET sponsor" do
    it "assigns city as @city" do
      city = Fabricate(:city)

      get :sponsor, { city_id:  city.slug }
      assigns(:city).should eq(city)
    end
  end
end
