@javascript 
Feature: View Role

  @authorization @failure
  Scenario: A visitor tries to view a role's page
    Given I have not signed in
    Then I should not be able to navigate to the "Admin" role page
    And I should not be able to navigate to the "User" role page

  @authentication @failure
  Scenario: A visitor tries to view a role's page
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the "Admin" role page
    And I should not be able to navigate to the "User" role page

  @read
  Scenario: An admin views a role's page
    Given I have signed in as "admin1@admin.com"
    Then I should be able to navigate to the "Admin" role page
    And I should see "Admin" in the "role" table's "Name" row
    And I should be able to navigate to the "User" role page
    And I should see "User" in the "role" table's "Name" row

  @navigation
  Scenario: An admin clicks the edit button on a role's page
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "Admin" role page
    When I click on the "Edit" button
    Then I should see the edit page for the "Admin" role
