require 'spec_helper'
describe CitiesController, type: :controller do
  let(:city) { City.create(name: 'Xanadu') }

  describe "GET #sponsor" do

    it "assigns city as @city" do
      get :sponsor, { id:  city.slug }

      assigns(:city).should eq(city)
    end
  end

  describe 'GET #show' do

    it 'should raise a routing error when a non-existent city is in the route' do
      expect { get :show, { id: 'erewhon' } }.to raise_error ActionController::RoutingError
    end

    it 'should respond with success if the city exists' do
      get :show, { id: city.slug }

      response.status.should eql 200
    end
  end

end
