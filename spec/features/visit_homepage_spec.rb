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

  context "when there are no events coming up" do
    let!(:city) { Fabricate(:city) }

    scenario "he can view the cities listed" do
      visit root_path

      expect(page).to have_content city.name
      expect(page).to have_content "View #{city.name} events"
    end

  end
end
