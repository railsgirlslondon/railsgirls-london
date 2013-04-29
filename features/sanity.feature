Feature: Sanity test

  Scenario: A user can access the website
    Given I navigate to "/"
    Then I can view "Rails Girls London"
