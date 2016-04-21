require 'spec_helper'

describe Event do

  context "scopes" do

    context "#upcoming" do
      it "retrieves upcoming meetings" do
        upcoming_events = 3.times.map { Fabricate(:event) }
        3.times.map { Fabricate(:event, :active => false) }
        2.times { Fabricate(:event, :ends_on => Date.today-1.week) }

        expect(Event.upcoming).to eq(upcoming_events.reverse)
      end
    end
  end

  describe "#coaches.who_attended" do
    let!(:event) { Fabricate(:event) }
    let!(:coaching_unknown) { Fabricate(:event_coaching, coachable_id: event.id, attended: :unknown) }
    let!(:coaching_attended) { Fabricate(:event_coaching, coachable_id: event.id, attended: :attended) }
    let!(:coaching_cancelled) { Fabricate(:event_coaching, coachable_id: event.id, attended: :cancelled) }
    let!(:coaching_no_show) { Fabricate(:event_coaching, coachable_id: event.id, attended: :no_show) }

    it "lists only unknown and attending coaches" do
      expect(event.coaches.who_attended).to eq([coaching_unknown.coach, coaching_attended.coach])
    end
  end

  describe "registrations" do
    let(:event) { Event.new(registration_deadline: date) }

    describe "#accepting_registrations?" do
      subject { event.accepting_registrations? }

      context "no registration deadline" do
        let(:date) { nil }
        it { should be false }
      end
    end

    describe "#registrations_open?" do
      subject { event.registrations_open? }

      context "deadline in future" do
        let(:date) { 2.days.from_now }
        it { should be true }
      end

      context "deadline today" do
        let(:date) { Date.today }
        it { should be true }
      end

      context "deadline in the past" do
        let(:date) { Date.yesterday }
        it { should be false }
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

      event.dates.should eq "13-14 July 2013"
    end

    it "two days over two months" do
      event = Fabricate(:event,
                        starts_on: Date.new(2013,11,30),
                        ends_on: Date.new(2013,12,1))

      event.dates.should eq "30 November-1 December 2013"
    end

    it "one day" do
      event = Fabricate(:event,
                        starts_on: Date.new(2013,8,3),
                        ends_on: Date.new(2013,8,3))

      event.dates.should eq "August 3, 2013"
    end
  end

  describe "applications" do
    let(:event) { Fabricate(:event) }
    let!(:accepted) { 3.times.map { Fabricate(:attended_registration, event: event) } }
    let!(:weeklies) { 2.times.map { Fabricate(:weeklies_registration, event: event) } }
    let!(:waiting_list) { 2.times.map { Fabricate(:waiting_list_registration, event: event) } }

    it "#selected_applicants" do
      event.selected_applicants.should eq accepted
    end

    it "#waiting_list_applicants" do
      event.waiting_list_applicants.should eq waiting_list
    end

    it "#converts_attendees_to_members!" do
      5.times.map { Fabricate(:registration, event: event) }
      attendees = 2.times.map { Fabricate(:attended_registration, event: event) }

      registrations = event.registrations
      event.should_receive(:registrations).and_return(registrations)
      registrations.should_receive(:accepted).and_return(attendees)

      attendees.each { |attendee| Member.should_receive(:create_from_registration).with(attendee) }

      event.convert_attendees_to_members!
    end
  end

end
