require "spec_helper"

feature "Coachings" do
  Given { admin_logged_in! }
  Given!(:coach) { Fabricate(:coach) }

  context "for events" do
    Given!(:event) { Fabricate(:event, coachable: true) }

    context "can be created" do
      When do
        visit admin_coach_path(coach)
        click_on "Coach"
      end

      Then do
        page.has_content? "#{coach.name} has been assigned to #{event.to_s}."
        visit admin_city_event_path(event.city, event)
        page.has_content? coach.name
      end
    end

    context "can be set as organiser" do
      When do
        visit admin_coach_path(coach)
        click_on "Coach"
        check "Organiser"
        click_on "Update"
      end

      Then do
        page.has_content? "#{coach.name} coaching has been updated."
        visit admin_city_event_path(event.city, event)
        page.has_content? coach.name
      end
      And { page.has_content? "Organiser" }
    end

    context "can be removed" do
      Given do
        Fabricate(:event_coaching, coach: coach, coachable_id: event.id)
      end

      When do
        visit admin_coach_path(coach)
        click_on "Remove"
      end

      Then do
        page.has_content? "#{coach.name} has been removed from #{event.to_s}."
        visit admin_city_event_path(event.city, event)
        !page.has_content? coach.name
      end
    end
  end

  context "can be created for a meeting" do
    Given!(:meeting) { Fabricate(:meeting, coachable: true) }

    When do
      visit admin_coach_path(coach)
      click_on "Coach"
    end

    Then do
      page.has_content? "#{coach.name} has been assigned to #{meeting.to_s}."
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
