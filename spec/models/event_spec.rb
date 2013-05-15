require 'spec_helper'

describe Event do
  it { should belong_to(:host_city) }

  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }

  context "#display dates" do
    it 'an event starting and finishing in the same month' do
      event = FactoryGirl.create(:event)

      event.dates.should eq("19-20th April")
    end

  end
end
