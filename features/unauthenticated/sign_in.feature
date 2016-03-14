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
    And I have navigated to the "Sign In" page
    When I enter the sign in information for "user1@user.com"
    And I enter "<value>" in the "<field>" field
    And I click on the "Sign In" button
    Then I should see an error message that says "<message>"

    Examples:
      | field    | value          | message                                        |
      | Email    | wrong@user.com | Could not find a user with that email address. |
      | Password | wrong          | Incorrect password.                            |

  # Scenario: A visitor checks the Remember Me checkbox on the Sign In form
  #   Given I have not signed in
  #   And I have navigated to the "Sign In" page
  #   When I enter the sign in information for "user1@user.com"
  #   And I check the "Remember me" checkbox
  #   And I click on the "Sign In" button
  #   And I close and reopen the browser
  #   And I navigate to the "Sign In" page
  #   Then I should be automatically signed in

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
