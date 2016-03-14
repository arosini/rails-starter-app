@javascript
Feature: Forgot Your Password

  @email
  Scenario: A visitor successfully changes their password through the Forgot Your Password form and signs in
    Given I have not signed in
    When I navigate to the "Forgot Your Password" page
    And I enter "user1@user.com" in the "Email" field
    And I click on the "Submit" button
    Then I should be redirected to the "Sign In" page
    And I should see a success alert message that says "You will receive an email with instructions on how to change your password in a few minutes."
    And an email with a password change link should be sent to "user1@user.com"
    When I click on the link in the email
    And I fill out the "Change Your Password" form with the following values:
     | field    | value  |
     | Password | asdqwe |
     | Confirm  | asdqwe |
    And I click on the "Submit" button
    Then I should be automatically signed in
    And I should see a success alert message that says "Your password was changed successfully. You are now signed in."

  @failure
  Scenario Outline: A visitor submits the Forgot Your Password form with an invalid email
    Given I have not signed in
    When I navigate to the "Forgot Your Password" page
    And I enter "<email>" in the "Email" field
    And I click on the "Submit" button
    Then I should see an error message that says "<message>" near the "Email" field

    Examples:
     | email               | message                                        |
     | idontexist@user.com | Could not find a user with that email address. |
     | bad-email           | This value should be a valid email.            |

  @email @failure
  Scenario Outline: A visitor tries to changes their password to an invalid password
    When I navigate to the "forgot your password" page
    And I enter "user1@user.com" in the "Email" field
    And I click on the "Submit" button
    Then I should be redirected to the "Sign In" page
    And I should see a success alert message that says "You will receive an email with instructions on how to change your password in a few minutes."
    And an email with a password change link should be sent to "user1@user.com"
    When I click on the link in the email
    And I fill out the "Change Your Password" form with the following values:
     | field    | value      |
     | Password | <password> |
     | Confirm  | <confirm>  |
    And I click on the "Submit" button
    Then I should see an error message that says "<message>" near the "<field>" field

    Examples:
      | password | confirm | field    | message                        |
      | asdqw    | asdqw   | Password | Must be at least 6 characters. |
      |          |         | Password | Can't be blank.                |
      | asdqwe   | asdqwee | Confirm  | Must match password.           |
      |          |         | Confirm  | Can't be blank.                |

  @navigation
  Scenario Outline: A visitor clicks a link on the Forgot Your Password page
    Given I have not signed in
    And I have navigated to the "Forgot Your Password" page
    When I click on the "<action>" link
    Then I should see the "<page>" page

    Examples:
      | action  | page    |
      | Sign In | Sign In |
      | Sign Up | Sign Up |

  @authorization @failure
  Scenario Outline: A user/admin cannot access the Forgot Your Password page
    Given I have signed in as "<user>"
    When I navigate to the "Forgot Your Password" page
    Then I should see an error message that says "You are already signed in."

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |
