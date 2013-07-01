require 'spec_helper'

describe Member do

  let(:city) { Fabricate(:city) }

  context "#name" do

    it "returns the given name and last name" do
      member = Fabricate(:member)

      expect(member.name).to eq("#{member.first_name} #{member.last_name}")
    end
  end

  context "#latest" do

    it "returns the last 10 members" do
      members = 30.times.map { Fabricate(:member, city: city) }

      expect(city.members.latest).to eq(members.last(10).reverse)
    end
  end

  context "#permitted_attributes_from" do
    it "extracts the permitted attributes from another object" do
      registration = Fabricate(:registration, :event => Fabricate(:event, city: city))

      permitted_attributes = Member.permitted_attributes_from(registration).symbolize_keys.keys

      expect(permitted_attributes).to include(*Member::PERMITTED_ATTRIBUTES)
    end
  end

  context "#create_from_registration" do
    it "creates a member from a registration" do
      registration = Fabricate(:registration, :event => Fabricate(:event, city: city))

      Member.create_from_registration(registration)

      member = Member.last
      expect(member.first_name).to eq(registration.first_name)
      expect(member.id).to eq(registration.member_id)
    end
  end

end
