@javascript
Feature: View Role

  Scenario Outline: A non-admin tries to view a role's page
    Given I have <status>
    Then I should not be able to navigate to the "Admin" role page
    And I should not be able to navigate to the "User" role page

    Examples:
    | status                        |
    | not signed in                 |
    | signed in as "user1@user.com" |

    Scenario: An admin views a role's page
    Given I have signed in as "admin1@admin.com"
    Then I should be able to navigate to the "Admin" role page
    And I should be able to navigate to the "User" role page