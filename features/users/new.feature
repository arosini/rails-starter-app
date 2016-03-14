@javascript
Feature: New User

  @authentication @failure
  Scenario: A visitor tries to access the new user page
    Given I have not signed in
    Then  I should not be able to navigate to the "new user" page

  @authorization @failure
  Scenario: A visitor tries to access the new user page
    Given I have signed in as "user1@user.com"
    Then  I should not be able to navigate to the "new user" page

  @create
  Scenario: An admin creates a new user
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "new user" page
    When I fill out the "new user" form with the following values:
      | field    | value         |
      | Email    | test@test.com |
      | Password | asdqwe        |
      | Confirm  | asdqwe        |
    And I click on the "Submit" button
    Then I should be able to sign in as "test@test.com"

  @create @failure
  Scenario Outline: An admin tries to create a new user with an invalid attribute
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "new user" page
    When I fill out the "new user" form with the following values:
      | field    | value         |
      | Email    | test@test.com |
      | Password | asdqwe        |
      | Confirm  | asdqwe        |
    And I enter "<value>" in the "<field>" field
    And I click on the "Submit" button
    Then I should see an error message that says "<message>" near the "<field>" field

    Examples:
      | field    | value          | message                             |
      | Email    | invalidemail   | This value should be a valid email. |
      | Email    | user1@user.com | Email has already been taken.       |
      | Email    |                | Can't be blank.                     |
      | Password | asdqw          | Must be at least 6 characters.      |
      | Password |                | Can't be blank.                     |
      | Confirm  | asdqwee        | Must match password.                |
      | Confirm  |                | Can't be blank.                     |
