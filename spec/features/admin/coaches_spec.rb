require "spec_helper"

feature "admin CRUDing coaches" do
  let(:name) { Faker::Name.name }
  let(:email) { Faker::Internet.email }

  Given { admin_logged_in! }

  context "creating a coach" do
    Given do
      click_on "Coaches"
      click_on "Add Coach"
    end

    context "with the minimum required information" do
      When do
        fill_in "Name", with: name
        fill_in "Email", with: email

        click_on "Create Coach"
      end

      Then { page.has_content? 'Coach was successfully created.' }
      And { page.has_content? name }
      And { page.has_content? email }

      context "then editing that coach" do
        When do
          click_on "Edit"

          fill_in "Name", with: "a new name"
          fill_in "Phone number", with: "a phone number"

          click_on "Update Coach"
        end

        Then { page.has_content? 'Coach was successfully updated.' }
        And { page.has_content? 'a new name' }
        And { page.has_content? "a phone number" } 
      end

      context "viewing that coach on the index" do
        When do
          click_on "Back"
        end

        Then { page.has_content? name }
        And { page.has_content? email }
      end

      context "deleting that coach" do
        When do
          click_on "Back"
          click_on "Destroy"
        end

        Then { page.has_content? 'Coach was successfully destroyed.' }

        context "that coach no longer shows up on the index" do
          When do
            visit admin_coaches_path
          end

          Then { !page.has_content? name }
        end
      end
    end

    context "assigning a coach to an event" do
      Given!(:city) { City.create! name: "A city" }
      Given!(:event) do
        Event.create! city_id: city.id, description: "an event name", starts_on: Time.now, ends_on: Time.now, coachable: true
      end
      Given!(:non_coachable_meeting) { Fabricate(:meeting) }
      Given { Fabricate(:coach, name: "a coach") }

      When do
        click_on "Coaches"
        click_on "Edit"
      end

      context "non coachable cannot be assigned" do
        Then { page.has_content? "Not coaching" }
        Then { !page.has_content? non_coachable_meeting.to_s }
      end

      context "with no coach currently assigned" do
        Then { !page.has_content? "Coaching" }
        And { page.has_content? event.dates }
        And { page.has_content? "Not coaching" }
      end

      context "coaching an event" do
        When { click_on "Coach" }

        Then { page.has_content? "Coaching" }
        And { page.has_content? event.dates }
        And { !page.has_content? "Not coaching" }

        context "viewing the coach on the event show" do
          When { visit admin_event_path(event) }

          Then { page.has_content? "a coach" }
        end

        context "removing a coaching" do
          When { click_on "Remove" }

          Then { !page.has_content? "Coaching" }
          And { page.has_content? event.dates }
          And { page.has_content? "Not coaching" }
        end
      end
    end
  end
end
