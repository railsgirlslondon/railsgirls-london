require 'spec_helper'

feature "an admin CRUDing cities" do
  Given!(:city) { City.create! name: "A city that exists" }
  Given { admin_logged_in! }

  context "creating cities" do
    Given { click_on "Cities" }

    When do
      expect(page).to_not have_content "Some City"
      click_link "Add city"

      fill_in "Name", with: "Some City"
      click_on "Create City"
    end

    Then do
      expect(page).to have_content("Some City")

      visit root_path

      expect(page).to have_content("Cities")
      expect(page).to have_content("London")
    end
  end

  context "managing" do
    context "events" do
      Given!(:event) { Fabricate(:event, city: city) }

      Given { click_on "Cities" }

      When do
        click_on city.name
      end

      Then do
        expect(page).to have_content("#{city.name} dashboard")
        expect(page).to have_link("Add event")
        expect(page).to have_link(event.dates)
      end
    end

    context "meetings" do
      Given!(:meeting) { Fabricate(:meeting, city: city) }
      Given { click_on "Cities" }

      When do
        click_on city.name
      end

      Then do
        expect(page).to have_content("#{city.name} dashboard")
        expect(page).to have_link("Add meeting")
        expect(page).to have_link(meeting.name)
      end
    end

    context "members" do
      Given!(:member) { Fabricate(:member, city: city) }
      Given { click_on "Cities" }

      When do
        click_on city.name
      end

      Then do
        expect(page).to have_content("#{city.name} dashboard")
        expect(page).to have_link("Add member")
        expect(page).to have_link(member.name)
      end
    end
  end

end

