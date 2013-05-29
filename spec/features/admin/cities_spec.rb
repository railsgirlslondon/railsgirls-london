require 'spec_helper'

feature "an admin CRUDing cities" do
  Given { admin_logged_in! }

  context "creating cities" do
    When do
      expect { find(".cities a") }.to raise_error

      click_link "New city"

      fill_in "Name", with: "London"
      click_on "Create City"
    end

    Then do
      expect(page).to have_content("London")

      visit root_path

      find(".cities a").should have_text "London"
    end
  end
end

