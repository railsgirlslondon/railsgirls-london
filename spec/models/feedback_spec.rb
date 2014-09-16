require 'spec_helper'

describe Feedback do

it { should callback(:send_feedback_confirmation).after(:create) }

end