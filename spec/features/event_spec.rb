require 'spec_helper'

feature "viewing an event" do
  Given(:city) { Fabricate(:city) }

  context "when it is active" do

    context "and the registration deadline is set, registrations are available" do

      Given!(:event) { Fabricate(:event, city: city) }

      When do
        visit city_event_path(city, event)
      end

      Then { page.has_content? "Apply to the event." }
    end

    context "and no registration deadline is set, registrations are not available" do
      Given!(:event) { Fabricate(:event, registration_deadline: nil, city: city) }

      When do
        visit city_event_path(city, event)
      end

      Then { page.has_content? "Applications are not available." }
    end
  end

  context "registrations are no the event it not active" do

    Given!(:event) { Fabricate(:inactive_event, city: city) }

    When do
      visit city_event_path(city, event)
    end

    Then { page.has_content? "This event has already taken place." }

  end
end
