require 'spec_helper'

describe Event do
  context "validations" do
    Given(:city) { City.create! name: "London" }
    Given do
      Event.create! description: "something", city_id: city.id, active: true, starts_on: Time.now, ends_on: Time.now
    end

    context "only one active event per city" do
      When(:invalid_event) { Event.create description: "something", city_id: city.id, starts_on: Date.today, ends_on: Date.tomorrow,  active: true}
      Then { not invalid_event.valid? }

      And { not invalid_event.errors[:active].empty?}

      context "allows multiple inactive events" do
        When(:event_1) { Event.create description: "something", city_id: city.id, active: false, starts_on: Time.now, ends_on: Time.now}
        When(:event_2) { Event.create description: "something", city_id: city.id, active: false, starts_on: Time.now, ends_on: Time.now}

        Then { event_1.valid? }
        And { event_2.valid? }
      end

      context "allows for other active events in other cities" do
        Given(:other_city) { City.create! name: "Another city" }

        When(:valid_event) { Event.create description: "something", city_id: other_city.id, starts_on: Date.today, ends_on: Date.tomorrow,  active: true}

        Then{ valid_event.valid? }
      end

    end
  end

  describe "#accepting_registrations?" do
    let(:event) { Event.new(registration_deadline: date) }

    subject { event.accepting_registrations? }

    context "no registration deadline" do
      let(:date) { nil }
      it { should be_false }
    end

    context "deadline in future" do
      let(:date) { 2.days.from_now }
      it { should be_true }
    end

    context "deadline today" do
      let(:date) { Date.today }
      it { should be_false }
    end

    context "deadline in the past" do
      let(:date) { Date.yesterday }
      it { should be_false }
    end
  end

  describe "hosting" do
    let!(:event) { Fabricate(:event) }   
    let!(:sponsor) { Fabricate(:sponsor_with_address) }

    let!(:event_sponsorship) { EventSponsorship.create! event: event, sponsor: sponsor, host: true }

    specify { expect(event.host) == sponsor }
    specify { expect(event.has_host?) == true }

    context "when no sponsorships is there" do
      before { event_sponsorship.destroy }

      specify { expect(event.host).to eq(false) }
      specify { expect(event.has_host?).to eq(false) }
    end
  end
end
