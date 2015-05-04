require 'spec_helper'

describe Meeting do
  context "validations" do
    let(:meeting) { Meeting.create(properties) }

    subject { meeting.valid? }

    context "no meeting type set" do
      let(:properties) {{ meeting_type: nil }}
      it { should be false }
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

  context "#invite_members" do
    let(:members) { [ Fabricate(:member),
                      Fabricate(:member),
                      Fabricate(:member, active: false)] }
    let!(:city) { Fabricate(:city, members: members) }
    let!(:meeting) { Fabricate(:meeting, city: city) }

    it "sends emails only to active members" do
      mailer = double(MeetingMailer, deliver_now: nil)
      MeetingMailer.should_receive(:invite).twice.and_return(mailer)

      meeting.invite_members
    end
  end
end
