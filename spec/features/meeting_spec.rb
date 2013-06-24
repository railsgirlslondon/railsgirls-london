require 'spec_helper'

feature "viewing a meeting" do
  Given(:city) { Fabricate(:city) }

  context "when it has been announced" do
    Given!(:meeting) { Fabricate(:meeting, city: city) }

    When do
      visit city_meeting_path(city, meeting)
    end

    Then { page.has_content? meeting.name }
    And { page.has_content? meeting.description }

  end

  context "when it has not been announced" do
    Given!(:meeting) { Fabricate(:unannounced_meeting, city: city) }

    When do
      visit(city_meeting_path(city, meeting))
    end

    Then { page.has_content? "No such meeting." }

  end
end
