require 'spec_helper'

describe Meeting do
  context "validations" do
    let(:meeting) { Meeting.create(properties) }

    subject { meeting.valid? }

    context "no meeting type set" do
      let(:properties) {{ meeting_type: nil }}
      it { should be_false }
    end
  end

  context "#upcoming" do
    it "retrieves upcoming meetings" do
      upcoming_meetings = 3.times.map { Fabricate(:meeting) }
      2.times { Fabricate(:meeting, date: Date.today-1.week) }

      expect(Meeting.upcoming).to eq(upcoming_meetings)
    end
  end

  context "#announced" do
    it "retrieves announced meetings" do
      announced_meetings = 3.times.map { Fabricate(:meeting) }
      2.times { Fabricate(:unannounced_meeting) }

      expect(Meeting.announced).to eq(announced_meetings)
    end
  end
end
