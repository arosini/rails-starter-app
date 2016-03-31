@javascript
Feature: Sign In

  @authentication
  Scenario Outline: A visitor signs in successfully
    Given I have not signed in
    When I sign in as "<user>"
    Then I should see the "Home" page
    And I should see the page title as "Users Index"
    
    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |

  @authentication @failure
  Scenario Outline: A visitor cannot sign in with invalid information
    Given I have not signed in
    When I try to sign in as "<email>" using "<password>" as the password
    Then I should see the "Sign In" page
    And I should see an error message that says "<message>"

    Examples:
      | email          | password | message                                        |
      | wrong@user.com | asdqwe   | Could not find a user with that email address. |
      | user1@user.com | wrong    | Incorrect password.                            |

  @authentication
  Scenario: A visitor checks the Remember Me checkbox on the Sign In form
    Given I have signed in as "user1@user.com" and told the application to remember me
    When I close and re-open the browser
    Then I should be able to view the profile page for "user1@user.com"

  @authentication
  Scenario: A visitor does not check the Remember Me checkbox on the Sign In form
    Given I have signed in as "user1@user.com"
    When I close and re-open the browser
    Then I should not be able to view the profile page for "user1@user.com"

  @navigation
  Scenario Outline: A visitor clicks a link on the Sign In page
    Given I have not signed in
    And I have navigated to the "Sign In" page
    When I click on the "<action>" link
    Then I should see the "<page>" page

    Examples:
      | action                | page                 |
      | Sign Up               | Sign Up              |
      | Forgot your password? | Forgot Your Password |

  @authorization @failure
  Scenario Outline: A user/admin cannot access the sign in page
    Given I have signed in as "<user>"
    When I navigate to the "Sign In" page
    Then I should see an error message that says "You are already signed in."

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |
