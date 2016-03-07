@javascript
Feature: Roles

  Scenario: A visitor tries to access the new role page
    Given I have not signed in
    Then I should not be able to navigate to the "new role" page

  Scenario: A user tries to access the new role page
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the "new role" page

  Scenario: An admin creates a new role
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "new role" page
    And I fill out the "new role" form with the following values:
      | field | value |
      | Name  | test  |
    And I click on the "Submit" button
    Then I should be redirected to the "test" role page
    And I should see "test" in the "Name" row
    When I navigate to the edit user page for "user1@user.com"
    And I select "test" in the "Roles" dropdown
    And I click on the "Submit" button
    Then I should see the profile page for "user1@user.com"
    And I should see an alert message saying "Successfully updated user."
    And I should see "test" in the "Role" row

  Scenario Outline: An admin tries to create an invalid role
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "new role" page
    And I fill out the "new role" form with the following values:
      | field | value |
      | Name  | Admin |
    And I click on the "Submit" button
    Then I should see an error message saying "" near the "Name" field

    Examples:
    | name  | message                      |
    | Admin | Role name is already in use. |
    |       | Can't be blank.              |
    
  Scenario: A visitor tries to access the roles index
    Given I have not signed in
    Then I should not be able to navigate to the "roles" page

  Scenario: A user tries to access the roles index
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the "roles" page

  Scenario Outline: An admin views a role in the role index
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "roles" page
    Then I should see a row for "<role>" in the "roles" table
    And I should see "<users>" in the "<role>" row
    And I should not see "<missing>" in the "<role>" row
    And I should see the following actions in the "<role>" row: "Show, Update, Delete"

    Examples:
    | role  | users                              | missing                            |
    | Admin | admin1@admin.com, admin2@admin.com | user1@user.com, user2@user.com     |
    | User  | user1@user.com, user2@user.com     | admin1@admin.com, admin2@admin.com |
