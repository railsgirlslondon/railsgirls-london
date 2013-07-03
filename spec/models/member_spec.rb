require 'spec_helper'

describe Member do

  let(:city) { Fabricate(:city) }

  context "#name" do

    it "returns the given name and last name" do
      member = Fabricate(:member)

      expect(member.name).to eq("#{member.given_names} #{member.last_name}")
    end
  end

  context "#latest" do

    it "returns the last 10 members" do
      members = 30.times.map { Fabricate(:member, city: city) }

      expect(city.members.latest).to eq(members.last(10).reverse)
    end
  end
end
