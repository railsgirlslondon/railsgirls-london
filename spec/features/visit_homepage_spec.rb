require 'spec_helper'

feature "A user visits the homepage" do

  context "when there are events coming up" do
    let!(:event) { Fabricate(:event) }

    scenario "he can view the upcoming events" do
      visit root_path

      expect(page).to have_content event.dates
      expect(page).to have_content "Application"
    end
  end
end
