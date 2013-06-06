require "spec_helper"

describe EventSponsorship do
  describe "validations" do
    let!(:event) { Fabricate(:event) }

    subject do
      EventSponsorship.new event: event, sponsor: sponsor, host: true 
    end

    context "sponsor without a full address" do
      let(:sponsor) { Fabricate(:sponsor) }

      specify do
        expect(subject.valid?).to eq(false)

        expect(subject).to have(1).error_on(:host)
      end
    end

    context "sponsor with a full address" do
      let(:sponsor) { Fabricate(:sponsor_with_address) }
      
      specify do        
        expect(subject.valid?).to eq(true)
      end
    end
  end
end