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

  def fill_out_registration!
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

    scenario "adding a registrant to the event and marking as attending" do
      fill_out_registration!

      click_link "Accept"

      expect(page).to have_content "john@registrant.com"
      expect(page).to have_link "Send invite"
      expect(page).to have_link "Decline"
    end

    scenario "declining a registrant after originally marking as attending" do
      fill_out_registration!

      click_link "Accept"
      click_link "Decline"

      expect(page).to have_link "Accept"
      expect(page).not_to have_link "Send invite"
    end

    scenario "sending an invite" do
      fill_out_registration!

      expect(EventMailer).to receive(:invite)

      click_link "Accept"
      click_link "Send invite"
    end
  end

end
