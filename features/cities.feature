Feature: Listing cities

  Scenario: Clicking on london
    Given I have a city called "Sama"
    And I have a city called "Na"
    And I navigate to "/"
    Then I can view "Cities"
    And I can view "Na"
    And I can view "Sama"
    When I click on "Sama"
    Then I can view "Rails Girls Sama"