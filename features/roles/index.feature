@javascript
Feature: Roles Index
  
  @authentication @failure
  Scenario: A visitor tries to access the roles index
    Given I have not signed in
    Then I should not be able to navigate to the "roles" page

  @authorization @failure
  Scenario: A user tries to access the roles index
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the "roles" page

  @read
  Scenario Outline: An admin views a role in the role index
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "roles" page
    Then I should see a "<role>" row in the "roles" table
    And I should see "<users>" in the "roles" table's "<role>" row
    And I should not see "<missing>" in the "roles" table's "<role>" row
    And I should see the following actions in the "roles" table's "<role>" row: "Show, Edit, Delete"

    Examples:
    | role  | users                              | missing                            |
    | Admin | admin1@admin.com, admin2@admin.com | user1@user.com, user2@user.com     |
    | User  | user1@user.com, user2@user.com     | admin1@admin.com, admin2@admin.com |

  @read @search
  Scenario Outline: An admin searches for roles in the role index
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "roles" page
    And I enter "<search>" in the "Name" contains search field
    Then I should see search results for only the following roles: "<results>"
    And I should see search suggestions for only the following roles: "<suggestions>"

    Examples:
    | search | results     | suggestions |
    |        | Admin, User |             |
    | a      | Admin       | Admin       |
    | Admin  | Admin       | Admin       |
    | u      | User        | User        |
    | User   | User        | User        |
    | x      |             |             |

  @navigation
  Scenario: An admin clicks the new button in the roles index
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "roles" page
    And I click on the "New Role" button
    Then I should see the "New Role" page

  @navigation
  Scenario Outline: An admin clicks an action for a role in the role index
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "roles" page
    And I click on the "<action>" button in the "roles" table's "<role>" row
    Then I should see the <page>

    Examples:
    | action | role  | page                           |
    | Show   | Admin | "Admin" role page              |
    | Edit   | Admin | edit page for the "Admin" role |
    | Show   | User  | "User" role page               |
    | Edit   | User  | edit page for the "User" role  |
