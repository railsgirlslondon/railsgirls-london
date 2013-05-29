require 'spec_helper'

feature "an admin CRUDing cities" do
  Given { admin_logged_in! }

  context "creating cities" do
    Given { click_on "Cities" }
    
    When do
      expect(page).to_not have_content "Some City"
      click_link "New city"

      fill_in "Name", with: "Some City"
      click_on "Create City"
    end

    Then do
      expect(page).to have_content("Some City")

      visit root_path

      find(".cities a").should have_text "Some City"
    end
  end
end

