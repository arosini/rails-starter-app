@javascript
Feature: Roles

Scenario: An admin creates a new role
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "new role" page
    And I fill out the "new role" form with the following values:
      | field                  | value |
      | Name                   | test  |
    And I click on the "Submit" button
    Then I should be able to sign in as "test@test.com"