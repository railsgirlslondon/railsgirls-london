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

    context "selection_state" do
      it 'allows selection state to be one of the selected statues' do
        Registration::SELECTION_STATES.each do |selection_state|
          subject.selection_state = selection_state
          subject.valid?
          expect(subject.errors[selection_state]).to be_empty
        end
      end

      it "doesn't allow other values" do
        subject.selection_state = "something else"
        subject.valid?
        expect(subject.errors[:selection_state]).to_not be_empty
      end
    end
  end
end
