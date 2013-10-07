require 'spec_helper'

describe Feedback do

  it "#pending_confirmation?" do
    feedback = Fabricate(:feedback)

    expect(feedback.pending_confirmation?).to be_true
    feedback.update_attribute(:confirmed, true)

    expect(feedback.pending_confirmation?).to be_false
  end
end
