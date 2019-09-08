require 'spec_helper'

describe Event do

  describe "scopes" do
    before do
      old_event = create(:event, starts_on: Date.yesterday-1.day, ends_on: Date.yesterday)
    end

    context "#upcoming" do
      let!(:upcoming_event) { create(:event, starts_on: Date.tomorrow, ends_on: Date.tomorrow+1.day) }

      it "retrieves upcoming meetings" do
        expect(described_class.upcoming).to contain_exactly(upcoming_event)
      end
    end
  end

  describe "#coaches.who_attended" do
    let!(:event) { create(:event) }
    let!(:coaching_nil) { create(:event_coaching, coachable_id: event.id) }
    let!(:coaching_unknown) { create(:event_coaching, coachable_id: event.id, attended: :unknown) }
    let!(:coaching_attended) { create(:event_coaching, coachable_id: event.id, attended: :attended) }
    let!(:coaching_cancelled) { create(:event_coaching, coachable_id: event.id, attended: :cancelled) }
    let!(:coaching_no_show) { create(:event_coaching, coachable_id: event.id, attended: :no_show) }

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
    let!(:event) { create(:event) }
    let!(:sponsor) { create(:sponsor_with_address) }
    let!(:other_sponsor) { create(:sponsor, events: [event]) }

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
      let!(:event) { create(:event) }
      let!(:sponsor) { create(:sponsor_with_address) }
      let!(:other_sponsor) { create(:event_sponsorship) }

      let!(:sponsorship) { Sponsorship.create! sponsorable_id: event.id, sponsorable_type: 'Event', sponsor: sponsor, host: true }

      context "when there is a host" do
        specify { expect(sponsor.is_host_for?(event)).to eq(true) }
      end

    end

  end

  describe "dates" do

    it "two days in the same month" do
      event = create(:event,
                        starts_on: Date.new(2013,7,13),
                        ends_on: Date.new(2013,7,14))

      expect(event.dates).to eq("13-14 July 2013")
    end

    it "two days over two months" do
      event = create(:event,
                        starts_on: Date.new(2013,11,30),
                        ends_on: Date.new(2013,12,1))

      expect(event.dates).to eq("30 November-1 December 2013")
    end

    it "one day" do
      event = create(:event,
                        starts_on: Date.new(2013,8,3),
                        ends_on: Date.new(2013,8,3))

      expect(event.dates).to eq("August 3, 2013")
    end
  end

  describe "applications" do
    let(:event) { create(:event) }
    let!(:accepted) { 3.times.map { create(:attended_registration, event: event) } }
    let!(:weeklies) { 2.times.map { create(:weeklies_registration, event: event) } }
    let!(:waiting_list) { 2.times.map { create(:waiting_list_registration, event: event) } }

    it "#selected_applicants" do
      expect(event.selected_applicants).to match_array(accepted)
    end

    it "#converts_attendees_to_members!" do
      5.times.map { create(:registration, event: event) }
      attendees = 2.times.map { create(:attended_registration, event: event) }

      registrations = event.registrations
      expect(event).to receive(:registrations).and_return(registrations)
      expect(registrations).to receive(:accepted).and_return(attendees)

      attendees.each { |attendee| expect(Member).to receive(:create_from_registration).with(attendee) }

      event.convert_attendees_to_members!
    end
  end

end
