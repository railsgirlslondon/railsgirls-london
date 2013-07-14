require 'spec_helper'

describe Coach do
  let!(:coach) { Fabricate(:coach) }
  let!(:event) { Fabricate(:event) }

  describe "validations" do
    let!(:coach) { Coach.create name: "Name", email: "email@emial.com" }

    it "requires phone number when organising" do
      expect(coach.valid?).to be_true

      coaching = Coaching.create coachable_type: 'Event', coachable_id: event.id, coach: coach, organiser: true

      expect(coaching.valid?).to be_false
      expect(coaching).to have(1).error_on(:coach)
    end
  end

  describe "#is_organiser and #is_organiser_for?" do
    let!(:other_event) { Fabricate(:event) }

    before do
      Coaching.create! coachable_type: 'Event', coachable_id: event.id, coach: coach, organiser: true
      Coaching.create! coachable_type: 'Event', coachable_id: other_event.id, coach: coach, organiser: false
    end

    specify { expect(coach.is_organiser?).to eq(true) }
    specify { expect(coach.is_organiser_for?(event)).to eq(true) }
    specify { expect(coach.is_organiser_for?(other_event)).to eq(false) }
  end
end
