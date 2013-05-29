require "spec_helper"

feature "admin CRUDing events" do
  Given { City.create! name: "London" }
  Given { admin_logged_in! }

  context "creating and editing an event" do
    When { visit new_admin_event_path }  
    When { fill_in "Description", with: "Second RG workshop" }
    When { select "London", from: "City" }
    When { check "Active" }
    When { click_on "Create Event" }

    Then { page.has_content? "Event was successfully created." }
    And { page.has_content? "Second RG workshop" }
    And { page.has_content? "London" }
    And { page.has_content? "true" }

    context "editing an event" do
      When { click_on "Edit" }
      When { fill_in "Description", with: "A new description" }
      When { click_on "Update Event" }

      Then { page.has_content? "Event was successfully updated." }
      And { page.has_content? "A new description" }
    end

    context "viewing the event on the index" do
      When { visit admin_events_path }
      Then { page.has_content? "Second RG workshop" }
    end

    context "deleting an event" do
      When { click_link "Back"}
      When { click_link "Destroy" }
      Then { !page.has_content? "Second RG workshop" }
    end
  end
end