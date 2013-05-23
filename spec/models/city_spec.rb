require 'spec_helper'

describe City do

  context "twitter" do
    it 'can have twitter configured' do
      city = City.new twitter: "railsgirls_ldn"
      city.valid?.should be true
    end
  end

end

