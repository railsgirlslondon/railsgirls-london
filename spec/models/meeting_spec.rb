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

  context "#announce!" do
    let(:meeting) { Fabricate(:meeting) }
    let(:registrations) { 5.times.map { Fabricate(:registration, selection_state: "RGL Weeklies") } }

    it "announces the meeting to all RGL members" do
      registrations.each do |registration|
        mailer = mock(MeetingMailer, deliver: mock)
        MeetingMailer.should_receive(:invite).with(meeting, registration).and_return(mailer)
        mailer.deliver
      end

      meeting.announce!
    end
  end
end
