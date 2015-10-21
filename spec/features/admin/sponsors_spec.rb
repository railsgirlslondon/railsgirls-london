require "spec_helper"

feature "admin CRUDing sponsors" do
  let(:name) { Faker::Name.first_name }
  let(:description) { Faker::Lorem.paragraph }
  let(:email) { Faker::Internet.email }
  let(:website) { Faker::Internet.domain_name }
  let(:image_url) { Faker::Internet.domain_name }

  Given { admin_logged_in! }

  context "creating a sponsor" do
    Given do
      click_on "Sponsors"
      click_on "Add Sponsor"
    end

    When do
      fill_in "Name", with: name
      fill_in "Description", with: description
      fill_in "Primary contact email", with: email
      fill_in "Image url", with: image_url
      fill_in "Website", with: website

      click_on "Create Sponsor"
    end

    Then { page.has_content? 'Sponsor was successfully created.' }
    And { page.has_content? name }
    And { page.has_content? description }
    And { page.has_content? email }

    context "then editing that sponsor" do
      When do
        click_on "Edit"

        fill_in "Name", with: "a new name"

        click_on "Update Sponsor"
      end

      Then { page.has_content? 'Sponsor was successfully updated.' }
      And { page.has_content? 'a new name' }
    end

    context "viewing that sponsor on the index" do
      When do
        click_on "Back"
      end

      Then { page.has_content? name }
      And { page.has_content? email }
    end

    context "deleting that sponsor" do
      When do
        click_on "Back"
        click_on "Destroy"
      end

      Then { page.has_content? 'Sponsor was successfully destroyed.' }

      context "that sponsor no longer shows up on the index" do
        When do
          visit admin_sponsors_path
        end

        Then { !page.has_content? name }
      end
    end

  end

  context "assigning a sponsor to an event" do
    Given!(:event) do
      Event.create! description: "an event name", starts_on: Time.now, ends_on: Time.now
    end
    Given { Sponsor.create! name: "a sponsor", website: website }

    When do
      click_on "Sponsors"
      click_on "Edit"
    end

    context "with no sponsor currently" do
      Then { !page.has_content? "Sponsoring" }
      And { page.has_content? event.dates }
      And { page.has_content? "Not sponsoring" }
    end

    context "sponsoring an event" do
      When { click_on "Sponsor" }

      Then { page.has_content? "Sponsoring" }
      And { page.has_content? event.dates }
      And { !page.has_content? "Not sponsored" }

      context "viewing the sponsor on the event show" do
        When { visit admin_event_path(event) }

        Then { page.has_content? "a sponsor" }
      end

      context "making a sponsor a host" do
        When do
          fill_in "Address line 1", with: "My apartment"
          fill_in "Address line 2", with: "123 Street st"
          fill_in "City", with: "Sama"
          fill_in "Postcode", with: "N1 3TY"

          click_on "Update Sponsor"
        end

        When do
          click_on "Edit"
          find(:css, "#sponsorship_host").set(true)
          click_on "Update"
          click_on "Show"
        end

        Then { page.has_content? "Host" }
        And { page.has_content? "My apartment" }
        And { page.has_content? "123 Street st" }
        And { page.has_content? "Sama" }
        And { page.has_content? "N1 3TY" }
      end

      context "removing a sponsorship" do
        When { click_on "Remove" }

        Then { !page.has_content? "Sponsoring" }
        And { page.has_content? event.dates }
        And { page.has_content? "Not sponsoring" }
      end
    end
  end
end
