require 'spec_helper'

describe "Listing cities" do
  Given { City.create!(name: "Sama") }
  Given { City.create!(name: "Na") }

  context "viewing cities" do
    When { visit root_path }

    Then { page.has_content? "Sama" }
    And { page.has_content? "Na" }
  end

  context "selecting a city" do
    Given { visit root_path }

    When { click_on("Sama") }
    Then { page.has_content? "Rails Girls Sama" }
  end

  context "visiting a city directly" do
    Given { visit "/sama" }
    Then { page.has_content? "Rails Girls Sama" }
  end
end

describe "Viewing a city" do
  Given(:city) { Fabricate(:city) }

  context "with an upcoming event" do
    Given { Fabricate(:event, city: city) }

    When { visit city_path(city) }
    Then { find("#upcoming_event .title").text.should eq city.upcoming_event.title }
    Then { find("#upcoming_event .description").text.should eq city.upcoming_event.description }
    Then { find("#upcoming_event .links").text.should include "Tweet" }
  end

  context "with a past event" do
    Given { Fabricate(:inactive_event, city: city) }

    When { visit city_path(city) }
    Then { find("#past_events .title").text.should eq city.past_events.first.dates }
  end

  context "with upcoming meetings" do
    Given!(:meeting) { Fabricate(:meeting, city: city) }

    When { visit city_path(city) }
    Then { page.has_content?(I18n.l(meeting.date)) }
    Then { page.has_content? meeting.name }
  end

end
