require 'spec_helper'

describe City do

  context "twitter" do
    it 'can have twitter configured' do
      city = City.new twitter: "railsgirls_ldn"
      city.valid?.should be true
    end

  end

  context "slug" do
    it "generated when a city is saved" do
      city = City.create name: "Honolulu"

      city.slug.should eq "honolulu"
    end

    it "generated correctly for a city with a not so common name" do
      city = City.create name: "Cross O’ Th’ Hands"

      city.slug.should eq "cross-o-th-hands"
    end
  end

end

