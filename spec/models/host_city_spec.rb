require 'spec_helper'

describe HostCity do

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }

    it { should validate_uniqueness_of(:slug) }

    it "only accepts a valid twitter username" do
      nepal = HostCity.new name: "Nepal", slug: :slug, twitter: 'invalid'
      nepal.save

      nepal.errors.first.should eq [:twitter, "It must begin with @"]
    end
  end
end
