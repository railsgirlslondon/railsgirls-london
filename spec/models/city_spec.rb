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
      city = Fabricate(:city, name: "Honolulu")

      expect(city.slug).to eq("honolulu")
    end

    it "generated correctly for a city with a not so common name" do
      city = Fabricate(:city, name: "Cross O’ Th’ Hands")

      expect(city.slug).to eq("cross-o-th-hands")
    end
  end

  context "#associations" do
    let(:city) { Fabricate(:city) }

    context "upcoming_event" do
      it "returns nil if there are no active events" do
        city = City.create! name: "San"
        2.times { Fabricate(:inactive_event, city: city) }

        expect(city.upcoming_event).to eq(nil)
      end

      it "can retrieve the upcoming event" do
        active_event = Fabricate(:event, city: city)
        other_event = Fabricate(:inactive_event, city: city)

        expect(city.upcoming_event).to eq(active_event)
      end
    end
  end

  context "#sponsors" do
    let(:city_1) { Fabricate(:city) }
    let(:city_2) { Fabricate(:city) }

    let!(:event_1) { Fabricate(:event, city: city_1) }
    let!(:meeting) { Fabricate(:meeting, city: city_1) }
    let!(:event_2) { Fabricate(:event, city: city_2) }

    before do
      2.times { Fabricate(:event_sponsorship, sponsorable_id: event_1.id) }
      4.times { Fabricate(:event_sponsorship, sponsorable_id: event_2.id) }
      1.times { Fabricate(:meeting_sponsorship, sponsorable_id: meeting.id) }
    end

    it "returns all the sponsors related to city events and meetups" do

      city_1.sponsors.should eq(event_1.sponsors + meeting.sponsors)
    end

  end
end
