@javascript
Feature: Back Button

  @navigation
  Scenario: Home button appears after direct navigation
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "Roles" page
    And I click on the "Home" button
    Then I should see the "Home" page

  @navigation
  Scenario: Back button appears after clicking on link
    Given I have signed in as "admin1@admin.com"
    When I click on the "Roles" link in the navbar
    And I click on the "Back" button
    Then I should see the "Home" page