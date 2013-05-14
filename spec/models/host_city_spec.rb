require 'spec_helper'

describe HostCity do

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }

    it { should validate_uniqueness_of(:slug) }
  end
end
