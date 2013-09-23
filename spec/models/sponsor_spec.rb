require "spec_helper"

describe Sponsor do
  let!(:event) { Fabricate(:event) }
  subject { Fabricate(:sponsor_with_address) }

  before do
    Sponsorship.create! sponsorable_type: 'Event', sponsorable_id: event.id, sponsor: subject, host: true
  end

  describe "validations" do
    context "when not hosting" do
      specify do
        subject.address_line_1 = nil
        subject.address_line_2 = nil
        subject.address_city = nil
        subject.address_postcode = nil

        expect(subject.valid?).to eq(false)

        expect(subject).to have(1).error_on(:address_line_1)
        expect(subject).to have(1).error_on(:address_city)
        expect(subject).to have(1).error_on(:address_postcode)
      end
    end

    context "when hosting" do
      specify do
        subject.valid?

        expect(subject).not_to have(1).error_on(:address_line_1)
        expect(subject).not_to have(1).error_on(:address_city)
        expect(subject).not_to have(1).error_on(:address_postcode)
      end
    end
  end

  describe "#is_host? and #is_host_for?" do
    let!(:other_event) { Fabricate(:event) }

    before do
      Sponsorship.create! sponsorable_type: 'Event', sponsorable_id: other_event.id, sponsor: subject, host: false
    end

    specify { expect(subject.is_host?).to eq(true) }
    specify { expect(subject.is_host_for?(event)).to eq(true) }
    specify { expect(subject.is_host_for?(other_event)).to eq(false) }
  end
end
