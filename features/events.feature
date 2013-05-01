Feature: RailsGirls Events

  @cities @wip
  Scenario: Viewing information
    When I navigate to "/london"
    Then I can view "Rails Girls London"
    And I can see an event "19-20th April"
