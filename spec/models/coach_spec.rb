require 'spec_helper'

describe Coach do
  describe "#is_organiser_for?" do
    subject { Fabricate(:coach) }
    let!(:event) { Fabricate(:event) }
    let!(:other_event) { Fabricate(:event) }

    before do
      Coaching.create! coachable_type: 'Event', coachable_id: event.id, coach: subject, organiser: true
      Coaching.create! coachable_type: 'Event', coachable_id: other_event.id, coach: subject, organiser: false
    end

    specify { expect(subject.is_organiser_for?(event)).to eq(true) }
    specify { expect(subject.is_organiser_for?(other_event)).to eq(false) }
  end
end
