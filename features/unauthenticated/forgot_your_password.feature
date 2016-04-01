@javascript
Feature: Forgot Your Password

  @email
  Scenario: A visitor successfully changes their password through the Forgot Your Password form and signs in
    Given I have not signed in
    When I change "user1@user.com"'s password to "newpassword" using password confirmation "newpassword"
    Then I should be automatically signed in
    And I should see a success alert message that says "Your password was changed successfully. You are now signed in."

  @email @failure
  Scenario Outline: A visitor submit invalid information to the change your password form
    Given I have not signed in
    When I try to change "user1@user.com"'s password to "<password>" using password confirmation "<confirm>"
    Then I should see an error message that says "<message>" near the "<field>" field
    And I should not be automatically signed in

    Examples:
      | password | confirm | field    | message                        |
      | asdqw    | asdqw   | Password | Must be at least 6 characters. |
      |          |         | Password | Can't be blank.                |
      | asdqwe   | asdqwee | Confirm  | Must match password.           |
      |          |         | Confirm  | Can't be blank.                |

  @failure
  Scenario Outline: A visitor submits the Forgot Your Password form with an invalid email
    Given I have not signed in
    When I submit the Forgot Your Password form using email "<email>"
    Then I should not be redirected to the "Sign In" page
    And I should see an error message that says "<message>" near the "Email" field

    Examples:
     | email               | message                                        |
     | idontexist@user.com | Could not find a user with that email address. |
     | bad-email           | This value should be a valid email.            |

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
