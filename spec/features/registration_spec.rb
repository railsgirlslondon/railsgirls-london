require 'spec_helper'

feature "a girl registering" do
  let(:first_name) { Faker::Name.name }
  let(:last_name) { Faker::Name.name }
  let(:email) { Faker::Internet.email }
  let(:phone_number) { Faker::PhoneNumber.phone_number }
  let(:twitter) { Faker::Name.name }
  let(:experience) { Faker::Lorem.sentence }
  let(:reason) { Faker::Lorem.sentence }
  let(:gender) { "Female" }

  Given(:city) { City.create! name: "London" }
  Given { visit new_city_registration_path(city) }

  When do
    fill_in "First name", with: first_name
    fill_in "Last name", with: last_name
    fill_in "Email", with: email
    fill_in "Phone number", with: phone_number
    fill_in "Twitter", with: twitter
    fill_in "Programming experience", with: experience
    fill_in "Reason for applying", with: reason
    select "Female", from: "Gender"

    click_on "Register"
  end

  Then { page.has_content? "Thanks for registering!" }
end
