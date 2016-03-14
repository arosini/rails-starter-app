@javascript
Feature: Sign Up

  @authentication
  Scenario: Visitor signs up successfully
    Given I have not signed in
    And I have navigated to the "Sign Up" page
    When I fill out the "sign up" form with the following values:
      | field    | value             |
      | Email    | new-user@user.com |
      | Password | asdqwe            |
      | Confirm  | asdqwe            |
    And I click on the "Sign Up" button
    Then I should be automatically signed in

  @authentication  @failure
  Scenario Outline: Vistor cannot sign up with invalid information
    Given I have not signed in
    And I have navigated to the "Sign Up" page
    When I fill out the "sign up" form with the following values:
      | field    | value          |
      | Email    | user1@user.com |
      | Password | asdqwe         |
      | Confirm  | asdqwe         |
      | <field>  | <value>        |
    And I click on the "Sign Up" button
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

  @navigation
  Scenario: Visitor clicks the sign in link on the sign up page
    Given I have not signed in
    And I have navigated to the "Sign Up" page
    When I click on the "Sign In" link
    Then I should see the "Sign In" page

  @authorization @failure
  Scenario Outline: An authenticated user cannot access the sign up page
    Given I have signed in as "<user>"
    When I navigate to the "Sign Up" page
    Then I should see an error message that says "You are already signed in."

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |
