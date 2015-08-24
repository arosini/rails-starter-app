@javascript
Feature: Users Index

  Scenario: A visitor tries to access the new user page
    Given I have not signed in
    Then I should not be able to navigate to the "Users" page
    And I should not see a "New User" button

  Scenario: A user tries to access the new user page
    Given I have signed in as "user1@user.com"
    When I navigate to the "users" page
    Then I should not see a "New User" button
    And I should not be able to navigate to the "new user" page

  Scenario: An admin creates a new user
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "users" page
    When I click on the "New User" button
    And I fill out the "new user" form with the following values:
      | field                  | value         |
      | Email                  | test@test.com |
      | Password               | asdqwe        |
      | Confirm                | asdqwe        |
    And I click on the "Submit" button
    Then I should be able to sign in as "test@test.com"

  Scenario Outline: A user searches for other users
    Given I have signed in as "<user>"
    And I have navigated to the "users" page
    When I search with the following values:
      | field | value    |
      | Email | <search> |
    Then I should see <results> for only the following users: "<users>"

    Examples:
      | user             | search | users                                                              | results                        |  
      | user1@user.com   |        | user1@user.com, user2@user.com                                     | search results                 |  
      | user1@user.com   | user2  | user2@user.com                                                     | search results and suggestions |  
      | user1@user.com   | a      |                                                                    | search results and suggestions |  
      | admin1@admin.com |        | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com | search results                 |  
      | admin1@admin.com | u      | user1@user.com, user2@user.com                                     | search results and suggestions |  
      | admin1@admin.com | user2  | user2@user.com                                                     | search results and suggestions |  
      | admin1@admin.com | a      | admin1@admin.com, admin2@admin.com                                 | search results and suggestions |  
      | admin1@admin.com | admin2 | admin2@admin.com                                                   | search results and suggestions |

  Scenario: An admin deletes a user from the users index
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "users" page
    When I click on the "Delete" button in the "user1@user.com" row
    And I accept the popup alert
    Then I should see an alert message saying "Successfully deleted user."
    And I should see links to the profile pages for only "admin1@admin.com, admin2@admin.com, user2@user.com"
    And I should not be able to sign in as "user1@user.com"