require 'spec_helper'

describe SponsorComparator do

  let(:event) { Fabricate(:event) }
  let(:subject) { SponsorComparator.new(event) }

  describe "#sponsors_for_logos" do
    context "with no sponsors" do
      it "returns an empty array" do
        expect(subject.sponsors_for_logos).to eql([])
      end
    end

    context "with sponsors" do
      let(:sponsorship1) { Fabricate(:event_sponsorship, sponsorable_id: event.id) }
      let(:sponsorship2) { Fabricate(:event_sponsorship) }

      let!(:sponsor1) { sponsorship1.sponsor }
      let!(:sponsor2) { sponsorship2.sponsor }

      it "returns current sponsors highest" do
        expect(subject.sponsors_for_logos).to eql([sponsor1, sponsor2])
      end

      context "for the same event" do
        let!(:sponsorship3) { Fabricate(:event_sponsorship, sponsorable_id: event.id) }
        let!(:sponsorship4) { Fabricate(:event_sponsorship, sponsor: sponsorship3.sponsor, sponsorable_id: sponsorship2.sponsorable_id) }

        let!(:sponsor3) { sponsorship3.sponsor }

        it "returns more frequent sponsors above less frequent" do
          expect(subject.sponsors_for_logos).to eql([sponsor3, sponsor1, sponsor2])
        end
      end
    end
  end

end
