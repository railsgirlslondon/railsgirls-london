require "spec_helper"

feature "admin CRUDing events" do
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
  let(:dietary_restrictions) { Faker::Lorem.sentence }

  Given!(:city) { City.create! name: "London" }
  Given { admin_logged_in! }

  context "creating and editing an event" do
    When do
      visit new_admin_event_path
      fill_in "Title", with: "Autumn Workshop"
      fill_in "Description", with: "Second RG workshop"
      select "London", from: "City"
      check "Active"
      click_on "Create Event"
    end

    Then { page.has_content? "Event was successfully created." }
    And { page.has_content? "Autumn Workshop" }
    And { page.has_content? "Second RG workshop" }
    And { page.has_content? "London" }
    And { page.has_content? "The event is active" }

    context "editing an event" do
      When do
        click_on "Edit"
        fill_in "Description", with: "A new description"
        click_on "Update Event"
      end

      Then { page.has_content? "Event was successfully updated." }
      And { page.has_content? "A new description" }
    end

    context "viewing the event on the index" do
      When { visit admin_events_path }
      Then { page.has_content? "Second RG workshop" }
    end

    context "deleting an event" do
      When do
        visit admin_events_path
        click_link "Destroy"
      end

      Then { !page.has_content? "Second RG workshop" }
    end

    context "adding a registrant to the event and marking as attending" do
      When do
        click_on 'Add registration'
        fill_in 'First name', with: 'Johnny'
        fill_in 'Last name', with: "Smithington"

        select "Female", from: "Gender"
        fill_in 'registration_email', with: 'john@registrant.com'
        fill_in "Email confirmation", with: 'john@registrant.com'
        fill_in "Phone number", with: phone_number
        fill_in "Address", with: address
        fill_in "Spoken languages", with: spoken_languages
        fill_in "Preferred language", with: preferred_language
        select "Yes", from: "UK Resident"
        select "OS X", from: "Operating System"
        fill_in "OS Version", with: os_version
        fill_in "Programming experience", with: experience
        fill_in "Reason for applying", with: reason
        check('registration_terms_of_service')

        click_on 'Create Registration'
      end

      Then { page.has_content? "john@registrant.com" }

      When { click_link "Accept" }
      Then { page.has_link? "Decline" }
    end

    context "declining a registrant after originally marking as attending" do
      When do
        click_on 'Add registration'
        fill_in 'First name', with: 'Johnny'
        fill_in 'Last name', with: "Smithington"

        select "Female", from: "Gender"
        fill_in 'registration_email', with: 'john@registrant.com'
        fill_in "Email confirmation", with: 'john@registrant.com'
        fill_in "Phone number", with: phone_number
        fill_in "Address", with: address
        fill_in "Spoken languages", with: spoken_languages
        fill_in "Preferred language", with: preferred_language
        select "Yes", from: "UK Resident"
        select "OS X", from: "Operating System"
        fill_in "OS Version", with: os_version
        fill_in "Programming experience", with: experience
        fill_in "Reason for applying", with: reason
        check('registration_terms_of_service')


        click_on 'Create Registration'
      end

      When { click_link "Accept" }
      When { click_link "Decline" }
      Then { page.has_link? "Accept" }
    end
  end

  context "converting event attendees to members" do
    Given!(:event) { Fabricate(:event, city: city, active: false) }
    Given!(:registration) { Fabricate(:attended_registration, event: event)}

    When do
      visit admin_city_event_path(city, event)

      click_on "Convert attendees to members"
    end

    Then do
      !page.has_content? "Convert attendees to members"
      page.has_content? "member"
    end

  end
end
