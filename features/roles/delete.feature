@javascript
Feature: Delete Role

  @delete
  Scenario: An admin clicks the Delete button for a role in the roles index
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "Roles" page
    When I click on the "Delete" button in the "roles" table's "User" row
    And I accept the popup alert
    Then I should see an alert message saying "Successfully deleted role."
    And I should not see a "User" row in the "roles" table

  @delete @failure
  Scenario: An admin accidentally clicks the Delete button for a role in the roles index
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "Roles" page
    When I click on the "Delete" button in the "roles" table's "User" row
    And I dismiss the popup alert
    Then I should not see an alert message saying "Successfully deleted role."
    And I should see a "User" row in the "roles" table

  @delete
  Scenario: An admin clicks the delete button on a role's page
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "User" role page
    When I click on the "Delete" button
    And I accept the popup alert
    Then I should be redirected to the "Roles" page
    And I should see an alert message saying "Successfully deleted role."
    And I should not see a "User" row in the "roles" table

  @delete @failure
  Scenario: An admin accidentally clicks the delete button on a role's page
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "User" role page
    When I click on the "Delete" button
    And I dismiss the popup alert
    Then I should see the "User" role page
    And I should not see an alert message saying "Successfully deleted role."
    When I navigate to the "Roles" page
    Then I should see a "User" row in the "roles" table