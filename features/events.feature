Feature: RailsGirls Events

  @cities
  Scenario: Viewing information
    When I navigate to "/london"
    Then I can view "Rails Girls London"
    And I can see the latest event date "19-20th April"
