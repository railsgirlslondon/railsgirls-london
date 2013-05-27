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
  let(:address) { Faker::Lorem.sentence }
  let(:spoken_languages) { Faker::Lorem.sentence }
  let(:preferred_language) { Faker::Lorem.sentence }
  let(:os_version) { Faker::Lorem.sentence }

  Given(:city) { City.create! name: "London" }
  Given(:event) { Event.create! city_id: city.id, description: Faker::Lorem.sentence }
  Given { visit new_city_event_registration_path(city, event) }

  context "with the minimum required information" do

    When do
      fill_in "First name", with: first_name
      fill_in "Last name", with: last_name
      select "Female", from: "Gender"
      fill_in "Email", with: email
      fill_in "Phone number", with: phone_number
      fill_in "Address", with: address
      fill_in "Spoken languages", with: spoken_languages
      fill_in "Preferred language", with: preferred_language
      select "Yes", from: "UK Resident"
      select "OS X", from: "Operating System"
      fill_in "OS Version", with: os_version
      fill_in "Programming experience", with: experience
      fill_in "Reason for applying", with: reason

      click_on "Register"
    end

    Then { page.has_content? "Thanks for registering!" }
  end

  context "with all information filled in required information" do

    When do
      fill_in "First name", with: first_name
      fill_in "Last name", with: last_name
      select "Female", from: "Gender"
      fill_in "Email", with: email
      fill_in "Phone number", with: phone_number
      fill_in "Twitter", with: twitter
      fill_in "Address", with: address
      fill_in "Spoken languages", with: spoken_languages
      fill_in "Preferred language", with: preferred_language
      select "Yes", from: "UK Resident"
      select "OS X", from: "Operating System"
      fill_in "OS Version", with: os_version
      fill_in "Programming experience", with: experience
      fill_in "Reason for applying", with: reason

      click_on "Register"
    end

    Then { page.has_content? "Thanks for registering!" }
  end

end
