require 'spec_helper'

describe Registration do
  let(:registration) { Fabricate(:registration) }

  it '#fullname' do
    registration.fullname.should eq "#{registration.first_name} #{registration.last_name}"
  end

  it '#to_s' do
    [:fullname,
     :gender,
     :uk_resident,
     :programming_experience,
     :spoken_languages,
     :preferred_language].each do |information|
      registration.to_s.should include registration.send information
    end
  end

  it "#accepted" do
    accepted_registrations = 3.times.map { Fabricate(:registration,
                                                 selection_state: "accepted",
                                                 attending: true) }

    Registration.accepted.to_a.should eq accepted_registrations
  end

  it "#mark_selection" do
    registration.mark_selection "accepted"


    registration.selection_state.should eq "accepted"
  end

  describe "validation contexts" do
    it 'allows an admin to save only minimal information' do
      registration = Registration.new(first_name: "first",
                                      last_name: "last",
                                      email: "email@example.com")

      expect(registration).to be_valid
    end

    it 'requires all the registration attributes on registration' do
      invalid_registration = Registration.new

      expect(invalid_registration.valid?(:registration)).to be false
      Registration::REGISTRATION_ATTRIBUTES.each do |attribute|
        next if attribute == :gender
        expect(invalid_registration.errors[attribute]).not_to be_empty
      end
    end

    it "Only allows one registration per email address for each event" do
      member = Fabricate(:member)
      event = Fabricate(:event)
      first_registration = Fabricate(:registration, event: event, email: member.email)
      expect(first_registration).to be_valid

      second_registration = Fabricate.build(:registration, event: event, email: member.email)
      expect(second_registration).not_to be_valid
    end

    it "Allows an email address to register for multiple events" do
      member = Fabricate(:member)
      event_1, event_2 = Fabricate.times(2, :event)
      expect(Fabricate(:registration, event: event_1, email: member.email)).to be_valid
      expect(Fabricate(:registration, event: event_2, email: member.email)).to be_valid
    end
  end

  describe "#members" do
    it "returns the registrations converted into members" do
      Fabricate(:registration, selection_state: "RGL Weeklies")
      2.times.map { Fabricate(:registration, member: Fabricate(:member)) }
      4.times { Fabricate(:registration, selection_state: "accepted", attending: false)}
      4.times { Fabricate(:attended_registration) }

      expect(Registration.members.count).to eq 2
    end
  end
end
