require "spec_helper"

feature "admin CRUDing members" do

  let(:first_name) { Faker::Name.name }
  let(:last_name) { Faker::Name.name }
  let(:email) { Faker::Internet.email }
  let(:phone_number) { Faker::Lorem.word }


  Given!(:city) { Fabricate(:city) }
  Given { admin_logged_in! }

  context "creating a member" do
    Given do
      visit admin_city_members_path(city)

      click_on "Add Member"
    end

    context "with the minimum required information" do
      When do
        fill_in "First name", with: first_name
        fill_in "Last name", with: last_name
        fill_in "Phone number", with: phone_number
        fill_in "Email", with: email

        click_on "Create Member"
      end

      Then { page.has_content? 'Member was successfully created.' }
      And { page.has_content? first_name }
      And { page.has_content? last_name }
      And { page.has_content? email }

      context "then editing that member" do
        let(:new_email) { Faker::Internet.email }

        When do
          click_on "Edit"

          fill_in "Email", with: new_email

          click_on "Update Member"
        end

        Then { page.has_content? 'Member was successfully updated.' }
        And { page.has_content? new_email }
      end

      context "viewing that member on the city dashboard" do
        When do
          click_on "Back"
        end

        Then { page.has_content? first_name }
        Then { page.has_content? last_name }
      end

      context "Adding a member with the same email" do
        let(:other_first_name) { Faker::Name.name }
        let(:other_last_name) { Faker::Name.name }
        let(:other_phone_number) { Faker::Lorem.word }

        When do
          click_on "Add Member"

          fill_in "First name", with: other_first_name
          fill_in "Last name", with: other_last_name
          fill_in "Phone number", with: other_phone_number
          fill_in "Email", with: email

          click_on "Create Member"
        end

        Then { page.has_content? 'Please review the problems below' }
        And { page.has_content? "has already been taken" }
      end
    end
  end
end
