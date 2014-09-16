require "spec_helper"

feature "admin CRUDing meetings" do
  Given!(:city) { Fabricate(:city) }
  Given!(:meeting_type) { Fabricate(:meeting_type) }
  Given { admin_logged_in! }

  context "creating and editing a meeting" do
    When do
      visit new_admin_city_meeting_path(city)

      select meeting_type.name, from: "Meeting type"

      select "20", from: "meeting[date(3i)]"
      select "November", from: "meeting[date(2i)]"
      select "2014", from: "meeting[date(1i)]"
      select "18", from: "meeting[date(4i)]"
      select "30", from: "meeting[date(5i)]"

      fill_in "Available slots", with: 1

      click_on "Create Meeting"
    end

    Then { page.has_content? "Meeting was successfully created." }
    And { page.has_content? "20 Nov 2014 18:30" }

    context "editing the meeting" do
      When do
        click_on "Edit"
        select "October", from: "meeting[date(2i)]"

        click_on "Update Meeting"
      end

      Then { page.has_content? "Meeting was successfully updated." }
      And { page.has_content? "20 Oct 2014 18:30" }
    end

    context "deleting a meeting" do
      When do
        click_link "Destroy"
      end

      Then { page.has_content? "Meeting was successfully destroyed." }
      Then { !page.has_content? "20 Oct 2014" }
    end
  end

  context "sending invitations" do
    Given!(:city) { Fabricate(:city_with_members) }
    Given!(:meeting) { Fabricate(:meeting, city: city) }
    Given!(:sponsor) { Fabricate(:sponsor_with_address) }
    Given { Fabricate(:hosting, sponsor: sponsor, sponsorable: meeting) }

    context "sending invitations" do

      Given do
        visit admin_city_meeting_path(city, meeting)
      end

      context "is available when none have been sent out" do

        Then do
          city.members.each { |member| !page.has_content? member.name  }
        end
      end

      context "sends to all members" do
        When do
          click_on "Invite members"
        end

        Then do
          city.members.each { |member| page.has_content? member.name  }
        end

      end
    end
  end
end
