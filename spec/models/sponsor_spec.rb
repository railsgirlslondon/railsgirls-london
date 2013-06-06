require "spec_helper"

describe Sponsor do
  describe "validations" do
    it "validate address details if hosting" do
      subject.host = true

      expect(subject.valid?).to eq(false)

      expect(subject).to have(1).error_on(:address_line_1)
      expect(subject).to have(1).error_on(:address_line_2)
      expect(subject).to have(1).error_on(:address_city)
      expect(subject).to have(1).error_on(:address_postcode)
    end

    it "allows empty addresses if not hosting" do
      subject.host = false

      subject.valid?

      expect(subject).not_to have(1).error_on(:address_line_1)
      expect(subject).not_to have(1).error_on(:address_line_2)
      expect(subject).not_to have(1).error_on(:address_city)
      expect(subject).not_to have(1).error_on(:address_postcode)
    end
  end
end