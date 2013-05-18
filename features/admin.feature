Feature: Admin CRUD

  Scenario: Creating a city
    Given an admin exists
    And I log in as that admin

    When I create a city
    Then it shows up on the city list

