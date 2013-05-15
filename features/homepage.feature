Feature: RailsGirls Homepage

  @cities
  Scenario: Viewing information
    When I navigate to "/"
    Then I can see "London" listed as a host city

  @cities
  Scenario: Visiting London
    When I navigate to "/"
    And I click on "london"
    Then I can view "Rails Girls London"

