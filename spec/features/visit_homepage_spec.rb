require 'spec_helper'

feature "A user visits the homepage" do

  context "when there are events coming up" do
    let!(:event) { Fabricate(:event) }
    let!(:host) { Fabricate(:hosting, sponsorable_type: 'Event', sponsorable_id: event.id) }

    scenario "he can view the upcoming events" do
      visit root_path

      expect(page).to have_content event.dates
      expect(page).to have_content "Rails Girls London"
      expect(page).to have_content "Making technology more approachable for women"
    end
  end
end
