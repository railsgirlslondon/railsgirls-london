require 'spec_helper'

describe ErrorsController do

  describe "GET 'not_found'" do
    it "returns http not_found" do
      get 'not_found'
      response.response_code.should == 404
    end
  end

end
