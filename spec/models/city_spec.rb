require 'spec_helper'

describe City do

  context "twitter" do
    it 'can have twitter configured' do
      city = City.new twitter: "railsgirls_ldn"
      expect(city).to be_valid
    end

  end

  context "slug" do
    it "generated when a city is saved" do
      city = City.create name: "Honolulu"

      expect(city.slug).to eq("honolulu")
    end

    it "generated correctly for a city with a not so common name" do
      city = City.create name: "Cross O’ Th’ Hands"

      expect(city.slug).to eq("cross-o-th-hands")
    end
  end

  context "#associations" do
    context "upcoming_event" do
      it "returns nil if there are no active events" do
        city = City.create! name: "San"
        Event.create! description: Faker::Lorem.sentence, city_id: city.id, active: false, starts_on: Time.now+1.day, ends_on: Time.now
        Event.create! description: Faker::Lorem.sentence, city_id: city.id, active: false, starts_on: Time.now, ends_on: Time.now

        expect(city.upcoming_event).to eq(nil)
      end

      it "can retrieve the upcoming event" do
        city = City.create! name: "San"
        active_event = Event.create! description: Faker::Lorem.sentence, city_id: city.id, active: true, starts_on: Time.now + 1.day, ends_on: Time.now
        other_event = Event.create! description: Faker::Lorem.sentence, city_id: city.id, active: false, starts_on: Time.now, ends_on: Time.now

        expect(city.upcoming_event).to eq(active_event)
      end
    end
  end

end

