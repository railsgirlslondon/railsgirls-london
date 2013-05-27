require 'spec_helper'

describe ErrorsController do

  describe "GET 'not_found'" do
    it "returns http success" do
      get 'not_found'
      response.should be_success
    end
  end

end
