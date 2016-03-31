@javascript
Feature: Sign Up

  @authentication
  Scenario: Visitor signs up successfully
    Given I have not signed in
    When I sign up with email "newuser@user.com", password "asdqwe" and password confirmation "asdqwe"
    Then I should be automatically signed in

  @authentication  @failure
  Scenario Outline: Vistor cannot sign up with invalid information
    Given I have not signed in
    When I sign up with email "<email>", password "<password>" and password confirmation "<confirmation>"
    Then I should see an error message that says "<message>" near the "<field>" field

    Examples:
      | email          | password | confirmation | field    | message                             |
      | invalidemail   | asdqwe   | asdqwe       | Email    | This value should be a valid email. |
      | user1@user.com | asdqwe   | asdqwe       | Email    | Email has already been taken.       |
      |                | asdqwe   | asdqwe       | Email    | Can't be blank.                     |
      | new@user.com   | asdqw    | asdqw        | Password | Must be at least 6 characters.      |
      | new@user.com   |          |              | Password | Can't be blank.                     |
      | new@user.com   | asdqwe   | asdqwee      | Confirm  | Must match password.                |
      | new@user.com   | asdqwe   |              | Confirm  | Can't be blank.                     |

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
