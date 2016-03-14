@javascript
Feature: New Role

  @authentication @failure
  Scenario: A visitor tries to access the new role page
    Given I have not signed in
    Then I should not be able to navigate to the "new role" page

  @authorization @failure
  Scenario: A user tries to access the new role page
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the "new role" page

  @create
  Scenario: An admin creates a new role and assigns it to a user
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "new role" page
    And I fill out the "new role" form with the following values:
      | field | value |
      | Name  | test  |
    And I click on the "Submit" button
    Then I should be redirected to the "test" role page
    And I should see an alert message saying "Successfully created role."
    And I should see "test" in the "role" table's "Name" row
    When I navigate to the edit user page for "user1@user.com"
    And I select "test" in the "Roles" dropdown
    And I click on the "Submit" button
    Then I should see the profile page for "user1@user.com"
    And I should see an alert message saying "Successfully updated user."
    And I should see "test" in the "user" table's "Role" row

  @create @failure
  Scenario Outline: An admin tries to create an invalid role
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "new role" page
    And I fill out the "new role" form with the following values:
      | field | value |
      | Name  | <name> |
    And I click on the "Submit" button
    Then I should see an error message saying "<message>" near the "Name" field

    Examples:
    | name  | message                      |
    | Admin | Role name is already in use. |
    |       | Can't be blank.              |