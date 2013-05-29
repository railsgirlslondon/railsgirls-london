require "spec_helper"

feature "admin CRUDing coaches" do
  let(:name) { Faker::Name.first_name }
  let(:twitter) { Faker::Name.first_name }
  let(:email) { Faker::Internet.email }

  Given { admin_logged_in! }

  context "creating a coach" do
    Given do
      click_on "Coaches"
      click_on "New Coach"
    end

    When do
      fill_in "Name", with: name
      fill_in "Twitter", with: twitter
      fill_in "Email", with: email

      click_on "Create Coach"
    end

    Then { page.has_content? 'Coach was successfully created.' }
  end
end