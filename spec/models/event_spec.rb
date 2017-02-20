require 'spec_helper'

describe Event do

  context "scopes" do

    context "#upcoming" do
      it "retrieves upcoming meetings" do
        upcoming_events = 3.times.map { Fabricate(:event) }
        3.times.map { Fabricate(:event, :active => false) }
        2.times { Fabricate(:event, :ends_on => Date.today-1.week) }

        expect(Event.upcoming).to eq(upcoming_events)
      end
    end
  end

  describe ".next_event" do
    let(:next_event) { Event.next_event }

    context "with no upcoming events" do
      it "is nil" do
        expect(next_event).to be_nil
      end
    end

    context "with upcoming events" do
      # let!(:past_event) { Fabricate(:event, ends_on: Date.today-1.week) }
      let!(:next_upcoming_event) { Fabricate(:event, starts_on: Date.today+1.week) }
      let!(:future_event) { Fabricate(:event, starts_on: Date.today+2.week) }

      it "is the next event" do
        expect(next_event).to eql(next_upcoming_event)
      end
    end
  end

  describe "#coaches.who_attended" do
    let!(:event) { Fabricate(:event) }
    let!(:coaching_nil) { Fabricate(:event_coaching, coachable_id: event.id) }
    let!(:coaching_unknown) { Fabricate(:event_coaching, coachable_id: event.id, attended: :unknown) }
    let!(:coaching_attended) { Fabricate(:event_coaching, coachable_id: event.id, attended: :attended) }
    let!(:coaching_cancelled) { Fabricate(:event_coaching, coachable_id: event.id, attended: :cancelled) }
    let!(:coaching_no_show) { Fabricate(:event_coaching, coachable_id: event.id, attended: :no_show) }

    it "lists only unknown and attending coaches" do
      expect(event.coaches.who_attended).to eq([coaching_nil.coach, coaching_unknown.coach, coaching_attended.coach])
    end
  end

  describe "registrations" do
    let(:event) { Event.new(registration_deadline: date) }

    describe "#accepting_registrations?" do
      subject { event.accepting_registrations? }

      context "no registration deadline" do
        let(:date) { nil }
        it { is_expected.to be false }
      end
    end

    describe "#registrations_open?" do
      subject { event.registrations_open? }

      context "deadline in future" do
        let(:date) { 2.days.from_now }
        it { is_expected.to be true }
      end

      context "deadline today" do
        let(:date) { Date.today }
        it { is_expected.to be true }
      end

      context "deadline in the past" do
        let(:date) { Date.today - 1.day }
        it { is_expected.to be false }
      end
    end
  end

  describe "hosting" do
    let!(:event) { Fabricate(:event) }
    let!(:sponsor) { Fabricate(:sponsor_with_address) }
    let!(:other_sponsor) { Fabricate(:sponsor, events: [event]) }

    let!(:sponsorship) { Sponsorship.create! sponsorable_id: event.id, sponsorable_type: 'Event', sponsor: sponsor, host: true }

    specify { expect(event.host) == sponsor }
    specify { expect(event.has_host?) == true }

    specify { expect(event.non_hosting_sponsors).not_to include(sponsor) }
    specify { expect(event.non_hosting_sponsors).to eq([other_sponsor]) }

    context "when no sponsorships is there" do
      before { sponsorship.destroy }

      specify { expect(event.host).to eq(nil) }
      specify { expect(event.has_host?).to eq(false) }
    end

    describe "is_host_for?" do
      let!(:event) { Fabricate(:event) }
      let!(:sponsor) { Fabricate(:sponsor_with_address) }
      let!(:other_sponsor) { Fabricate(:event_sponsorship) }

      let!(:sponsorship) { Sponsorship.create! sponsorable_id: event.id, sponsorable_type: 'Event', sponsor: sponsor, host: true }

      context "when there is a host" do
        specify { expect(sponsor.is_host_for?(event)).to eq(true) }
      end

    end

  end

  describe "dates" do

    it "two days in the same month" do
      event = Fabricate(:event,
                        starts_on: Date.new(2013,7,13),
                        ends_on: Date.new(2013,7,14))

      expect(event.dates).to eq("13-14 July 2013")
    end

    it "two days over two months" do
      event = Fabricate(:event,
                        starts_on: Date.new(2013,11,30),
                        ends_on: Date.new(2013,12,1))

      expect(event.dates).to eq("30 November-1 December 2013")
    end

    it "one day" do
      event = Fabricate(:event,
                        starts_on: Date.new(2013,8,3),
                        ends_on: Date.new(2013,8,3))

      expect(event.dates).to eq("August 3, 2013")
    end
  end

  describe "applications" do
    let(:event) { Fabricate(:event) }
    let!(:accepted) { 3.times.map { Fabricate(:attended_registration, event: event) } }
    let!(:weeklies) { 2.times.map { Fabricate(:weeklies_registration, event: event) } }
    let!(:waiting_list) { 2.times.map { Fabricate(:waiting_list_registration, event: event) } }

    it "#selected_applicants" do
      expect(event.selected_applicants).to match_array(accepted)
    end

    it "#converts_attendees_to_members!" do
      5.times.map { Fabricate(:registration, event: event) }
      attendees = 2.times.map { Fabricate(:attended_registration, event: event) }

      registrations = event.registrations
      expect(event).to receive(:registrations).and_return(registrations)
      expect(registrations).to receive(:accepted).and_return(attendees)

      attendees.each { |attendee| expect(Member).to receive(:create_from_registration).with(attendee) }

      event.convert_attendees_to_members!
    end
  end

end
