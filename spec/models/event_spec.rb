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

  describe "registrations" do
    let(:event) { Event.new(registration_deadline: date) }

    describe "#accepting_registrations?" do
      subject { event.accepting_registrations? }

      context "no registration deadline" do
        let(:date) { nil }
        it { should be_false }
      end
    end

    describe "#registrations_open?" do
      subject { event.registrations_open? }

      context "deadline in future" do
        let(:date) { 2.days.from_now }
        it { should be_true }
      end

      context "deadline today" do
        let(:date) { Date.today }
        it { should be_true }
      end

      context "deadline in the past" do
        let(:date) { Date.yesterday }
        it { should be_false }
      end
    end
  end

  describe "hosting" do
    let!(:event) { Fabricate(:event) }
    let!(:sponsor) { Fabricate(:sponsor_with_address) }
    let!(:other_sponsor) { Fabricate(:sponsor, events: [event]) }

    let!(:event_sponsorship) { EventSponsorship.create! event: event, sponsor: sponsor, host: true }

    specify { expect(event.host) == sponsor }
    specify { expect(event.has_host?) == true }

    specify { expect(event.non_hosting_sponsors).not_to include(sponsor) }
    specify { expect(event.non_hosting_sponsors).to eq([other_sponsor]) }

    context "when no sponsorships is there" do
      before { event_sponsorship.destroy }

      specify { expect(event.host).to eq(false) }
      specify { expect(event.has_host?).to eq(false) }
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
    let(:event) { Fabricate(:event, city: Fabricate(:city, name: "test-#{Time.now}")) }
    let!(:accepted_registrations) { 3.times.map { Fabricate(:registration, event: event, selection_state: "accepted") } }
    let!(:waiting_registrations) { 2.times.map { Fabricate(:registration, event: event, selection_state: "waiting list") } }

    it "#export_applications_to_trello" do
      event_trello = mock(:event_trello, export: nil)

      EventTrello.should_receive(:new).and_return(event_trello)
      event_trello.should_receive(:export)

      event.export_applications_to_trello
    end

    it "processess all applications" do
      registration = Fabricate(:registration, event: event)
      card = mock(:card, name: registration.reason_for_applying)
      applications = mock

      event.trello.should_receive(:add_list).and_return(nil)
      event.trello.should_receive(:move_cards_to_list).and_return(nil)
      event.trello.should_receive(:applications).and_return(applications)
      applications.should_receive(:take).and_return([card])
      applications.should_receive(:drop).and_return([])

      event.process_applications 2

      registration.reload.selection_state.should eq "accepted"
    end

    it "#selected_applicants" do
      event.selected_applicants.should eq accepted_registrations
    end

    it "#waiting_list_applicants" do
      event.waiting_list_applicants.should eq waiting_registrations
    end

    it "#send_email_to_selected_applicants" do
      accepted_registrations.each do |registration|
        registration_mailer = mock(:registration_mailer, deliver: nil)
        RegistrationMailer.should_receive(:application_accepted).with(event, registration).and_return(registration_mailer)
      end

      event.send_email_to_selected_applicants
    end

    it "#send_email_to_rejected_applicants" do
      waiting_registrations.each do |registration|
        registration_mailer = mock(:registration_mailer, deliver: nil)
        RegistrationMailer.should_receive(:application_rejected).with(event, registration).and_return(registration_mailer)
      end

      event.send_email_to_waiting_list_applicants
    end

  end
end
