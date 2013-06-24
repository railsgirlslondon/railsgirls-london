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

      expect(invalid_registration.valid?(:registration)).to be_false
      Registration::REGISTRATION_ATTRIBUTES.each do |attribute|
        expect(invalid_registration.errors[attribute]).not_to be_empty
      end
    end
  end

  describe "#members" do
    it "returns the list of people who attended the workshop" do
      Fabricate(:registration, selection_state: "RGL Weeklies")
      2.times.map { Fabricate(:registration, selection_state: "accepted", attending: true) }
      2.times { Fabricate(:registration) }
      4.times { Fabricate(:registration, selection_state: "accepted", attending: false)}

      expect(Registration.members.count).to eq 3
    end
  end
end
