require "spec_helper"

feature "Coachings" do
  Given { admin_logged_in! }
  Given!(:coach) { Fabricate(:coach) }

  context "can be created for an event" do
    Given!(:event) { Fabricate(:event, coachable: true) }

    When do
      visit admin_coach_path(coach)
      click_on "Coach"
    end

    Then do
      visit admin_city_event_path(event.city, event)
      page.has_content? coach.name
    end
  end

  context "can be created for a meeting" do
    Given!(:meeting) { Fabricate(:meeting, coachable: true) }

    When do
      visit admin_coach_path(coach)
      click_on "Coach"
    end

    Then do
      visit admin_city_meeting_path(meeting.city, meeting)
      page.has_content? coach.name
    end
  end

  context "are not available if a meeting is not coachable" do
    Given!(:meeting) { Fabricate(:meeting) }

    When do
      visit admin_city_meeting_path(meeting.city, meeting)
    end

    Then do
      !page.has_content? "Add Coach"
    end
  end
end
