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

  context "#associations" do
    context "upcoming_event" do
      it "returns nil if there are no active events" do
        city = City.create name: "San"
        Event.create description: Faker::Lorem.sentence, city_id: city.id, active: false
        Event.create description: Faker::Lorem.sentence, city_id: city.id, active: false

        city.upcoming_event.should eq nil
      end

      it "can retrieve the upcoming event" do
        city = City.create name: "San"
        active_event = Event.create description: Faker::Lorem.sentence, city_id: city.id, active: true
        other_event = Event.create description: Faker::Lorem.sentence, city_id: city.id, active: false

        city.upcoming_event.should eq active_event
      end
    end
  end

end

