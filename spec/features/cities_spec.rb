require 'spec_helper'

describe "Listing cities" do
  Given { City.create!(name: "Sama") }
  Given { City.create!(name: "Na") }

  context "viewing cities" do
    When { visit root_path }

    Then { page.has_content? "Sama" }
    And { page.has_content? "Na" }
  end

  context "selecting on a city" do
    Given { visit root_path }

    When { click_on("Sama") }
    Then { page.has_content? "Rails Girls Sama" }
  end
end