require 'spec_helper'

describe ErrorsController, :type => :controller do

  describe "GET 'not_found'" do
    it "returns http not_found" do
      get 'not_found'
      expect(response.response_code).to eq(404)
    end
  end

end
