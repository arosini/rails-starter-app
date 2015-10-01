@javascript
Feature: Auth

  Scenario: The root path directs an unathenticated visitor to the landing page
    Given I have not signed in
    When I navigate to the "home" page
    Then I should see the "landing" page

  Scenario Outline: The root path directs an athenticated user to the users index
    Given I have signed in as "<user>"
    When I navigate to the "home" page
    Then I should see the "users" page

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |

  Scenario Outline: Visitor signs in successfully
    Given I have not signed in
    When I sign in as "<user>"
    Then I should see the "home" page
    
    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |

  Scenario Outline: Visitor cannot sign in with invalid information
    Given I have not signed in
    When I navigate to the "Sign In" page
    And I enter the sign in information for "user1@user.com"
    And I enter "<value>" in the "<field>" field
    And I click on the "Sign In" button
    Then I should see an error message saying "<message>"

    Examples:
      | field       | value          | message                                        |
      | Email       | wrong@user.com | Could not find a user with that email address  |
      | Password    | wrong          | Incorrect password                             |

  Scenario Outline: An authenticated user cannot access the sign in page
    Given I have signed in as "<user>"
    When I navigate to the "Sign In" page
    Then I should see an error message saying "You are already signed in."

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |