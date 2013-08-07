require 'spec_helper'

describe Coaching do
  describe "validations" do
    it "requires a phone number for a coach" do
      coach = Fabricate(:coach, phone_number: nil)
      event = Fabricate(:event)

      coaching = Coaching.new(coachable_id: event.id,
                              coachable_type: 'Event',
                              coach: coach,
                              organiser: true)

      expect(coaching.valid?).to be_false
      expect(coaching).to have(1).error_on(:coach)
    end
  end
end
