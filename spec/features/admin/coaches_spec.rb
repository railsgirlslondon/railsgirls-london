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
    And { page.has_content? name }
    And { page.has_content? twitter }
    And { page.has_content? email }

    context "then editing that coach" do
      When do
        click_on "Edit"

        fill_in "Name", with: "a new name"

        click_on "Update Coach"
      end

      Then { page.has_content? 'Coach was successfully updated.' }
      And { page.has_content? 'a new name' }
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
end