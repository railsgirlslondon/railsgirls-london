require 'spec_helper'

describe Event, wip: true do
  it { should belong_to(:host_city) }

  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
end
