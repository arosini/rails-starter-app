@javascript
Feature: Users Index

  # Scenario Outline: A user sees specific actions on the users index

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