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

  Given { admin_logged_in! }

  context "creating and editing an event" do
    When do
      visit new_admin_event_path
      fill_in "Title", with: "Autumn Workshop"
      fill_in "Description", with: "Second RG workshop"
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
  end

end
