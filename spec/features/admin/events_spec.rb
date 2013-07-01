require "spec_helper"

feature "admin CRUDing events" do
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
        fill_in 'Email', with: 'john@registrant.com'

        click_on 'Create Registration'
      end

      Then { page.has_content? "john@registrant.com" }

      When { click_on 'Attend' }
      Then { page.has_content? 'attending' }

      When { click_on "Don't Attend" }
      Then { page.has_content? 'attending' }
    end
  end

  context "converting event attendees to members", wip: true do
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
